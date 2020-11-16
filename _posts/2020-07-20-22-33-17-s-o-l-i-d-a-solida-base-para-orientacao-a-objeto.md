---
title: "S.O.L.I.D.: A sólida base para Orientação a Objeto"
permalink: /posts/s-o-l-i-d-a-solida-base-para-orientacao-a-objeto
published: true
description: SOLID é uma das base a Orientação a Objeto. Nesse post explico os motivos que geraram essa base e os princípios de cada letra.
series: Coisas que todo Sênior deve saber
tags: [Orientação a Objeto, Java, SOLID, Programação]
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/uy2e9rldjjrumiekusnz.jpg
publish_date: 2020-07-20 22:33:17 +0300
original: "https://dev.to/vepo/s-o-l-i-d-a-solida-base-para-orientacao-a-objeto-4de7"
---

Entrevistas para vagas em empresas brasileiras é muito focada nas tecnologias. Você é um bom desenvolvedor do Framework ZYX? Ok. Sempre estive acostumado com isso, apesar de nunca querer me especializar em um framework. 

Até que quando fui fazer minha primeira entrevista para uma vaga em uma empresa de fora, a primeira pergunta foi: _"Me explique o que é o SOLID e como se aplica em Java."_ **PÃ!** 🚨🚨🚨 Bugou! Em mais de 10 anos ninguém nunca tinha me perguntado isso. Acho que nunca mais tinha ouvido falar em SOLID desde a faculdade, e também não lembrava, obviamente.

# Porque é importante?

Mas se ninguém se importa com isso, porque é importante? 

Simplesmente porque não devemos saber as coisas só pra mostrar para os outros. SOLID é a base paa um bom design *Orientado a Objetos*. Se você deseja ser um bom desenvolvedor Java, ou qualquer outra linguagem OO que aparecer num futuro, você vai ter que saber aplicar o SOLID. Ele vai ter ajudar a fazer um código mais elegante. 🤵

# Porque SOLID?

