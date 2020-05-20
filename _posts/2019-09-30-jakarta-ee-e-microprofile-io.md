---
title: "Jakarta EE e Microprofile.io"
description: "Introdução as especificações Jakarta EE e Microprofile.io"
tags: [Jakarta-EE, Java-EE, Java, Framework]
series: Especificações Jakarta EE & Microprofile.io
comments: true
publish_date: 2019-09-30 09:44:36 +0300
original: "https://dev.to/vepo/jakarta-ee-e-microprofile-io-4gbg"
cover_image: "https://thepracticaldev.s3.amazonaws.com/i/rt90zdwn2g9yaf3hifpl.jpeg"
---

<p>Talvez você como desenvolvedor Java não conheça esses dois nomes. Talvez quando você vai pensar em desenvolver Java
    já pensa em Spring. Caso você esteja nesses dois grupos, essa série é para você!</p>

<!--more-->

<p>Para quem não conhece, o mundo Java é direcionados por especificações. Especificações são coisas as vezes um pouco
    chatas, mas que nos dão uma segurança enorme de desenvolvimento. Para quem desenvolve Java faz mais de 15 anos,
    nunca vi uma <i>breaking feature</i>, algo que tornou meu código antigo não compilável! Isso se deve as especificações
    Java, cada feature nova deve ser compatível com especificações antigas e devem ser especificadas.</p>
<p>Especificações não existem somente para a linguagem Java, existem também para a comunidade Java. </p>

<h2>Java EE</h2>

<p>Até 2018 existia algo que chamavamos de Java EE. </p>
<p>RIP! ☠️☠️☠️ </p>
<p>Long live to Jakarta EE! 👑👑👑</p>
<p>Java EE não era um framework. Era um conjunto de especificações que serviam de base para implementação de Frameworks.
    O intuido dessas especificações era tornar qualquer aplicação Java EE livre de implementações. Assim qualquer
    projeto Java EE, poderia ser facilmente migrável para qualquer uma das implementações compatíveis. Evitando assim o
    que podemos chamar de <a href="https://en.wikipedia.org/wiki/Vendor_lock-in">Vendor Lock-in</a>.</p>
<p>Java EE tinha um sério problema. O <i>timing</i> das especificações era mais lento que o passo da comunidade. Isso se
    devia ao processo imposto pela Oracle ao desenvolvimento, que ao ser <a
        href="https://www.oracle.com/java/technologies/java-ee-glance.html"><i>Specification First</i></a> já impunha um
    passo lento às inovações.</p>
<p>Mas....</p>

<h2>Microprofile.io</h2>

<p>Por volta de 2017, alguns nomes da comunidade perceberam que o Java EE não estava acompanhando o desenvolvimento de
    aplicações <a href="https://12factor.net/pt_br/">Cloud Native</a>, suas especificações englobavam tudo que havia de
    novo em 2007, mas estavamos em 2017! Era preciso fazer algo! </p>

<div class="image-box">
    <img src="https://thepracticaldev.s3.amazonaws.com/i/eidzpplis9ehe42q46z6.png" alt="Microprofile.io" />
</div>

<p>Para isso foi proposto um novo conjunto de especificações o <a href="https://microprofile.io/">Microprofile.io</a>.
    Este seria focado em implementar os padrões de projetos para Cloud Native e <a
        href="https://microservices.io/">Microserviços</a>. Mas em termos de gerenciamento, estas especificações não
    seriam <i>Specification First</i>, mas <i>Coding First</i>. Assim os padrões que já era implementados por um ou mais
    framework seriam homogeinizados e quiça melhorados. O projeto não seria coordenado pela Oracle, mas pela <a
        href="https://twitter.com/EclipseFdn">Eclipse Foundation</a>. Com o padrão de governança da Eclise Fdn, haveria
    mais agilidade no desenvolvimento de novas especificações.</p>

<div class="image-box">
    <img src="https://thepracticaldev.s3.amazonaws.com/i/yzjn0p8qop27l9n5ff2s.png" alt="Especificações" />
</div>

<h2>Jakarta EE</h2>

