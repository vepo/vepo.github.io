---
title: Arquitetura Event-Driven
published: true
permalink: /posts/event-driven-architecture
description: Nesse post vamos fazer uma pequena introdução do que é uma Arquitetura Event-Driven (EDA) e o que a diferencia de uma arquitetura Cliente-Servidor.
tags: [Event-Driven Architecture, Apache Kafka, Arquitetura]
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/g87dtn83anqssn9yw4q6.jpg
publish_date: 2022-04-01 11:00:00 +0300
---

Nesse post vamos fazer uma pequena introdução do que é uma Arquitetura Event-Driven (EDA) e o que a diferencia de uma arquitetura Cliente-Servidor. Mas antes de falarmos especificamente sobre EDA, vamos recapitular alguns conceitos sobre Sistemas Distribuídos que podem ser muito úteis para caracterizar cada um dos sistemas.

# Recapitulando

## O que é uma Arquitetura?

Resumidamente, uma arquitetura é uma abstração do software em execução em vários níveis. Todo software vai possuir algumas caracteristicas que podem ser associadas a alguns padrões comuns. Um exemplo é quando falamos de uma aplicação linha de comando, já sabemos o que significa e estamos falando de uma pequena base de código que será executada em uma máquina especifica. Mas se falamos de um sistema web, podemos estar falando de um conjunto de softwares que interagem entre si através de conexões IP e esse sistema pode conter também uma aplicação de linha de comando. Tanto a arquitetura da linha de comando como do sistema web são arquiteturas válidas, mas em níveis diferentes, quando falamos do sistema web, podemos omitir o programa de linha de comando caso ele não seja relevante para o entendimento do que está sendo feito. É como se tivessemos aumentando e diminuindo o zoom da nossa architetura e omitindo algumas informações quando elas deixam de ser relavantes no que queremos observar.

Toda arquitetura irá conter uma série de Componentes, Conectores e Dados. Para detalhar o que é cada um dos elementos, veja a thread abaixo que fiz no twitter em fevereiro de 2021 ao ler a tese que define a arquitetura REST.

