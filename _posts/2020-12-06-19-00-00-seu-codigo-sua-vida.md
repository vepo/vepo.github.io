---
title: Seu Código, Sua vida
permalink: /posts/seu-codigo-sua-vida
published: false
description: TBD
tags: [Desenvolvimento de Software, Backend, Histórico]
cover_image: /assets/images/backend/clint-eastwood-the-good-the-bad-and-the-ugly.jpg
series: Backend Roadmap
publish_date: 2020-12-06 19:00:00 +0300
---

Uma vez falaram pra mim que a organização do meu guarda roupa diz muito sobre a minha personalidade. Eu discordo veementemente! O guarda roupas é meu, só eu vou mexer nas minhas cuecas... Nem minha esposa mexe lá! Mas será que meu código é igual meu guarda roupas?

Bom sendo ou não, temos uma diferença básica... Ninguém vai ler a sua gaveta de cuecas. E se alguém precisar pegar uma camiseta sua emprestada? Ou se alguém precisar saber onde colocar uma bermuda de praia nova? E se daqui a 5 anos você precisar entender a lógica por trás da organização das gravatas? Código não é igual a guarda roupas, ele precisa se expressar de maneira clara, outras pessoas vão ler e dar suporte a ele... E por fim, seu guarda roupas, por mais bagunçado que seja, tem uma gaveta pra cada proposito!

Vamos falar de como organizar melhor seu código? Alias, se você é um desenvolvedor Backend, ele é o seu principal portfólio.

![Guarda roupas cheio de ternos](/assets/images/backend/guarda-roupas.jpg)

# Referências

Se me fizessem uma única pergunta: _Como melhorar meu código?_ A minha resposta seria breve, leia livros! 

Em 1995 um cara escreveu um livro para dizer que livros não são mais necessários. Além do grave problema lógico embutido, e da questão ética de que ele ganhava financeiramente com o dispositivo que substituia os livros, ele errou! Livros são e por muitos anos serão necessários. Se você vai ler eles digitalmente ou não, não importa. E por incrível que parece existem muitos livros sobre códigos!

Mas ler não é o bastante, um software sabe ler, mas o ser humano tem uma capacidade única que nenhum software pode desenvolver: senso crítico. Compreenda o livro e questione-o. Absorva somente aquilo que você compreendeu válido, se algo não foi válido, escreva sobre e coloque na internet para outros lerem!

Alguns livros me ajudaram a melhorar meu código e vou indicar eles...

![Biblioteca antiga](/assets/images/biblioteca-velha.jpg)
<center>Foto de <a href="https://www.pexels.com/pt-br/foto/abajur-arquitetura-assento-banco-2079451/"><b>Emre Can</b></a> no <b>Pexels</b></center>

## Código Limpo

