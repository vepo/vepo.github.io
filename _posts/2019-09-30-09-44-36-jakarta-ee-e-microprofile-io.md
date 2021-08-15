---
title: "Jakarta EE e Microprofile.io"
permalink: /posts/jakarta-ee-e-microprofile-io
description: "Introdução as especificações Jakarta EE e Microprofile.io"
tags: [Jakarta-EE, Java-EE, Java, Framework]
series: Especificações Jakarta EE & Microprofile.io
publish_date: 2019-09-30 09:44:36 +0300
original: "https://dev.to/vepo/jakarta-ee-e-microprofile-io-4gbg"
cover_image: "https://thepracticaldev.s3.amazonaws.com/i/rt90zdwn2g9yaf3hifpl.jpeg"
---

Talvez você como desenvolvedor Java não conheça esses dois nomes. Talvez quando você vai pensar em desenvolver Java já pensa em Spring. Caso você esteja nesses dois grupos, essa série é para você!

<!--more-->

Para quem não conhece, o mundo Java é direcionados por especificações. Especificações são coisas as vezes um pouco chatas, mas que nos dão uma segurança enorme de desenvolvimento. Para quem desenvolve Java faz mais de 15 anos, nunca vi uma _breaking feature_, algo que tornou meu código antigo não compilável! Isso se deve as especificações Java, cada feature nova deve ser compatível com especificações antigas e devem ser especificadas.

Especificações não existem somente para a linguagem Java, existem também para a comunidade Java.

## Java EE

Até 2018 existia algo que chamavamos de Java EE.

RIP! ☠️☠️☠️

Long live to Jakarta EE! 👑👑👑

Java EE não era um framework. Era um conjunto de especificações que serviam de base para implementação de Frameworks. O intuido dessas especificações era tornar qualquer aplicação Java EE livre de implementações. Assim qualquer projeto Java EE, poderia ser facilmente migrável para qualquer uma das implementações compatíveis. Evitando assim o que podemos chamar de [Vendor Lock-in](https://en.wikipedia.org/wiki/Vendor_lock-in).</p>

Java EE tinha um sério problema. O _timing_ das especificações era mais lento que o passo da comunidade. Isso se devia ao processo imposto pela Oracle ao desenvolvimento, que ao ser _[Specification First](https://www.oracle.com/java/technologies/java-ee-glance.html)_ já impunha um passo lento às inovações.

Mas....

## Microprofile.io

<p>Por volta de 2017, alguns nomes da comunidade perceberam que o Java EE não estava acompanhando o desenvolvimento de
    aplicações <a href="https://12factor.net/pt_br/">Cloud Native</a>, suas especificações englobavam tudo que havia de
    novo em 2007, mas estavamos em 2017! Era preciso fazer algo! </p>

![Microprofile.io](https://thepracticaldev.s3.amazonaws.com/i/eidzpplis9ehe42q46z6.png)

Para isso foi proposto um novo conjunto de especificações o [Microprofile.io](https://microprofile.io/). Este seria focado em implementar os padrões de projetos para Cloud Native e [Microsserviços](https://microservices.io/). Mas em termos de gerenciamento, estas especificações não seriam _Specification First_, mas _Coding First_. Assim os padrões que já era implementados por um ou mais framework seriam homogeinizados e quiça melhorados. O projeto não seria coordenado pela Oracle, mas pela [Eclipse Foundation](https://twitter.com/EclipseFdn). Com o padrão de governança da Eclise Fdn, haveria mais agilidade no desenvolvimento de novas especificações.


![Especificações](https://thepracticaldev.s3.amazonaws.com/i/yzjn0p8qop27l9n5ff2s.png)

## Jakarta EE


![Jakarta EE](https://thepracticaldev.s3.amazonaws.com/i/3m3hhtorm5c8kdgc2nvs.jpg)

Com o crescimento do Microprofile.io, houve uma pressão da comunidade para Oracle agilizar o processo de desenvolvimento de especificações. Isso levou a empresa a abrir mão e entregar o gerenciamento do projeto Java EE para Eclipse Foundation. Assim, o Java EE se tornou Jakarta EE. Java é um nome registrado da Oracle. Todas as especificações **Java EE 8.0** seria automaticamente transformadas em especificações **Jakarta EE 8.0**.

![Especificações](https://thepracticaldev.s3.amazonaws.com/i/r7qdl78m7mz01hyrc9vp.png)

## Modelo de Programação

No fundo Jakarta EE é um modelo de programação voltado a especificações. Uma aplicação Jakarta EE não depende de implementação, todas as dependências são declaradas como providades e estas devem ser implementadas e providas pelo Container Jakarta EE.

### Vantagens
Usando o modelo puramente Jakarta EE, nos dá certas vantagens ao desenvolvimento:
* Velocidade de Desenvolvimento
* Padronização do código
* Baixo acoplamento e alta coesão
* Foco na Lógica de Negócio

As especificações normalmente são de funcionalidades comuns a várias projetos. São requisitos não funcionais que liberam o desenvolvedor de se preocupar com coisas que já estão muito bem implementadas e testadas.

Exemplo:
* _Porque o desenvolvedor precisaria implementar um servidor HTTP?_
* _Porque o desenvolvedor precisaria implementar um framework de DI?_
* _Porque o desenvolvedor precisaria implementar um framework de Validação?_
* _Porque o desenvolvedor precisaria implementar um framework de Persistência?_

Na verdade não há necessidade de re-implementar nenhum desses requisitos, os frameworks devem prover meios de integrar um código a todas as funcionalidades propostar por ele. Jakarta EE padroniza esses meios. Assim qualquer aplicação desenvolvida poderá ser deployada em qualquer servidor de aplicação compatível.

### Container Jakarta EE

Quando falamos de Containers no mundo Jakarta EE, não estamos se referindo ao Container Docker! Não! Esse conceito é mais antigo.

Container Jakarta EE seria qualquer [Servidor de Aplicação](https://pt.wikipedia.org/wiki/Servidor_de_aplica%C3%A7%C3%A3o) responsável pela administração e configuração das aplicações Jakarta EE.

### Especificações

Esse post é uma introdução a uma série que iniciarei detalhando as especificações Jakarta EE e Microprofile.io. Com isso gostaria de compartilhar como é fácil desenvolver Microsserviços Java robustos! Segue a lista de Especificações que planejo abranger:
* JSR 365 – Contexts and Dependency Injection (CDI) 2.0
* JSR 370 – Java API for RESTful Web Services (JAX-RS) 2.1
* JSR 380 – Bean Validation 2.0
* MicroProfile Configuration
* MicroProfile Health


## Conclusão

![Just use-it!](https://thepracticaldev.s3.amazonaws.com/i/1aed10d6upbh2rmvhdo8.jpg)

Caso você não conheça as especificações Jakarta EE, esse é um bom ponto de inicio para você.

Caso você já conheça as especificações Jakarta EE, esse é um bom inicio para aprender um pouco mais.