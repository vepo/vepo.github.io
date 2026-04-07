---
title: Linguagem Onipresente
permalink: /posts/linguagem-onipresente
published: true
description: Uma introdução ao termo Linguagem Onipresente baseada no livro Domain-Driven Design. 
# series: Domain-Driven Design
tags: [Domain-Driven Design, DDD, Arquitetura de Software, Desenvolvimento de Software]
image: /assets/images/capas/mulher-ao-quadro-negro.jpg
publish_date: 2020-07-20 15:15:12 +0300
original: "https://dev.to/vepo/linguagem-onipresente-1nld"
---

Faz alguns meses comprei o livro "Domain-Driven Desing: Atacando as Complexidades no Coração do Software" e comecei a ler somente agora. Ao iniciar a leitura já topo com um termo muito interessante e bem pertinente. O autor nos apresenta a necessidade de se construir uma Linguagem Onipresente (_ubiquitous language_).

Nesse post vou apresentar o que é uma Linguagem Onipresente e como podemos contrui-lá. Fica uma aviso que eu ainda estou começando a ler o livro. 😉

# Porque desenvolver programas?

Antes de entrar na faculdade, gostava muito de matemática e achava ela em si um fim. Pra mim, a matemática existia simplesmente por existir. Foi grande a minha decepção quando descobri que a matemática é uma linguagem com um proposito. Calculo existe para explicar o movimentos dos Corpos e foi criada por Newton. Se Newton não tivesse interesse de estudar o movimento dos corpos, provavelmente o Calculo não existiria e o mundo seria completamente diferente. 

Porque eu fui falar de matemática? Porque com computação acontece a mesma coisa. A computação em si não existiria se ela não ajudasse a resolver problemas do mundo real. Pra que programar? No fundo você está resolvendo um problema ou automatizando uma atividade que já estava aí. Logo existe um usuário que está aí já lidando com o problema que você quer resolver. Este pode ser um operador de caixa, um advogado, uma médica, uma farmacêutica, um chefe de cozinha ou você desenvolvendo software.

Esse usuário já lida com o problema pelo qual você vai resolver e já tem muitos conceitos criados. Chamamos de **Domínio** (_Domain_) a Área de Atuação desse problema.

# A Necessidade de Modelos

Qualquer desenvolvedor sabe que precisa de Modelos. Os mais inexperientes não conseguem abstrair o que é um modelo, ficando presos a conceitos da linguagem. 

_—  "Eu tenho um array aqui com o nome dos meus funcionários"_

A criação de um modelo é um passo importante para se resolver o problema satisfatoriamente. No caso da frase acima, eu considero que existe a entidade **Funcionário**. Este passa a ser um conceito abstrato no contexto do seu projeto. A **Funcionário** serão dados atribuições relacionamentos.

_—  "Tenho 500 **Funcionários** na Base de Dados, e consigo fazer um relatório por departamento."_

Modelos podem ser representados em diagramas, gráficos e textos. Porém eles existem no código, estão amarrados ao código. Uma vez mudando o código o diagrama não é atualizado, o que pode gerar confusão.

# De Modelos a Domínio

Como já foi dito, Domínio é algo que já existe antes da criação de um software. Antes que você escreva um programa para o RH da empresa, já existirão funcionários lá. Ao contrário de Modelos, o Domínio ele é inerente ao negócio. Este pode não estar mapeado, ou nomeado, mas já existe lá.

Podemos afirmar que o conhecimento do Domínio, ou o Modelo do Domínio é o coração do software. Sem o conhecimento dela, o software pode desempenhar um papel não desejado e assim não ser utilizado.

Vale aqui resaltar que Modelo pode se aplicado em vários contextos. Podemos falar em Modelo de Dados ou Modelo de Domínio. Aqui vamos tratar de Modelo de Domínio.

