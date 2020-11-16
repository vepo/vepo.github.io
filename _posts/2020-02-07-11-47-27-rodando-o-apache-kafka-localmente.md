---
title: Rodando o Apache Kafka localmente
permalink: /posts/rodando-o-apache-kafka-localmente
published: true
description: Nesse artigo, vou mostrar como rodar localmente o Kafka em uma Máquina Windows.
tags: [Apache Kafka, Messaging, Middleware, Microsserviços]
series: Entendendo o Kafka
cover_image: "https://dev-to-uploads.s3.amazonaws.com/i/vjb2xa2hwzvtgdks1x9v.png"
publish_date: 2020-02-07 11:47:27 +0300
original: "https://dev.to/vepo/rodando-o-apache-kafka-localmente-412i"
---

Continuando a série de **Entendendo o Kafka**, vou criar aqui um pequeno tutorial de como rodar o Kafka localmente em ambiente Windows. 

Para desenvolvimento, recomendo usar containers Docker. Porém, para aprendizado vale a pena configurar um cluster manualmente.

# Configurando

1. Instale o JDK 8
2. Baixe a última versão do Kafka em [https://kafka.apache.org/downloads](https://kafka.apache.org/downloads)
   * Há várias versões baseadas na versão do Scala, escolha qualquer uma delas. Vamos usar a **kafka_2.12-2.4.0** por ela estar recomendada no site.
3. Extraia o arquivo
   * No Windows a extensão **.tgz** não é muito amigável, mas você precisa das ferramentas corretas. Dica, use o [7-Zip](https://www.7-zip.org/). Com ele dá pra extrair usando o menu de contexto do mouse. 
4. Feito! Não é necessário nenhuma configuração a mais. Para melhor organização eu sempre instalo em `C:\opt`, ficando o Kafka com o PATH `C:\opt\kafka`.


# Iniciando o Servidor Kafka

O Kafka depende do Zookeeper. Este é um serviço para sincronia de configurações. Provavelmente será removido em futuras release. Mas por enquanto é necessário.

Para iniciar o Kafka, abra duas linhas de comando e execute a partir da pasta de instalação do Kafka:

```
.\bin\windows\zookeeper-server-start.bat config\zookeeper.properties
```

```
.\bin\windows\kafka-server-start.bat config\server.properties
```

Pronto! Você tem um Kafka **_Up & Running_**!

## Testando o Cluster

Para testar o cluster, a instalação do Kafka já vem com alguns scripts preparados. 

Primeiro precisamos criar um tópico para enviar mensagens. Isso pode ser feito com a linha abaixo:

```
.\bin\windows\kafka-topics.bat --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
```

Após criado o tópico é só, a partir de duas janelas, executar as seguintes linhas abaixo:

```
.\bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic test --from-beginning
```

![Kafka Consumer](https://dev-to-uploads.s3.amazonaws.com/i/x6zzoik8zb1a66ytivow.png)

```
.\bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic test
```

![Kafka Producer](https://dev-to-uploads.s3.amazonaws.com/i/3plxrkla0kra0g7ga46p.png)

A primeira inicia um consumidor do Tópico `test` e a segunda um produtor. Cada mensagem escrita na segunda será enviada para a primeira.


# Conclusão

É fácil configurar um servidor Kafka para testes. Em outra oportunidade vou compartilhar como utilizar uma imagem docker, mas por enquanto apenas com o JDK 8 instalado é possível fazer essa configuração de qualquer ambiente.