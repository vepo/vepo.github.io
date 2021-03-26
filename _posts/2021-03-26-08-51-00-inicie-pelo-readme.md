---
title: Inicie um projeto pelo README.md
permalink: /posts/inicie-um-projeto-pelo-readme
published: false
publish_date: 2021-03-26 08:51:06 +0300
description: Antes de iniciar a desenvolver, descreva o que você vai fazer
tags: [Documentação de Software, README, Documentação, Engenharia de Software]
cover_image: https://thepracticaldev.s3.amazonaws.com/i/x6xpao28ktzva7sinrym.JPG
---

Quando comecei a trabalhar oficialmente como Arquiteto de Software, identifiquei uma grande deficiência: _documentar_. Documentar não é uma atividade fácil, e você pode sentir essa dor ao usar qualquer software, biblioteca ou framework proprietário ou open source. Investi parte do meu tempo para [ler sobre](https://amzn.to/3sCJvMg) o assunto e praticar tanto nos meus projetos pessoais quanto da empresa que trabalhava.

Pela minha própria experiência, posso afirmar que praticar é uma boa tática. Documentar não é uma atividade natural para nenhum desenvolvedor, muitas vezes supomos que as coisas são obvias e quem vai usar nosso software irá compreender o que está feito imediatamente. As vezes quando chega uma pergunta, sempre vem aquele pensamento _"Como ele é burro?"_, mas isso deve ser evitado. Nenhum usuário é burro, ele só não compreendeu o que está posto.

Vale uma reflexão aqui... Quantas horas você já gastou tentando entender alguma coisa? Pode ser que seja a implementação mais simples que existe, mas se existe um conceito (ou uma convenção) desconhecido, você não irá compreender. John Ousterhout em seu livro [A Philosophy of Software Design](https://amzn.to/3cp1TTh) chama isso de _Unknown unknowns_, Desconhecido desconhecidos em tradução livre. Falei um pouco sobre complexidade e da experiência da leitura desse livro em [Sobre Design de Software (I): O que é complexidade?](https://vepo.substack.com/p/sobre-design-de-software-i).

Então em Junho de 2019 coloquei no papel o que tinha em mente [Start a project by the README](https://vepo.github.io/posts/start-a-project-by-the-readme). Está em inglês porque precisava praticar minha escrita. 🙃

Aqui vou revisitar o post e expandir ele, muita coisa muda em 3 anos.

## Documentações nem sempre são boas

Para escrever boas documentações, a primeira coisa que temos que fazer é ler documentações. Depois temos que ter um conceito claro do que é uma boa documentação. Quais são as caracteristicas delas? Se não pararmos para refletir nisso, provavelmente nunca conseguiremos escrever uma.

Boas documentações são aquelas onde as dúvidas são facilmente resolvidas, elas são bem estruturadas e o programador não se perde. Logo no começo ela deve definir o que é e para o que se propõe aquele componente. Assim um desenvolvedor perdido não irá gastar tempo lendo o que não se precisa. 

### Vamos mostrar um exemplo? 

Em 2017 eu precisava fazer um benchmark de todos Messages Queue que existiam no mercado, assim fazendo o levantamento cai no ZeroMQ. Logo ao abrir sua página inicial li _"connecta seu código em qualquer linguagem ou plataforma"_, com essa informação eu poderia supor eu poderia usar ele como um middleware, logo comecei a ler e não cheguei a nenhuma conclusão. Você pode tentar navegar na documentação dele [em 2017](https://web.archive.org/web/20170223010343/http://zeromq.org/) pra ver se entende.

![Descrição do ZeroMQ em 2017](/assets/images/zeromq/2017-description.jpg)

Agora vamos olhar a [documentação de 2021](https://web.archive.org/web/20210324125900/https://zeromq.org/). Observe que a primeira frase diz _"ZeroMQ (também conhecido como ØMQ, 0MQ ou zmq) parece uma biblioteca de comunicação, mas atua como um framework de concorrência."_. Já na primeira frase, muitas dúvidas são retiradas:

* Quais são os nomes que podemos chamar
* Ela não é apenas uma biblioteca para um middleware
* Ela é um framework para se construir a comunicação entre dois serviços, em outras palavras, não existe middleware, você precisa construir.

Se eu tivesse lido essa documentação em 2017, teria economizado algumas horas. É muito importante que as pessoas não percam tempo lendo a documentação do seu componente, porque isso gera antipatia e é tudo que não precisamos. Se evitarmos que a pessoa invista tempo investigando, com certeza ela irá lembrar do seu componente quando realmente precisar dele.

![Descrição do ZeroMQ em 2021](/assets/images/zeromq/2021-description.jpg)

## Dicas

Vamos então dar dicas fáceis para que sua documentação seja de qualidade. Vamos elencar 5 dicas:

1. Inicie descrevendo seu componente
2. Explique as motivações dele
3. Defina os termos que você irá usar
4. Explique o comportamento e as interações
5. Descreva como usar

Vale lembrar que essas são dicas para quem vai _usar_ seu componente, no futuro farei uma lista com dicas para quem vai _alterar_ seu componente.

### 1. Inicie descrevendo seu componente

Seja direto. Descreva seu componente de forma simples e direta. 

Nas primeiras sentenças você tem que fazer com que qualquer desenvolvedor que caia desavisado sabia onde usar seu componente. Vamos ver alguns exemplos?

## Good Example

A good example is [Zookeeper](http://zookeeper.apache.org/) description:

_ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services._

In the first line you know what problem you an solve with this project. If you continue to reading there is a more detailed description. Good!

## Bad Example

A bad example is [Kafka](https://kafka.apache.org/intro) description:

_Apache Kafka® is a distributed streaming platform. What exactly does that mean?_

The documentation is clear that the reader will not undestand!! If you continue to read, it will describe _real time pipelines_, _clusters_, etc... But what the main porpuse of Kafka?

If I had to rewrite Kafka documentation, this will be the second item from it. The first will be a short description of **What is** Kafka and **Which type of problem it solves**.

## Tips

1. Avoid own defined terms. Use commons terms
2. Be short. Few and short lines.
3. Answer questions.

## Briefly... 
A good description is a short text that answer two question. What is and Which type of problem solves.

# 2. After describing you project, explain hidden ideas

The second section of my READMEs are the **Rational** section. Here I quickly list all ideas behind my code. 

Let's imagine we are building a new NoSQL database. 

The first thought a user can have is: _I lost all my SQL validations?_

The first thought a developer can have is: _Can we add some kind of validations?_

Both questions are welcome, but it can be answer with a single line in this session:

* This achieve a High-Throughput, no validation will be done by the database.

Any important idea **SHOULD** be described in this session shortly. If more information is need, you can add a link to another README explain it.

# 3. Explain Resources and Terms

Does your project define any term? Explain here.

Does your project uses a own file format? Explain here.

Imagine that I'm building a Business Rule Engine, all business rule must be written in a specifica file format. You should explain shortly what is this file format and create a specific README file for it:

* BR file defines a single Business Rule. (More information link)

# 4. Explain behaviour and Interactions

Explain how your code works. A user or a developer should know how your project works. If you are developing a Message Queue, here is a good place where you can describe shortly how a message will be delivered to all (or not to all) clients.

# 5. Describe which API you provide

Do you provide a REST API? An Java library? A C library? Describe the key points for the provided API. Shortly! 

# Be short!

In the main README file you **SHOULD** be shortly. This is not the place where you will deeply explain everything, this is the place to show key concepts.

# Be consistent!

What if a change on the code change something related with what is written in the README? This is the main problem that occurs in software development. The documentation is not consistent with the code.

For each project you should define your own **Definition Of Done**. If the change does not reflects the documention, so the change is not ready!

# Concluding

When you listen that *the documentation is the code*, do not touch in this code! Every line of code there is a hidden idea that sometimes are not expressed because it cannot be expressed in code. 

{% twitter https://twitter.com/unclebobmartin/status/870311898545258497 %}

The idea of Uncle Bob is well accepted in simple projects, but what if the project has some architectural complex decisions? How can express it without a README or some comments?

# More

You can add more sections to your main README file. But you should be short.