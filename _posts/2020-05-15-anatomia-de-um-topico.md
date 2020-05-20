---
title: Anatomia de um Tópico
published: true
description: Uma breve descrição de como funciona um Tópico do Kafka. Como garantir replicação e ordenação
tags: [Apacha Kafka, Java, Messaging, Microsserviços]
cover_image: "https://dev-to-uploads.s3.amazonaws.com/i/pvvsoor323buopn3db3k.jpg"
series: Entendendo o Kafka
comments: true
publish_date: 2020-05-15 20:05:21 +0300
original: "https://dev.to/vepo/anatomia-de-um-topico-25da"
---

Aprofundando um pouco mais no Kafka, precisamos entender o que é um Tópico e como ele se comporta. Tópico é um dos conceitos mais básicos do Kafka! Está presente em quase tudo. 

Sobre Tópico podemos falar:
- Um _Producer_ envia uma mensagem para um Tópico. 
- Um _Consumer_ se subscreve a um, ou mais, Tópicos.
- Um Tópico pode ser subscrito por um ou mais _Consumer_.

# Nomenclatura

Daqui pra frente, precisamos definir alguns nomes. Sempre que falamos de uma instalação do Kafka, estamos falando de um _broker_ Kafka, isso significa, um servidor ou uma instância. Esse _broker_ faz parte de um conjunto maior, que é o _cluster_ Kafka. O _cluster_ é um conjunto de _brokers_ que atuam como se fossem um sistema só. Os dados fazem parte do _cluster_ e podem estar em um ou mais _broker_.

# Criação 

Vamos olhar para criação de um Tópico para tentar entender mais:

```
.\bin\windows\kafka-topics.bat --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
```

Dada a linha acima podemos identificar alguns parâmetros para criação de um tópico:
- **bootstap-server**: Mesmo já especificado na criação do _Consumer_ e _Producer_. Identitica o _cluster_ onde será criado o tópico. É formado pelo **ip**:**porta** de cada _broker_ separado por virgula.
- **partitions**: Um Tópico é dividido em partições. Estas podem estar no mesmo _broker_ ou não. Normalmente elas são distribuídas entre _brokers_.
- **replication-factor**: Número mínimo de vezes que os dados desse tópico serão replicados. Caso tenha um fator de replicação maior que um, cada partição será replicada em outro _broker_.

![Anatomia de um Tópico](https://dev-to-uploads.s3.amazonaws.com/i/d0apb022msv68pyw0bk0.png)

Podemos assim definir que um Tópico é distribuído entre partições. Cada partição é uma armazena parte das mensagens enviadas, estas, por sua vez, são distribuídas entre as partições de acordo com a chave associada a ela. 

As mensagens são armazenadas sequencialmente dentro de uma partição, assim, cada mensagem terá associada um número de partição e um _offset. Este offset é a posição da mensagem dentro da partição.

# Distribuição

Ao se criar um tópico, as partições do mesmo são distribuídas entre os _borkers_. Não necessariamente todas as mensagens serão armazenadas juntas. 

Cada mensagem é envida para apenas uma partição, essa distribuição é feita baseada na chave associada a mensagem. Assim, mensagens com a mesma chave, irão para a mesma partição. **Isso é importante!**

# Estrutura de Arquivos

Uma partição é um arquivo de log. Quando o broker recebe uma mensagem, ela é adicionada ao final da partição. A essa mensagem é associado um offset.

Com isso para se localizar exatamente onde uma mensagem está armazenada é preciso observar os valores:

* topic
* partition
* offset

Todos esses valores estão presentes em [RecordMetadata](https://kafka.apache.org/20/javadoc/org/apache/kafka/clients/producer/RecordMetadata.html) e [ConsumerRecord](https://kafka.apache.org/20/javadoc/org/apache/kafka/clients/consumer/ConsumerRecord.html).

# Replicação

No Kafka, é possível haver replicação de dados. Para isso é preciso que exista ao menos um broker configurado.

Utilizando o parametro `replication-factor` da criação do tópico, cada partição será replicada em um broker diferente. Assim o valor máximo para esse parâmetro é o número de brokers existente.

# Ordenação das Mensagens

As mensagens de uma partição serão enviadas a apenas um consumer, não haverá mais de um consumer para uma partição. Assim, as mensagens da partição serão entregues em ordem cronológica.

Vale lembrar que o Kafka não garante a ordenação global das mensagens enviadas. Mas dada uma boa escolha da chave das mensagens, é possível garantir a ordenação das mensagens associadas. 

Por exemplo, se estamos consumindo mensagens de acesso de usuários. Podemos usar o id do usuário como chave, assim todas as mensagem de um mesmo usuário serão consumidas em ordem cronológica, evitando erros de consistência dos dados.