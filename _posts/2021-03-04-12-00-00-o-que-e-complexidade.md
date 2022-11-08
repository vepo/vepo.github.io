---
title: O que é complexidade?
permalink: /posts/o-que-e-complexidade
published: true
description: O que trás complexidade a um projeto de software?
tags: [Design de Software, Arquitetura de Software, Complexidade]
cover_image: /assets/images/pexels-pixabay-206685.jpg
series: Sobre Design de Software
publish_date: 2021-03-04 20:00:00 +0300
original: https://vepo.substack.com/p/sobre-design-de-software-i
---

## Motivador

Comecei a ler o livro [A Philosophy of Software Design](https://www.amazon.com.br/Philosophy-Software-Design-2nd-English-ebook/dp/B09B8LFKQL?keywords=Philosophy-Software-Design-English&qid=1667927943&sr=8-5&ufe=app_do%3Aamzn1.fos.6121c6c4-c969-43ae-92f7-cc248fc6181d&linkCode=ll1&tag=vepo0f-20&linkId=191bf91d38700ad4d84885900b3b695a&language=pt_BR&ref_=as_li_ss_tl), o livro surge das notas de aula de um curso de [Software Design na Stanforn University CS-190](https://web.stanford.edu/~ouster/cgi-bin/cs190-winter20/index.php).

Esse é um curso que eu gostaria de fazer, tendo cursado uma modalidade praticamente industrial de Engenharia de Computação, muito do meu foco na graduação foi desenvolvimento C e Assembler. Ao entrar no mercado tive que aprender a abstrair, e abstração é tudo no mundo de software.

Essas notas serão livres, não se propões a serem um resumo do livro.

## Software e Diagramas

Você pode não ter desenhado nenhum diagram do seu software ou do seu sistema como um todo. Mas esse diagrama existe, ele é virtual, é baseado no conjunto das interações de cada peça do seu sistema, de cada classe do seu software. Você vai começar a racionalizar ele quando começar a colocar “no papel” esses diagramas.

Na Engenharia de Software existem várias ferramentas e linguagens de apresentação que você pode usar, mas eu recomendo uma bem mais simples pra começar: [README.md](https://dev.to/vepo/start-a-project-by-the-readme-4c49).

![Notas em um quadro](/assets/images/software-design/notes.jpeg)

Quando for começar a escrever, pense em quem vai ler. O que é preciso saber? Coloque suas ideias em uma sessão chamada **Racional**. Depois coloque uma sessão (ou um novo documento) com todas as informações necessárias para execução. Por fim vá descrevendo cada conceito que seu software tem, um glossário com os termos usados.

Eric Evans em [Domain-Driven Design](https://www.amazon.com.br/Domain-Driven-Design-Eric-Evans/dp/8550800651?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=1Q6E8PM9BGI79&dchild=1&keywords=domain+driven+design&qid=1611780458&sprefix=domain%2Caps%2C870&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=35481008730f03c32f145959755e807a&language=pt_BR&ref_=as_li_ss_tl) afirma que cada projeto tem sua Linguagem Onipresente, está é a definição dos termos que em comum entre o código e o negócio. É muito importante esses termos estarem bem definidos.

Se possível, coloque as decisões arquiteturais também. Crie um diretório de documentação e faça a lista com tudo que foi cogitado e escolhido. _Porque não usamos tal biblioteca?_ 

> _A grande limitação ao se escrever software, é entender o sistemas que estamos criando._

Software é complexo, e podemos reduzir essa complexidade documentando as ideias e conceitos que estamos usando. Um simples desenho vai ajudar muito que pode te ajudar a desenvolver.

## De onde vem a complexidade?

A complexidade vem da dificuldade de compreensão. Qualquer dificuldade de compreensão no desenvolvimento/manutenção do software causará dificuldade.

Segundo John Ousterhout, os sintomas da complexidade são:

* **Mudança amplificada**: se para fazer uma alteração simples, for necessária alterações em vários locais, seu software é complexo.

* **Carga Cognitica**: o quanto é necessário para um desenvolvedor saber quando for fazer alterações em seu código? A Carga Cognitiva pode ser atacada pela modularização. Se criarmos bons módulos ou componentes, podemos isolar conceitos deixando-os encapsulado. Imagine uma Arquitetura Orientada a Eventos, cada microsserviços terá que implementar seu produtor e consumidor de eventos, cada microsserviços terá que implementar seus módulos de serialização. Mas no fundo isso será um padrão no sistema, e se isso fosse uma biblioteca/framework?

* **Desconhecidos Desconhecidos**: A informação tem que ser evidente. Exemplos de desconhecidos desconhecidos? Uma procedure SQL que altera valores na base e não estão configurada na base de código. 

> _Um dos mais importantes objetivos de um bom Desgin é para um sistema ser óbvio._

A complexidade vem principalmente de dependências e obscuridade. Dependência significa quando uma parte depende de outra, quanto menos dependências entre as partes, menos complexidade seu software terá. E obscuridade significa aquilo que não é obvio, seu software tem comportamentos mágicos ou paranormais? Se for escolher entre fazer algo que pareça mágica, faça uma boa escolha e documente o processo.

Por fim, a complexidade é incremental. Nenhum software é descartável, todos podem ser salvos. Se você encontra muita dificuldade, uma pergunta que se tem que fazer: _quanto custaria pra reescrever tudo?_ Nunca parta para opção de reescrever sem antes ter uma estatística e provavelmente será a opção mais cara. 

Caso não queira reescrever, um dica é o livro [Trabalho Eficaz com Código Legado](https://www.amazon.com.br/Trabalho-Eficaz-com-C%C3%B3digo-Legado/dp/8582600321?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&dchild=1&keywords=trabalhando+legado&qid=1611783106&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=ca23ee34596853e70ef5ace4fa0ed96f&language=pt_BR&ref_=as_li_ss_tl). Nele o autor vai trabalhar várias abordagens de como trabalhar com seu código. Uma que já validei em uma empresa que trabalhei foi fazer uma fachada em alguns módulos. Criar uma interface e ir reescrevendo os módulos aos poucos. Outra é você ir fazendo mudanças pequenas, melhorando o design.

## Conclusão

Todo design de software evolui. Se hoje pode estar bom, em poucos meses pode estar ruim. Vale pensar em como as funcionalidades devem ser colocadas.