{% twitter https://twitter.com/dev_roadmap/status/1358053172992950272 %}

## O que é um Estilo Arquitetural?

Ao definirmos uma arquitetura, vamos encontrar alguns padrões em comum. Esses padrões são definidos por um conjunto de regras e essas regras é o que chamamos de Estilo Arquitural. Ao definir um estilo arquitural, já colocamos que nossa aplicação deverá ter alguma similaridade com outras aplicações do mesmo estilo arquitetural. Logo definir um estilo arquitetural é criar uma série de regras que devem ser seguidas, totalmente ou em parte, por uma aplicação.

Um estilo não é uma imposição, é uma constatação ou um direcionamento. Aplicações devem adaptar o estilo arquitetural para tentar responder ao seu negócio, caso o estilo torne complicado resolver o problema de negócio, pode significar que a escolha do estilo está errada. Nesse caso, é preciso reavaliar a arquitetura do sistema. Vamos ver como isso se dá mais a frente.

## O que são Sistemas Distribuídos?

Segundo Van Steen e Tanembaum, Sistemas distribuídos _são um conjunto de elementos computacionais autônomos que aparentam ser um único sistema coerente para os seus usuários_. Esses sistemas podem ser heterogêneos, isso significa que não precisam estar rodando na mesma máquina, ou sistema operacional, ou mesmo não precisam ser implementados na mesma linguagem. Eles interagem através da rede usando trocas de mensagens e essa heterogeneidade é garantida pelo Middleware. Middleware é a camada de software que fornece abstração de programação e pode mascarar heterogeneidade. Um middleware pode ser composto por processos, bibliotecas e frameworks.

Um sistema distribuído pode ser síncrono ou assíncrono. Quando o sistema é caracterizado como síncrono, significa que cada etapa de processamento tem um limite especifico de tempo, cada mensagem deve ser recebida e processada dentro de um intervalo de tempo especificado. Quando o sistema é assíncrono, significa que não há limitações de tempo para o processamento. Esses sistemas podem ter conexões síncronas ou assíncronas. É importante não confundir conexão síncrona com sistema síncrono. Quando falamos de conexão síncrona, significa que quando um processo envia uma mensagem, ele irá esperar por uma resposta e uma conexão assíncrona significa que quando um processo envia uma mensagem, ele não vai esperar por uma resposta.

Conexões também podem ser caracterizadas pelo número de elementos que a compões. Podemos afirma que uma conexão é *um-para-um* (_one-to-one_) ou *um-para-muitos* (_one-to-many_). Quando falamos de um-para-um, dizemos que uma mesma requisição só será processada por um componente, mas quando falamos de um-para-muitos uma mesma requisição pode ser processada por muitos elementos.

# Definição de uma Arquitetura Cliente-Servidor

Antes de falarmos de uma Arquitetura Event-Driven precisamos entender o que é uma Arquitetura Cliente-Servidor e quais as limitações dela são enderaçadas. Resumidamente um sistema Cliente-Servidor é quando cada compomente da arquitetura tem um papel bem definido, o **um cliente** elabora uma requisição, envia para **um servidor** que irá ler e responder essa requisição síncronamente. A conexão entre cliente e servidor é síncrona e para cada requisição há uma resposta. Nessa definição eu coloquei em destaque que ela sempre envolve um cliente e um servidor, porque toda comunicação cliente servidor é **um-para-um**, não havendo comunicação **um-para-muitos**.

A natureza **um-para-um** do estilo cliente-servidor já expões uma das limitações existente. Ao se adicionar um novo servidor, é preciso que os clientes saibam da existência dele. Não estou falando de instância, mas de tipo de servidor. Uma nova instância de um servidor pode ser adicionada e o processo de service discovery irá fazer com que o cliente encontre esse servidor, mas ele deverá ser de um tipo ou uma API já conhecida pelos clientes.

Outra limintação é a natureza síncrona da comunicação, pois para processos demorados será necessário se criar toda infraestrutura para criação do processo. É possível criar eventos assíncronos em sistemas cliente-servidor, mas isso traz complexidade ao processo e a API.

Com essa duas limitações, podemos dizer que sistemas cliente-servidor tem um alto acoplamento, pois a cada novo serviço adicionado, é preciso que outros serviços saibam da sua existência, isso significa que o cliente precisa saber quem é o servidor e qual a interface exposta pelo servidor. 

Uma outra limitação é que quando um cliente depende de um servidor, ele está automaticamente diminuindo a sua disponilidade. A disponibilidade real de um serviço é definida pela multiplicação da sua disponibilidade pela disponibilidade de todos os serviços que ele depende. Isso significa que se meu serviço tem uma disponibilidade de 99,9% e depende de outro com também 99,9%, a disponibilidade real dele é 99,8%. O número pode parecer pequeno, mas quando colocado em minutos por ano pode surpreender. Se esse serviço estiver indisponível, é preciso que haja uma retentativa e temos mais uma complexidade no sistema que precisa se respondida: falhamos a requisição ou tentamos novamente? Seja qual for a resposta, estamos adicionando latência e complexidade.

Uma arquitetura cliente-servidor não precisa ser obrigatóriamente implementada usando HTTP, mas este é o protocolo mais comum hoje em dia a usar essa arquitura. Assim todo estilo arquitetural que usa HTTP também é cliente-servidor, como o REST, GraphQL e todas as implementaç~eos RCPs (como gRPC, SOAP, etc).

# Uma solução desacoplada

Logo, para buscarmos uma solução um pouco melhor para os nossos problemas, precisamos ter três objetivos em mente:

1. Diminuir o acoplamento
2. Diminuir a latência
3. Controlar a complexidade

Esses objetivos devem ser endereçado durante o design do sistema. Isso significa que um sistema cliente-servidor precisaria ter sua arquitetura refatorada para alcançar esses objetivos, o que não é simples e possa ser feito em um passe de mágica.

Podemos **diminuir o acoplamento** ao propor que um serviço só deva conhecer a si mesmo e as mensagens que ele mesmo emite e recebe. Ele não deve conhecer quais são os outros serviços e nem quais APIs eles implementam.

Podemos **diminuir a latência** ao propor que nem todas as trocas de mensagem sejam síncronas, ao se fazer uma requisição, várias mensagens possam ser emitidas e processos iniciado, mas a requisição pode retornar sem saber como esses processos terminaram.

Podemos **controlar a complexidade** propondo que um sistema não deva controlar a chamada a outros sistemas. Cada sistema deve emitir mensagens informando o resultado do seu processamento e todo o processamento se dá assincronamente.

Observe que refatorando o design do sistema, podemos criar processos assíncronos para resolver esses problemas, mesmo com conexões síncronas. Essas mudanças podem ser feitas por HTTP? Podem, mas a complexidade para sincronia e retentativa seria exagerada. É preciso um Middleware que encapsule essa complexidade.

# Caracterizando uma Arquitetura Event-Driven

Em uma EDA, cada sistema deve emitir **Eventos** que capturam a mudança de estado, **Comandos** para execução de processos ou consultas ou **Documentos** que são mensagem que contém apenas dados. Esses eventos são criados por **Publishers** e podem ser consumidor por **Subscribers** ou **Streamers**. O fluxo de dados é chamado de **Stream**, e os Streamers são processos que apenas transformam o dado já existente. Streamers operam em tempo real, processando mensagens assim que elas estão disponível no broker. O tempo de processamento pode aumentar caso o paralelismo não seja suficiente, impactando seriamente a latência. Processos **Subscribers** não usam os dados podendo também emitri eventos, nesse caso são também caracterizados como **Subscribers**. 

Todo evento pertence a um, e exatamente um, **Canal**. Os eventos são enviados para um **Broker**, que deve coordenar qual processo irá ler qual mensagem. Ao contrário de uma API cliente-servidor, um canal pode ser qualificado como **um-para-um** e **um-para-todos** assim a entrega da mensagem pode ser feita até uma vez (_at most once_), exatamente uma vez (_exactly one_) ou ao menos uma vez (_at least once_).

Um evento pode ser caracterizado ainda por ser um **Evento de Notificação** (_Event Notification_) ou um **Evento de Transporte de Estado** (_Event-Carried State Transfer_). Um evento de notificação apenas informa que um evento ocorreu e o evento de transporte de estado contém todas as informações relacionadas ao evento. 

Todos os tipos de eventos possuem dados no **Corpo da Mensagem** (_Payload_), assim como Headers, Metadados e Timestamps. O corpo da mensagem pode ser em qualquer formato, sendo Apache Avro, Protobuf e JSON os mais comuns.

Quando temos um sistema Cliente-Servidor, algum serviço terá que atuar como **Orquestrador** fazendo a chamada e o controle de transação de todo o processo. Mas em um sistema Event-Driven essa função não existe, ao contrário temos um **Coreografia** em que as responsabilidades são distribuídas e cabe ao broker enviar as mensagens em tempo real a cada sistema independentemente. Por ser um sistema naturalmente distribuído, o controle de transação é impossível, quase sempre apresentando **Consistência Eventual** de Dados. 

As transações podem ser implementadas com a implementação de um padrão chamado **Sagas**, em que cada processamento irá emitir uma mensagem de sucesso e fracasso, de forma que os outros sistemas possam ser informados e possam atuar para mitigar o erro ou o próprio sistema possa fazer uma retentativa. Quando uma messagem não é processada corretamente, ela pode ser enviada para um canal especifico para que posteriormente possa haver uma retentativa, esse padrão é conhecido como **Dead Letter Queue**.

Os brokers também podem ser caracterizados como **Message Broker** e **Event Streaming**. Um message broker irá enviar a mensagem para todos os subscribers disponível no momento que a mensagem é gerada. Já um event streaming armazenará um histórico de mensagens (em formato _log_) para que possa ser processado posteriormente ou mesmo para possibilitar o reprocessamento dessas mensagens.

Para realizar o tracking de mensagens, é necessária a criação de um **Correlation ID** que poderá calcular o tempo de processamento e associar o log de execução das aplicações com as mensagens sendo processadas. Esse id de correlação não precisa ser armazenado na mensagem, ele pode fazer parte dos cabeçalhos.

O canal é a forma de armazenamento de toda informação existente em um broker. Para que o sistema seja suscetível a falhas, todo dado dentro dele pode ser **replicado**, assim caso um broker falhe, outro pode assumir a função sem prejuízo a execução. Para que o sistema escale, o canal também pode ser **particionado**, de forma que cada partição atue independentemente. Os canais não possuem indices para navegar, todas as mensagens são entregues em ordem cronológica dentro da sua partição.

A documentação de uma Arquitetura Event-Driven é complexa se usarmos as notações UML, mas ela pode ser mais simples se usarmos **Business Process Model and Notation** (BPMN). Os processos e as mensagens podem ser documentadas, assim como as decisões. Para documentar a topologia dos canais existe o projeto [AsyncAPI](https://www.asyncapi.com/) que procura criar ferramentas de visualização e documentação similares ao OpenAPI.

# Conclusão

Essa é uma pequena descrição de todo o ecossistema de aplicações Event-Driven. Ela não é exaustiva, tenta focar nos conceitos e tecnologias.