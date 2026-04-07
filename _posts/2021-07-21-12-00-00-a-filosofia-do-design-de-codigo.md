---
title: A Filosofia do Design de Código
published: true
description: Uma introdução da palestra que farei sobre Filosofia do Design de Código no TheDevConf 2021.
tags: [Complexidade, Design de Código, Programação]
image: /assets/images/peanuts.jpg
publish_date: 2021-07-21 12:00:00 +0300
permalink: /posts/a-filosofia-do-design-de-codigo
original: "https://vepo.medium.com/a-filosofia-do-design-de-c%C3%B3digo-ffb137cef9c2?source=friends_link&sk=2f150acfb6c8a30370475f78f7168a5b"
---

Muitos engenheiros desconhecem as ciências humanas. Acreditam que é perca de tempo esse tipo de estudo. Porque vou estudar o modo com pensamos? Porque vamos estudar o modo como a sociedade é organizada? Ou o modo como os fenômenos sociais acontecem? Ou quem sabe como a língua evolui? Bom, cada área dessa tem muito a ajudar, talvez um engenheiro não saiba disso por puro desconhecimento.
Desconhecimento só se resolve com conhecimento, e por isso que levanto o seguinte questionamento: _como a filosofia pode ajudar no desenvolvimento de software?_

---

# O que é filosofia?

Antes de tudo, precisamos antes entender ao que a filosofia se propõe. Temos no nosso imaginário a ideia do filósofo como alguém depressivo que vive pensando na vida, alguém solitário. Esse estereótipo não é verdadeiro. Para quem lembra do desenho Peanuts (ou Turma do Charlie Brown ou Snoopy), o Charlie Brown é só um cara meio depressivo e inteligente.

![Essa imagem é o resumo da filosofia clássica.](/assets/images/filosofia.avif)

Mas nós não estamos aqui para falar de filosofia, mas da filosofia do design de código…

---

# O que é Design de Código?

Estamos tentando pensar o que é Design de Código, para isso vamos iniciar com uma sugestão:

> _Design de Código são Técnicas que diminuem a complexidade do código._

Na verdade dessa afirmação é verdadeira, mas ela é vaga. Primeiro porque não sabemos exatamente o que é uma técnica. Depois não sabemos definir exatamente o que é complexidade. E por fim, sabemos o real objetivo de se escrever código?

# O que é uma Técnica?

A definição de Técnica é bem complexa. Na realidade, é um assunto que tenho bastante interesse e por isso, se te interessar, recomendo a leitura o livro "_The Technological Society_" do Jacques Ellul. Eu estou relendo esse livro e fazendo os resumos da minha leitura.

Se eu precisar resumir o que é Técnica, eu partiria da definição do Ellul de Operação Técnica no primeiro capitulo do seu livro.

> _Técnica pode ser definida como qualquer operação, ou conjunto de operações, executada com um determinado **método** com o **objetivo** a ser atingido._

Baseado nessa definição podemos concluir que o Design de Código é um método e tem um objetivo claro.

O método não é tão fácil de deduzir, mas quem já estudou engenharia é capaz pensar em um método. Vamos propor um bem simples? Primeiro temos que ter estatísticas, fazer algumas mudanças e verificar o que aconteceu com essas estatísticas. Isso é o que chamamos de iteração, a cada iteração nosso código deve estar mais próximo do seu objetivo que é **não ser complexo**. Quem quiser pensar mais nas estatísticas, recomendo o post do Alberto Souza [Design de código: seu papel até hoje](https://www.zup.com.br/blog/design-de-codigo-seu-papel-ate-hoje).

O objetivo do Design de Código já está na definição diminuir a complexidade. Mas o que é complexidade? Porque ela acontece? Que tipos de complexidade existem?

# Porque existe complexidade?

Quando falamos de complexidade de software, muitos desenvolvedores tem em mente bibliotecas e linguagens altamente complexas. Isso acontece porque muitos já nasceram em um mundo onde é possível declarar um objeto e dar ordens ao objeto. Mas isso é muito alto nível. Na verdade isso é extremamente abstrato, computadores não sabem o que são objetos e não sabem o que são ordens. Então vamos nos perguntar o que os computadores entendem?

![Olha o código da ignição da Apolo 11! 😲](/assets/images/apollo11.png)

Todo computador vai compreender bits, um conjunto de instruções básicas e alguns periféricos como monitor, teclado, placa de rede. Isso é um computador, uma máquina burra que apenas pega a próxima instrução da memória e executa ela alterando valores no barramento ou registradores.

**_- Conseguiu entender?_**

![Exemplo de Opcode](/assets/images/opcode.png)

É óbvio que não! Para escrever código era preciso muita compreensão, muita atenção, além de saber decorado que valores estavam nos registradores e todos os comandos que o processador aceita. Era uma atividade extremamente complexa. Quando estudei linguagem de montagens, o professor nos encorajava a construir fluxogramas detalhados sobre a execução do programa. Era preciso antes de colocar o primeiro _opcode_ (entenda como um número para cada operação e alguns parâmetros) ter o desenho completo do que iria acontecer e onde cada informação seria armazenada.

Percebeu que eu não falei variável? Sim, nem esse conceito existia. O que existia era informação na memória: código de execução, sistema operacional, variáveis, constantes, etc… Quem bom que não precisamos mais disso! Só quem trabalha com IoT e drivers.

Mas porque eu fiz esse passeio histórico? **Para dizer que linguagens de programação existem para diminuir a complexidade.** Complexidade já existe em software porque máquinas são complicadas e burras ao mesmo tempo. Reza a lenda que Dennis Ritchie desenvolveu a linguagem C porque queria desenvolver um jogo… Bom era isso que falavam na época que eu estava na faculdade.

A complexidade é acidental em software. Ela sempre vai existir. Sem uma boa linguagem de programação, muito que temos hoje não existiria. Testes de Software não seriam possível de automatizar. Bibliotecas são muito complexas de serem criadas. A compreensão do código é praticamente impossível, leia o código da [Apollo 11](https://github.com/chrislgarry/Apollo-11) e observe que há mais comentários do que código. Sem uma boa linguagem de programação a afirmação do Uncle Bob dizendo que comentários são desnecessários é ridícula.

# Próximos passos

Nesse post eu tratei de tudo aquilo que não vou falar mais. O que é filosofia. De onde vem a complexidade. O que é técnica.

Nos próximos passos vou tentar definir o que é Complexidade.