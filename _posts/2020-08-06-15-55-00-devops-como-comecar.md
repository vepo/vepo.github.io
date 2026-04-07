---
title: DevOps! Como começar?
permalink: /posts/devops-como-comecar
published: true
description: Este é um pequeno roteiro sobre um primeiro passo para o DevOps. Faço algumas perguntas para ver a maturidade do seu projeto e tentar melhorar.
tags: [Devops, Java, Maturity, Programação]
series: Coisas que todo Sênior deve saber
publish_date: 2020-08-06 15:55:00 +0300
image: /assets/images/capas/mapa.jpg
original: https://dev.to/vepo/devops-como-comecar-54gk
---

_—  Porque desenvolvemos software?_

Muitos desenvolvedores não fazem essa pergunta. E tudo bem se você nunca a fez. Agora Engenheiros devem fazer essa pergunta, porque a função de um engenheiro é refletir sobre a natureza do proprio trabalho. Se você nunca se perguntou a diferença entre um desevolvedor e engenheiro, fica uma dica.

![Significado de Engenharia](https://dev-to-uploads.s3.amazonaws.com/i/vs25yg8ritu70x9e99rg.png)

Um engenheiro, por natureza da sua formação, deve refletir sobre a natureza do seu trabalho, também como pelo processo do seu trabalho. Deve aplicar metodos científicos para melhoria do todo que envolvem o seu trabalho.

Em resumo a função de um software é automatizar tarefas já anteriormente executadas. Mas eu desenvolvo software, são novas demandas! Sim, o software pode criar demandas de novas tarefas, porém elas também pode ser automatizadas por software. 🤖

Então fico com uma dúvida: _Porque em alguns projetos de software muitas vezes realizamos sempre tarefas repetitivas?_

Em um time, as tarefas repetitivas devem ser feitas automaticamente. Se não é possível fazer a automatização, deve ser gasto um esforço para isso. A seguir descrever que tarefas podem ser executadas, quais os argumentos a favor da automatização e como ela pode ser feita.

# Que tarefas podem ser executadas?

Nos últimos 10 anos, entre as 10 palavras da moda do mundo do TI, com certeza, essas três sempre estiveram em destaque **DevOps**, **Continuous Integration** e **Continuous Delivery**. Com essas palavras já temos uma boa visão do que deve ser otimizado.

**DevOps** normalmente é apresentado em palestras como um **Estado da Arte**, normalmente o palestrante apresenta em 50 minutos um dashboard que demorou anos a ser construido por várias mãos. Então calma lá! Sua equipe não terá isso tão fácil. Mas podemos pegar desses pipelines o que pode ser automatizado.

O livro [**O Projeto Fênix**](https://www.amazon.com.br/projeto-f%C3%AAnix-Gene-Kim/dp/8550801895?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&dchild=1&keywords=O+Projeto+F%C3%AAnix&qid=1596651256&sr=8-1&linkCode=ll1&tag=vepo0f-20&linkId=442bd0b794b6f97a6d321b732c5196b0&language=pt_BR&ref_=as_li_ss_tl) é novela sobre o que o **DevOps** pode trazer de benefícios a uma equipe de desenvolvimento. Na narrativa, um dos métodos que é usado para se escolher "onde vamos gastar esforço automatizando" é onde há o gargalo do projeto. Segundo o livro, todos esforço que você investir em melhoria de processo, se não for onde está o gargalho será esforço perdido. Logo, se você for escolher por onde começar, veja seu processo desenvolvimento, mapei e procure os gargalos.

Agora sendo mais práticos, o que pode ser automatizado? Podemos citar Montagem de Ambiente, Testes, Build e Deploy. Uma frase bem comum antes da moda do DevOps era **"na minha máquina funciona"**. Bom, se você já ouviu essa frase, comece a pensar em automatizar algumas coisas.

# Vantagens

## 1. Automatização Padroniza

Eu mesmo já falei muitas vezes **"na minha máquina funciona"**, mas depois que comecei a automatiza, ela simplesmente desapareceu. 😀

Um dos hábitos que adiquiri foi criar scripts e rodar ele em várias máquinas. Por exemplo, para montar um ambiente de desenvolvimento, quando trabalhava com C, criava um script com todas as dependencias e executava ele em uma VM. 

Esse método também me foi bastante útil quando montei um ambiente produção em cliente onde não podia ter acesso a internet. Todos os pacotes tinha que ser levados ao ambiente de produção. Criando o script e executando ele diversas vezes, usando como referencia uma VM com a exata mesma versão do SO de destino. Conseguimos sucesso com essa tarefa.

## 2. Automatização Economiza Tempo

Uma das dificuldades encontradas para se investir tempo em automatização é a falta de tempo. É certo que muitas vezes é difícil convencer o seu gerente, ou cliente, sobre a necessidade de se gastar tempo em algo que aparentemente não terá um retorno financeiro.

[![Automação pelo XKCD](https://imgs.xkcd.com/comics/automation.png)](https://xkcd.com/1319/)

Por isso que você pode se prepara para convençer seu cliente que o racicionio dele é falso! Investir em automação pode sim economizar tempo. Podemos citar um breve relato sobre testes automaticos, garantindo que os testes serão rodados automaticamente antes de cada build, iremos evitar que façamos os testes manualmente, ou mesmo que tenhamos que gastar tempo resolvendo bugs em produção. 

E se prepare para convençer bem seu gerente, pode ser que depois ele venha contra-argumentar que o tempo gasta não foi útil, porque não houveram bugs em produção. Ora, não houve porque investimos tempo em automatização.

![Estamos ocupados](https://dev-to-uploads.s3.amazonaws.com/i/fesavqhzg7b385mg489p.jpg)

## 3. Automatização garante padrão mínimo de estabilidade

Leia bem, não estou dizendo que não haverá bugs. Mas se você investir tempo em criar testes e automatizar as execuções desses testes, você evitará que uma série de bugs ocorram. 

Mas bastante cuidado! Essa automatização tem que estar dentro do ambiente de desenvolvimento. De que adianta ter toda uma fase de desenvolvimento se no final é preciso _"atualizar os testes"_! Isso é uma má pratica! 

A automatização também traz a certeza que um deploy será executado extamente da forma que foi planejada.


# Roadmap

_—  Ok, mas como eu consigo começar?_

Isso vai depender do seu projeto. Cada um tem um Roadmap especifico. Mas aqui vou te fazer algumas perguntas que pode te ajudar.

## 1. Como é feita a build do seu projeto?

* Os testes são automatizados?
* Há alguma validação estatica de código?

Essa é uma boa para se começar. Se seu projeto não usa um gerenciamento de build, corre e configura um [Maven](https://maven.apache.org/) ou [Gradle](https://gradle.org/)!

Assim saímos do ponto zero! Com essas ferramentas temos a certeza que todas as dependências são corretamente definidas. Não haverá mais diferenças entre versões de dependências.

## 2. Há testes no seu software?

Testes tem que ser frutos do desenvolvimento. Sou evangelista do TDD, uma pratica que trouxe muita qualidade ao meu código e aos produtos que já desenvolvi. 

Se não sabe como aplicar. Vamos com calma. TDD é uma pratica, quanto mais você treina, melhor fica. Uma dica que dou é fazer um curso, indico o [TDD – Desenvolvimento de software guiado por testes](https://pt.coursera.org/learn/tdd-desenvolvimento-de-software-guiado-por-testes) do ITA que dá pra fazer gratuitamente no Coursera. Depois compartilha com sua equipe.

![Ciclos do TDD](https://dev-to-uploads.s3.amazonaws.com/i/pv1bw9ge1ttmbclmmcxw.png)

## 2. Como os testes são executados?

Se você já resolveu o problema (1) e (2)? Agora pode configurar o JUnit no Maven e automatizar a execução dos testes. Assim uma vez criado o testes, você só precisará alterar eles se houver mudanças de requisitos.

## 3. Quem gera o entregável?

Isso muitas vezes pode ser responsabilidade de uma pessoa dentro do projeto. Mas e se ele fosse gerado automaticamente depois de cada commit? E se antes de gerar fosse criado um relatório de testes? Como fazer isso? 

Pega uma máquina de build e instala o [Jenkins](https://www.jenkins.io/), configura a build apontando para o repositório e adiciona um Jenkinsfile na raiz do projeto. Assim a cada commit, o Jenkins automaticamente pegará o código e executará o pipeline declarado no Jenkinsfile. 

Com isso é possível salvar o executável gerado pelo projeto, sem depender do ambiente de nenhuma máquina de desenvolvimento.

## 4. Qual a cobertura de testes do seu código?

Sabe responder essa pergunta? Se não, já procura uma ferramenta pra resolver esse problema. Para Java temos o [Jacoco](https://www.jacoco.org/jacoco/trunk/doc/maven.html) pode ser, não tão facilmente, integrado no Mavem. 

Com isso pode-se acompanhar a evolução da cobertura de testes do seu projeto.

## 5. Por quais análises seu código passa?

Nunca ouvi falar de Análise Estática de Código? São algoritmos que rodam e analisam seu código sem o executar. Verificam erros básicos, que as vezes podem nem aparecer como validações de nulos, ou mesmo erros de design. 

O [Sonarqube](https://www.sonarqube.org/) faz isso automaticamente, dá pra usar tanto localmente quanto em cloud. Ele dá um relatório de inumeros erros que o código pode ter, assim pode ser integrado a um relatório de cobertura de código.

![Sonar](https://dev-to-uploads.s3.amazonaws.com/i/hy74s3xzdh2tknd40sz6.png)

Com uma ferramenta desse tipo, você pode acompanhar a evolução da qualidade do seu código. Sempre melhorando obviamente. 

## 6. Como é feito seu deploy?

Se você entra na máquina e semelhantemente a um filme de ação dos anos 80 faz tudo na mão. Para. Vamos começar a fazer scripts, mapear o que precisa ser feito em cada deploy. Depois, que tal criar uma Task no Jenkins para fazer isso automaticamente?

## 7. Como sua base de dados é atualizada?

Se a cada deploy é um _pega pra capar_ pra saber que mudanças foram feitas na base. E a base está diferente da base de homologação... E temos que resolver problemas que só acontence na produção... 😰

Calma, isso já aconteceu com todo mundo. Mas podemos melhorar! 

Existem ferramentas que podem versionar sua base de dados. E você pode construir sua propria! Eu mesmo já implementei uma para MongoDB e projetos CDI, que está rodando em uma empresa que já trabalhei. Ele vê a versão atual, vai num diretório e pega todos os scripts para avançar. Se a versão atual do código for inferior, pega os scripts de rollback salvos no banco e executa. 

Mas... não é preciso reinventar a roda! Usa o [Flyway](https://flywaydb.org/). Devem ter outros também!

## 8. É preciso fazer alterações no Sistema Operacional a cada deploy?

Isso é bem comum. Imagina migrar do **Java 8** para o **Java 78**? Será doloroso, não? É para isso que existem conteinerização! E se na próxima atualização você fizesse o deploy usando Docker. Não precisa migrar toda a stack, mas já mantive ambientes de produção só usando Docker Compose. 

Garanto que só a primeira migração será dolorosa. Depois cada deploy, ou mesmo rollback, serão feitos de forma suave. Será necessário apenas algerar as versões de um arquivo.

# Conclusão

Todo mudança envolve risco. Se não o risco de uma falha, mas o risco de um sucesso. **DevOps** não é feito com uma apresentação bonita, mas uma estrada tortuosa que cada projeto/empresa pode e deve trilhar.

# Sugestões de Leitura

* [O Projeto Fênix: um Romance Sobre TI, DevOps e Sobre Ajudar o seu Negócio a Vencer](https://www.amazon.com.br/projeto-f%C3%AAnix-Gene-Kim/dp/8550801895?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=2QE72H1Y32GFM&dchild=1&keywords=projeto+fenix&qid=1596739246&s=books&sprefix=projeto+fe%2Caps%2C279&sr=1-1&linkCode=ll1&tag=vepo0f-20&linkId=005d6032487c59d4f41beb4746efac08&language=pt_BR&ref_=as_li_ss_tl) de Gene Kim
* [Como ser um Programador Melhor: um Manual Para Programadores que se Importam com Código](https://www.amazon.com.br/Como-Ser-Um-Programador-Melhor/dp/8575224158?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=2GX9IEL9WQHAI&dchild=1&keywords=programador+melhor&qid=1596739303&s=books&sprefix=programador+melh%2Cstripbooks%2C275&sr=1-1&linkCode=ll1&tag=vepo0f-20&linkId=87c311e1edea749a351a14fe98c7a59d&language=pt_BR&ref_=as_li_ss_tl) de Pete Goodliffe

---
![Roadmap](https://dev-to-uploads.s3.amazonaws.com/i/8tykl2s0ek99gmv13odp.jpg)
[Foto de **Lorenzo** no **Pexels**](https://www.pexels.com/pt-br/foto/aconselhamento-ao-ar-livre-aventura-busca-240834/)
