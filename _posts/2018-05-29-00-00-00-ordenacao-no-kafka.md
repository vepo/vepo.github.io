---
title: Ordenação no Kafka
permalink: /posts/ordenacao-no-kafka
published: true
description: Procurando entender melhor o Kafka, fiz um resumo de como o Kafka garante a ordenação das mensagens entregues a ele.
tags: [Apache Kafka]
cover_image: /assets/images/rio-fluindo.webp
publish_date: 2018-05-29 12:00:00 +0300
last_modified_at: 2023-09-05 19:40:00 +0300
original: "https://medium.com/@vepo/ordena%C3%A7%C3%A3o-no-kafka-953721ee7468"
---

Procurando entender melhor o Kafka, fiz um resumo de como o Kafka garante a ordenação das mensagens entregues a ele.

# O que é?

Caso não saiba o que é o Kafka, a primeira resposta é muito mais do que você imagina. Alguns imaginam ele ser um broker de mensagens, o que no fundo ele é, mas as funcionalidades feitas em cima disso dão infinitas possibilidades.

Assim, defini-lo apenas como um broker de mensagens é errado. Ele é uma plataforma de _Streaming_. Podendo atuar como broker, base de dados e muito mais.

# Ele garante ordenação de mensagens?

Sim e não!

Dependendo do uso que você faz dele, você pode ter a ordenação garantida. Para isso você tem que entender sua arquitetura.

# Arquitetura do Kafka

Para começar, o Kafka é um cluster. São vario servidores a fim de garantir que não haja um [Ponto Único de Falha](https://en.wikipedia.org/wiki/Single_point_of_failure). Caso você esteja construindo um cluster na nuvem, escola regiões diferentes para cada nó do cluster.

Outro ponto do Kafka, é que ele escreve as mensagens em arquivos de Log. Cada mensagem é simplesmente escrita em um arquivo e lida dele, sem muito processamento. A leitura dela é feita com base em um _offset_.

Como é um cluster, não existe somente um arquivo de Log, eles são divididos em _partitions_. Assim a mensagem é enviada para um log especifico dentro de uma _Partition_.

![Anatomia de um Tópico](/assets/images/kafka/topico.png)

Um tópico seria composto por uma ou mais partição de um arquivo de log.

Como é escolhido qual mensagem vai para qual _partition_?

Cada mensagem pode ser associada a uma chave. Quando a mensagem é associada a uma chave, a partição é escolhida de acordo com a chave. Quando nenhuma chave é associada, a mensagem é distribuída pelas partições disponíveis.

Simples?

# Garantindo a Ordenação

Voltemos a pergunta: como garantir a ordenação? Na verdade, a pergunta é: Que tipo de ordenação você precisa?

## Ordenação Relativa

Se seu sistema precisa de uma ordenação relativa, por exemplo, todas as mensagens relacionadas a um produto devem vir ordenadas, então você pode criar um tópico com várias partições e usar o `productId` como chave.

```bash
./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 10 --topic product
```

```java
Properties configProperties = new Properties();
configProperties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
configProperties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.LongSerializer");
configProperties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, "org.vepo.MySerializer");

Producer<Long, Product> producer = new KafkaProducer<>(configProperties);
ProducerRecord<Long, Product> rec = new ProducerRecord<>("product", product.getId(), product);
producer.send(rec);
in.close();
producer.close();
```

No exemplo acima, criei um tópico com 10 partições e 3 replicas cada partição e garanto que as mensagens são entregues na ordem, para cada produto.

## Ordenação Absoluta

Caso queira garantir uma ordenação absoluta. A garantia de ordenação está na configuração do Tópico. Nesse caso você terá que criar um tópico com uma única partição.


```bash
./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic users
```

Assim, quando o cliente se conectar ao tópico, a leitura da partição terá sua ordem garantida.

## Não ordenado

Caso ordenação não seja um requisito, você pode criar quantas partições quiser, mas se for usar chaves, garanta que elas serão igualmente distribuídas entre as partições. Para garantir isso, basta não usar chaves sempre iguais.