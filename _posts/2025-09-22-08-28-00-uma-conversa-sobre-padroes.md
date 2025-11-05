---
title: Uma conversa sobre Padrões de Projeto
published: true
description: | 
    Esse é o segundo post da série Conversas sobre Arquitetura. Nele vamos discutir o que são Padrões de Projetos e como eles vão muito além do livro inicial do Gang of Four. Descubra como os padrões aumentam nosso vocabulário técnico, permitem comunicação mais eficiente entre desenvolvedores e formam linguagens que nos ajudam a compor soluções arquiteturais mais robustas e adequadas aos problemas que precisamos resolver.
tags: [Arquitetura de Software, Padrões de Projetos]
cover_image: /assets/images/capas/caderno-caneta.jpg
permalink: /posts/uma-conversa-sobre-padroes
series: Conversas sobre Arquitetura
publish_date: 2025-09-22 08:28:00 +0300
---

{% youtube 6snGJFaj0ig %}

Quando tentamos definir arquitetura de software não podemos fugir de discutir o conceito de padrões de projeto. No fundo, o papel de um arquiteto é encontrar dentro de um conjunto de padrões, a solução que melhor se adequa aos requisitos de negócio que o sistema que está sendo arquitetado precisa atender.

Padrões de Projetos não surgiram com o livro de 1995 de Erich Gamma, Richard Helm, Ralph Johnson e John Vlissides, mais conhecidos como a Gang of Four (GoF). O conceito de padrões de projeto foi inicialmente discutido por Christopher Alexander no livro **A Pattern Language: Towns, Buildings, Construction** em 1977. Alexander foi um arquiteto e urbanista que propôs que existem soluções recorrentes para problemas recorrentes na arquitetura e no design urbano. Ele sugeriu que essas soluções poderiam ser documentadas como "padrões" que poderiam ser reutilizados em diferentes contextos.

![Christopher Alexander](/assets/images/conversas-sobre-arquitetura/fig-02-padroes.png)

Isso é dito no proprio livro **Design Patterns: Elements of Reusable Object-Oriented Software**. Abaixo, reproduzo um trecho do prefácio do livro:

> Christopher Alexander afirma: "_Cada padrão descreve um problema que ocorre repetidamente em nosso ambiente e, em seguida, descreve o cerne da solução para esse problema, de tal forma que você pode usar essa solução um milhão de vezes, sem nunca fazer da mesma maneira duas vezes_". Embora Alexander estivesse falando sobre padrões em edifícios e cidades, o que ele diz é verdade sobre padrões de projeto orientados a objetos. Nossas soluções são expressas em termos de objetos e interfaces em vez de paredes e portas, mas no cerne de ambos os tipos de padrões está uma solução para um problema em um contexto.
> 
> Em geral, um padrão possui quatro elementos essenciais:
> 1. O **nome do padrão** é um identificador que podemos usar para descrever um problema de projeto, suas soluções e consequências em uma ou duas palavras. Nomear um padrão aumenta imediatamente nosso vocabulário de projeto. Isso nos permite projetar em um nível mais alto de abstração. Ter um vocabulário para padrões nos permite falar sobre eles com nossos colegas, em nossa documentação e até mesmo conosco mesmos. Isso torna mais fácil pensar sobre projetos e comunicá-los, juntamente com suas compensações, a outros. Encontrar bons nomes tem sido uma das partes mais difíceis do desenvolvimento do nosso catálogo.
> 2. O **problema** descreve quando aplicar o padrão. Ele explica o problema e seu contexto. Pode descrever problemas específicos de design, como representar algoritmos como objetos. Pode descrever estruturas de classes ou objetos que são sintomáticas de um design inflexível. Às vezes, o problema inclui uma lista de condições que devem ser atendidas antes que faça sentido aplicar o padrão.
> 3. A **solução** descreve os elementos que compõem o design, seus relacionamentos, responsabilidades e colaborações. A solução não descreve um design ou implementação concreto específico, porque um padrão é como um modelo que pode ser aplicado em muitas situações diferentes. Em vez disso, o padrão fornece uma descrição abstrata de um problema de design e como um arranjo geral de elementos (classes e objetos, no nosso caso) o resolve.
> 4. As **consequências** são os resultados e as compensações da aplicação do padrão. Embora as consequências muitas vezes não sejam mencionadas quando descrevemos decisões de design, elas são cruciais para avaliar alternativas de design e para entender os custos e benefícios da aplicação do padrão. As consequências para o software frequentemente envolvem compensações de espaço e tempo. Elas também podem abordar questões de linguagem e implementação. Como a reutilização costuma ser um fator no design orientado a objetos, as consequências de um padrão incluem seu impacto na flexibilidade, extensibilidade ou portabilidade de um sistema. Listar essas consequências explicitamente ajuda a entendê-las e avaliá-las.

