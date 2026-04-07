---
title: Inicie um projeto pelo README.md
permalink: /posts/inicie-um-projeto-pelo-readme
published: true
publish_date: 2021-03-26 08:51:06 +0300
description: Antes de iniciar a desenvolver, descreva o que você vai fazer
tags: [Documentação de Software, README, Documentação, Engenharia de Software]
image: /assets/images/docs-100-42.webp
---

Quando comecei a trabalhar oficialmente como Arquiteto de Software, identifiquei uma grande deficiência: _documentar_. Documentar não é uma atividade fácil, e você pode sentir essa dor ao usar qualquer software, biblioteca ou framework proprietário ou open source. Investi parte do meu tempo para [ler sobre](https://www.amazon.com.br/Documenting-Software-Architectures-Views-Beyond/dp/0321552687?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=2LKF8X7AVG95S&dchild=1&keywords=documenting+software+architectures&qid=1616765005&sprefix=documenting+so%2Caps%2C299&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=526aaf0393ca484d229ae901a6ab7cfb&language=pt_BR&ref_=as_li_ss_tl) o assunto e praticar tanto nos meus projetos pessoais quanto da empresa que trabalhava.

Pela minha própria experiência, posso afirmar que praticar é uma boa tática. Documentar não é uma atividade natural para nenhum desenvolvedor, muitas vezes supomos que as coisas são obvias e quem vai usar nosso software irá compreender o que está feito imediatamente. As vezes quando chega uma pergunta, sempre vem aquele pensamento _"Como ele é burro?"_, mas isso deve ser evitado. Nenhum usuário é burro, ele só não compreendeu o que está posto.

Vale uma reflexão aqui... Quantas horas você já gastou tentando entender alguma coisa? Pode ser que seja a implementação mais simples que existe, mas se existe um conceito (ou uma convenção) desconhecido, você não irá compreender. John Ousterhout em seu livro [A Philosophy of Software Design](https://www.amazon.com.br/Philosophy-Software-Design-2nd-English-ebook/dp/B09B8LFKQL?keywords=Philosophy-Software-Design-English&qid=1667927943&sr=8-5&ufe=app_do%3Aamzn1.fos.6121c6c4-c969-43ae-92f7-cc248fc6181d&linkCode=ll1&tag=vepo0f-20&linkId=191bf91d38700ad4d84885900b3b695a&language=pt_BR&ref_=as_li_ss_tl) chama isso de _Unknown unknowns_, Desconhecido desconhecidos em tradução livre. Falei um pouco sobre complexidade e da experiência da leitura desse livro em [Sobre Design de Software (I): O que é complexidade?](https://vepo.substack.com/p/sobre-design-de-software-i).

Então em Junho de 2019 coloquei no papel o que tinha em mente [Start a project by the README](https://blog.vepo.dev/posts/start-a-project-by-the-readme). Está em inglês porque precisava praticar minha escrita. 🙃

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

#### Um bom example

Um bom exemploe é a documentação do [Zookeeper](http://zookeeper.apache.org/). Vemos ver o que está escrito?

> Apache ZooKeeper is an effort to develop and maintain an open-source server which enables highly reliable distributed coordination.
> ##### What is ZooKeeper?
> _ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services._

Na primeira linha você já tem uma ideia do problema que ele se propõe a resolver. Se você continuar lendo vai encontrar um lista completa dos [casos de uso](https://zookeeper.apache.org/doc/current/zookeeperUseCases.html). Isso é muito bom! Já dá pra ter uma boa visão do que é possível fazer com ele.

#### Um exemplo ruim

Um exemplo não tão bom foi a documentação do [Apache Kafka](https://web.archive.org/web/20190711233550/https://kafka.apache.org/intro) quando eu escrevi o primeiro post. Ele descrevia o Kafka como:

_Apache Kafka® is a distributed streaming platform. What exactly does that mean?_


Porque essa documentão não é clara? Porque ela não define os termos. Um leitor desavisado não vai entender o real proposito dela. É preciso primeiro definir os conceitos. Seria o Kafka um Pub/Sub? O que difere um Stream de simplesmente mensagens? Se você continuar, ele vai usar termos como _pipelines_ e _clusters_ sem definir eles. Mas qual é o real proposito do Kafka? Porque o Kafka é mais do que um Message Queue? Vale a penas usar o Kafka apenas como Message Queue?

Eu resumiria tudo isso em uma única frase: _Apache Kafka foi construido ser a Fonte da Verdade de sistemas reativos. Muito além de um simples Pub/Sub, é possível todo um ecosistema orientado a eventos com baixo acoplamento, alta escalabildade e estabildidade._

Observe que eu tentei responder duas perguntas básicas **O que é** e **Que tipo de problema resolve**. Além disso acabei respondendo **O que não é**.

#### Dicas

1. Evite usar seus próprios termos.
2. Seja direto. Poucas linas.
3. Responde as principais questões.

#### TL; DR;
Uma boa descrição é um texto curto que responde a duas questões. O que é e Que tipo de problema resolve;

### 2. Explique as motivações dele

Um segundo passo é descrever quais são as motivações do seu componente. Isso deve ir muito além do problema que ele resolve, deve se explicar os principais motivos que incentivaram o desenvolvimento de um novo componente.

Vamos supor um caso, você quer criar um novo Server Render Framework, mas esse será diferente dos demais, o servidor fará a renderização do template e do código javascript. Esses templates serão usados em tempo de execução com algumas funções que são chamadas via REST. Para que isso acontece, o desenvolvedor deve declarar qual é o escopo de cada código. Um desenvolvedor deve conhecer essa motivação, senão ele será tentado a criar os templates para cada dela, sem separar responsabilidades de cada componente.

Eu normalmnente crio uma sessão no meu README.md chamada **Racional**, onde descrevo as principais forças que me levaram a escolher alguns detalhes arquiteturais. Por exemplo, uma vez desenvolvi uma engine de Regras de Negócio que tinha um XML para descrever a regra de negócio que era associado a um classpath. Eu detalhei isso explicando os motivos, usava XML para que os times de negócio pudesse validar o que estava sendo feito podendo eles alterarem sem alterar código Java. Logo, qualquer desenvolvedor saberia que o XML poderia ser inspecionado por um não desenvolvedor, assim ele tinha por obrigação criar um XML que expressasse a regra, ao invês de encapsular tudo isso dentro do código Java.


#### TL; DR;

Qualquer idea importante **DEVE** ser descrita brevemente. Se mais informações é necessária, pode-se criar um link para o local onde ela é descrita por completo.

### 3. Defina os termos que você irá usar

Cada software tem seus termos com seus próprios significados. O [MongoDB](https://docs.mongodb.com/manual/core/document/) fala de documentos e não são os mesmo documentos do [Apache POI](https://poi.apache.org/). O [Apache Kafka](https://kafka.apache.org/documentation/streams/) fala de Stream, mas não é o mesmo definido pela biblioteca padrão do [Java](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html).

Sua documentação deve definir esses conceitos de maneira clara. Há algum termo que você comum que você usa com outro sentido? Vale apena definir ele? Cria uma sessão para isso. Explique _o que é_ e _o que não é_ esse termo.

O livro [Domain-Driven Design: atacando as complexidades no coração do software](https://www.amazon.com.br/Domain-Driven-Design-Eric-Evans/dp/8550800651?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=1D2KUNV054DKA&dchild=1&keywords=domain+driven+design&qid=1616796613&sprefix=domain+d%2Caps%2C319&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=3386cdec4271f3774f6cfa591c57224d&language=pt_BR&ref_=as_li_ss_tl) trás um conceito que acho bastante interessante. Ele chama de Linguagem Onipresente. Ela é as definições dos termos comuns usadas no contexto de um projeto, se você está criando uma biblioteca, você também pode criar termos. Comece definindo eles, depois use em toda a documentação e código.

### 4. Explique o comportamento e as interações

Como as coisas acontecem? Como as coisas se relacionam? Isso também deve ser descrito pela sua documentação. 

Um dos projetos Jakarta EE que eu mais gosto é o [Java CDI](http://cdi-spec.org/), ele possibilita um baixo acoplamento em projetos Java. Mas... Ao usar ele, muitas coisas podem parecer mágica. Ao implementar meu primeiro _CDI Bean_, eu fiquei me perguntando quem cria os objetos? Isso não está respondido na documentação, mas é o CDI Container.

Se eu fosse reescrever a documentação do Java CDI, iria fazer um pequeno diagrama com o ciclo de vida de um objeto. Além disso, iria usar o termo Beans Gerenciado (Managed Beans) largamente no texto, para que o desenvolvedor saiba que quem controla o Ciclo de Vida desse objeto é o próprio framework e não o meu código.

### 5. Descreva como usar

Você fornece uma API REST? Uma biblioteca Java? Uma biblioteca C? Descreva como usar cada funcionalidade da API fornecida. Seja breve, porém extenso! Uma dica é criar uma lista de funcionaldiades e Code Snippets.

#### Seja Breve!

No seu README você deve ser breve, não se alongue muito. Coloque apenas o principal uso e um exemplo simples, depois link uma página com a lista detalhada. Mas dê preferência a usar um indice, nesse é melhor usar um [AsciiDoc](https://asciidoc.org/) ao invés de um [Markdown](https://www.markdownguide.org/). Use um **Snippets.adoc** ao inves de um **Snippets.md**.

#### Seja consistente!

Considere a documentação como parte do seu código. Na verdade ela é! 

Qualquer alteração que você fizer, procure se ela altera algum ponto na documentação.

Qualquer nova funcionalidade que você adiciona, descreve ela na documentação.

No SCRUM temos o conceito de [**Definição de Pronto**](https://www.agilealliance.org/glossary/definition-of-done), entre em acordo com seu time que para que uma tarefa seja concluída, a documentação deve refletir as alterações.

Inconsistências são muito perigosas, elas podem levar a erros de uso ou bugs que podiam ser facilmente evitáveis, mas é muito difícil de achar.

## Concluindo

Quando você ouvir que **o código é a documentação**, tenha muito ao usar esse código. você não conhece a intenção de quem fez. Código descreve apenas comportamento, não descreve a intenção de quem o fez. Cada linha de código pode ter algo escondido que trará muitoa complexidade ou quem sabe bugs escondidos.

Aqui quero até expressar em como discordo do Uncle Bob sobre Comentários e Documentação. Ele sempre expressa que o código deve ter todas as respostas. Eu acho essa opinião fundamentalistas, o código deve ter muitas respostas, mas deve existir documentação para explicar os conceitos do código.

{% twitter https://twitter.com/unclebobmartin/status/870311898545258497 %}

A ideia do Uncle Bob é bem aceita em projetos simples, mas e se o projeto tiver algumas decisões arquitetônicas complexas? Como posso expressá-lo sem um README ou alguns comentários?

## Mais

Você pode adicionar o que quiser ao seu README.md. Seja livre!