<div class="image-box">
    <img src="https://thepracticaldev.s3.amazonaws.com/i/3m3hhtorm5c8kdgc2nvs.jpg" alt="Jakarta EE" />
</div>

<p>Com o crescimento do Microprofile.io, houve uma pressão da comunidade para Oracle agilizar o processo de
    desenvolvimento de especificações. Isso levou a empresa a abrir mão e entregar o gerenciamento do projeto Java EE
    para Eclipse Foundation. Assim, o Java EE se tornou Jakarta EE. Java é um nome registrado da Oracle. Todas as
    especificações <b>Java EE 8.0</b> seria automaticamente transformadas em especificações <b>Jakarta EE 8.0</b>.</p>

<div class="image-box">
    <img src="https://thepracticaldev.s3.amazonaws.com/i/r7qdl78m7mz01hyrc9vp.png" alt="Especificações" />
</div>

<h2>Modelo de Programação</h2>

<p>No fundo Jakarta EE é um modelo de programação voltado a especificações. Uma aplicação Jakarta EE não depende de
    implementação, todas as dependências são declaradas como providades e estas devem ser implementadas e providas pelo
    Container Jakarta EE. </p>

<h3>Vantagens</h3>
<p>Usando o modelo puramente Jakarta EE, nos dá certas vantagens ao desenvolvimento:
<ul>
    <li>Velocidade de Desenvolvimento</li>
    <li>Padronização do código</li>
    <li>Baixo acoplamento e alta coesão</li>
    <li>Foco na Lógica de Negócio</li>
</ul>
</p>
<p>As especificações normalmente são de funcionalidades comuns a várias projetos. São requisitos não funcionais que
    liberam o desenvolvedor de se preocupar com coisas que já estão muito bem implementadas e testadas. </p>

<p>Exemplo:
<ul>
    <li><i>Porque o desenvolvedor precisaria implementar um servidor HTTP?</i></li>
    <li><i>Porque o desenvolvedor precisaria implementar um framework de DI?</i></li>
    <li><i>Porque o desenvolvedor precisaria implementar um framework de Validação?</i></li>
    <li><i>Porque o desenvolvedor precisaria implementar um framework de Persistência?</i></li>
</ul>
</p>

<p>Na verdade não há necessidade de re-implementar nenhum desses requisitos, os frameworks devem prover meios de
    integrar um código a todas as funcionalidades propostar por ele. Jakarta EE padroniza esses meios. Assim qualquer
    aplicação desenvolvida poderá ser deployada em qualquer servidor de aplicação compatível.</p>

<h3>Container Jakarta EE</h3>

<p>Quando falamos de Containers no mundo Jakarta EE, não estamos se referindo ao Container Docker! Não! Esse conceito é
    mais antigo. </p>

<p>Container Jakarta EE seria qualquer <a href="https://pt.wikipedia.org/wiki/Servidor_de_aplica%C3%A7%C3%A3o">Servidor
        de Aplicação</a> responsável pela administração e configuração das aplicações Jakarta EE.</p>

<h3>Especificações</h3>

<p>Esse post é uma introdução a uma série que iniciarei detalhando as especificações Jakarta EE e Microprofile.io. Com
    isso gostaria de compartilhar como é fácil desenvolver microserviços Java robustos! Segue a lista de Especificações
    que planejo abranger:
<ul>
    <li>JSR 365 – Contexts and Dependency Injection (CDI) 2.0</li>
    <li>JSR 370 – Java API for RESTful Web Services (JAX-RS) 2.1</li>
    <li>JSR 380 – Bean Validation 2.0</li>
    <li>MicroProfile Configuration</li>
    <li>MicroProfile Health</li>
</ul>
</p>

<h2>Conclusão</h2>

<div class="image-box">
    <img src="https://thepracticaldev.s3.amazonaws.com/i/1aed10d6upbh2rmvhdo8.jpg" alt="Just use-it!" />
</div>

<p>Caso você não conheça as especificações Jakarta EE, esse é um bom ponto de inicio para você.</p>

<p>Caso você já conheça as especificações Jakarta EE, esse é um bom inicio para aprender um pouco mais.</p>