O primeiro é [**Código Limpo: Habilidades Práticas do Agile Software**](https://amzn.to/3ghtXs8) de Robert C. Martin, vulgo Uncle Bob. Apesar de odiado por muitos, Uncle Bob tem uma certa importância no mercado, nem tanto por esse livro, mas por outros conceitos que vamos abordar mais a frente. Mas porque esse livro é bom? Esse livro vai te apresentar o que seria uma posição extrema de como fazer código bem feito. Na verdade ele é um extremista, mas você pode ponderar sobre o que ele fala. 

Uma das posições dele é não ter comentários no código. O princípio é importante, mas a posição é radical. A ideia básica é que o código deve se expressar por si mesmo, logo comentários não são necessários. Isso é válido para situações em que não há dependências de sistemas externos. Mas ainda há alguns problemas. Como se documenta soluções de design? Como se documenta tentativas de refactor que falharam? Como se documenta pontos de melhoria? No meu código eu sempre uso marcações para adicionar comentários. `TODO` para ideias que não serão implementadas por falta de tempo. `FIXME` para erros encontrados no código que deverão ser removidos em uma próxima oportunidade. E `XXX` para _code-smells_ que podem ser melhoradas. Esses comentários devem ser descritivos porque hoje você pode saber o que deve ser feito, mas depois de um fim de semana, pode nem lembrar mais qual é o problema.

Outra posição extrema dele é o tamanho máximo de um método. Segundo o Uncle Bob, um método não pode passar de 5 linhas. Não sejamos extremos! Eu discordo em partes. Porque podem existir métodos de 15 linhas que são facilmente entendívels, enquanto alguns métodos de 5 linhas podem ser horrorosos! Para isso há uma medida chamada [Complexidade Cognitiva](https://www.sonarsource.com/docs/CognitiveComplexity.pdf). Você pode até procurar ler as referências, mas a maneira mais simples de decidir o tamanho de um método é perguntar: _consigo entender o que está sendo feito?_ Se você achar que dá pra separar alguma lógica, já é hora de separar.

## Sendo um programador melhor

Outro livro bem melhor é [**Como ser um Programador Melhor: um Manual Para Programadores que se Importam com Código**](https://amzn.to/2VKRBns) de Pete Goodliffe. Pete não tem uma abordagem tão extrema, ele é bem humorado e bem flexível. A sua dica mais valiosa é _"escreva menos código"_! Sim código não significa software. Quanto menos código menos bugs. Ele não está falando pra você não programar, muito pelo contrário, você deve programar, mas tem que fazer de maneira efetiva. Porque fazer uma funcionalidade se ela não é necessária? Remova código que não é utilizado. 

Goodliffe também vai dar dicas de como debugar um código e como testar. E como é um livro completo, vai falar de ética e a cultura do desenvolvedor.

## Design Orientado ao Domínio

Outro livro excelente é o [**Domain-Driven Design: Atacando as Complexidades no Coração do Software**](https://amzn.to/37DwZTH), este não irá falar do código, mas do design do código. Bons desenvolvedores irão escreve códigos que são parte do negócio do software, para isso é preciso pensar no código. Ele defende que o código deve ter uma Linguagem Onipresente, sendo os conceitos expressos no código presente e entendiveis para outras pontas do processo.

A reflexão sobre o Domínio deve fazer parte do processo de desenvolvimento, sendo o domínio a razão do software existir.

# Processos chatos

Sabe os processos de desenvolvimento de software? Pois é, muitos deles são chatos, mas são chatisses necessária. Talvez você esteja reclamando de barriga cheia, nunca enfrentou um Waterfall de 3 meses. Mas talvez você tenha que preencher páginas e páginas de documentação antes de meter a mão no código.

Um processo desses foi instituido por um único motivo: _alguém lá de cima da empresa acha que código ruim está sendo produzido!_ Então como resolver isso? Você tem duas opções: _1. tentar reduzir a burocracia e manter a qualidade atual_ ou _2. tentar reestruturar o processo e melhorar a qualidade atual_. Para fazer qualquer uma dessas soluções você tem que entender os motivos que esse processo existe, mapear se o processo está realmente sendo executado, mostrar para a gerência responsável que você está compromissado com a motivação deles e por fim propor a melhoria.

Vou agora te mostrar o porque existem certos processos para que você possa entender como ele trás qualidade ao código.

## Galhos e Folhas

* _**Seu_Código_Sua_Vida.pdf**_
* _**Seu_Código_Sua_Vida_2.pdf**_
* _**Seu_Código_Sua_Vida_3.pdf**_
* _**Seu_Código_Sua_Vida_FINAL.pdf**_
* _**Seu_Código_Sua_Vida_AGORA_VAI.pdf**_

Já te ocorreu de ficar revisando coisas antigas para achar onde foi inserido um erro? Pois é, é pra isso que deve existir um controle de versão. Todo processo de desenvolvimento de software deve garantir que cada entrega seja rastreável. 

Imagina se o cliente te chega com a seguinte informação. _Deu erro ao fazer _. E você pega a versão mais recente e não consegue encontrar o erro. Será que o erro existe ainda? Ou ele acontece em outras circustâncias? Como saber? A resposta disso deve vir com uma pergunta: _qual é a versão que deu o erro?_ O entregável deve ser rastreável, para isso ferramentas como Jenkins salvam _fingerprints_ dos arquivos compilados para poderem ser rastreáveis, sabendo exatamente quando ele foi gerado. Mas o processo de geração da release tem que ser bem estruturado. Deve ser criada uma TAG. Alterada a versão. Se possível o hash/id do _commit_ armazenado no código.

Imagina duas pessoas alterando o mesmo aquivo. Vamos dar nomes Madalena e Severiano. Madalena por ser mais eficiente termina sua funcionalidade primeiro e manda um merge lá na _master_ (ou _main_). Severiano é meio malemolente, por ser folgado ele terminou depois e viu que deu ums problemas de merge.... Mas ele foi apagou umas linhas e nem testou! Vê algum problema? Como resolver o possível problema? Severiano pode ter gerado um erro e nem saber. Por sua vez Madalena crê que suas alterações estão lá e o provavél problema irá recair sobre suas costas. É por isso que existe processos de _Code Review_. Nada pode ir pra _branches_ principais se não for revisado por pares, e mais de 1 por favor! _Code Review_ também serve para evitar a criação de Silos dentro do projeto, fazendo com que exista o compartilhamento do conhecimento. Também homogeniza o estilog do código.

Imagina que você acabou de resolver um problema, fez o _commit_ e colocou como comentário: _**bla bla bla**_. Você passou dias pra resolver esse problema, mas a solução era simples. Daqui a seis meses o mesmo problema acontece em outro projeto! O desenvolvedor vai lá e acha na descrissão do Ticket #5764 o problema mesmo problema que está enfrentando. Mas o Ticket foi fechado depois de 3 dias com o seguinte comentário: _Problema Resolvido!_ Será que serão necessário mais 3 dias pra resolver o problema? Ele te procura, mas você nem lembra como resolveu. Como podemos melhorar? Duas opções são possíveis. A primeira é fazer comentários pertinentes nos Tickets! Se você tivesse descrito o problema e como ele foi solucionado, poderia dar uma luz ao outro desenvolvedor. A outra solução é referenciar o Ticket no comentário do _commit_, assim qualquer um pode achar onde foi resolvido o problema. Eu recomendo que você faça os dois e mais ainda. No _commit_ só coloque alterações referente ao mesmo para não atrapalhar quem no futuro for procurar pela solução.

![Homem bravo](/assets/images/bravo.jpg)

<center>Foto de <a href="https://www.pexels.com/pt-br/foto/adulto-bravo-cadeira-camisa-azul-1447424/"><b>Crypto Crow</b></a> no <b>Pexels</b></center>

## Post-it!

Muitas pessoas gerenciam o desenvolvimento de software através de Post-it! É uma ótima abordagem se você não precisar rastrear as alterações. Mas os complexos serviços de Gerenciamento de Mudanças existem por um motivo.