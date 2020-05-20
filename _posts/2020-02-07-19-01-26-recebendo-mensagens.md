---
title: Recebendo Mensagens
published: true
description: Exemplo de como receber uma mensagem para um broker Kafka
tags: [Apache Kafka, Messaging, Middleware, Microsserviços]
series: Entendendo o Kafka
publish_date: 2020-02-07 16:01:26 +0300
cover_image: "https://dev-to-uploads.s3.amazonaws.com/i/9qhf82wsvoi0ibnsi1gb.jpg"
comments: true
original: "https://dev.to/vepo/recebendo-mensagens-15b5"
---

Ao iniciar o post **Enviando Mensagens**, falei que enviar é simples. Se você não achou simples, depois de ver a complexidade de receber uma mensagem verá que *sim, é simples!*

# Parâmetros comuns

Para configurar um _consumer_ são necessários mais parâmetros. Os parâmetros abaixo são similares ao do _producer_ com excessão da troca de Serializador por Desserializador, visto que a mensagem deve ser agora transformada de byte[] para um objeto.

* **BOOTSTRAP_SERVERS**: Conjunto de pares IP:PORTA para acessar o cluster. Por exemplo, `kafka-1:9092,kafka-2:9092` irá acessar o cluster que contem os duas instâncias `kafka-1:9092` e `kafka-2:9092`
* **KEY_DESERIALIZER_CLASS**: É a classe que fará a desserialização da Chave. O que é e como é usada a chave, vamos explicar posteriormente. Deve ser uma implementação da interface `org.apache.kafka.common.serialization.Deserializer`.
* **VALUE_DESERIALIZER_CLASS**: É a class que fará a desserialização do Valor. Não há mensagem sem um valor. Deve ser uma implementação da interface `org.apache.kafka.common.serialization.Deserializer`.

Dados os parametros abaixo, agora é preciso configurar o **GROUP_ID**. Antes de escolher um, é necessário pensar em como será a leitura dessa mensagem.

# _Read once_

Um _Producer_, escreve uma mensagem por tópico. Ele não se preocupa como essa mensagem será lida. Já o _Consumer_ deve se preocupar para que a mensagem não apenas uma vez, não menos que isso.

No Kafka, uma mensagem é recebida apenas uma vez por um _Consumer_ de um **GROUP_ID**. Isso que dizer que, se dois processos diferentes tiverem consumers com o mesmo **GROUP_ID**, essa mensagem será consumida por apenas um. 

Essa funcionalidade pode ajudar muito, mas pode também atrapalhar. O cuidado que deve ser tomado é:
* Para cada tipo de consumer, sempre escolher um **GROUP_ID** por tipo
* Tratar as mensagens como [idempotentes](https://pt.wikipedia.org/wiki/Idempot%C3%AAncia)

# Instanciando um _Consumer_

Para instanciar um consumer, então, são necessários os 4 parâmetros: **BOOTSTRAP_SERVERS**, **KEY_DESERIALIZER_CLASS**, **VALUE_DESERIALIZER_CLASS** e **GROUP_ID**.

{% gist https://gist.github.com/vepo/66ee3db0a6684cec90d8c1349a2a2e1d %} 

Pronto, criado o _Consumer_, deve-se fazer o pull e processar as mensagens. 

No exemplo acima, há uma condição de saida, mas isso é apenas para exemplo. Normalmente um programa que processas mensagens opera até ser interrompido.

# Conclusão

Criar um _Consumer_ para um Tópico Kafka é simples, não tão simples quanto um _Producer_. Deve-se atentar para quantos outros consumers vão concorrer pelas mensagens, se uma mensagem deve ser lida por um ou mais consumer. E ainda deve-se tratar a mensagem como se ela fosse repetida. 

Ficou com dúvida... alguns pontos ainda serão tradados. Mas pode perguntar!
