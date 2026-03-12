---
title: Artigos que todo "programador" deveria ler
published: false
description:
tags: [JPA, Hibernate, ORM, Bad Smells, Banco de Dados]
cover_image: /assets/images/capas/disquete-100-42.jpg
series: Introdução a Bases de Dados
permalink: /posts/bad-smells-em-orm
publish_date: 2026-03-10 10:44:00 +0300
---

Voltando a ler o livro ["Criando Microsserviços" do Sam Newman](https://amzn.to/4sqgrqB), eu topei uma referência a um post onde o autor [relê os papers do David Parnas](https://blog.acolyer.org/2016/10/17/information-distribution-aspects-of-design-methodology/) sob a ótica de um arquiteto moderno. Para quem não conhece, [David Parnas](https://www.computer.org/profiles/david-parnas) é um dos nomes mais famosos da computação que publicou sobre [modularidade](https://dl.acm.org/doi/abs/10.1145/361598.361623) e [envelhecimento](https://ieeexplore.ieee.org/abstract/document/296790) de software, dois temas que são chaves na engenharia de software.

Esse post é baseado em uma [recomendação de leitura da Barbara Liskov](http://jpirker.com/hlf16-liskovs-reading-list-for-computer-scientists/), em uma palestra de 2016. OK. Se você também não conhece a Barbara Liskov, lembra do Principio da Substituição de Liskov? É o "L" do **S.O.L.I.D.**. Mas ela é muito mais importante que ser uma letra num acrônimo bastante conhecido, mas também bastante questionável. Liskov recomenda a leitura de 7 artigos que são fundamentais para todo cientista da computação ou pessoa que desenvolve software.

Caso queira assistir a palestra, eu recomendo, está disponível no YouTube.

{% youtube fX7hrszOAN0 %}

A lista é curta e os artigos são realmente interessante. _Quem sou eu para questionar a recomendação de leitura da Barbara Liskov?!?!_ 

* [Dijkstra, E. W. (1968). Letters to the editor: go to statement considered harmful. Communications of the ACM, 11(3), 147-148.](https://dl.acm.org/doi/10.1145/362929.362947)
* [Wirth, N. (1971). Program development by stepwise refinement. Communications of the ACM, 14(4), 221-227.](https://dl.acm.org/doi/10.1145/362575.362577)
* [Parnas, D. L. (1971). Information distribution aspects of design methodology.](https://kilthub.cmu.edu/articles/journal_contribution/Information_distribution_aspects_of_design_methodology/6606470?file=12096995)
* [Dahl, O. J., & Hoare, C. A. R. (1972). Chapter III: Hierarchical program structures (pp. 175-220). Academic Press Ltd..](https://www.informatik.uni-bremen.de/agbkb/lehre/programmiersprachen/artikel/dahl-hoare-hierarchical.pdf)
* [Morris Jr, J. H. (1973). Protection in programming languages. Communications of the ACM, 16(1), 15-21.](https://dl.acm.org/doi/10.1145/361932.361937)
* [Liskov, B., & Zilles, S. (1974, March). Programming with abstract data types. In ACM Sigplan Notices (Vol. 9, No. 4, pp. 50-59). ACM.](https://dl.acm.org/doi/10.1145/800233.807045)
* [Liskov, B. H. (1972, December). A design methodology for reliable software systems. In Proceedings of the December 5-7, 1972, fall joint computer conference, part I (pp. 191-199). ACM.](https://dl.acm.org/doi/10.1145/1479992.1480018)

## Declaração `go to` considerada prejudicial

Na verdade não é um artigo, é uma carta que é tratada como um artigo. Ela é citada por diversos artigos durante os últimos 40 anos e continua sendo bastante citada até hoje.

![Print do número de citações](/assets/images/artigos/citacoes-dijkstra.png)

É até irônico eu topar com essa recomendação proque o artigo estava na minha lista de desejo de leitura por vários motivos. O primeiro deles é que é do Dijkstra. Depois que ele faz parte de um grande debate que ocorreu por anos e fez até o Knuth cunhar a frase sobre "otimização prematura". 

Outra irônia desse artigo é que ele é um click bait! Sim, o título da carta era _A Case Against the Goto Statement_ (um argumento contra a declaração `go to`, em tradução livre), mas o editor achou por bem dizer que o Dijkstra tinha falado que usar `go to` é prejudicial. Na verdade o Dijkstra discorre sobre o porque o `go to` atrapalha o entendimento dos programas, uma vez que ele tem utilidade funcional, mas traz complexidade a compreensão.

![Print do Research Rabbit mostrando os novos artigos que citam](/assets/images/artigos/research-rabbit-dijsktra.png)

O que Dijkstra está fazendo ali é abandonando a lógica da máquina para abraçar de vez a lógica do "fluxo". Uma das suas referências era um trabalho que falava sobre uso de fluxogramas.

Para fazer essa argumentação, Dijkstra estabelece que um programa de computador é um fluxo de transformação de dados dinâmico guiado por um mapeamento estático, o código. Para entender o funcionamento de programas, os desenvolvedores devem olhar para esse modelo conceitual estático e procurar entender como o processo dinâmico está seguindo o processo estático. **Dijkstra estabelece o programa como um fluxo, um índice de passos que coordena uma execução.**

Hoje essa afirmação pode parecer óbvia para muitos, mas ela não é óbvia e nem todos os desenvolvedores tem esse entendimento.

Entender a programação como a construção de um roteiro estático para um processo dinâmico mostra o quão complexa é essa atividade. Precisamos não só codificar o que será feito, mas todas as excepcionalidades que podem acontecer e isso tem que ser compreensível tanto por uma máquina quanto por um humano.

## Desenvolvimento de programa pelo refinamento gradual

Esse artigo é bem interessante e ele dialoga com uma insatisfação que eu venho tendo há tempo nas minhas revisões de código. No primeiro paragrafo, o autor coloca o que eu já percebi ao revisar qualquer alteração, nós somos ensinar a programar tendo a máquina como centro do processo criativo, enquanto na verdade a máquina é apenas uma ferramenta que será usada para transformar dados que resolvem um problema do mundo real. O centro do nosso processo criativo deveria ser o problema do mundo real que estamos resolvendo com o nosso programa. 

Isso dialoga muito com o que chamamos _Domain-Driven Design_ (DDD)! Aliás, o autor do livro que cunhou essa expressão coloca essa mesma insatisfação nos primeiros capítulos, mas formulada de outra forma.

Essa dificuldade no ensino de programação, reflete em outro problema, acreditamos que basta conhecer uma linguagem e ter alguma intuição para que sejamos considerados programadores. Mas um programador não só escreve código, ele toma uma série de decisões de projetos para decompor um problema em problemas menoras que podem ser representados por código.

No fundo, todo programa é uma decisão de projeto que poderia ser diferente se decisões não tivessem sido feitas, e essas decisões são direcionadas por requisitos ou condições ambientais. Uma decisão mal feita pode atrapalhar o desenvolvimento de um programa por dificultar as decisões futuras.

Um exemplo dessa decisão mal feita é a escolha da estrutura de dados a ser utilizada. Quando escolhemos a forma que armazenamos os dados, limitamos as nossas opções de manipulação dos mesmo, o que nos leva ter que procurar soluções alternativas, ou rever a forma como representamos os dados. Isso, aliás, é um dos motivos pelo qual devemos postergar ao máximo a escolha sobre a forma como devemos armazenar e representar nossos dados.

Dessa forma, escrever um programa é uma sequência de refinamento de passos. Gradualmente pensamos sobre processos e os dividimos em atividades e sub-atividades. Escolhemos estruturas de dados, definimos classes, métodos e processos. Tudo isso é escrito em uma notação que é compreendida tanto por humanos quanto por computadores: as linguagens de programação. O grau de dificuldade do nosso problema inicial define o grau de modularidade que precisamos na nossa solução.

Um ponto interessante desse paper é o problema proposto que reflete a realidade da atividade de construção de programas. O problema das 8 rainhas pode ser resolvido quando dividimos o tabuleiro de xadrez em tabuleiro menores. Considerando que uma escolha foi feita e ela é correta, ela gerará um subconjunto de escolhas em que as escolhas prévias não são mais um problema.

<!-- 
> Given are an 8 X 8 chessboard and 8 queens which are hostile to each other. Find a position for eachqueen (a configuration) such that no queen may be taken by any other queen (i.e. such that every row, column, and diagonal contains at most one queen).
-->

> **O problema das 8 rainhas**
>
> Dado um tabuleiro de xadrez 8 x 8 e 8 rainhas que são hostis uma as outras. Encontre a posição para cada rainha (uma configuração) tal qual nenhuma rainha pode ser tomada por outra rainha (ou seja, cada linha, coluna e diagonal deve conter apenas uma rainha).

Eu li esse exemplo como uma grande metáfora da modularidade. Quando criamos um módulo e garantimos que ele funciona corretamente, não precisamos mais nos preocupar com possíveis falhas que ele tenha. Ele é um subproblema dentro do meu problema complexo que eu separo, especifico, valido e depois integro como algo confiável.