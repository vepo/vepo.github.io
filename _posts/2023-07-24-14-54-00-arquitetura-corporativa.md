---
title: Arquitetura Corporativa
published: false
#description: Como funciona o gerenciamento de memória com Java? Nesse post vou descrever como funciona a memória de um programa Java e comparar ele com de outros programas. Depois vou mostrar quais os principais desafios do gerenciamento de memória em programas Java. A ideia desta série é criar um tutorial Java onde mostrarei todos os segredos da linguagem e do ecossistema.
tags: [Arquitetura]
cover_image: /assets/images/java/duke-paper.webp
#series: Java 101
permalink: /posts/arquitetura-corporativa
publish_date: 2023-07-24 15:55:00 +0300
---

O interesse por arquitetura de software vem caindo nos últimos anos. Isso é um fato como você pode ver no gráfico abaixo. Não tenho a intenção de procurar uma explicação para esse fato, podemos ter várias suposições, mas nenhuma suposição dessa teria seriedade se não for submetidaa um escrutínio academico. Fazer a pergunta "porque as pessoas tem se interessado cada vez menos por arquitetura" tem que ser acompanhado de uma investigação séria e embasada.

![Gráfico do Google Trends sobre Arquitetura de Software e Arquitetura Corporativa](/assets/images/software-architecture.PNG)

Uma das possíveis explicações seria que hoje software é tratado como uma _commodity_. As empresas que fornecem software já estão tão bem estabelecidas que os desenvolvedores normalizam a existência de fornecedores externos. Eles podem ser comprados, como se compra feijão na feira. Está tudo bem! Esse era o caminho esperado.

Mas será que é tudo bem não ter interesse em arquitetura de software? 🤔

Essa pergunta me surgiu quando ao acessar as redes sociais na manhã de hoje eu me deparei com duas listagem de casos de uso para Apache Kafka que o limitavam a um mecanismo de integração. Talvez fossem pessoas que só estavam atrás de likes e visibilidade, pode até ser... Mas havia um indicador surpreendente! Analisei uma das publicações e vi que ela tinha muitos compartilhamentos e ninguém comentou o óbvio: ela estava incorreta!

# A função do Apache Kafka e uma ferramenta de integração

Sem querer entrar no mérito da publicação, mas ela dizia em 2 dos 5 casos de uso que o Kafka poderia ser um mecanismo de integração. Realmente o Kafka pode ser usado como um mecanismo de integração, mas uma leitura rápida da documentação vai mostrar que ele é muito mais que isso. A pessoa ia trazer complexidade desnecessária. 

Se a pessoa tivesse feita uma busca por "frameworks de integração de dados" poderia achar o Apache Camel. O Camel é feito para integrações, tem suporte para isso, deve ter produtos feito em cima dele com isso. Pronto! Não tem motivos para usar o Kafka.

Mas para que serve o Kafka e porque isso está em um post chamado Arquitetura Corporativa?!?!

Bom, estamos falando de Arquitetura e o Kafka é a ferramenta perfeita para se construir um Barramento de Mensagens. Eu quero falar um pouco de arquitetura e subir o nível até chegar a arquitetura corporativa.

Voltando ao tema... O Kafka pode ser usado para se CONSTRUIR um barramento de dados corporativo, distribuído e altamente escalável, mas para isso é preciso pensar toda a infraestrutura de software de outra maneira. Primeiro devemos voltar atrás, é preciso PENSAR NA INFRAESTRUTURA! Para você entender melhor o que eu estou tentando dizer, se pergunte: **na sua empresa, tem alguém pensando em padronização através dos times e departamentos?**

Se a resposta para a pergunta anterior é não. Tudo bem. Existem empresas que padronização não é o foco, mas saiba que muita informação e oportunidades podem estar sendo perdida. Voltemos ao Apache Kafka. Ele é conhecido por ser o mais poderoso Middleware Orientado a Mensagens, e ao se construir aplicações baseadas em trocas de mensagens temos um padrão arquitetural um pouco diferente do famoso cliente-servidor, ou REST.

Aplicações orientadas as mensagem pode prover um estilo arquitetural chamado Event-Driven Architecture, que é bastante interessante e torna a integração de aplicações mais desacopladas. Essa escolha pode ser feita por um time independente, mas se dois times tem escolhas arquiteturais diferentes começamos a montar uma torre de babel. Seria fácil integrar 2 produtos ou duas informações de uma empresa sem nada padronizado?

# _Data Mesh is not about software_

Quando nós paramos para olhar para história do processamento de dados, voltamos lá para 2010 quando se falava que Big Data é igual sexo adolescente: _todo mundo fala sobre, ninguém sabe fazer, todo mundo acha que os outros estão fazendo e todo mundo diz fazer_. 

