---
title: O Papel da Arquitetura de Software
published: true
description: | 
    Esse é o terceiro post da série **Conversas sobre Arquitetura**. A arquitetura de software vai muito além da tecnologia. Descubra como ela conecta aspectos técnicos, estratégicos, humanos e culturais para criar sistemas que realmente entregam valor de negócio, equilibrando decisões que vão desde a garantia de atributos de qualidade até a administração de expectativas de stakeholders em um ambiente em constante mudança.
tags: [Arquitetura de Software]
cover_image: /assets/images/capas/caderno-caneta.jpg
permalink: /posts/o-papel-da-arquitetura
series: Conversas sobre Arquitetura
publish_date: 2025-10-02 07:44:00 +0300
---

{% youtube uVIMee-yIaI %}

A Arquitetura de Software é uma disciplina que se relaciona com diversos contexto. Podemos afirmar que uma pessoa atuando como arquiteto de software atua em pelo menos quatro contextos diferentes:
1. Técnico: _como o sistema é construído?_
2. Estratégico: _qual o impacto do sistema no negócio?_
3. Pessoal: _como o arquiteto lida com as diferentes pessoas envolvidas no projeto?_
4. Cultural: _como a cultura da organização impacta o desenvolvimento do sistema?_

É importante ressaltar que estamos falando do papel do arquiteto de software que pode ser desempenhado por diferentes pessoas em diferentes momentos de um projeto. Em equipes pequenas, o papel do arquiteto pode ser desempenhado por um desenvolvedor sênior ou líder técnico. Em equipes maiores, pode haver um arquiteto dedicado ou uma equipe de arquitetos. Em alguns casos, o papel do arquiteto pode ser desempenhado por um gerente de projeto ou um gerente de produto.

## Arquitetura no contexto Técnico

É comum as pessoas associarem arquitetura de software a atividade de escolher tecnologias, frameworks e ferramentas. Embora essas atividades façam realmente parte do trabalho do arquiteto, elas são pautadas pela atuação de outros contextos. Todos os contextos se influenciam mutuamente e um arquiteto deve ser capaz de navegar por todos eles. Dessa forma, como veremos, o contexto técnico não é uma mera questão de escolhas técnicas, as vezes uma escolha técnica pode ser decidida por questões estratégicas, pessoais ou culturais.

### 1. Arquitetura inibe ou habilita o alcance de Atributos de Qualidade

A primeira responsabilidade de um arquiteto de software é definir os atributos de qualidade e garantir que os mesmos sejam alcançados. Um atributo de qualidade é uma característica do sistema que é importante para os stakeholders, falaremos mais sobre stakeholders dentro do contexto pessoal.

**Atributo de Qualidade** é uma propriedade testável e mensurável de um sistema que é usada para avaliar como o sistema satisfaz as necessidades dos stakeholders.

Podemos definir os requisitos dos sistema como Funcionalidades, Atributos de Qualidade e Condicionantes (_Constraints_). Em muitas situações, o arquiteto não tem influência sobre as funcionalidades do sistema, mas é de sua responsabilidade garantir que os atributos de qualidade sejam alcançados e para isso deve ser capaz de tomar decisões que impactam os escolhas técnicas do sistema para que esses atributos sejam mensuráveis e testáveis.

Alguns exemplos de atributos de qualidade são:
* **Disponibilidade**: O sistema está disponível para uso quando necessário?
* **Escalabilidade**: O sistema pode lidar com um aumento na carga de trabalho?
* **Elasticidade**: O sistema pode alocar mais recursos conforme a demanda aumenta?
* **Interoperabilidade**: O sistema pode interagir com outros sistemas?
* **Modificabilidade**: O sistema pode ser modificado facilmente para atender a novas necessidades?
* **Manutenibilidade**: O sistema pode ser mantido e atualizado com facilidade?
* **Desempenho**: O sistema usa eficientemente os recursos disponíveis?
* **Segurança**: O sistema é vulnerável a ataques e protege os dados contra acessos não autorizados?
* **Testabilidade**: O sistema pode ser testado facilmente para garantir que funciona conforme o esperado?
* **Usabilidade**: O sistema é fácil de usar e entender?
* **Confiabilidade**: O sistema funciona de maneira consistente e previsível?

