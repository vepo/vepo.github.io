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

Nós recebemos como requisito que deveriamos processar mensagens diameter enviada através de um tópico Kafka. Ora, se é uma mensagem diamter, logo sabemos que por mais threads que tivermos, uma thread deve processar todas as mensagens de uma mesma sessão (sim, Diameter não é stateless). Por isso começamos com a solução simples:

```java

```