OK! Isso é um meme! Hoje ninguém mais se gaba de usar dados, as vezes as pessoas dizem ter um "data lake" sem nem ao menos saber o que é um "data lake", só porque uma consultoria disse que o produto era um "data lake". Aí eu volto as perguntas retóricas: **sua empresa usa estatísticas de dados de produção?**

Um dos conceitos mais interessantes que eu vi nos últimos 2 anos foi o conceito de Data Mesh, ou Malha de Dados. Gostei tanto que resolvi escrever minha proposta de mestrado usando ele. Data Mesh é um padrão arquitetural CORPORATIVO. Não é um padrão arquitetural de software! Mas um padrão para empresa que deve ser implantando em software. E aqui chego ao ponto que vou tentar unificar as pontas soltas.

Para entender o que é um padrão arquitetural corporativo é preciso que empresa tem que ter um padrão interno de integrações alinhado com a estratégida da mesma. É papel do CTO olhar para empresa, procurar mapear como as coisas estão sendo feitas e ver se o que está sendo feito atinge o alinhamento estratégico da empresa.

Vamos inventar um e-comerce ficticio para tentar descrever?

## TechMart: Um caso gerado pelo ChatGPT

Vamos supor que o e-commerce "TechMart - Sua Loja de Tecnologia Online" é um e-commerce simples usando uma plataforma paga e sem muitos recursos. Com apenas 2 anos de existência teve um crescimento expressivo e resolveu profissionalizar sua gestão. O corpo de diretores se reuniu e definiu qual será a Missão, Visão e Valores da empresa assim como quais são os objetivos de curto e médio prazo.

> ## Missão:
> Oferecer aos nossos clientes uma experiência de compra online excepcional, fornecendo os mais modernos produtos eletrônicos do mercado, garantindo a qualidade e a autenticidade dos produtos, e proporcionando um atendimento ao cliente de excelência. Esse foi o documento criado nessa reunião:
> 
> ## Visão:
> Ser reconhecido como o e-commerce líder no segmento de tecnologia, sendo a primeira escolha dos consumidores quando buscam produtos eletrônicos inovadores, além de ser referência em atendimento ao cliente e responsabilidade ambiental.
> 
> ## Valores:
>
> 1. **Qualidade e Confiança**: Compromisso com a venda apenas de produtos de alta qualidade e originais, garantindo a satisfação e a confiança dos nossos clientes.
> 2. **Atendimento ao Cliente**: Colocar o cliente em primeiro lugar, oferecendo um atendimento excepcional, ouvindo suas necessidades e solucionando seus problemas com agilidade e eficiência.
> 3. **Inovação e Tecnologia**: Manter-se atualizado com as últimas tendências em tecnologia e oferecer aos nossos clientes produtos inovadores e de ponta.
> 4. **Responsabilidade Ambiental**: Ser ecologicamente responsável, adotando práticas sustentáveis, utilizando embalagens amigáveis ao meio ambiente e buscando parcerias com fabricantes comprometidos com ações ecológicas.
> 5. **Transparência e Ética**: Agir com integridade em todas as nossas operações, sendo transparentes em nossas políticas e práticas de negócio.
> 6. **Foco no Cliente**: Entender as necessidades dos nossos clientes e superar suas expectativas, buscando a sua satisfação em todas as etapas da jornada de compra.
> 7. **Valorização dos Colaboradores**: Reconhecer e valorizar nossos colaboradores, proporcionando um ambiente de trabalho estimulante, inclusivo e de crescimento profissional.

E esses foram os objetivos de médio e longo prazo definidos pelo corpo de diretores:

> ## Objetivos de Médio Prazo (3 a 5 anos):
> 1. **Crescimento das Vendas**: Aumentar significativamente o volume de vendas anuais, atraindo novos clientes e fidelizando os clientes existentes.
> 2. **Expansão do Mix de Produtos**: Ampliar a variedade de produtos oferecidos para abranger outras categorias relacionadas à tecnologia, como gadgets inteligentes, produtos de realidade virtual e dispositivos de automação residencial.
> 3. **Cobertura Geográfica**: Expandir a área de entrega para atender a um maior número de regiões e países, possibilitando que mais clientes tenham acesso aos produtos do TechMart.
> 4. **Liderança em Atendimento ao Cliente**: Tornar-se líder no segmento de atendimento ao cliente, investindo em treinamento de equipe, tecnologias de suporte e soluções para garantir a máxima satisfação dos clientes.
> 5. **Parcerias Estratégicas**: Estabelecer parcerias com fabricantes e fornecedores de renome, garantindo acesso exclusivo a produtos inovadores e condições comerciais vantajosas.
> 6. **Reconhecimento da Marca**: Fortalecer a marca TechMart no mercado, tornando-a sinônimo de qualidade, confiança e inovação.
>
> ## Objetivos de Longo Prazo (5 a 10 anos):
>
> 1. **Expansão Global**: Tornar-se uma referência global em e-commerce de tecnologia, expandindo a atuação para diversos países ao redor do mundo.
> 2. **Diversificação de Negócios**: Diversificar as atividades da empresa, explorando oportunidades em serviços de assistência técnica, programas de troca e reciclagem de dispositivos eletrônicos usados, entre outros.
> 3. **Inovação Tecnológica**: Investir em pesquisa e desenvolvimento para criar produtos e serviços próprios, impulsionando a inovação e diferenciando o TechMart da concorrência.
> 4. **Sustentabilidade Total**: Tornar-se uma empresa totalmente sustentável, desde a gestão interna até a logística de entrega, minimizando o impacto ambiental e promovendo práticas sustentáveis em toda a cadeia de valor.
> 5. **Serviços Personalizados**: Oferecer serviços personalizados, como assistência técnica especializada, recomendações de produtos baseadas no perfil do cliente e programas de fidelidade aprimorados.
> 6. **Responsabilidade Social**: Desenvolver programas de responsabilidade social corporativa, apoiando iniciativas de educação, inclusão digital e outras causas relacionadas à tecnologia e à comunidade.

