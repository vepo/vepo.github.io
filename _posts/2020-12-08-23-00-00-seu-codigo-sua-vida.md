---
title: Seu Código, Sua vida
permalink: /posts/seu-codigo-sua-vida
published: false
description: Como vai o seu código? Exitem formas de melhorar ele? Será que sua empresa se preocupa com isso também?
tags: [Desenvolvimento de Software, Backend, Linguagem de Programação, Qualidade de Código]
cover_image: /assets/images/pexels-negative-space-169573.jpg
series: Backend Roadmap
publish_date: 2020-12-08 23:00:00 +0300
---

Uma vez falaram pra mim que a organização do meu guarda roupa diz muito sobre a minha personalidade. Eu discordo veementemente! O guarda roupas é meu, só eu vou mexer nas minhas cuecas... Nem minha esposa mexe lá! Mas será que meu código é igual meu guarda roupas?

Bom sendo ou não, temos uma diferença básica... Ninguém vai ler a sua gaveta de cuecas. E se alguém precisar pegar uma camiseta sua emprestada? Ou se alguém precisar saber onde colocar uma bermuda de praia nova? E se daqui a 5 anos você precisar entender a lógica por trás da organização das gravatas? Código não é igual a guarda roupas, ele precisa se expressar de maneira clara, outras pessoas vão ler e dar suporte a ele... E por fim, seu guarda roupas, por mais bagunçado que seja, tem uma gaveta pra cada proposito!

Vamos falar de como organizar melhor seu código e tudo que gira ao redor dele. Alias, se você é um desenvolvedor Backend, ele é o seu principal portfólio.

![Guarda roupas cheio de ternos](/assets/images/backend/guarda-roupas.jpg)

# Referências

Se me fizessem uma única pergunta: _Como melhorar meu código?_ A minha resposta seria breve, leia livros! 

Em 1995 um cara escreveu um livro para dizer que livros não são mais necessários. Além do grave problema lógico embutido, e da questão ética de que ele ganhava financeiramente com o dispositivo que substituia os livros, ele errou! Livros são e por muitos anos serão necessários. Se você vai ler eles digitalmente ou não, não importa. E por incrível que parece existem muitos livros sobre códigos!

Mas ler não é o bastante, um software sabe ler, mas o ser humano tem uma capacidade única que nenhum software pode desenvolver: senso crítico. Compreenda o livro e questione-o. Absorva somente aquilo que você compreendeu válido, se algo não foi válido, escreva sobre e coloque na internet para outros lerem!

Alguns livros me ajudaram a melhorar meu código e vou indicar eles...

![Biblioteca antiga](/assets/images/biblioteca-velha.jpg)
<center>Foto de <a href="https://www.pexels.com/pt-br/foto/abajur-arquitetura-assento-banco-2079451/"><b>Emre Can</b></a> no <b>Pexels</b></center>

## Código Limpo