Observe que o livro identifica claramente qual é a vantagem de se conhecer padrões: aumentar a nossa capacidade de se descrever software aumentando o nosso nível de abstração. Mas um grande problema é achar que os padrões se reduzem aos padrões de projetos descritos no GoF, eles vão além. Os padrões do GoF se reduzem aos padrões Criacionais, Estruturais e Comportamentais pois foi uma das primeiras discussões sobre o tema, mas logo após o livro a discussão sobre padrões se expandiu criando uma nova série de linguagens de padrões. Agora vamos falar um pouco de Linguagem de Padrões e como surge os padrões.

Ao contrário do que o especialista de internet imagina, padrões não são criados, eles são identificados e apresentados a comunidade. Qualquer pessoa pode fazer isso, só precisa estruturar seu padrão em um formato especifico, ou um template como o GoF propõe e escrever sobre ele. Existem conferências de padrões como a Pattern Languages of Programs (PLoP), onde eu participei em 2021 apresentando um padrão chamado [Lazy Clone](https://dl.acm.org/doi/10.5555/3712039.3712049) com pesquisadores da área. Um padrão ele é identificado em código já existente, registrado em um template e discutido no template. Ele pode ser um bom padrão ou um padrão problemático, que chamamos de Anti-Padrão.

Padrões também podem ser organizados em Linguagens de Padrões, o proprio GoF propõe uma linguagem de padrão ao catalogar os padrões em 3 tipos e propor a seção "Padrões Relacionados" no template. Um linguagem de padrões é uma coleção estruturada e relacionada de padrões. Linguagens de padrões servem para organizar os padrões e relacionar eles por objetivos ou por soluções alternativas, dessa forma uma linguagem de padrões bem construída torna fácil você indentificar padrões e associar padrões alternativos.

Vamos olhar para a [linugagem de padrões de microsserviços](https://microservices.io/patterns/index.html), na primeira visualização conseguimos identificar que existem padrões de infraestrutura, de descoberta de serviços, observabilidade e etc... E que entre os padrões de descoberta posso escolher entre Registro de Serviço, Descoberta Server-side ou Client-side, etc... Isso tudo está obvio na figura. Eu como arquiteto não preciso conhecer todos os padrões a fundo, mas quando eu for projetar uma funcionalidade que envolva descoberta de serviços, possa usar um ou mais padrões para compor minha solução.

![Linguagem de Padrões de microsserviços](/assets/images/conversas-sobre-arquitetura/fig-03-microservices-pattern-language.jpg)

Outras linguagens de padrões que devem ser conhecidas são o [Catalogo de Padrões de Enterprise Application Architecture](https://martinfowler.com/eaaCatalog/), o [Catálogo de Code Smells ORM](https://github.com/spgroup/ORM-Smells-Catalog), [padrões para construção de APIs REST](https://blog.vepo.dev/posts/como-avaliar-uma-api) e os [Enterprise Integration Patterns](https://www.enterpriseintegrationpatterns.com/patterns/messaging/).
