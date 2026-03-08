---
title: Design Patterns. E se alguém já tiver resolvido seu problema?
permalink: /posts/design-patterns-e-se-alguem-ja-tiver-resolvido-seu-problema
published: true
description: Todo Sênior deve conhecer ao menos um Padrão de Projeto. Aqui apresento o que são e como um deles me ajudou em 2006.
tags: [Desenvolvimento de Software, Design Patterns, Padrões de Projeto, Clean Code]
series: Coisas que todo Sênior deve saber
cover_image: /assets/images/capas/pao.jpg
publish_date: 2020-05-06 15:39:52 +0300
original: "https://dev.to/vepo/design-patterns-e-se-alguem-ja-tiver-resolvido-seu-problema-4klf"
---

Continuando com a Série **Coisas que todo Sênior deve saber**, vamos falar sobre Design Patterns e como eles podem ajudar no seu desenvolvimento.

# Porque Design Patterns?

Quando você pega um problema e abre sua IDE favorita, você logo começa a pensar em como resolver esse problema. Certo?

E se seu problema já tiver sido solucionado por uma infinidade de pessoas? Você não estaria perdendo tempo em pensar como resolvê-lo?

São aí que surgem os **Design Patterns**. Na verdade esse nome vem do livro escrito por 4 engenheiros de software, `<ironia>` em uma época um tanto remota 1994`</ironia>`, [***Padrões de Projetos: Soluções Reutilizáveis de Software Orientados a Objetos***](https://www.amazon.com.br/gp/product/8573076100?ie=UTF8&linkCode=ll1&tag=vepo0f-20&linkId=8d150eef8cf1e085cf2064c5de0357ba&language=pt_BR&ref_=as_li_ss_tl)

Pra ser sincero eu não li o livro, mas ainda pretendo ler ele.

# Tipos de Problemas

Antes de partir para descrever os Padrões de Projetos, precisamos entender os tipos de problemas que eles tentam resolver. 

***Essas classificações são minhas!!!***

**Algoritmos** são receitas de bolo para software. Todo software é composto por algoritmo. Mas vou classificar algoritmos como os passos para solução de problemas complexos. Não vou falar deles aqui.

**Padrões de Projetos** são receitas simples para problemas de projeto. Você vai usa-los em projeto um pouco maiores, mas são problemas como: Criação de Objetos, Interpretar Comandos, Aplicar operações em Elementos. 

Vamos valor sobre Padrões de Projetos!

## Como os conheci?

Muito tempo atrás, estava trabalhando no desenvolvimento de ferramentas de desenvolvimento, e desenvolvíamos um produto baseado no Eclipse para uma multinacional que na época era a número 1 na venda de telefones celulares (o smartphone ia nascer em poucos meses). 

Fizemos um prototipo e sucesso! Ganhamos o projeto. E de 3 pessoas o projeto foi pra 60!!!!! 😱😱😱😱

Então nosso código começou a desandar! Tínhamos por volta de 4 equipes com 10 pessoas cada (falta 20, né?), imagina 10 pessoas colocando a mão no código! Então fizemos um _Working Group_ para melhorar a qualidade do nosso código, desse Grupo de Trabalho saiu a ideia de investigarmos os Padrões de Projetos e cada semana alguém escolher 1, apresentar e propor uma alteração que poderíamos fazer no produto com ele.

# Tipos de Padrões de Projetos

No livro Padrões de Projeto, são propostos 3 tipos de padrões.

1. **Padrões de criação**: são padrões que guiam a criação de objetos. Deve responder perguntas básicas do seu software como "como criar objetos?", "quem implementa meus objetos?". Conhecer eles ajuda bastante em soluções inteligente, assim você consegue um baixo acoplamento em seu software já criado.
2. **Padrões estruturais**: são padrões que guiam como objetos podem ser implementados. 
3. **Padrões comportamentais**: são padrões que auxiliam na implementações de soluções dentro do seu programa.

Muitas vezes você pode estar quebrando cabeça com algum problema e nem imagina que existem uma solução como a que está aí sendo desenvolvida.

# Meu primeiro Padrão Implementado

Quando chegou minha vez de apresentar, eu tinha acabado de desenvolver uma _feature_ para _deploy_ da aplicação no celular. O ano era 2006, uma aplicação era bem diferente do que você conhece hoje! 🤔 

Eu tinha implementado o protocolo [OBEX](https://en.wikipedia.org/wiki/OBject_EXchange) para transferir o pacote para o celular. E não estava feliz. Havia alguns erros nele, e tinha um que ocorria muito esporadicamente e era difícil de pegar. O código era macarrônico, como era comum naquela época. então resolvi estudar o [Command](https://pt.wikipedia.org/wiki/Command).

## Command Pattern

Se você for pesquisar as [referências](https://refactoring.guru/pt-br/design-patterns/command) sobre esse padrão verá que ele se aplica muito para comandos de interface gráfica. Mas aí que está a beleza dos **Design Patterns**, você pode adaptar uma solução para vários problemas diferentes.

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/wgzwbhi4c3q8mdos9b5r.png)

O _Command_ nos obriga a separar o que é código de execução de um comando de outros códigos como interface, controle de sessão, etc... Assim ao aplicar a minha implementação do OBEX, eu deveria antes de tudo me perguntar: *quais comandos o protocolo tinha*?

Dada essa resposta, eu criei uma classe abstrata `Command`, uma classe `Session` e _voilà_. Estava quase tudo pronto!!!!! 😲 

Só faltava implementar os comandos e cada um só precisava saber das suas responsabilidades. A partir daí, comecei a refatorar o código a fim de separar cada operação.

Sabe aquele bug esporádico que acontecia? Pois é, era um lixo que ficava na sessão de sessões anteriores que não dava pra ver com um código macarrônico. Mas quando eu refatorei, ao abrir uma classe eu via apenas a lógica dela, nada mais. Sabia como ela interagia com as outras.

### Resultado

Com a aplicação do *Command* muito do meu código foi literalmente apagado. Havia muita duplicação. 

A lógica ficou evidente, facilitando a manutenção do mesmo. Tanto que nunca mais tivemos bugs ali. Ele durou até o *SmartPhone* decretar o fim do *[Feature Phone](https://en.wikipedia.org/wiki/Feature_phone)*.

# Outros Padrões

Ok. O mundo mudou desde 2006. Mas existem outros padrões que devemos seguir?

Sim! 

Caso você trabalhe com Microsserviços? Obrigatoriamente você tem que conhecer os padrões de Microsserviços. Vá em [microservices.io](https://microservices.io/patterns/index.html) e leia.

Caso você trabalhe com Java? Existem alguns padrões do extinto Java EE, agora Jakarta EE. Eu falo de um deles aqui: 

{% youtube iDGgNNLYaO4 %}

# Conclusão

Todo Sênior deve conhecer ao menos 1 Design Pattern de cabeça, isso quer dizer, sabe implementar ele sem consultar nada. Deve ter ao menos 2 favoritos.

Design Patterns nos ajudam a classificar e resolver problemas simples que não são importantes no negócio da nossa aplicação, mas se não funcionar impacta o negócio.

Design Patterns ajudar seu código a ficar elegante. Isso impressiona! 🧔

Design Patterns é o pão de cada dia do desenvolvedor. Ele deve ser básico, usado diariamente.

# Indicações de Leitura

_Estão em ordem de prioridade!_ 😉

* [Como ser um Programador Melhor: um Manual Para Programadores que se Importam com Código](https://www.amazon.com.br/gp/product/8575224158?ie=UTF8&linkCode=ll1&tag=vepo0f-20&linkId=d0f9586ee355bbed4caec0e1c4eb57e8&language=pt_BR&ref_=as_li_ss_tl)
* [Código Limpo: Habilidades Práticas do Agile Software](https://www.amazon.com.br/gp/product/8576082675?ie=UTF8&linkCode=ll1&tag=vepo0f-20&linkId=1790bc18757d15dc12820f4b286bb3e5&language=pt_BR&ref_=as_li_ss_tl)
* [Padrões de Projetos: Soluções Reutilizáveis de Software Orientados a Objetos](https://www.amazon.com.br/gp/product/8573076100?ie=UTF8&linkCode=ll1&tag=vepo0f-20&linkId=2294e03e9fc5e276cb2d1ec14ef9f053&language=pt_BR&ref_=as_li_ss_tl)