---
title: O que é o Apache Kafka
permalink: /posts/o-que-e-o-apache-kafka
published: true
description: Nesse artigo vou explicar brevemente o que é o Kafka e qual sua finalidade
cover_image: /assets/images/capas/livros-papeis.jpg
tags: [Apache Kafka, Messaging, Middleware, Microsserviços]
series: Entendendo o Kafka
publish_date: 2020-02-07 11:46:34 +0300
original: https://dev.to/vepo/o-que-e-o-apache-kafka-3kpk
---

Esse artigo é uma [reescrita de um que escrevi 2 anos atrás](https://medium.com/@vepo/entendendo-o-kafka-bf64169e421f). Naquela época estava tentando entender como funcionava esse middleware tão importante em sistemas distribuídos. Depois trabalhei na reestruturação de um sistema bem complexo usando Kafka como base de verdade.

# O que é?

Antes de Entender o que é Kafka, precisamos entender um pouco de Sistemas Distribuídos.

## Pub/Sub

Dentre os padrões de arquiteturas de Sistemas Distribuídos há o [Pub/Sub](https://cloud.google.com/pubsub/docs/overview?hl=pt-br). Quando desenhamos um sistema, ao enviar uma mensagem, há duas questões básicas: 

1. Para quem enviaremos? 
2. Como enviaremos?

Quando usamos APIs REST (ou gRPC) estamos limitados a conhecer o destinatário e enviar para todos os destinatários que estão esperando essa mensagem. Usando um middleware Pub/Sub não precisamos nos preocupar com isso.

Em uma arquitetura Pub/Sub, temos duas perguntas básicas para fazer ao se enviar uma mensagem:

1. Para quais Tópicos enviaremos essa mensagem?
2. Qual o formato que será a mensagem?

Pub/Sub é baseado no conceito de Tópico. Tópico é como se fosse um canal, quem subscreve a um Tópico irá receber todas as mensagens enviadas nele. Quem envia a mensagem não sabe quem irá receber, e vice versa! 🧐 

## O Kafka

Kafka estende o conceito de Pub/Sub ao seu limite. O que de certa forma por o tornar bem mais complexo que seus similares como [RabbitMQ](https://www.rabbitmq.com/), [ActiveMQ](https://activemq.apache.org/), ou o [SQS](https://aws.amazon.com/pt/sqs/)/[SNS](https://aws.amazon.com/pt/sns/) da Amazon.

Com o Kafka você pode:

1. Configurar o tempo de armazenamento de cada Tópico.
  * Por padrão o [retention.ms](http://kafka.apache.org/documentation/#topicconfigs) de um Tópico é configurado para 604800000 ms (7 dias!)
2. Criar vários _Consumers_ concorrentes e garantir a forma de funcionamento deles!
  * Uma Mensagem ser recebida por todos os _Consumers_
  * Uma Mensagem ser recebida por apenas um _Consumer_
  * Uma Mensagem ser recebida por _Consumers_ Diferentes!
  * Etc... Com o Kafka qualquer tipo de configuração é possível
3. Escalonamento fácil. 
  * Fácil de adicionar um novo nó Kafka
  * Fácil de adicionar um novo _Consumer_/_Producer_
4. Reprocessamento de mensagens
  * É possível reprocessar todas as mensagens de um Tópico/_Consumer_ específico
5. Sem [Ponto Único de Falha (SPOF)](https://pt.wikipedia.org/wiki/Ponto_%C3%BAnico_de_falha)
6. Criar Streaming de Eventos
7. Tratar Streaming de Eventos como Base de Dados

Essas duas últimas features são bastantes complexas e não devem ser utilizadas sem muito experimentação prévia.

# Referência Literária

Há um termo comum que muitos não devem conhecer que é a [Burocracia Kafkaniana](https://www.jornalopcao.com.br/colunas-e-blogs/contraponto/burocracia-brasileira-e-mais-kafkiana-do-que-kafka-56504/). Talvez se você é que nem eu, que conhece a literatura de Franz Kafka, mas nunca a leu, só sabe que ele vira uma barata, você não saberá que ele tinha horror a burocracia e que isso está expresso nos livros dele. 

Talvez esse nome se refere ao problema que o Apache Kafka resolve. Seu sistema não precisa ser que nem Guichês do Detran, vai de um para outro, para outro... indefinidamente!!!

![A Barata](https://dev-to-uploads.s3.amazonaws.com/i/akka1r41bfnwlf4hrjpg.jpg)

# Conclusão

Se você está construindo um sistema que demandará um nível de complexidade ainda desconhecido, mas já seguro que será bastante complexo. Você pode considerar de usar o Kafka para delegar a responsabilidade de integração de cada serviço.

Com o Kafka, cada serviço deve se preocupar em:

1. Gerar Eventos
2. Ouvir os Eventos interessados

Assim há um grande desacoplamento dos serviços. Você pode criar uma Loja virtual que apenas emite um evento de *CompraEfetuada* gerando assincronamente: 
1. Um serviço de EmitirNotaFiscal
2. Um serviço de ProcessarPacote
3. Etc...
4. Etc... no tempo! Daqui a 1 semana você pode criar um novo serviço e usar TODOS esses eventos! 😊😊😊😊

_To be continue..._