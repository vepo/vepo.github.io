---
title: Outras formas de pensar código
published: false
description: Talvez você fale de programação funcional, orientação a objetos, etc... Mas na verdade muitas vezes falamos desses paradigmas, mas continuamos usando a velha, e não boa, programação procedural.
tags: [Programação Orientada a Objetos, Programação Funcional]
cover_image: /assets/images/java/duke-paper-100-42.webp
permalink: /posts/outras-formas-de-pensar-codigo
publish_date: 2025-04-24 14:08:00 +0300
---

:figure-caption: Figura
:imagesdir: /assets/images/

Nesse post vou apresentar para vocês as formas que podemos pensar em código e como elas nos ajuda a escrever bom código. Caso você tenha entrado no universo da computação desavisado, 
saiba que existem diversas formas de pensar a maneira como escrevemos código. Não é só sair escrevendo por aí. Não faça isso! É preciso pensar no código, pensar no tipo de problema 
que estamos resolvendo e ler, mas ler muito, código. Cada forma de se pensar no código é composto por um dialeto que nos ajuda a resolver tipos diferentes de problemas.

== Um pouco de história

Antes de falar das linguagens de programação moderna, vamos rever um pouco da história? Talvez você esteja pensando aí em que isso pode te ajudar a ser um programador melhor? Talvez em
nada! Mas vai ter dar uma luz sobre o que é programação e o que são essas tais máquinas programáveis que usamos no nosso dia a dia. Por isso precisamos voltar ao século XIX, mais precisamente
a Inglaterra Vitoriana.

A primeira linguagem de programação não foi nada do que você imagina. Ela foi criada por uma mulher chamada Ada Lovelace, a filha de um famoso e controverso poeta romântico. Se você 
não lembra das aulas de literatura, não tenha ideia do que significa a palavra "romântico". Lord Byron não era uma pessoa apaixonada pela mãe da Ada, muito pelo contrário, abandonou-a
e viveu uma vida cheia de excessos. Mas não estamos aqui para falar de romântismo, idealismo, ou mesmo da vida sexual de poetas europeus que não tinham coisa melhor pra fazer. Ada mudou 
a história ao se encontrar com Charles Babbage!

Babbage era um engenheiro, e também aristocrata, inglês que estudava formas de criar uma máquina para calculos, a Máquina Analítica. Então, Ada traduziu um artigo de Luigi Menabrea acerca
da máquina e adicionou diversas notas, entre elas a implementação de um programa para o calculo nos Números de Bernoulli, fazendo dela a primeira programadora da história. A máquina de 
Babbage nunca chegou a ser finalizada, mas o seu projeto serviu de referência para outras maquinas eletrônicas no futuro.

Outro nome influente é o de Alonzo Church que talvez você nunca tenha ouvido falar, mas todo dia você deve pronunciar uma palavra usada por ele: lambda. Church estudava uma forma de descrever
o comportamento dos termos em uma função e por isso propos uma sintaxe de termos chamada Lambda Calculus. Sua intenção era caputurar os aspectos computacionais de uma função. Caso você ainda 
não tenha reparado, as palavras computador ou computação derivam do termpo computar, que, por sua vez, vem da matemática. Computação surge assim como uma forma de se resolver problemas 
matemáticos complexos. O primeiro computador eletrônico programável, o ENIAC, era usado para cálculos balísticos que anteriormente era feitos manualmente.