SOLID foi proposto pelo Uncle Bob, vulgo Robert C. Martin, em [2000](https://web.archive.org/web/20150906155800/http://www.objectmentor.com/resources/articles/Principles_and_Patterns.pdf). Sua ideia ao propor alguns padrões era evitar podridão no código. Essa ideia de podridão não era novo, Joseph Yoder já tinha usado o termo Big Ball of Mud alguns anos antes. Mas a ideia era, quando um software vai evoluindo, algumas vezes o design/arquitetura não evolui, logo é preciso ter algumas parametros para analise antes de fazer uma alteração. 

Mas vamos conhecer antes quais problemas ele identificou?

## Rigidez

Está dificil alterar o seu código? Bom, então ele está rigido! 

Rigidez é a capacidade de não ser fácil fazer uma alteração no código. Ou por um alto acoplamento. Se mexer em um lugar vai ter que mexer em outro e assim por diante. 

Desenvolvedores pouco experientes vão achar que isso é natural de um sistema. Na verdade isso é bastante comum e sempre irá existir, mas pode ser reduzido. Com a experiência temos mais repertório de soluções de como deixar nosso código pouco acoplado.

## Fragilidade

Fragilidade é a capacidade do código de apresentar erros ao se criar alterações. Quem nunca encontrou um comentário "DO NOT TOUCH!" no meio do código? 

As vezes isso acontece por códigos que iteragem entre si ou mesmo de comportamentos poucos ortodoxos. Ou isso simplesmente acontece por mudanças de requisitos. Muda-se o requisito, mas não se altera todo o software referente aquele requisito.

Mas há meios de se resolver isso...

## Imobilidade

Já teve que reescrever uma solução? Quando temos um código que precisa ser replicado porque simplemente não dá pra generalizar o uso dele para dois casos bem similares, temos uma imobilidade. 

Desenvolvedores menos experientes não verão problema nisso. Até o dia que alguém alterar em um lugar e esquecer do outro.

## Viscosidade

Viscosidade vem de duas forma: viscosidade do design e viscosidade do ambiente.

Viscosidade do Design acontece quando na necessidade de uma mudança, manter a consistência do design se torna dificil. Sempre que há a necessidade de uma mudança, você pode alterar o design ou manter o designo original. Se manter o padrão do desing é dificil, temos um código viscoso.

Viscosidade do Ambiente acontece quando o ambiente de desenvolvimento é dificil de operar. Ou o tempo de compilação é demorado, ou o deploy em ambiente de desenvolvimento é demorado. 

# Principios da Orientação Objeto

Para resolver esses problemas foram propostos alguns principios que podem nos dar um caminho. 

## SRP - Principio da Responsabilidade Única

> "_Uma classe deve ter um, e somente um, motivo para mudar._"

Também chamado de Coesão, esse principio se relaciona a proximidade das funções de um modulo. Se o modulo faz diversas funções, não é coeso. Já se o modulo possue uma única função, se torna coeso. 

Quando uma classe é coesa, a necessidade de alterar ela diminui, pois as interações com ela se reduzem.

Por exemplo, imagine que tenho um framework de testes. Posso pensar em vários tipos de testes a serem feitos, porém a classe que Executa os testes não deve se preocupar com nada. Deve haver uma interface para se abstrair quais as atividades de um teste e essa classe deve chamar apenas essas abstrações.

{% gist https://gist.github.com/vepo/cdcaa8c6adb667bdb305cfe02f8e8252 %}

### Anti-Pattern

O princípio da Responsabilidade Única vem associada a um Anti-Pattern bem comum o [Objeto Deus](https://pt.wikipedia.org/wiki/Objeto_deus). Este objeto é aquele que Sabe Tudo e Faz Tudo. Já trabalhei em uma empresa que tinha que dá manutenção em um servidor de serviços de voz (TTS e ASR), quando abri a classe que tratava as requisiões.... Mais de 10.000 linhas!!! 😱 Qualquer alteração era bastante dolorosa, porém com a implentação de alguns Design Patterns foi possível reduzir ela para algo em torno de 100 linhas.

![Matador de Deuses](https://dev-to-uploads.s3.amazonaws.com/i/ltor91r9jxxdf09s5uio.jpeg)

## OCP - Princípio Aberto-Fechado

> "_Um módulo deve estar aberto para extensão, mas fechado para modificação._"

Esse principio pode ser resumido em dizer que um módulo, ou uma classe, deve ser aberto para extensão sem ser necessário modificação.

Na época em que foi proposto o SOLID isso se dava basicamente por herança, ou seja, criação de hieraquias de classes e interfaces. Porém hoje há outras formas mais comuns, e composição é uma bem mais aceitável para isso.

Voltando ao nosso exemplo da classe de teste, podemos ter Testes de vários tipos, mas podemos criar testes compostos: 

{% gist https://gist.github.com/vepo/21d01d3768980317d62ec8beccf29aae %}

Nesse examplo acima vemos que Testes novos podem ser criados tanto por Herança quanto por acoplamento e não será necessário reimplementar nenhuma das classes.

![Please, come in and be nice!](https://dev-to-uploads.s3.amazonaws.com/i/kfzcj8aiuaz4c1s9txpo.jpg)

## LSP - Princípio da Substituição de Liskov

> "_As subclasses devem ser substituíveis por suas classes base._"

Esse principio parece simples, principalmente se você usa linguagens como Java, pois a linguagem aparentemente já garante ele. Certo?

Nem sempre, um dos erros mais comuns em Java é não se atentar ao Contrato de um Método. Vamos explicar...

Em Java todo Objeto estende a classe Object, essa classe define alguns Métodos para validar igualdade de objetos como o [hashCode](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#hashCode--) e [equals](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#equals-java.lang.Object-). Muitos desenvolvedores nunca leram a definição desses métodos ou nunca se preocuparam em implementar eles. Mas o que acontece se eu não implemento eles? Algumas classes da API dependem deles, as mais comuns são: [HashMap](https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html), [HashSet](https://docs.oracle.com/javase/8/docs/api/java/util/HashSet.html). Caso um objeto não implemente corretamente esses métodos, uma operação de adição em uma dessas classes pode resultar em comportamentos inesperados.

## ISP - Princípio da Segregação da Interface

> "_Muitas interfaces específicas do cliente são melhores que uma interface de uso geral_".

Esse é um padrão bem comum nas interfaces gráficas, para cada ação há uma interface **Listerner**. Havendo uma grande variedade de interfaces promove o desacoplamento de uma implementação com outras ações indesejadas. 

Esse princípio tem um efeito negativo que pode deve ser contido. Não se deve criar interfaces indesejadas. Por exemplo, se temos em uma interface gráfica um **Botão** e **Link**, podemos supor que ambos possuem a mesma operação de **Clique**, logo não faz sentido criar mais do que um **CLiqueListerner**.

O Java padeceu por muito tempo de uma sobrecarga nas definições de classes por causa desse principio, em um único projeto havia inumeras implementas de Listeners etc... Porém, desde o Java 8 isso pode ser contornado pelo uso de Lambdas e funções como parâmetros. Um bom inicio para se conhecer essa interfaces é o package [java.util.function](https://docs.oracle.com/javase/8/docs/api/java/util/function/package-summary.html). Nele é possível encontrar interfaces como [Consumer](https://docs.oracle.com/javase/8/docs/api/java/util/function/Consumer.html) e [Function](https://docs.oracle.com/javase/8/docs/api/java/util/function/Function.html) que nos ajudam a evitar criar novas interfaces.

## DIP - Princípio da inversão da dependência

> "_Dependa de abstrações. Não dependa de implementações._"

Esse princípio não é resolvido pela linguagem, mas pelo design do seu código. Dependa sempre de Classes Abstratas ou de Interfaces. 

Porque disso? Supõe-se que toda implementação é volátil e pode ser alterada, estendida ou substituida. Até mesmo classes bem pouco volátil com String sofreu algumas alterações com a adição de métodos. Obviamente que essa alteração não torna nenhum código já implementado imcompatível. Mas se se houvesse uma mudança interna na classe? Isso alteraria seu código?

Imagine que você estende um Cliente HTTP e altera o comportamento interno dele por algum motivo exotérico. Seria possível migrar para uma nova versão dessa dependência que usa HTTP2? Ou seria possível trocar o cliente em tempo de execução? Muito provavél que não. 

Isso serve de sinal até mesmo quando for referenciar uma variável, use sempre o tipo mais abstrato que puder, evitando assim acoplamento.

# Conclusão

Esses 5 princípios existem há muito tempo, e é sempre bom relembrar eles. Com a ajuda deles podemos criar códigos mais elegantes e que vão garantir que as alterações sejam mais fáceis e a manutenção menos trabalhosa.

Uma outra dica é sempre refatorar seu código. Procure pelos sinais de putrefação e levante esses defeitos com a equipe.

# Livros Recomendados

* [Java Efetivo: as Melhores Práticas Para a Plataforma Java](https://amzn.to/30tVPSh) de Joshua Bloch