![Vai um vinho?](https://dev-to-uploads.s3.amazonaws.com/i/88dcrwupiimcho95whsm.png)

# Construindo o Modelo do Domínio

O Domínio é algo prexistente, porém cada usuário tem uma visão do mesmo. Um cliente do supermercado não precisa saber o horário de entrega do fornecedor de verduras, porém o estoquista precisa dessa informação. Porém, mesmo já existindo, pode ser que este não esteja mapeado ou modelado.

A atividade de se Modelar um Domínio é um processo em várias etapas. Ela involve questionamos e perguntas e deve ser feita em voz alta.

_—  "Um **Funcionário** tem apenas um supervisor?"_
_—  "Não, há **Funcionários** que respondem para seu gerente e para o cliente._
_—  "E quais são as responsabilidades do **Gerente** para com o **Funcionário**? E quando esse responde também ao **Cliente**, qual o papel do mesmo?_

Observe que no dialogo acima, há palavras que aparecem em negrito. Quando coloco elas em negrito, estou afirmando que a mesma foi incorporada ao Modelo de Domínio. Assim nesse pegqueno dialogo, o desenvolvedor acabou de descobrir que na modelagem de um software para RH, deve levar em consideração tanto o **Gerente** do **Funcionário** quanto o **Cliente**, porém o **Cliente** não é um **Funcionário**.

Esses termos quando identificados e devidamente adicionados ao Modelo, começam a fazer parte da **Linguagem Onipresente** do mesmo. **Linguagem Onipresente** é o conjunto de nomes de entidades e operações que a mesma podem fazer associadas ao Domínio do Software. Essa linguagem deve ser construida e cultivada em todo o ciclo de vida do projeto de software, não sendo considerada acabada enquanto o software ainda estiver em desenvolvimento.

## Como extrair o Modelo

### 1. Ligando o modelo e a implementação

O modelo do Domínio é o coração do software e ele deve refletir em todos os os contextos, por isso se chama Onipresente. Assim ele deve estar presente no Código, na Base de Dados, na Documentação e na comunicação de todos envolvidos no projeto. Tanto os desenvolvedores quandos os usuários do programa. 

Se, por algum motivo, o modelo não estiver atualizado em algum desses contextos, teremos um problema em potencial.

### 2. Cultivando uma Linguagem baseada no Modelo

Extrair termos do Domínio e começar a usa-los corretamente no dia a dia é um hábito muito útil no desenvolvimento de software. Ele habilitará os usuários a terem ciência de certas atividades que já desenvolvem. E também ajudará os desenvolvedores a conhecerem as atividades que o usuário desenvolvem. 

O desenvolvedor não precisa saber exatamente como a atividade é desenvolvida, assim como o usuário não precisa saber de detalhes da implementação. Mas habilitará uma comunicação com os dois "_extremos_".

### 3. Desenvolvendo um modelo rico em conhecimentos

O modelo vai muito além do que está implementado. E ele pode ser enriquecido sempre que possível. Construir o modelo é uma atividade que não tem fim.

### 4. Destilando o modelo

Apesar de a construção do modelo não acabar, enquanto o projeto não acabar. Não significa que ele não possa ser simplificado. Sou muito fã do princípio [_**KISS**: Keep It Simple, Stupid_](https://pt.wikipedia.org/wiki/Princ%C3%ADpio_KISS). 

Em qualquer estudo, ao se adicionar novas informações aumenta-se a complexidade do sistemas. [Isso é uma lei da natureza, se não gastarmos esforço para compreender a relação entre os novos conceitos e os antigos tentando simplificar](https://pt.wikipedia.org/wiki/Leis_de_Newton#Primeira_lei_de_Newton)... [a entropia do sistema vai aumentar](https://www.significados.com.br/entropia/).

### 5. Colhendo ideias e experimentando

A construção de inteções, cenários, pressupostos e afirmações é um exercicio que enriquece muito o modelo. Simples perguntas podem criar novas entidades, podem fundir duas entidades que poderiam ser consideradas distintas ou simplesmente alterar relações entre entidades. Nesse ponto não há pergunta boba.

## Como **NÃO** extrair o Modelo

### 1. Importar modelos

É comum, em projetos de software, a importação de modelos já prontos. Ao se iniciar um projeto já se define algumas classes e objetos com nomes padrão. Quem nunca viu **UserService**? Pra que serve um UserService? Essa pergunta pode ter uma resposta completamente genérica que em muitos casos não se aplica ao atual projeto.

### 2. Importar uma nomenclatura

É comum, em projetos de software, nomear objetos com o nome dos seus tipos. Muitas vezes o desenvolvedor cria um **UserDTO** logo ao se iniciar um projeto, sem ao menos se perguntar qual seria a melhor nomenclatura. 

[DTO](https://pt.wikipedia.org/wiki/Objeto_de_Transfer%C3%AAncia_de_Dados) significa **Data Transfer Object** e é um objeto usado para transfêrencia de Dados. Eu uso muitos DTOs, mas nunca uso esse sufixo, até porque ele não tem sentido dentro de um software. Quando os uso posso chamar:

| Nome | Descrição |
|------|-----------|
| **UserResponse** | Resposta a chamada REST que retorna os dados do Usuário |
| **UserCreatedEvent** | Evento de criação de um Usuário |
| **UserChangedEvent** | Evento de alteração dos dados de um usuário | 
| **UserPayload** | Dados do Usuário usado para criação em serviços REST |
| ... | ... |

Observe que para cada Nome existe uma funcionalidade associada.

### 3. Desenvolvimento Orientado a Design Patterns

Design Patterns são extremamente uteis, porém devem não devem ser usados apenas por usar. Eles devem fazer sentido. Pode se usar uma adaptação ou mesmo uma mescla de dois sentidos, vai depender do problema. Entre um Desing Pattern e o Domínio, prefira o Domínio. Não que ele tenha que existir um conflito entre os dois, mas o Pattern tem que se adaptar ao modelo.

# Conclusão

Modela um software é uma atividade muito importante. Cada software tem o seu Domínio e este deve ser modela de acordo com o problema a ser resolvido. O Domínio é muito mais extenso que a implementação do software e quando desenvolvedores limitam sua linguagem a apenas a implementação isso pode ser um fator gerador de problemas. 

# Livros Recomendados

1. [Domain-Driven Design: Atacando as Complexidades no Coração do Software](https://www.amazon.com.br/Domain-Driven-Design-Eric-Evans/dp/8550800651?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=1ZIEQ6223BW12&dchild=1&keywords=domain+driven+design&qid=1595274795&s=books&sprefix=domai%2Caps%2C293&sr=1-1&linkCode=ll1&tag=vepo0f-20&linkId=8f0de1abfc56f235286a41828f4019fc&language=pt_BR&ref_=as_li_ss_tl) de Eric Evans
2. [Como ser um Programador Melhor: um Manual Para Programadores que se Importam com Código](https://www.amazon.com.br/Como-Ser-Um-Programador-Melhor/dp/8575224158?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=2WIBH8YTQLN6C&dchild=1&keywords=como+ser+um+programador+melhor&qid=1595274941&s=books&sprefix=como+ser+um%2Cstripbooks%2C287&sr=1-1&linkCode=ll1&tag=vepo0f-20&linkId=98a599ceadf5e966cf2675305e638090&language=pt_BR&ref_=as_li_ss_tl) de Pete Goodliffe
3. [Código Limpo: Habilidades Práticas do Agile Software](https://www.amazon.com.br/C%C3%B3digo-limpo-Robert-C-Martin/dp/8576082675?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&keywords=clean+code&qid=1588968796&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=936ea100df5aa63c041438ac166948ed&language=pt_BR&ref_=as_li_ss_tl) de Robert C. Martin