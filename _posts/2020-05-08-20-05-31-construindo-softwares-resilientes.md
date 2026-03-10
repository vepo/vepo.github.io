---
title: Construindo softwares resilientes
permalink: /posts/construindo-software-resilientes
published: true
description: Um Sênior de Verdade sabe construir software resilientes! Mas o que significa um Software Resiliente?
tags: [Desenvolvimento de Software, Programação, TDD, Carreira]
series: Coisas que todo Sênior deve saber
cover_image: /assets/images/capas/flor.jpg
publish_date: 2020-05-08 17:05:31 +0300
original: "https://dev.to/vepo/construindo-softwares-resilientes-3d65"
---

_—  Já ouviu falar de **eXtreme Go Horse (XGH)**?_   
_—  Não?!_ 🙄   
_—  Mas você pratica **XGH**?_ 🤨  
_—  Não?_   
_—  Ainda bem!_ 😀  

**XGH** é uma piada que gosto muito. Espero que você não o pratique. Mas coloquei ele na roda por seu exato oposto. Um Sênior deve construir softwares estáveis. E para se construir software estáveis você tem que ir pro extremo oposto do **XGH**. Devemos construir software resilientes.

Sim, eu usei a palavra resiliente. Vamos ao significado?

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/ou8mdzzu5v5ii8n4fbay.png)

Resiliência é a propriedade de um sistema suportar adversidade.

# Construindo Resiliência

Nós como desenvolvedores resolvemos problemas automatizando coisas. Quando vemos um problema já pensamos no modo como ele deve ser resolvido. 

Mas e se houver outra forma? 
E se seu usuário não entender a forma como deve ser feito o processo? 
E se houver um erro durante processo? 
E se necessitar uma configuração na máquina?

É nessas horas que seu software tem que ser Resiliente. 

Verdadeiros Sêniors constroem sistemas resilientes. Mas não seja gnóstico, não é um post que vai te fazer construir sistemas resilientes, é resolvendo bugs! Tudo que posso fazer por você é te ensinar o caminho, você terá que trilhar ele sozinho.

Então vamos com algumas dicas:

## 1. Um Sênior pensa em todos os problemas que podem acontecer em um fluxo

Quando você vai escrever um código, você sempre tem premissas:

1. Existe um arquivo de configuração.
2. Há uma classe que implementa essa interface.
3. O servidor está de pé.
4. Etc...

E se uma premissas dessas não for verdadeira? Seu código irá funcionar? Ou pelo menos irá mostrar o erro correto?

Vamos para exemplos reais? 

Eu tenho um projeto que estou desenvolvendo para ser um tipo de tester. Dá uma olhada lá:

{% github vepo/plain-test %} 

Nele eu executo o testes em passos (_Step_), cada passo tem um plugin que implementa. Então para execução de um passo eu preciso:

1. Achar o Plugin de Execução
2. Executar o Passo
3. Verificar os Assertions do Passo

Simples? Poderia ser implementado em 1 linha?

