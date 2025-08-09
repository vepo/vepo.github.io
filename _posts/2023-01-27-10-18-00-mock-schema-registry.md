---
title: Testes de Kafka Stream e Schema Registry
published: true
permalink: /posts/mock-schema-registry
description: Qual é a maneira mais fácil de se testar um consumer/producer/stream Kafka usando Schema Registry?
tags: [Apache Kafka, Unit Test, Java]
cover_image: /assets/images/capas/chaplin-modern-times.webp
publish_date: 2023-01-27 10:21:00 +0300
---

Testes unitários são algo bem complexos usando Kafka Stream. É muito difícil separar o que é middleware do que é seu código próprio porque todo código vai depender de alguma dependência do Kafka que será muito difícil de criar mocks. Aqui vou mostrar de forma superficial como é possível criar testes unitários para Kafka Streams.

Antes de continuar precisamos trazer um pequeno esclarecimento sobre testes. Quando falamos de Unit Testing estamos separando uma parte de código para testar isoladamente. Já os testes de integração serão feitos usando os componentes externos. Essa é uma explicação superficial, seja benevolente pois minha intenção aqui não é falar sobre testes em geral.

# 1. Como testar um Kafka Stream

Antes de testar um Kafka Stream você precisa diferenciar dois conceitos do Stream. Todo Stream é um fluxo de dados e esse fluxo é representado pela classe [`Topology`](https://kafka.apache.org/34/javadoc/org/apache/kafka/streams/Topology.html). A topologia é a implementação da sua lógica de negócios e com ela dá para criar um Stream. Vamos ver isso no código abaixo?

```java
CountDownLatch latch = new CountDownLatch(1);    (1)

Properties props = new Properties();
props.put(StreamsConfig.APPLICATION_ID_CONFIG, applicationId);
props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass());
props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass());

StreamsBuilder builder = new StreamsBuilder();    (2)

KStream<String, String> textLines = builder.stream(inputTopic);    (3)
KTable<String, Long> wordCounts = textLines.flatMapValues(textLine -> {
                                                            System.out.println("Flat Map: " + textLine);
                                                            return Arrays.asList(textLine.toLowerCase().split("\\W+"));
                                                          }).groupBy((key, word) -> {
                                                                        System.out.println("Grouping: key=" + key + " work=" + word);
                                                                        return word;
                                                          }).count(Materialized.<String, Long, KeyValueStore<Bytes, byte[]>>as("counts-store"));
wordCounts.toStream().to(outputTopic, Produced.with(Serdes.String(), Serdes.Long()));
Topology topology = builder.build();    (4)
KafkaStreams streams = new KafkaStreams(topology, props);   (5)

Runtime.getRuntime().addShutdownHook(new Thread("streams-shutdown-hook") {
    @Override
    public void run() {
        streams.close();
        latch.countDown();
    }
});
streams.start();
latch.await();
```

Para explicar esse código vou levantar 5 pontos sobre ele. O primeiro **(1)** é que como o Stream funciona assincronamente quando usamos ele sem o auxilio de um framework precisamos garantir que o thread principal não seja finalizada, por isso eu uso o `CountDownLatch`. Depois **(2)** temos a classe `StreamsBuilder` que deve ser usada para se construir o Stream, como podemos ver no trecho iniciado em **(3)** deve existir um inicio e um fim do fluxo de dados, isso é feito usando uma DSL, mas depois o builder é usado para se gerar a topologia **(4)**. E por fim usamos a topologia gerada e as propriedades para criar o `KafkaStreams`.

A classe gerada pelo `KafkaStreams` vai se conectar diretamente com o Kafka, qualquer teste usando ela será um teste de integração, caso você queira fazer um teste de integração, recomendo o uso do [TestContainers](https://www.testcontainers.org/modules/kafka/) eu fiz um exemplo uma vez, mas [o teste](https://github.com/vepo/kafka-stream-with-testcontainers/blob/main/src/test/java/io/vepo/kafka/stream/delay/KafkaStreamTest.java) fica um pouco lento e limitado.

Mas o Kafka provê uma forma de testarmos a nossa topologia sem criar um Stream, para isso devemos usar a classe [`TopologyTestDriver`](https://kafka.apache.org/34/javadoc/org/apache/kafka/streams/TopologyTestDriver.html). Ela é instanciada da mesma forma do `KafkaStream`. Logo o código acima poderia ser refatorada para que a criação da topologia e o controle do stream fossem feito por trechos de código diferentes (_não vou propor nada_).

```java
Properties props = new Properties();
props.put(StreamsConfig.APPLICATION_ID_CONFIG, applicationId);
props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "dummy:1234");
props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass());
props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass());

StreamsBuilder builder = new StreamsBuilder();

KStream<String, String> textLines = builder.stream(inputTopic);
KTable<String, Long> wordCounts = textLines.flatMapValues(textLine -> {
                                                            System.out.println("Flat Map: " + textLine);
                                                            return Arrays.asList(textLine.toLowerCase().split("\\W+"));
                                                          }).groupBy((key, word) -> {
                                                                        System.out.println("Grouping: key=" + key + " work=" + word);
                                                                        return word;
                                                          }).count(Materialized.<String, Long, KeyValueStore<Bytes, byte[]>>as("counts-store"));
wordCounts.toStream().to(outputTopic, Produced.with(Serdes.String(), Serdes.Long()));
Topology topology = builder.build();
try (TopologyTestDriver testDriver = new TopologyTestDriver(topology, topologyProps)) {    (1)
    TestInputTopic<String, String> input = testDriver.createInputTopic(inputTopic, Serdes.String().serializer(), Serdes.String().serializer());    (2)
    TestOutputTopic<String, Long> output = testDriver.createOutputTopic(outputTopic, Serdes.String().deserializer(), Serdes.Long().deserializer());
    input.pipeInput("record-001", "word-1");    (3)
    input.pipeInput("record-002", "word-2");
    input.pipeInput("record-003", "word-1");
    TestRecord<String, Long> outputRecord = output.readRecord();    (4)
    [...]
}
```

Como podemos ver o mock do Stream é criado em **(1)**, depois devemos definir quais tópicos estão envolvidos no Stream **(2)**, enviamos os dados **(3)** e por fim consumimos as saídas do stream **(4)**. Existe uma série de vantagens ao se usar o `TopologyTestDriver` e a principal delas é que podemos controlar o avanço do tempo usando [testDriver.advanceWallClockTime(Duration.ofMinutes(60))](https://kafka.apache.org/34/javadoc/org/apache/kafka/streams/TopologyTestDriver.html#advanceWallClockTime(java.time.Duration)). Sem essa funcionalidade se torna impossível fazermos testes de streams que efetuam agregação no tempo.

Usando esse trecho de código é possível injetar e consultar dados no stream e através da biblioteca de assertions do [JUnit 5](https://junit.org/junit5/docs/5.8.2/api/org.junit.jupiter.api/org/junit/jupiter/api/Assertions.html) ou do [AssertJ](https://www.javadoc.io/doc/org.assertj/assertj-core/latest/org/assertj/core/api/Assertions.html) podemos criar testes unitários consistentes.

# 2. Como testar um Kafka Stream usando Schema Registry

Quando temos um ambiente de microsserviços um pouco mais complexos, precisamos garantir a evolução dos Schemas das mensagens no Kafka. Existe [alguma literatura](https://www.sciencedirect.com/science/article/pii/S0164121221000674#b26) sobre o assunto mas temos apenas alguns produtos no mercado. Os mais comuns são o [Schema Registry da Confluent](https://docs.confluent.io/platform/current/schema-registry/index.html) e o [Apicurio registry](https://www.apicur.io/registry/), que segundo a documentação é compatível com o produto da Confluent.

Um Schema Registry vai funcionar como registro de todos os schemas que são usados tanto para se produzir quanto consumir mensagens. Quando um producer vai enviar uma mensagem, ele irá gerá um Schema, que pode ser JSON, AVRO ou Protobuf, depois irá enviar para o registry afim de se garantir que ele já está registrado. Na mensagem enviada os primeiros bytes são reservados ao armazenamento do identificado do Schema. Sendo bem simplista, o schema registry é um CRUD de schema que associa cada tópico a um schema e suas versões. Se eu enviar uma mensagem com um schema diferente, ela será adicionada ao tópico como uma nova versão e eu posso consultar todas as versões existente, assim como alterar a validação de compatibilidade dos schemas.

A grande dificuldade de se testar o Schema Registry é que o cliente é implementado dentro do Serializar/Deserializer do Apache Kafka. Como vimos na primeira parte, os serializers podem ser alterados pois as propriedades usadas para criar o `TopologyTestDriver` são diferentes das usadas no `KafkaStreams`. Mas algumas vezes não é possível fazer essa diferenciação, pois aquele é o serializer padrão e em alguns casos o serializer é definido pela topologia.

A documentação da Confluent não ajuda muito quando falamos de testes, essa é a maior insatisfação ao se usar qualquer produtos deles, mas descobrimos olhando o [código fonte](https://github.com/confluentinc/schema-registry/blob/master/avro-serializer/src/main/java/io/confluent/kafka/serializers/AbstractKafkaAvroSerDeConfig.java#L41) que existe uma maneira de se fazer o teste. Depois quem encontramos isso foi possível ver que essa solução é bem conhecida, mas não há menções dela na documentação.

No trecho de código abaixo conseguimos criar um mock do cliente do Schema Registry, mesmo usando o [`Serde`](https://kafka.apache.org/34/javadoc/org/apache/kafka/common/serialization/Serde.html) padrão para AVRO e foi possível registrar os schemas desejados. Repare que os nomes do tópicos são `input`, `join` e `output`, mas internamente o Schema Registry adiciona os sufixos `-value` para o schema da mensagem e `-key` para a chave (_nós usamos String da massa_). Cada schema desejado deve ser configurado se usando a classe `MockSchemaRegistry` que criará um cliente local sem usar nenhum servidor web.

```java
[...]

topologyProps.setProperty(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, GenericAvroSerde.class.getName());
topologyProps.setProperty(AbstractKafkaSchemaSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, "mock://dummy1");

[...]

SchemaRegistryClient srClient = MockSchemaRegistry.getClientForScope("dummy1");
srClient.register("input-value", new AvroSchema(inputSchema));
srClient.register("join-value", new AvroSchema(inputSchema));
srClient.register("output-value", new AvroSchema(joinedSchema));

[...]

MockSchemaRegistry.dropScope("dummy1");
```

## Conclusão

Apesar do Stream do Apache Kafka parecer muito limitado para testes, é possível construir boas suites se separarmos a Topologia. Todo código deve ser testado de forma rápida e eficiente, por isso eu sempre recomendo a criação de testes unitários para que tenhamos uma resposta rápida.

O Schema Registry também permite o mock apesar de não ter uma documentação de fácil acesso sobre o assunto.
