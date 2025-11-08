---
title: Padrões e Estilos Arquiteturais
published: true
description: | 
    Esse é o quarto post da série Conversas sobre Arquitetura. Nele, exploramos a diferença entre padrões e estilos arquiteturais, mostrando como cada um se aplica na construção de sistemas. Enquanto os padrões, como MVC e Hexagonal, focam em resolver problemas específicos de organização interna, os estilos, como REST e Event-Driven, definem como os componentes interagem entre si para alcançar atributos de qualidade. Descubra como combinar essas abordagens pode resultar em soluções mais flexíveis, testáveis e alinhadas aos objetivos do negócio.
tags: [Arquitetura de Software]
cover_image: /assets/images/capas/caderno-caneta.jpg
permalink: /posts/padroes-e-estilos-arquiteturais
series: Conversas sobre Arquitetura
publish_date: 2025-10-05 08:33:00 +0300
---

{% youtube Ub-RUQ_aQ8Q %}

Quando se fala de arquitetura, a primeira imagem que se vem a cabeça é a organização de um projeto. Se vamos usar uma Arquitetura Model-View-Controller (MVC) ou uma Arquitetura em Camadas ou até mesmo uma Arquitetura Hexagonal. Isso também é arquitetura, mas não é a única forma de se discutir arquitetura. Nessa seção quero discutir a diferença entre Estilos e Padrões Arquiteturais mostrando como eles podem ser usados.

Primeiro precisamos definir o que são Estilos e Padrões. Padrões são os mais conhecidos, e [já falamos sobre eles](/posts/uma-conversa-sobre-padroes), mas agora não vamos falar de padrões que se aplicam localmente no código, mas não em uma classe ou arquivo em especifico e sim no projeto como um todo. Quando falamos de Padrões, já pensamos em um contexto e um problema. Logo quando vamos ler sobre MVC, Hexagonal ou Camadas, lembramos do contexto e do problema que eles tentam resolver. Vamos falar deles mais a frente e eles existem para resolver um problema em especifico. Já os Estilos Arquiteturais não tem o propósito de resolver um problema, mas são um conjunto de condicionantes escolhidas para se alcançar Atributos de Qualidades. É importante ressaltar que nem todo autor faz essa distinção entre padrão e estilo arquitetural, dessa forma você pode encontrar discussões sobre arquitetura que mistura esses conceito, mesmo eles sendo diferentes.

Roy Fielding em sua tese de doutorado definie estilos arquiteturais como **um conjunto coordenado de condicionantes que restringe as funções/características dos elementos e os relacionamentos permitidos entre esses elementos dentro de qualquer arquitetura que esteja em conformidade com esse estilo**. Ou seja, ao contrário do padrão que define uma forma de se resolver um problema, o estilo é um conjunto de regras que definem como o sistema deve ser construído.

Da mesma forma do padrão, o estilo também é um referencial para a construção de sistemas, mas ele não foca em resolver problemas mas em alcançar atributos de qualidade. Eles são qualitativamente diferentes dos padrões e não são mutuamente exclusivos. Mas eu costumo simplificar a discussão dizendo que um padrão arquitetural define como o seu componente será organizado internamente, enquanto o estilo define como o seu componente irá interagir com os outros componentes do sistema. Ou seja, quando eu falo de padrão estou pensando nas classes enquanto quando falo de estilo estou pensando em protocolos de comunicação, formatos de mensagens, etc. Mas a diferença primordia é que enquanto o padrão está tentando resolver um problema, o estilo arquitetural está procurando habilitar formas de interação entre os componentes.

Nas próximas seções vou apresentar os diversos padrões e estilos que serão discutidos posteriormente. Mas por enquanto vamos discutir os elementos que compõe um estilo arquitetural e como podemos usar os estilos para compor arquiteturas.

## Abstrações de Tempo de Execução

Para melhor caracterizarmos precisamos entender como caracterizar cada estilo arquitetural e para isso precisamos definir quais elementos básicos compõe um estilo arquitetural. Esses elementos são: componentes, conectores, dados, configurações e condicionantes (_constraints_).

### Componentes

Os componentes são as unidades computacionais que possuem estado e comportamento. Em uma arquitetura, os componentes em execução em algum determinado momento. É importante não confundir com componentes de software. Componentes arquiteturais são importantes para se descrever o software em execução, mas em muitos casos, componentes de software como classes, módulos ou bibliotecas não são componentes arquiteturais relevantes. Um componente arquitetural sempre é uma instância de software em execução.

### Conectores

Um conector é um mecanismo abstrato que media a comunicação, coordenação e cooperação entre os componentes. Eles definem como os componentes interagem entre si. Exemplos de conectores incluem chamadas de procedimento remoto (RPC), brokers de mensagens, APIs HTTP, entre outros.

