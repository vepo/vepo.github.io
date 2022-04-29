---
title: Explorando o consumer
published: false
permalink: /posts/log-cleanup-no-kafka
description: As vezes o consumer não pode ser tão simples como os que já detalhamos, para isso precisamos conhecer como ele funciona e como podemos usar suas funcionalidades ao máximo.
tags: [Kafka, Apache Kafka, Consumer]
series: Entendendo o Kafka
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/1os85b4rmdpauz3yjbsu.jpg
publish_date: 2022-02-05 11:00:00 +0300
---

Na grande maioria dos casos, quando vamos implementar um consumer usando Apache Kafka, não vale a pena adicionar complexidade. Use as configurações padrões e não se preocupe em commitar as mensagens. Mas em alguns casos é preciso sim se preocupar, mas quando é que precisamos ficar alerta?

Nesse post vou explorar um caso de uso real que nos levou a considerar adicionar uma complexidade extrema ao consumer, mostrando os motivos e as funcionalidades utilizadas.

# O caso de uso

Trabalho com TELECOM e temos um protocolo chamado Diameter. Diferentemente do HTTP, o Diameter é feito para ter uma baixa latência e conectar apenas alguns pontos (não vou usar cliente/servidor proque não é nesse tipo de arquitetura que ele é usado). Por essas conexões Diameter trafegam mensagens de sessões de usuários, por exemplo, se você está lendo esse post na sua rede 4G seu celular abriu uma conexão com a antena para que fosse possível consumir dados de internet. Podem existir mais de uma sessão em aberta e com caracteristicas distintas, é assim que sua operadora diz que você pode usar alguns serviços com velociadades distintas.

# 1. Um consumidor simples

Nós recebemos como requisito que deveriamos processar mensagens diameter enviada através de um tópico Kafka. Ora, se é uma mensagem diameter, logo sabemos que por mais threads que tivermos, uma thread deve processar todas as mensagens de uma mesma sessão (sim, Diameter não é stateless). Por isso começamos com a solução simples:

```java
AtomicBoolean running = new AtomicBoolean(true);
AtomicBoolean closed = new AtomicBoolean(false);
Runtime.getRuntime().addShutdownHook(new Thread(() -> {
    running.set(false);
    while (!closed.get()) {
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}));

// Configure the Consumer
Properties configProperties = new Properties();
configProperties.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:29092");
configProperties.put(ConsumerConfig.GROUP_ID_CONFIG, "ComplexConsumerGroup");
configProperties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
configProperties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, JsonDeserializer.class);
configProperties.put(JsonDeserializer.DESERIALIZE_CLASS_CONFIG, User.class);

try (Consumer<String, User> consumer = new KafkaConsumer<>(configProperties)) {
    consumer.subscribe(Arrays.asList(topicName));
    System.out.println("Consuming from topic: " + topicName);
    while (running.get()) {
        consumer.poll(Duration.ofSeconds(1))
                .forEach(ComplexConsumer::process);
    }
}
System.out.println("Consumer finalizado!");
closed.set(true);
```

Esse código pode parecer um pouco simples, mas existe um certo grau de complexidade. Primeiro é que a finalização do consumidor é associada ao sinal de shutdown da JVM. Isso vai evitar que mensagens seja processadas novamente pela ausência de commit. Por padrão o commit é feito automaticamente a cada 5 segundos. 

Por usar o Consumer sincronamente, várias instâncias desse mesmo código podem rodar em paralelo e elas vão atuar coordenadamente. A chave para essa coordenação está no parâmentro `GROUP_ID_CONFIG`, definirmos um id fixo e termos apenas uma thread, garatimos que todas as mensagens com mesma chave são processadas na ordem cronológica e em série. Se uma nova instância desse processo aparecer, a carga será automáticamente distribuida e nenhuma mensagem será processada em duplicidade.

Mas esse código tem uma séria limitação de processamento pois usamos uma JVM para processar apenas uma thread o que é um gasto de memória enorme. A JVM é planejada para grandes cargas e não para pequenas operações. Então como podemos adicionar mais threads ao nosso simples consumidor?

# 2. Adicionando mais threads

Então o próximo requisito era que deveríamos parametrizar o número de threads que devem rodar em um mesmo processo. Essa parametrização é muito importante porque durante o processamento da nossa mensagem existe uma troca de mensagens diamenter o que significa que, ao se colocar em produção, deve-se encontrar um número ótimo de threads para maximizar a performance.