{% gist https://gist.github.com/vepo/871ebd3e0fa62aebfbc135e61ad74235 %}

Mas temos dois problemas aqui que devem ser validados. 

1. Há um Plugin para implementar o Passo?
2. Na definição do Passo, todos os parâmetros estão definidos?

Vê que temos mais dois problemas a verificar? E detalhe, esses problemas são um erro de definição do teste e não de execução do teste. Logo o motivo da falha deve ser diferente.

{% gist https://gist.github.com/vepo/416b699bb7c9fca3b49e202b19d99d7d %}

Ao se identificar um erro, exiba a mensagem de erro correta, que ajuda quem irá resolver esse erro.

## 2. Um Sênior desenvolve software que é resistente a desenvolvedores

Ok! Você desenvolveu o negócio lindamente. Está tudo funcionando perfeitamente, fez o _deploy_ em produção. Resultado: usuários felizes! 😀

Fim? Pode ser que não, em algum momento esse software poderá ser atualizado. Pode ser necessários corrigir os bugs que ainda não foram encontrados, ou poderá ser adicionada alguma feature. Qualquer alteração, em qualquer lugar, tem o potencial de alterar a lógica do seu software. Como podemos validar que tudo está funcionando corretamente?

_Não vou vender TDD como uma bala de prata, esse não é o problema que TDD resolve. Depois falo de TDD. Eu gosto de TDD por isso repito TDD... Continuamente... TDD_

Um Sênior de verdade constrói software resiliente a desenvolvedores. Mas como fazer isso? 

Você deveria se preocupar com algumas coisas: 

1. Qual a cobertura de testes do sistema?
2. Os testes foram feitos só pra passar pela cobertura de testes e agradar o arquiteto? Ou os testes estão realmente validando o output? 
3. Os testes são executados no processo de build?

Caso você tenha respondido não para qualquer uma das perguntas abaixo, seu software não é resiliente a desenvolvedores. E você não pode confiar em si mesmo a ponto de pensar que você conseguirá resolver todos os problemas no futuro.

Quando resolvemos um bug, ou adicionamos uma feature nova, temos um pensamento viciado. Apenas pensamos em um fluxo, e nos esquecemos de outros. É normal e esperado isso. Você é um engenheiro e não Deus.

Como eu resolvo isso? Eu crio testes unitários com todos os pressupostos. 

{% gist https://gist.github.com/vepo/88d10d4c6e4ae0523ffe19268f5871f0 %}

É um habito meu começar meu desenvolvimento com alguns pressupostos desses, mas eles não fazem parte do _**TDD**_, pois não são _Baby Step_. Mas eles dão uma clara visão do que vai falhar. Pode ser que em uma próxima feature um passo desses falhe, e o desenvolvedor irá decidir:

1. Se corrige o problema
2. Se corrige o teste
3. Se remove o teste, caso ele não faça mais sentido.

## 3. Um Sênior investiga possíveis erros

_—  Então, esse teste falha em 50% dos casos. Mas caso falhe, roda de novo que dá certo._

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/lefte06h7r9ngi7d4l8b.jpg)

Se você ouvir essa frase. Recrimine! Isso não pode acontecer.

Um possível erro intermitente em um teste pode ser um erro intermitente em produção. Pode ser custoso investigar antes do _deploy_? Pode! Mas será mais barato do que investigar depois do _deploy_, não?

Um Sênior de verdade sabe que pequenos problemas não podem passar sem investigação. Não pode buscar a solução fácil de ignorar ou remover o teste. Isso é fácil, mas para um sênior é porco _(com todo respeito aos porcos)_.

# Conclusão

Quase todo software necessita de resiliência. E um Sênior de Verdade sabe ver isso.

Ele consegue se precaver de várias situações:

1. Erros esperados
2. Erros inesperados
3. Pessoas esperadas
4. Pessoas inesperadas 
5. Aleatoriedades....

Não que ele deva ser um Deus em se tratando de desenvolvimento, mas tem que praticar a disciplina de promover a resiliência. 

Esse é um caminho a ser trilhado....

# Livros Recomendados

1. [O Projeto Fênix: um Romance Sobre TI, DevOps e Sobre Ajudar o seu Negócio a Vence](https://www.amazon.com.br/projeto-f%C3%AAnix-Gene-Kim/dp/8550801895?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=2AYVJTDQGN55J&keywords=projeto+phoenix&qid=1588968692&sprefix=projeto+ph%2Caps%2C272&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=45c6f18224bfe9cf0d82b737331a5761&language=pt_BR&ref_=as_li_ss_tl)
2. [Test Driven Development: By Example](https://www.amazon.com.br/Test-Driven-Development-Kent-Beck/dp/0321146530?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=BXKYM1LP3IQH&keywords=test+driven+development&qid=1588968574&sprefix=test+dr%2Caps%2C275&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=b9ad00a6e5089e02d277bed813cb0283&language=pt_BR&ref_=as_li_ss_tl)
3. [Código Limpo: Habilidades Práticas do Agile Software](https://www.amazon.com.br/C%C3%B3digo-limpo-Robert-C-Martin/dp/8576082675?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&keywords=clean+code&qid=1588968796&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=7ff5c1abee4d3b6a1860924b6f392698&language=pt_BR&ref_=as_li_ss_tl)