### Dados

Dados são as informações trocadas entre os componentes através dos conectores. Eles podem ser caracterizados pelo seu formato de serialização, estrutura e semântica. Se considerarmos por exemplo uma arquitetura REST, as mensagem pode ser serviços JSON, XML, Protobuf, AVRO, etc. Mas cada mensagem pode ter uma estrutura diferente e a semântica depende da interface sendo invocada.

### Configurações

Configurações definem as relações entre os componentes, conectores e dados em uma arquitetura. 

### Condicionantes

Condicionantes são o que propriamente definem um estilo arquitetural. Eles são um conjunto de regras que restringem como os componentes, conectores e dados podem ser organizados e interagir entre si. Essas restrições podem incluir regras sobre o número de componentes, tipos de conectores permitidos, formatos de dados suportados, entre outros.

## Padrões Arquiteturais

Como já falamos anteriormente, Padrões Arquiteturais são definidos com o objetivos de se resolver problemas especificos. Dessa forma faremos uma lista de alguns padrões disponíveis e uma brevíssima discussão. Esses padrões serão discutidos em outra oportunidade.

* Model-View-Controller (MVC)
* Arquitetura em Camadas
* Arquitetura Hexagonal
* Monolito Modular
* Serverless

### Model-View-Controller (MVC)

O padrão **Model-View-Controller** (ou MVC) é normalmente usado para se construir interfaces gráficas. Ela se baseia na separação de responsabilidades entre Modelo, Interface e Controlador. A ideia é evitar que o software seja contaminado pela lógica da interface dificultando a reutilização do mesmo. 

Dessa forma, três tipos de componentes devem ser construído:

1. **Modelo**: define a lógica de negócios da aplicação;
2. **View**: lida com o layout e a exibição dos dados;
3. **Controlador**: interage com a view para implementar a lógica da interface usando a lógica da aplicação.

O Modelo não deve ser contaminado pela linguagem da interface e deve prover uma interface que possa ser usada em diversas interfaces. Já o controlador pode se contaminar com a lógica da interface, visto que ele naturalmente depende da interface.

### Arquitetura em Camadas

A Arquitetura em Camadas também observa a lógica da divisão de responsabilidades, mas voltada para aplicações web. Uma arquitetura em camada prevê que chamadas são sempre executadas das camadas mais elevadas para as camadas mais baixas e que uma camada só pode chamar a camada imediatamente inferior. 

Uma arquitetura em camadas normalmente se utiliza de três camadas: Apresentação, Negócios e Persistência. 

A **Camada de Apresentação** é responsável por interagir com a interface gráfica ou com a interface de comunicação, ou seja, um framework web. A responsabilidade dela é criar uma fronteira de separação entre os frameworks utilizados e o código da aplicação. Como esse padrão foi definido antes da popularização da separação de responsabilidades entre back-end e front-end, ela é hoje normalmente adaptada para APIs REST.

Hoje é difícil compreender a utilidade dela, visto que os frameworks web modernos acabaram por absorver grande parte dessa responsabilidadfe.

A **Camada de Negócios** visa implementar a lógica de negócios da aplicação sem depender do framework web e do ORM utilizado.

Já a **Camada de Persistência** visa fazer a conexão entre a base de dados, ou o mecanismo de armazenamento de dados e a camada de negócios. Hoje ela é bem reduzida, pois os frameworks facilitaram a implementação da mesma. Hoje é possível implementar a camada de persistência com apenas algumas interfaces.

### Arquitetura Hexagonal