Os atributos de qualidade não são definidos pelo arquiteto, mas são requisitos dos stakeholders que o arquiteto deve garantir que sejam alcançados. Sistemas são criados para garantir os objetivos de negócios de instituições, organizações ou empresas, e esses objetivos definem os atributos de qualidade que o sistema deve assegurar. Alguns desses atributos podem ter grande influência nas decisões técnicas dos sistemas.

Outro fator importante é que atributos de qualidades não são independentes, ou seja, um atributo pode impactar outro. Por exemplo, aumentar disponibilidade pode impactar negativamente a manutenibilidade. A interoperabilidade pode impactar a segurança. O arquiteto deve estar ciente dessas interações e ser capaz de tomar decisões que equilibram os diferentes atributos de qualidade.

### 2. Arquitetura e o Ambiente Técnico

O ambiente técnico (_technical environment_) influência diretamente as decisões arquiteturais. Para entender melhor é preciso primeiro definir o que é o ambiente técnico. Segundo o livro _Software Architecture in Practice_ (Len Bass, Paul Clements, Rick Kazman), o ambiente técnico inclui padrões da industria ou técnicas de engenharia de software dominantes quando o sistema está sendo desenvolvido.

Hoje todo mundo fala de nuvem, microsserviços, containers, DevOps, etc. Mas há 20 anos atrás nenhum desses nomes existia e por isso um sistema desenvolvido naquela época não poderia usar essas tecnologias. Da mesma forma, daqui a 20 anos, novas tecnologias e práticas surgirão e elas terão grande influência nas decisões arquiteturais dos sistemas que serão desenvolvidos naquele momento. 

Isso significa que um arquiteto deve estar ciente das tendências tecnológicas e das práticas de engenharia de software para que saiba utiliza-las em seus projetos. Isso não significa ter um conhecimento pleno das mesmas ou muito menos se deixar vender pelo "papo de vendedor". O arquiteto deve ter um apurado senso crítico e ser capaz de realizar provas de conceito (_proof of concept_) para validar se uma tecnologia ou prática é adequada para o sistema que está sendo desenvolvido.

