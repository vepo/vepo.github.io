---
title: Log Cleanup no Kafka
published: true
permalink: /posts/log-cleanup-no-kafka
description: Como o Kafka limpa as informações antigas? Quais parâmetros configurar?
tags: [Kafka, Apache Kafka, Microservices]
series: Entendendo o Kafka
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/1os85b4rmdpauz3yjbsu.jpg
publish_date: 2020-11-27 16:10:00 +0300
---

Ao ler o livro [Designing Event-Driven Systems](https://www.confluent.io/designing-event-driven-systems/), tive a impressão que o Kafka atua exatamente como uma base de dados. Essa é uma informação falsa. Ele pode atuar como uma base de dados, desde que seja configurado para. 

Nesse post vou mostrar algumas configurações de tópicos que deve ser feitas para que o dado seja persistente e não efêmero.

# Partições e Segmentos

Espero que você já conheça alguns elementos importantes de um tópico, como Partições e Fator de Replicação. Caso não conheça, leia [Anatomia de um Tópico](https://dev.to/vepo/anatomia-de-um-topico-25da) para podermos conhecer basicamente como funciona um tópico.

No post anterior, só entrei até o detalhe do número de partição, pois essa é a parte importante quando falamos de **ordenação de mensagens**. 

Já quando falamos de Cleanup, precisamos introduzir Segmentos. Cada partição, é subdividida em Segmentos. Segmentos contém os dados ordenados sequencialmente (um arquivo de log), assim como a partição. Ao escrever, o Broker escreve apenas ao final do último segmento da partição. Mas os dados são lidos sequencialmente pelos consumers.

![Segmentos](https://dev-to-uploads.s3.amazonaws.com/i/6r0v1w4vphys98eh76xp.png)

Se formos fazer um levantamento nas configurações de um tópico, podemos ver que muitas das propriedades são referentes não somente ao tópico, mas ao segmento.

| Propriedade | Descrição | Valor Padrão |
| ----------- | --------- | ------------ |
| [`segment.bytes`](https://kafka.apache.org/documentation/#segment.bytes) | Tamanho do arquivo de segmento. | 1073741824 (1 GB) |
| [`segment.index.bytes`](https://kafka.apache.org/documentation/#segment.index.bytes) | Tamanho do arquivo de index do segmento. | 10485760 (10 MB) |
| [`segment.jitter.ms`](https://kafka.apache.org/documentation/#segment.jitter.ms) | O jitter aleatório máximo subtraído do tempo de rolagem do segmento programado para evitar sobrecargas. | 0 |
| [`segment.ms`](https://kafka.apache.org/documentation/#segment.ms) | Idade máxima do segmento. O Kafka fará a rolagem para garantir sua limpeza | 604800000 (7 dias) |

Todos esses valores também podem ser configurados por cluster. A configuração de cluster é usando como padrão, caso o valor não seja configurado no Tópico.

| Configuração do Tópico | Configuração do Broker |
| ---------------------- | ---------------------- |
| `segment.bytes` | `log.segment.bytes` |
| `segment.index.bytes` | `log.index.size.max.bytes` |
| `segment.jitter.ms` | `log.roll.jitter.ms` | 
| `segment.ms` | `log.roll.ms` | 

Dado os valores de `segmento.ms` e `segment.bytes`, o Kafka decidirá quando um segmento será finalizado para que outro seja inicializado.

O arquivo de index, como o nome já diz, é um índice que mapeia em qual posição do arquivo de offset uma mensagem está armazenada, garantindo assim ao Kafka que qualquer mensagem seja lida em tempo constante.

Há também um outro arquivo de index, o `timeindex`. Este tem como função criar um index baseado no timestamp da mensagem.

# Políticas de Limpeza

Mas o que o Kafka faz com mensagens antigas? Isso é configurável por Tópico ou no Cluster.

Essa configuração é muito importante se você usa seu Cluster como Fonte de Verdade ou caso você precise fazer um reset de todo pipeline.

Para configurar é preciso alterar o valor de `cleanup.policy` (ou `log.cleanup.policy` para o Cluster). Essa propriedade aceita os valores `compact` e `delete`. Por padrão, essas propriedades vêm como `delete`. 


## Delete 

Quando a política de limpeza selecionada é delete, o Kafka vai remover o segmento baseado na sua idade ou no tamanho da partição.

| Propriedade | Descrição | Valor Padrão |
| ----------- | --------- | ------------ |
| [`retention.ms`](https://kafka.apache.org/documentation/#retention.ms) | Idade máxima de um segmento | 604800000 (7 dias) |
| [`retention.bytes`](https://kafka.apache.org/documentation/#retention.bytes) | Tamanho máximo da partição | -1 (desabilitado) |

Vale lembrar que essas duas propriedades podem também ser configuradas por Cluster.

| Configuração do Tópico | Configuração do Broker |
| ---------------------- | ---------------------- |
| `retention.ms` | `log.retention.ms` |
| `retention.bytes` | `log.retention.bytes` |


## Compactação

A compactação do Log vai fazer uma limpeza, mas garantindo que você terá ao menos a última mensagem enviada por chave. Assim teremos apenas a última informação de cada chave.

A compactação não irá alterar os offsets das mensagens, uma mensagem é imutável. Irá apenas remover mensagem com `offset` inferior a última mensagem de cada chave.

Mensagens anda podem ser recebidas, mesmo depois de removidas, isso é feito baseado na propriedade [`delete.retention.ms`](https://kafka.apache.org/documentation/#delete.retention.ms). Após esse tempo se esgotar a mensagem não será recebida.

Uma mensagem apagada, significa que novos consumidores não a receberão. Consumidores que já estejam recebendo mensagens não perceberão que o histórico foi alterado, a não ser que este tenha seu offset reiniciado.

A compactação ocorre quando o segmento é finalizado.

# Implicações

Ao desenvolvedor e arquiteto, uma pergunta deve ser feita. Quais as implicações da escolha da política de limpeza?

Um Cluster terá suas configurações padrão, mas cada Tópico pode ter sua própria configuração.

## Delete

Ao se escolher por remover mensagens de um Tópico, deve-se ter ciência que novos consumers não receberão mensagens antigas. Vamos imaginar que, com os valores padrões, a idade máxima de uma mensagem será 14 dias. Assim, se um tópico é considerado fonte de verdade, deve ter os valores de `retention.ms` e `retention.bytes` configurados corretamente.

Para se calcular o volume de dados armazenado por Tópico, é preciso levar em consideração o tamanho médio de uma mensagem, o número de mensagens por dia e o tempo de retenção de uma mensagem. Essa é uma informação que o Arquiteto de Software tem que ter, e mesmo que não tenha, deve estimar baseado nas estatisticas da aplicação.

## Compactação

Ao se escolher compactar segmentos de um Tópico, deve-se ter ciência que uma mensagem não deve conter apenas uma atualização de estado, mas a informação completa. Caso haja apenas atualização de estado, haverá perca de dados.

Para se calcular o volume de dados armazenado por Tópico, é necessário ter ciência do número de chaves únicas e o tamanho médio da mensagem, e adicionar o tamanho máximo de um segmento.

# Conclusão

Kafka pode ser usado como Fonte de Verdade, mas antes deve-se conhecer a fundo como configurar. As configurações padrão garantem que uma mensagem ficará armazenada por entre 7 e 14 dias, mas isso pode ser alterado de acordo com os requisitos do sistema.

---

![Hard Disk](https://dev-to-uploads.s3.amazonaws.com/i/1os85b4rmdpauz3yjbsu.jpg)

Foto de **Azamat E** no [**Pexels**](https://www.pexels.com/pt-br/foto/analogico-analogo-aparelhos-armazenamento-117729/).