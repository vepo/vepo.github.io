---
title: Enviando Mensagens
permalink: /posts/enviando-mensagens
published: true
description: Exemplo de como enviar uma mensagem para um broker Kafka
tags: [Apache Kafka, Messaging, Middleware, Microsserviços]
series: Entendendo o Kafka
cover_image: "https://dev-to-uploads.s3.amazonaws.com/i/g87dtn83anqssn9yw4q6.jpg"
comments: true
publish_date: 2020-02-07 14:09:55 +0300
original: "https://dev.to/vepo/enviando-mensagens-5ab0"
---

Enviar mensagens no Kafka é bastante simples.

# Instanciando um Producer

Para configurar, é preciso basicamente apenas 3 parametros:

* **BOOTSTRAP_SERVERS**: Conjunto de pares IP:PORTA para acessar o cluster. Por exemplo, `kafka-1:9092,kafka-2:9092` irá acessar o cluster que contem os duas instâncias `kafka-1:9092` e `kafka-2:9092`
* **KEY_SERIALIZER_CLASS**: É a classe que fará a serialização da Chave. O que é e como é usada a chave, vamos explicar posteriormente. Deve ser uma implementação da interface `org.apache.kafka.common.serialization.Serializer`.
* **VALUE_SERIALIZER_CLASS**: É a class que fará a serialização do Valor. Não há mensagem sem um valor. Deve ser uma implementação da interface `org.apache.kafka.common.serialization.Serializer`.

{% gist https://gist.github.com/vepo/1468c5a3af73aff7e0fc78ae296ca589 %} 

Pronto, configurado o _Producer_, basta criar o objeto `ProducerRecord`, que irá associar mensagem/chave/tópico, e enviar ela.

No código acima, eu criei um simples cliente que lê todas as mensagens do STDIN e envia para o tópico em questão.

# Recomendações

* O envio é assíncrono, verifique se a mensagem foi realmente enviada e tente novamente caso negativo. Normalmente o cliente Kafka já faz algumas tentativas.
* Particione tipos de mensagens por chave, a ordem das entregas de mensagens só é garantida para mensagens com mesma chave.

# Conclusão

O envio de mensagens Kafka é simples e descomplicado, mas mesmo assim deve ser feito de forma cuidadosa para se garantir a entrega. Tendo a entrega da mensagem garantida, é certo que teremos o recebimento dela garantido.

Mais informações sobre Chave serão dadas quando formos falar de ordenação.

# Referências

Todos os códigos estão no repositório [vepo/kafka-articles](https://github.com/vepo/kafka-articles)