Eu sempre recomendo que o arquiteto deve acompanhar conferências, ler livros bons técnicos, relatórios de mercado (como o [Radar da Thoughtworks](https://www.thoughtworks.com/pt-br/radar) ou [InfoQ Trends Report](https://www.infoq.com/infoq-trends-report/)) e participar de comunidades técnicas.

### 3. Trade-offs e Decisões Arquiteturais

Arquitetura de software é sobre tomar decisões. Essas decisões são tomadas para garantir os atributos de qualidade do sistema e para isso o arquiteto deve estar ciente das consequências dessas decisões. Essas consequências são chamadas de _trade-offs_. O [**Architecture Tradeoff Analysis Method** (ATAM)](https://www.sei.cmu.edu/documents/629/2000_005_001_13706.pdf) surge como uma abordagem sistemática para avaliar essas compensações, ajudando arquitetos a tomar decisões conscientes e fundamentadas.

Desenvolvido pela **Software Engineering Institute** (SEI), o ATAM baseia-se na premissa de que não existem soluções arquiteturais perfeitas, apenas soluções adequadas para contextos específicos. O método fornece um framework para:

* **Identificar pontos de sensibilidade**: Elementos arquiteturais críticos para atingir atributos de qualidade específicos
* **Reconhecer trade-offs**: Decisões que beneficiam um atributo em detrimento de outro
* **Detectar riscos**: Escolhas que podem comprometer o sucesso do sistema

O ATAM envolve várias etapas estruturadas para garantir uma análise abrangente da arquitetura: 
- **Etapa 1** - Coletar Cenários: o que o sistema DEVE fazer?
- **Etapa 2** - Coletar Requisitos/Restrições/Ambiente: quais condicões o sistema deve satisfazer?
- **Etapa 3** - Descrever Visões Arquitetônicas: criar visualizações/descrições dos sistemas. Descrever as restrições, ambientes e requisitos.
- **Etapa 4** - Análises Específicas de Atributos: avaliar como cada atributo de qualidade isoladamente é impactado ela arquitetura atual.
- **Etapa 5** - Identificar Sensibilidades: identificar a sensibilidade de cada atributo de acordo com variações na arquitetura. Quais são os pontos sensíveis?
- **Etapa 6** - Identificar Trade-off: os pontos sensíveis vão levar a identificar os trade-offs da aplicação.

![Etapas do ATAM](/assets/images/conversas-sobre-arquitetura/fig-05-atam-steps.png)

No entanto, o arquiteto não precisa seguir o processo do ATAM à risca. É importante entender o conceito de trade-offs e adaptar o processo para o contexto do projeto. O mais importante é que o arquiteto seja capaz de realizar análise e fazer decisões conscientes.

## Arquitetura no contexto Estratégico

### 1. Documentando e Comunicando a Arquitetura

Documentar e comunicar a arquitetura é função primordial de alguém responsável pela arquitetura. É essencial que todos os _stakeholders_ envolvidos no projeto compreendam não apenas a arquitetura definida, mas também as suas implicações técnicas e de negócio.

A documentação não é um fim em si mesma, mas um meio de comunicação adaptado ao perfil de cada stakeholder. Por exemplo:
* Desenvolvedores precisam entender a arquitetura para implementar componentes de forma alinhada com as decisões técnicas e restrições estabelecidas.
* Clientes devem compreender como a arquitetura suporta o funcionamento do sistema e entrega valor ao negócio.
* Equipes de suporte e operações necessitam de conhecimento arquitetural para monitorar, manter e ajustar o sistema de forma eficiente.

Dessa forma, a documentação atua como um veículo de transparência, alinhamento e governança, assegurando que todas as partes envolvidas compartilhem uma visão comum e atuem de maneira coordenada.


### 2. Analisando ou Avaliando a Arquitetura

A avaliação da arquitetura é um processo sistemático para verificar se a arquitetura proposta atende aos requisitos dos _stakeholders_, especialmente os atributos de qualidade. Len Bass destaca a importância de métodos como o ATAM (_Architecture Tradeoff Analysis Method_) para essa finalidade. Já Fred Brooks avaliar que a integridade conceitual é uma das propriedades chaves de um sistema sólido, e isso só pode ser alcançado se existem escolhas arquiteturais claras.

## Arquitetura no contexto Pessoal

### 1. Quem são os _Stakeholders_?

_Stakeholders_ são todos os indivíduos, grupos ou organizações que têm interesse no sistema, sejam eles usuários finais, desenvolvedores, gerentes, equipe de operações, clientes ou patrocinadores. Eles são fontes essenciais para a definição de requisitos funcionais, atributos de qualidade e restrições do sistema. O arquiteto deve identificar, envolver e gerenciar as expectativas dos _stakeholders_, garantindo que a arquitetura atenda às suas necessidades e prioridades.

### 2. Administrando expectativas

Um sistema possui inúmeros _stakeholders_ e cada um dele pode influencer no design do software. Cabe a pessoa responsável pela arquitetura administrar as expectativas de cada _stakeholder_ envolvido e fazer uma escolha de atributos de qualidade que maximize a satisfação das pessoas envolvidas. Sempre costumo lembrar dos antigos frameworks Java EE que priorizavam a personalização e o desempenho ao invês da experiência de usuário e foram facilmente substituído por frameworks que eram mais amigáveis e de certa forma eram menos eficientes.

### 3. Arquitetura e as hypes

O mercado de desenvolvimento de software é constantemente abalado por modas que chegam prometendo mudar a forma como desenvolvemos software. Mas para quem já é macaco velho, sabemos que a forma como se desenvolve software muda lentamente. E mesmo que mude, antigos sistemas continuam ativos e eficientes. Legado é uma das grandes forças do desenvolvimento de software. 

O arquiteto deve ser capaz de compreender as hypes e saber avaliar como uma tecnologia pdoe impactar o negócios. Ela é madura o suficiente para ser abraçada? Ela terá sobrevida no mercado?

Para entender como os ciclos das modas funcionam, o [Gartner](https://www.gartner.com/en/research/methodologies/gartner-hype-cycle) tem uma metodologia chamada _Hype Cycle_ (ou ciclo da moda em tradução livre) que avalia e emite relatórios sobre as tecnologias. Cada ciclo de hype consiste em cinco fases principais do ciclo de vida de uma tecnologia.:

1. **Gatilho tecnológico** (_Technology trigger_): Um potencial avanço tecnológico dá o pontapé inicial. Histórias iniciais de prova de conceito e interesse da mídia geram publicidade significativa. Muitas vezes, não existem produtos utilizáveis ​​e a viabilidade comercial não é comprovada.
2. **Pico de expectativas infladas** (_Peak of inflated expectations_): A publicidade inicial produz uma série de histórias de sucesso — frequentemente acompanhadas por dezenas de fracassos. Algumas empresas agem; a maioria, não.
3. **Poço da desilusão** (_Trough of disillusionment_): O interesse diminui à medida que experimentos e implementações falham. Os produtores da tecnologia se desfazem ou fracassam. O investimento só continua se os fornecedores sobreviventes melhorarem seus produtos para a satisfação dos primeiros usuários.
4. **Declive da iluminação** (_Slope of enlightenment_): Mais exemplos dos benefícios da tecnologia começam a se cristalizar e se tornarem mais amplamente compreendidos. Produtos de segunda e terceira gerações surgem de fornecedores de tecnologia. Mais empresas financiam pilotos; empresas conservadoras permanecem cautelosas.
5. **Platô da produtividade** (_Plateau of productivity_): A adoção em massa começa a decolar. Os critérios para avaliar a viabilidade do provedor estão mais claramente definidos. A ampla aplicabilidade e relevância da tecnologia no mercado estão claramente dando resultados. Se a tecnologia tiver mais do que um nicho de mercado, ela continuará a crescer.

Esse ciclo pode ser descrito como um gráfico de expectativa no tempo.

![Gráfico de expectativa no tempo. Inicia com uma curva ascendente que tem um pico e uma queda até chegar ao inicio da curva. Depois cresce lentamente até chegar no platô da produtividade.](/assets/images/conversas-sobre-arquitetura/fig-06-gartner-hype-cycle.png)

## Arquitetura no contexto Cultural

### 1. Arquitetura e o Ciclo de Vida de um Projeto de Software

Arquitetura de software está intrisecamente ligada ao ciclo de vida de um projeto de software. Decisões arquiteturais são tomadas em diferentes momentos e o tempo de vida de um projeto pode impactar a arquitetura pois os requisitos de negócios do sistema podem mudar ao longo do tempo.

Projetos de software podem ser gerenciados sob diferentes metodologias. Eu gosto de classificar essa metodologias através de dois grandes eixos: o eixo de **Planejamento** e o eixo de **Agilidade**.

<!-- https://excalidraw.com/#json=urWtlpjtSc7AUNJi4cClH,Gu77f3wAJ8gExwQwXTfzMw -->
![Metodologias classificadas nos eixos de Planejamento e Interatividade](/assets/images/conversas-sobre-arquitetura/fig-04-metodologias-de-desenvolvimento.png)

É importante não confundir Agilidade, Metodologias Ágeis e Manifesto Ágil. Agilidade é a capacidade de se adaptar rapidamente às mudanças. Metodologias Ágeis são aquelas que foram propostas como uma resposta ao Manifesto Ágil e muitas vezes evoluiram, ou são aplicadas, sem nenhum grau de agilidade. Já o Manifesto Ágil é um conjunto de valores e princípios que foram propostas por um grupo de desenvolvedores de software em 2001 como uma respostas às metodologias tradicionais de desenvolvimento de software.

Todo desenvolvedor deve conhecer ao menos a metodologia que está sendo aplicada no seu projeto e compreender o ciclo de vida do projeto. É importante lembrar que um software só é útil se ele funciona e entrega valor para o negócio, ou seja, somente software em produção é software que entrega valor. E o arquiteto deve também encontrar seu lugar dentro dos processos para que o desenvolvimento não seja interrompido por decisões arquiteturais que não foram tomadas a tempo.

Um dos Anti-Padrões em arquitetura é o [**Big Design Up Front (BDUF)**](https://agilemodeling.com/essays/bmuf.htm), que é quando o arquiteto tenta definir toda a arquitetura do sistema antes do desenvolvimento começar. Isso pode levar a atrasos no início do desenvolvimento e pode resultar em uma arquitetura que não atende às necessidades reais do sistema, pois os requisitos podem mudar durante o desenvolvimento. Simon Brown sugere fazer o [apenas design suficiente para começar o desenvolvimento](https://www.infoq.com/news/2014/05/minimal-architecture-design/).

### 2. Arquitetura e os Objetivos de Negócio

Arquitetura também impacta e é influenciada pelos objetivos de negócios de uma organização. Cada software ou projeto pode ser pensado como um **caso de negócio**, que é, brevemente, uma justificativa para um investimento organizacional. Isso significa que a arquitetura também tem Qualidades de negócios como:

* **Time to Market**: O tempo que leva entre pensar uma ideia e testar ela no mercado é essencial para a validação de uma ideia e a arquitetura pode minimizar esse tempo. A escolha dos processos de desenvolvimento, de requisitos de qualidades ou até mesmo a escolha de ferramenas pode influenciar no tempo de entrega do sistema.
* **Custo/Benefício**: A arquitetura deve equilibrar o custo de desenvolvimento e manutenção com o valor gerado para o negócio. Decisões arquiteturais podem otimizar recursos, reduzir desperdícios e maximizar o retorno sobre o investimento
* **Longevidade**: A capacidade do sistema de permanecer relevante e sustentável ao longo do tempo. Uma arquitetura bem fundamentada permite evolução e adaptação a mudanças tecnológicas e de negócio, estendendo o ciclo de vida do software.
* **Público-Alvo**: A arquitetura deve considerar as características e necessidades dos usuários finais, influenciando atributos como usabilidade, desempenho e acessibilidade para garantir a adoção e satisfação do público.
* **Cronograma**: Decisões arquiteturais impactam diretamente a viabilidade e o cumprimento dos prazos do projeto. Uma arquitetura muito complexa pode atrasar o desenvolvimento, enquanto uma arquitetura bem planejada facilita a parallelização de tarefas e a entrega incremental.
* **Interoperabilidade**: A capacidade do sistema de se integrar com outros sistemas existentes ou futuros na organização. Isso afeta diretamente a eficiência operacional e a capacidade de expandir funcionalidades sem rupturas.

## Conclusão

A Arquitetura de Software revela-se, portanto, como uma disciplina multifacetada e estratégica, cujo papel transcende em muito a simples escolha de tecnologias. Como vimos, o arquiteto atua na interseção de quatro contextos fundamentais — técnico, estratégico, pessoal e cultural — e deve equilibrar constantemente as demandas de cada um deles.

No âmbito **técnico**, a arquitetura é responsável por habilitar os atributos de qualidade do sistema, tomando decisões conscientes em um ambiente tecnológico em constante evolução e gerenciando os inevitáveis *trade-offs* entre diferentes requisitos não funcionais.

No contexto **estratégico**, a arquitetura serve como ponte entre os objetivos de negócio e a realização técnica, exigindo uma comunicação clara e transparente com todos os *stakeholders* e uma avaliação contínua de suas decisões.

No plano **pessoal**, o arquiteto atua como um facilitador e mediador, administrando expectativas, identificando necessidades e garantindo que a visão do sistema seja compartilhada e compreendida por todos os envolvidos.

E, por fim, no contexto **cultural**, a arquitetura é moldada e, ao mesmo tempo, molda a organização — adaptando-se a metodologias, ciclos de vida e, principalmente, aos objetivos de negócio de longo prazo.

Mais do que um planejador técnico, o arquiteto é um facilitador de valor, um estrategista e um agente de mudança. Sua atuação consciente e contextualizada é essencial para construir sistemas não apenas funcionais, mas também resilientes, adaptáveis e alinhados com o propósito do negócio que sustentam. A arquitetura, quando bem compreendida e praticada, deixa de ser um fim em si mesma e se torna um meio poderoso para a entrega de software com impacto real e duradouro.