---
title: Entendendo o Kafka
permalink: /posts/entendendo-o-kafka
published: true
description: Uma breve introdução ao Apache Kafka
tags: [Apache Kafka, Java, Microservices]
cover_image: /assets/images/rio-fluindo.webp
publish_date: 2018-04-30 12:00:00 +0300
last_modified_at: 2023-09-25 23:00:00 +0300
original: "https://medium.com/@vepo/entendendo-o-kafka-bf64169e421f"
---

# O que é?

O Apache Kafka é muito mais que um Message Broker open source. Com uma grande comunidade e muita estabilidade possui muito mais funcionalidades do que a simples troca de mensagens entre produtores e consumidores.

Ele é bem mais complexo que seus similares **RabbitMQ**, **ActiveMQ**, ou o **SQS** da Amazon. Caso você deseja somente uma troca de mensagens entre serviços, não perca tempo usando o Kafka, há outros mais simples.

Por sua grande complexidade, algumas pessoas vêem o Kafka do ponto de vista limitado ao uso que fizeram. Algumas vêem como uma API assyncrona, outros como uma base de dados para eventos e outras como um substituto para um Service Bus (ESB). Todos esses uso são usos limitados da plataforma.

O que você precisa saber é que, se você precisa manter mensagens por longos períodos, reprocessar mensagens antigas, baixo acoplamento entre serviços e tolerância a falhas, então é o Kafka que você procura!

Segundo o livro [Designing Event-Driven System](https://www.confluent.io/designing-event-driven-systems), o Kafka é uma plataforma de Streaming. Há APIs de processamento de Stream e APIs para envio e recebimento de dados.

![Stream Data Platform](/assets/images/stream-data-platform.webp)

Você pode usar o Kafka como uma [Fonte da Verdade](https://en.wikipedia.org/wiki/Single_source_of_truth). Recebendo eventos e dados, processando os dados e construir pipelines de dados e complexas arquiteturas baseadas em eventos e dados.

# Para que usar?

Caso você não tenha contato com padrões de arquitetura de Microserviços, sugiro ler alguns artigos em [microservices.io](http://microservices.io/). Nos últimos anos, as aplicações web pararam de ser apenas um servidor monólito tratando todas as requisições sincronamente.

Hoje, uma única aplicação pode se constituida de vários serviços, todos atuando independentemente. O dado agora flui entre os serviços e nenhum deles tem o total controle de um único dado. São novos padrões arquiteturais para satisfazer requisitos como escalabilidade.

# Arquitetura

O Kafka é um broker que roda em cluster, para sistemas tolerante a falhas, é aconselhável que seja configurar mais de uma instância. Como é um cluster, ele roda usando o ZooKeeper para sincronia.

Ele recebe, armazena e distribui records. Um record é um dado gerado por algum nó do sistema que pode ser um evento ou uma informação. Ele é enviado para o cluster e o mesmo o armazena em uma partition do tópico.

Cada record possui um offset sequência, e o consumer pode controlar o offset que está consumindo. Assim, caso há a necessidade de se reprocessar o tópico, pode ser feito baseado no offset.

# Criando um cluster Kafka

Vamos criar um cluster Kafka usando docker? Bom, não é necessário "reescrever" a roda, já temos algumas imagens prontas, vamos usar a do Spotify! E criar uma imagem do Kafka é um pouco mais complexo do que apenas docker, ele depende do ZooKeeper, mas é um bom exercício de configuração.

Antes de começar é necessário ter instalado:

* Docker
* Virtualbox

Para isso crie uma `docker-machine`:

```bash
docker-machine create --driver virtualbox kafka-broker
```

Agora que temos uma docker-machine precisamos colocar ela como a ativa:

```bash
eval $(docker-machine env kafka-broker)
```

Pronto! Agora podemos executar os passos para criar um container usando a imagem do Spotify:

```bash
docker run -p 2181:2181 -p 9092:9092 --env ADVERTISED_HOST=`docker-machine ip \`docker-machine active\`` --env ADVERTISED_PORT=9092 spotify/kafka
```

Sucesso! Agora temos um cluster Kafka rodando dentro de uma docker machine. Para saber qual o IP dela, basta executar:

```bash
docker-machine ip kafka-broker
```

O comando acima retornará um IP, que deve ser usado como nosso broker. Para se usar os exemplos abaixo, substitua _localhost_ pelo IP.

# Produzindo Mensagens

A produção de mensagens no Kafka é mais simples que o consumo. Uma mensagem é produzida e enviada para um Tópico. Não é preciso especificar um schema para mensagem, a única preocupação entre produtor e consumidor é como ela será Serializada.

Sistemas mais antigos usavam XML, mas o tanto de dados gerados é muito grande para pouca informação. Hoje é muito usado o formato JSON, que é de fácil leitura humana e gera mensagens menores do que se usarmos XML. Uma boa dica é usar [Protobuf](https://github.com/google/protobuf), este gera mensagens mais compactas e pode haver suporte a alterações de _schemas_.

Para o produtor, você pode serializar suas mensagens em ByteArray e enviar, no exemplo abaixo usaremos o meio mais simples, apenas o envio de String.

{% gist https://gist.github.com/vepo/ddd1afc55d38165b61eab83371723541 %}


# Consumindo Mensagens

Como já disse anteriormente, para consumir uma mensagem sua única preocupação tem que ser a Serialização de dados. Esse é o maior contrato entre produtor e consumidor no Kafka.

O Kafka garante que todas as mensagens somente serão consumidas uma vez por cliente. Isso significa, se eu enviar uma mensagem para um tópico X, e tiver 1000 consumidores com o Client ID Y, somente um vai processar essa mensagem. Isso garante um bom desacoplamento e fácil escalabilidade. Você pode delegar toda a sincronicidade do processamento para o Kafka.

Para que uma mensagem seja consumida por dois consumidores diferentes, só usar dois client ID diferentes.

{% gist https://gist.github.com/vepo/b63ff8384941329485266999f99e2264 %}

# Outras funcionalidades

O Kafka permite usar os tópicos como tabelas, permitindo fazer _queries_ para aquisição de dados, isso pode ser usado para uma arquitetura baseada em Eventos.

Essa funcionalidade porém não é tão simples como é descrito na documentação. A serialização é um grande impeditivo e em muitos momentos o stream "_se perde_". Acredito que essa feature só é recomendada quando:

* Os dados são apenas incrementais
* Os dados não são relacionais
* Os dados são sequênciais

# Ordenação das mensagens

O Kafka permite que as mensagens sejam processadas em ordem, isso é habilitado com a configuração do número de partições de um mesmo tópico

Para maiores detalhes veja o post [Ordenação no Kafka](https://blog.vepo.dev/posts/ordenacao-no-kafka).

# Conclusão

Kafka é o middleware mais robusto no mercado para atuar se criar uma arquitetura baseada em Eventos.

Fácil de se usar, dá para se construir uma arquitetura baseada em eventos na qual cada novas funcionalidades podem ser plugadas, desplugadas e atualizadas sem a necessidade de deploys em todos os serviços.

Seu backend pode se preocupar com o mínimo para um rápido processamento, criando pipelines assíncronas complexas. Assim, um webcomerce pode finalizar a compra e apenas enviando uma mensagem disparar outras ações como Nota Fiscal, Estoque, E-mail, etc…