Arquitetura Hexagonal foi [proposta em em 2005 por Alistair Cockburn como uma forma de facilitar os testes de aplicações que dependem de outros sistemas](https://alistair.cockburn.us/hexagonal-architecture). O padrão define o conceito de Portas e Adaptadores. Um adaptador é uma interface da qual o sistema implementa e depende. O código de negócio da aplicação deve interagir somente através do adaptador. Uma porta é uma implementação do adaptador que pode ser trocado dependendo do propósito. 

É importante ressaltar que esse estilo foi proposto em uma época que os frameworks não eram implementados para facilitar a criação de testes automatizados, dessa forma o padrão previa que em tempo de execução fosse utilizado o componente real e nos testes unitários fossem usados outros adaptadores que não dependessem dos componentes externos.

### Monolito Modular

Uma aplicação organizada como um Monolito Modular é organizada pelos domínios de negócios da aplicação. O objetivo de se desenvolver uma aplicação como monolito modular é isolar dominínios e reduzir a sobreposição de dominios. 

### Serverless

Serverless é um estilo de deployment em que a máquina física não está disponível o tempo inteiro. Ela pode ser compartilhada com outros serviços ou mesmo alocada de acordo com a necessidade. 

## Estilos Arquiteturais

Diferentemente dos Padrões arquiteturais, os Estilos não se propõe a resolver um problema, mas a atingir atributos de qualidade. 

* Client-Server
* Event-Driven Architecture (EDA)
* GraphQL
* Message Queueing
* Publish-Subscribe (Pub/Sub)
* Microservices
* Remote Procedurel Call (RPC)
* Representational State Transfer (REST)
* Service-Oriented Architecture (SOA)
* Data Stream Processing
* Microkernel

### Client-Server

Uma aplicação organizada como Cliente/Servidor pela separação de responsabilidades. Um servidor está sempre disponível para responder requisições elaboradas pelo cliente. O cliente utiliza o servidor que possui estado interno.

### Event-Driven Architecture

Em uma arquitetura baseada em eventos, os sistemas se comunicam através da emissão eventos em canais de comunicação, ou brokers de mensagens. 

### GraphQL

GraphQL é um tipo especial de servidor em que o formato do dado requerido é defindo pelo cliente. O cliente elabora uma requisição e o servidor elabora a mensagem, incluindo a estrutura dela, baseado na requisição do cliente.

### Message Queueing

Enfileiramento de mensagens é um tipo comunicação via mensagens em que cada mensagem é consumida apenas uma vez. Ao ser consumida, a mensagem é removida da fila quando confirmada pelo serviço. A responsabilidade do canal de comunicação é entregar a mensagem para ser consumida.

### Publish-Subscribe (Pub/Sub)

Publish-Subscribe é um tipo de comunicação via mensagens em que cada mensagem pertence ao canal de comunicação. O serviço que publica mensagens não espera por respostas e a mensagem é persistida no canal de comunicação sendo possível de ser consumida por mais de um serviço independentemente. 

### Microservices

Microsserviços é uma forma de implementação de sistemas distribuídos em que cada serviço pode ser entregue de forma independentemente e eles dependem apenas de uma interface de comunicação externa. A principal caracteristica dos microsserviços, segundo Sam Newman, é que eles são entregues independentemente.

### Remote Procedurel Call (RPC)

**Remote Procedurel Call** (RPC) é uma forma de implementações de interfaces que homogeniza a comunicação abstraindo o protocolo de comunicação. Todo framework RPC implementa uma linguagem definidora de interface e gera código para clientes e servidores baseados nessa linguagem. O desenvolvedor já interagem com o cliente ou o servidor gerado pelo framework, não se preocupando com as implementações dos protocolos, apenas com as interfaces de código. É importante ressaltar que um framework RPC não busca abstrair a ausência da comunicação em rede, mas a complexidade da implementação dos protocolos envolvidos na comunicação em rede.

### Representational State Transfer (REST)

REST é um estilo de composição de APIs HTTP focado na definição de recuros e na exposição de operações dos recursos usando nativamente o protocolo HTTP. O estilo REST usará praticamente todos os elementos do protocolo HTTP na composição do serviço, mas toda a modelagem da API é centrada na definição da entidade e nas operações expostas pela API.

### Service-Oriented Architecture (SOA)

Um **Service-Oriented Architecture** é uma arquitetura modular orientada por divisões de domínios do negócio. Um serviço representa um funçõa especifica de domínio. Em muitos casos uma arquitetura SOA pode se parecer com uma arquitetura de microsserviços, mas elas terão granularidade e formas de se integrar diferentes.

### Data Stream Processing

Um sistema Data Stream Processing se baseia no consumo e produção de eventos. Ele dependerá de um broker de mensagens e as mensagens são recebidas, consumidas e produzidas com a mínima latência possível.

### Microkernel

Uma Arquitetura de Microkernel é desenvolvida para facilitar a extensão através da composição usando plugins. Em uma aplicação usando microkernel, a aplicação implementa o kernel, que é o motor central da aplicação e provê um mecanismo de registro de plugins. A aplicação, e possívelmente os plugins, podem registrar e consultar o registro de plugins para executar processos de negócios.

## Composição Arquitetural

É importante notar que uma arquitura pode ser composta tanto por estilo como por padrões. Estilos vão ter um impacto maior em toda a arquitetura escolhida, enquanto padrões terão um impacto menor, sendo, em alguns casos, limitados a um serviço em questão. Em ambos os casos, estilos e padrões podem ser compostos entre si. Uma arquitetura não precisa ser de um estilo puro, podemos fazer composição, como por exemplo implementar um serviço que tanto usa REST quando comunicação via eventos.