O primeiro é [**Código Limpo: Habilidades Práticas do Agile Software**](https://www.amazon.com.br/C%C3%B3digo-limpo-Robert-C-Martin/dp/8576082675?ie=UTF8&linkCode=ll1&tag=vepo0f-20&linkId=e239c4d23c09e25a1c788dd8b587a848&language=pt_BR&ref_=as_li_ss_tl) de Robert C. Martin, vulgo Uncle Bob. Apesar de odiado por muitos, Uncle Bob tem uma certa importância no mercado, nem tanto por esse livro, mas por outros conceitos que vamos abordar mais a frente. Mas porque esse livro é bom? Esse livro vai te apresentar o que seria uma posição extrema de como fazer código bem feito. Na verdade ele é um extremista, mas você pode ponderar sobre o que ele fala. 

Uma das posições dele é não ter comentários no código. O princípio é importante, mas a posição é radical. A ideia básica é que o código deve se expressar por si mesmo, logo comentários não são necessários. Isso é válido para situações em que não há dependências de sistemas externos. Mas ainda há alguns problemas. Como se documenta soluções de design? Como se documenta tentativas de refactor que falharam? Como se documenta pontos de melhoria? No meu código eu sempre uso marcações para adicionar comentários. `TODO` para ideias que não serão implementadas por falta de tempo. `FIXME` para erros encontrados no código que deverão ser removidos em uma próxima oportunidade. E `XXX` para _code-smells_ que podem ser melhoradas. Esses comentários devem ser descritivos porque hoje você pode saber o que deve ser feito, mas depois de um fim de semana, pode nem lembrar mais qual é o problema.

Outra posição extrema dele é o tamanho máximo de um método. Segundo o Uncle Bob, um método não pode passar de 5 linhas. Não sejamos extremos! Eu discordo em partes. Porque podem existir métodos de 15 linhas que são facilmente entendível, enquanto alguns métodos de 5 linhas podem ser horrorosos! Para isso há uma medida chamada [Complexidade Cognitiva](https://www.sonarsource.com/docs/CognitiveComplexity.pdf). Você pode até procurar ler as referências, mas a maneira mais simples de decidir o tamanho de um método é perguntar: _consigo entender o que está sendo feito?_ Se você achar que dá pra separar alguma lógica, já é hora de separar.

## Sendo um programador melhor

Outro livro bem melhor é [**Como ser um Programador Melhor: um Manual Para Programadores que se Importam com Código**](https://www.amazon.com.br/Como-Ser-Um-Programador-Melhor/dp/8575224158?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=1W6VPWLEINLKP&dchild=1&keywords=como+ser+um+programador+melhor&qid=1607293417&sprefix=como+ser+um+pro%2Caps%2C288&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=706e475efd6efbd393dc07bc1fa8c18d&language=pt_BR&ref_=as_li_ss_tl) de Pete Goodliffe. Pete não tem uma abordagem tão extrema, ele é bem humorado e bem flexível. A sua dica mais valiosa é _"escreva menos código"_! Sim código não significa software. Quanto menos código menos bugs. Ele não está falando pra você não programar, muito pelo contrário, você deve programar, mas tem que fazer de maneira efetiva. Porque fazer uma funcionalidade se ela não é necessária? Remova código que não é utilizado. 

Goodliffe também vai dar dicas de como debugar um código e como testar. E como é um livro completo, vai falar de ética e a cultura do desenvolvedor.

## Design Orientado ao Domínio

Outro livro excelente é o [**Domain-Driven Design: Atacando as Complexidades no Coração do Software**](https://www.amazon.com.br/Domain-Driven-Design-Eric-Evans/dp/8550800651?ie=UTF8&linkCode=ll1&tag=vepo0f-20&linkId=71dab7716a982f7773012ec80551bffa&language=pt_BR&ref_=as_li_ss_tl), este não irá falar do código, mas do design do código. Bons desenvolvedores irão escreve códigos que são parte do negócio do software, para isso é preciso pensar no código. Ele defende que o código deve ter uma Linguagem Onipresente, sendo os conceitos expressos no código presente e entendíveis para outras pontas do processo.

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

Muitas pessoas gerenciam o desenvolvimento de software através de Post-it! É uma ótima abordagem se você não precisar rastrear as alterações. Mas os complexos serviços de Gerenciamento de Mudanças existem por um motivo. Se você tem alguma dúvida sobre usar realmente os seu software de gerenciamento de mudança, releia a sessão anterior. 

Te convenceu? Não? E como isso pode ajudar seu código?

A qualidade de qualquer código se degrada através das mudanças constantes. No livro **O Programador Pagramático** chama de entropia... Na verdade a Física chama de Entropia! Entropia é a característica do universo de sempre tender ao estado de menor energia que é a desorganização. Para ficar organizado você precisa inserir energia. E como se insere energia em Software? Pensando, descrevendo, submetendo seu pensamento a crítica e reestruturando seu pensamento de acordo com a crítica. E como isso é feito? Gerenciamento de Mudanças! É o famoso Ticket! Não há segredo.

Mas porque nossa perguiça de usar um Ticket?! Tenho três suposições sobre o tema.

A primeira é que gostamos de testar nossas ideias. Programadores são pessoas acostumadas a respostas rápidas, crio um prototipo e já rodo tendo o feedback quase imediato. Qual o motivo de documentar se já tenho uma solução na manga?

Minha segunda suposição é que não gostamos de descrever nossas soluções. Documentar software é difícil, não há como negar. E por isso temos que gastar muita energia para vencer a barreia de apender a descrever. Mas isso é um exercício que temos que fazer diariamente. Temos que documentar nossas decisões, seja no código, seja em `README.md` ou em Tickets! Quanto mais descrevermos nossa solução, melhor vai ficar suas descrições.

E minha terceira e última suposição é: **não gostamos de crítica!** Muitas vezes por motivos, um pouco imaturos, não queremos que coloquem defeito em nossas soluções. Isso seria um ponto se estivessemos na quinta série, mas somos pessoas maduras construindo software. Nossa motivação não deve ser garantir que nossa ideia seja aceita, mas é encontrar uma solução para o cliente. Devemos focar nas perguntas: **_qual é o problema?_** e **_qual é a melhor forma de resolver o problema?_** Muias ideias vão ser levantadas, mas se posicione baseado em fatos, pressupostos, análises e **Provas de Conceito**. Vamos falar nisso um pouco mais a frente.

![Ônibus Escolar](/assets/images/bus-school.jpg)

<center>Foto de <a href="https://www.pexels.com/pt-br/foto/leve-luz-light-veiculo-3427742/"><b>fotografierende</b></a> no <b>Pexels</b></center>

# Conheça sua linguagem

Um dos grandes erros da minha carreira foi demorar a conhecer a fundo minha linguagem. Se eu tivesse investido nisso assim que comecei a conhecer o Java, minha carreira teria sido totalmente diferente. Conhecer sua linguagem vai de dar um panorama melhor de como as coisas devem ser feitas e como você pode propor soluções melhores para seus problemas.

É muito comum os desenvolvedores se tornarem focados em resolver problemas. Não importa como, o problema deve ser resolvido. Isso deixa muitos direto ao ponto, sem conhecer bem o ferramental disponível. Conhecer o ferramental é muito importante! Gaste um tempo vendo palestras sobre a sua linguagem, conheça os principais nomes, veja Meetups. Procure a documentação e observe o _Release Notes_ das novas versões da sua linguagem.

**CUIDADO! Não veja Youtubers!** Muitos deles vão focar em agradar a audiência, e não em propor um conteúdo relavante para o seu trabalho. Eles vão focar em falar de modinhas e não daquela feature difícil de enteder, mas que vai melhorar a performance do seu código. A missão deles não é propor conteúdo pra vocês, mas garantir o _billing_ do canal deles.

Eu sou um desenvolvedor Java desde 2004, e o Java mudou muito. O modo como se desenvolvia em 2004 não é o modo de desenvolvimento hoje. Na minha história com o Java, eu tive muito ganho aprendendo _Reflection_ em 2004. Ele me deu a oportunidade de desenvolver um projeto de IDE para uma grande empresa usando o Eclipse. Depois patinei muito... aprendi pouco! Muitos anos depois usava muita _Reflection_, mas não conhecia a documentação de [`Object#hashCode`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#equals-java.lang.Object-) e [`Object#equals`](https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html#hashCode--), só fui aprender depois de não saber responder uma pergunta de entrevista de emprego. Muitos anos depois e já me achando master, implementei um produto inteiro se baseando em _Reflection_... Ficou elegante, mas poderia ter sido muito mais performatica se eu tivesse usado [_Handles_ e não _Reflection_](https://github.com/c-guntur/java-katas/tree/master/java-handles).

Outro ponto sobre a linguagem é o idioma. Não gosto muito do Chico Buarque, me julguem, mas gostei do seu livro Budapeste. Nesse livro ele conta a história de um Gost Writer que vai morar em Budapeste a luta para aprender o idioma, porque escreve em um idioma não é só traduzir o que está escrito em outro idoma. Você gosta de _telemarketing_? Exatamente! Gerundismo é uma feature do inglês e não do português. E cada linguagem de programação tem o seu idoma, tem expressões idiomaticas, tem modos de fazer cada coisa diferente. Devemos conhecer o idioma da nossa linguagem

# Conheça outras linguagens

Benchmark é enriquecedor! Você consegue ter uma visão muito rica de qualquer coisa. Conhecendo outras linguagens vai ter forçar a conhecer outros "idiomas", como acabamos de falar. Cada linguagem tem o seu proposito e conhecer esse proposito pode te enriquecer de várias formas.

Você pode aprender uma nova forma de resolver problemas. Nada me tira da cabeça que Programação Reativa é uma resposta ao Javascript, que foi escrito para resolver eventos e depois foi portado para rodar sem estar no navegador. Isso é um mérito parao o Javascript, mas não precisa ficar só lá! Programação Reativa provou que não travar a _Thread_ nos dá ganhos de performance, mesmo tendo uma só _Thread_! E essa solução já foi portada para outras linguagens, temos [Vert.x](https://vertx.io/) em Java que apresenta uma performance superior aos outros frameworks.

Conhecer outras linguagens também pode te ajudar a resolver problemas. Você não precisa resolver todos os problemas na sua linguagem, talvez seu problema seja resolvido de forma mais eficiente em outra linguagem. Será que Clojure não resolve seu problema melhor? E Go? E C? Eu não conheço seu problema, mas conheço algumas coisas dessas linguagens. C e Go são linguagens compiladas e terão um footprint de memória muito menor do que Java. Mas é mais difícil desenvolver nessa linguagens. Clojure é uma linguagem funcional... etc...

# Resolva problemas

Uma outra forma de melhorar seu código é ter mais repertório. Eu sou um músico amador, estudei por quase 4 anos gaita. Conheço praticamente todas as técnicas e teorias, mas hoje seria muito difícil tocar uma música. Porque?

Existem dois motivos para isso. O primeiro é que não tenho mais repertório. Eu parei estudar e não tenho tocado. Não sei as frases mais comuns e nem os _licks_ que podem ser copiados e usados em improvisos. 

O outro motivo é que estou enferrujado! Me falta prática. Eu me lembro de algumas músicas de cabeça, sei escrever a partitura dela. Me lembro de ter tocado _The Wizard_ do _Black Sabbath_ na audição da escola num bar lotado. A música é super simples, tanto que não era minha audição, mas do cara da bateria. A bateria dela é complicada, a gaita... bobeira. Mas se eu for tocar agora vou travar! Me falta prática!

Esses dois motivos vão atua em qualquer atividade cognitiva sua. Atua até mesmo quando você deixa de falar sua lingua natal por uns anos, imagina com programação. E programar é como tocar um instrumento, quanto mais exercicio você faz, mais repertório você terá.

Uma forma de ter mais repertório é resolver problemas simpels. Existem sites para isso! Podemos falar do [codewars](https://www.codewars.com/kata) ou [HackerRank](https://www.hackerrank.com/). Eles vão te dar problemas simples, mas alguns com soluções elegantes. Se você é alguém iniciante, vai tentando resolver uns problemas, vê a solução de outros. Isso vai te dar repertório para você usar no seu dia a dia.

# Tome café

E por último, vamos falar de café! Sim, o café pode ajudar a melhorar o seu código. Tomar café não é o ato de beber uma bebida de origem Árabe/Africana, é o ato de socializar. Quando eu digo que Tomar café vai além de beber estou falando dos processos que giram em torno desse ato. 

O primeiro deles é a socialização. Comente sobre seu trabalho no café da empresa. Imagina que você está precisando implementar um Parser de uma Linguagem Formal... Alguém pode te sugerir usar [ANTLR](https://www.antlr.org/). Ou alguém pode de explicar que uma Linguagem Formal é muito mais simples que uma Linguagem Natural, e que é bobeira você ficar vendo esse monte de vídeos abertos sobre Machine Learning...

O segundo processo é a reflexão. Dê um tempo para pensar na sua solução. Vá refletir, desfoque e depois volte a problema. Vá no café e não pense no problema por 15 minutos. Você vai ver que novas ideias se formaram na sua cabeça e essas novas ideias podem enriquecer a sua solução.

# Preocupe-se

Você já tem algumas dicas de como melhorar seu código. Ele é o seu produto, aquilo que você produz. Seja um artesão de software. Um artesão sempre procura melhorar a sua técnica, melhorar o seu trabalho. 

Se você se preocupa somente com cuspir código, provavelmente você ficará estagnado no mesmo lugar toda vida. Mas se você procurar melhorar, você irá crescer.

![Computador com caneca](/assets/images/pexels-negative-space-169573.jpg)