Nessa reunião foi também definida que a empresa seria fortemente orientada a dados e para isso todos os departamentos deveriam expor dados para consumidos por outros departamentos. Ao CTO ficou a responsabilidade de definir como seria essa implantação dessa politica, assim como para o COO ficou de definir como seria o redesenho dos departamentos.

Você já deve tá pensando que é só o CTO dizer que agora todo mundo usa Kafka tá feito, né? ERRADO!

Esse é o momento que o CTO deve olhar para o estado atual da empresa e mapear:

1. Quais são os dados que a empresa tem hoje.
2. Como eles são expostos.
3. Quem gera esses dados e como gera esses dados.
4. Quem consome esses dados e qual a forma que consome.
5. Que tipos de solução a empresa tem? Elas são criadas internamente ou externamente? Quais as limitações?
6. Qual o potencial que a empresa tem de desenvolvimento baseado nos recursos humanos?

Desse mapeamento será gerado algo que podemos definir como Arquitetura AS-IS. Ou seja, é a arquitetura atual da empresa, não só de software, mas de capacitação também.

O CTO dessa empresa fez a lição de casa e chegou a conclusão que existem poucas soluções feitas em casa, tudo é integração usando serviço de prateleira com APIs REST que gastam muito tempo e dinheiro em integrações. Para atingir o objetivo que foi deletado a ele, o CTO viu que Data Mesh é uma boa solução, para isso ele definiu que o time de arquitetura deveria criar um modelo de maturidade para avaliar se os serviços internos estão adequados ao que a empresa deseja ou não.

Como na definição de Data Mesh dados são tratados como um produto, o CTO estabeleceu a criação de um time de ferramentas que iria criar um framework para integrações que pudesse:

1. Ser usado por todos os times para expor seus dados internos.
2. Ser usado por todos os times para consumir dados de outros times.
3. Desse visibilidade aos nível gerencial para fazer buscas simples ou montar dashboards.
4. Fosse atualizado em tempo real.

Esse time decidiu que o Apache Kafka era a solução perfeita como barramento e por isso ele começou a ser usado largamente dentro da empresa. Em um primeiro momento ele foi imposto aos times e o time de integrações viu que começou a haver uma resistência dos outros times. Para isso o CTO começou um programa de capacitação em [Programação Reativa](https://www.reactivemanifesto.org/pt-BR) para que todos os processos e produtos tivessem aderência a nova arquitetura. Agora todos observar se as soluções eram Responsivas, Elásticas e Resilientes, para isso foi feito algumas palestras internas sobre como sistemas poderiam migrar de uma arquitetura cliente-servidor padrão para uma arquitetura Orientada a Mensagens.

Depois de 1 ano, os times tinham soluções orientadas a mensagens com a capacidade de geração de estatisticas em tempo real. Com isso o corpo diretivo começou a ter uma visibilidade de alguns dados para a tomada de decisão.

## Análise do caso TechMart

Esse caso foi ficticio e eu queria ilustrar o que é arquitetura corporativa. Empresa devem ter uma Missão, Visão e Valores estabelecidos, e dessas informações são gerados objetivos de curto, médio e longo prazo. Ao CTO cabe não só a função e gerir as tecnologias da empresa, mas como é o processo de desenvolvimento da tecnologia e os dados gerados. E foi assim que no TechMart o CTO conseguiu que a empresa começasse a gerar dados para que a empresa pudesse verificar se os objetivos eram plausíveis e estavam sendo atingidos.

A arquitetura de software da empresa foi mudando aos poucos direcionada pela gestão para atingir um objetivo de gestão.