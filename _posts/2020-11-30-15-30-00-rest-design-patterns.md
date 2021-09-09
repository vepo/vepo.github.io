---
title: Padrões de Projetos para APIs REST?
permalink: /posts/rest-api-design-patterns
published: false
description: Existem Padrões de Projetos para APIs REST? Fui procurar uma resposta para essa pergunta
tags: [API, REST, Design Patterns, Arquitetura de Software]
cover_image: /assets/images/biblioteca.jpg
series: Backend Roadmap
publish_date: 2020-11-30 09:14:00 +0300
---

# Motivação

A motivação desse post é fazer um estudo sobre quais são os Design Patterns e Anti-Patterns para REST APIS. APIs é uma tendência atualmente e como desenvolvedor Backend sempre me preocupei em criar boas, e bem projetas, APIs. Creio que conhecendo tanto os Design Patterns quanto os Anti-Patterns, vou melhorar ainda mais minha capacidade de projetar boas APIs.

# Levantamento Bibliografico

Para fazer o levantamento desses Patterns, resolvi buscar na academia, por isso fiz um levantamento usando o Google Scholar e os termos:

* REST Anti Pattern
* REST Design Patterns

Minha intenção é buscar artigos publicado nos últimos 10 anos que me tragam insights para o meu proprio aprendizado.

Os artigos selecionados para leitura foram:

* 2014 - [Detection of REST Patterns and Antipatterns: A Heuristics-Based Approach](https://link.springer.com/chapter/10.1007/978-3-662-45391-9_16): Francis Palma, Johann Dubois, Naouel Moha, and Yann-Gaël Guéhéneuc
* 2017 - [A Framework for the Structural Analysis of REST APIs](https://ieeexplore.ieee.org/abstract/document/7930199): Florian Haupt, Frank Leymann, Anton Scherer, Karolina Vukojevic-Haupt
* 2020 - [Defining Design Patterns for IoT APIs](https://link.springer.com/chapter/10.1007/978-3-030-59155-7_32): Rasmus Svensson, Adell Tatrous, Francis Palma

# Resumos

## Detection of REST Patterns and Antipatterns: A Heuristics-Based Approach

Palma propões uma analise de Patterns e Anti-Patterns baseado nas hueristicas que os proprios Patterns propõe. Esse artigo foi escrito antes da [proposição](https://smartbear.com/news/news-releases/sponsorship-of-swagger/) do [OpenAPI](https://spec.openapis.org/oas/v3.0.3), em 2015. Na analise foi uma identificação das requisições e respostas, baseada nas implementações de clientes das APIs.

Foi identificada que muitas das APIs comerciais da época implementavam Anti-Patterns e Design Patterns.

![Resultados](/assets/images/design-patterns/palma-2014-results.png)

## A Framework for the Structural Analysis of REST APIs

Haupt propões uma analise estrutural baseada na documentação da API usando OpenAPI. A documentação de APIs abertas foram analisadas por uma ferramenta para se extrair o modelo dela. Ele por sua vez se baseia no _Atomic Resource Model_ e no _URI Model_. O segundo modelo estende o primeiro, dando a oportunidade ao cliente da API de navegar nos recursos baseados em hyperlinks providos pela propria API.

![Atomic Resource Model](/assets/images/design-patterns/atomic-resource-model.png)

Com essa analise é possivel conhecer a complexidade da API, descrevendo quandos Recursos ela possui, quantos desses são _ReadOnly_ e quais as relações entre eles através de links.

## Defining Design Patterns for IoT APIs

Svensson faz uma analise de algumas APIs de mercado para IoT e propões 8 Design Patterns, baseado no modelo do GoF. APIs de IoT são altamente voltada a recursos, pois cada dispositivo é um recurso. Segundo Svensson, os Patterns presentes na literatura são mais voltados para garantir a qualidade RESTful das APIs e não para o design dos endpoints, por isso todos esses Patterns são voltados para o endpoint.

# Anatomia de uma Requisição

Segundo a [IETF RFC 3986](https://tools.ietf.org/html/rfc3986), uma URI deve ser dividida nos seguintes componentes:

> Scheme://Authority/Path?Query#Fragment

Cada componente de uma URI tem sua especificidade e significância que deve ser levada em conta na construção de uma API.

| Componente | Descrição | Exemplo |
|------------|-----------|---------|
| Scheme | Define sobre qual protocolo essa API está sendo disponibilizada. APIs REST são obrigatoriamente disponibilizadas via HTTP, logo para nosso caso teremos apenas HTTP e HTTPS | **http**://www.google.com/ |
| Authority | Define onde está a API e como será acessada. Na grande maioria dos casos é composto pelo `hostname` do serviço, mas este pode ser substituido pelo endereço IP. Pode contar ainda qual autenticação será feita e a porta a ser acessada. | https://**api.twitter.com**/1.1/search/tweets.json |
| Path | Contem dados organizados hieraquircamente através de nós. Cada nó é separado por "/" |
| Query | Parâmetros opcionais ou obrigatórios da requisição |
| Fragment | Parâmetros que não serão considerados na requisição |

Svensson subdvide o **Path** em **Base** e **Main**. **Base** normalmente é usado para definir qual API e/ou qual versão da API deve ser acesada. Enquanto o **Main** é o ponto crucial da requisição. Dentre os nós de um **Path**, é possível também classificar sua função.

> Scheme://Authority/Base/Main?Query

| Nome | Descrição |
| ---- | --------- |
| Nó de Acesso | Um nó que é usado apenas para direcionar as seguintes partes do URI para uma determinada seção da API, ou seja, não é um recurso ou dados que podem ser buscados. |
| Nó Pai | Um nó que geralmente representa uma categoria, um recurso que inclui recursos ou um objeto. Na API e no URI, esse nó existe em uma hierarquia. Aqui, tendemos a mencionar apenas o fim da hierarquia. |
| Nó Indicativo | Um nó que representa uma ordem, consulta ou ação a ser realizada em um determinado recurso para aplicar esta ação ou conhecer uma informação específica sobre esse recurso, por exemplo, filtrar os resultados de uma solicitação feita em um determinado recurso. Podemos pensar nisso como um ponto final que dispara uma função. Geralmente é uma palavra convencional, como info, ‘create’, ‘last’, ‘status’, etc. Nós indicativos podem ser divididas em três categorias: Nós de Ação, Nós de Filtro e Nós Informacionais |
| Nós de Ação | Um nó usado para acionar uma função específica ou aplicar funcionalidades clássicas de CRUD em um recurso, usando qualquer método de solicitação HTTP. Na maioria dos casos, esses nós assumem a forma de um pedido para realizar uma ação, por exemplo, "create", "clone", "upload" ou "consume" |
| Nós de Filtro | Um nó usado para direcionar um grupo específico ou estado dos recursos solicitados. |
| Nós Informacionais | Um nó usado para obter informações sobre metadados para um ou vários recursos. Esses metadados não podem ser modificados diretamente nem acessíveis por meio do recurso |

Svensson também classifica a Authority como dinâmica e estática. 

* **Dinâmica**: o mesmo valor é usado para todos os recursos controlado pela API
* **Estática**: valores são gerados para controlar grupo de recursos.

# Design Patterns

## Micro-Level Patterns

### Entity Linking
Este padrão permite a **comunicação em tempo de execução** através de **links** providos pelo servidor no corpo da resposta ou via **Location:**, no cabeçalho da responsta. Usando hyperlinks, cliente e servidor, estão **fracamente acoplados**, e o cliente pode **automaticamente encontrar** as **entidades relacionadas** em **tempo de execução**.

### Response Caching
O cacheamento da resposta é uma boa pratica para **evitar enviar requisições duplicadas** e **respostas** através do cacheamento de todas as mensagens no **local** da máquina do cliente. São usados os cabeçalhos **Cache-Control** e **ETag**, assim como o **código HTTP 304**.

### Content Negotiation
Esse padrão suporta **representações alternativas para recursos**, (por exemplo, em **json**, **xml**, **pdf**, etc.) assim o serviço consumidor se torna mais flexivel com alta reutilização. Servidores podem prover recursos em **qualquer formato padrão** requerido pelos clientes. Este padrão é aplicado através dp **HTTP Media Types** e adere ao principio de serviço de baixo acoplamento.

### End-point Redirection
A funcionalidade de redirecionamento através da Web é suportado por este padrão, que também desempenha um papel importante como meio de **composição de serviços**. Para redirecionar clientes,o servidor envia uma nova localidade para acompanhar um dos códigos HTTP entre 301, 302, 307 ou 308. O principal beneficio desse padrão é - um serviço alternativo continua ativo mesmo que o endpoint requerido não responda.

### Entity Endpoint
Serviços com um único **endpoint** são pouco granular. Usualmente, um cliente requer ao menos **dois identificadores**: um **global** para o **serviço** em si e um **local** para o **recurso ou entidade** gerenciada pelo serviço. Aplicando este padrão, isto é, usando **multiplos endpoints**, cada entidade (ou recurso) de um serviço incorporado pode ter seu **identicador único** e **endereço global**.

## Anti-Patterns

### Breaking Self-descriptiveness
Desenvolvedores de APIs **REST** tendem a ignorar os **cabeçalhos padrão**, **formatos** e **protocolos** e criam customizações proprias. Esta pratica quebra o carater auto-descritivo e a mensagem contida no cabeçalho. A ausência do carater auto-descritivo limita a **reutilização** e a **adaptabilidade** do recurso REST.

### Forgetting Hypermedia
A falta de hipermídia, ou seja, a não vinculação de recursos, dificulta a transição de estado para aplicativos REST. Uma possível indicação deste antipadrão é a ausência de links de URL na representação de origem, o que normalmente restringe os clientes a seguir os links, ou seja, limita a comunicação dinâmica entre clientes e servidores

### Ignoring Caching
Clientes REST e desenvolvedores backend tendem a **evitar** o cache devido à sua complexidade de implementação. No entanto, a capacidade de armazenamento em cache é uma das principais restrições de REST. Ao ignorar recursos de chace não usando **_Cache-Controe: no-cache_** ou **_no-store_** e não provendo um **ETag** no **cabeçalho da resposta**.

### Ignoring MIME Types
O servidor deve representar **recursos** em vários formatos, por exemplo, **XML**, **JSON**, PDF, etc., o que pode permitir a clientes, desenvolvidos em qualquer linguagens, um consumo de serviço mais flexível. No entanto, os **desenvolvedores** backend geralmente pretendem ter uma **única representação** de recursos ou depender de seus próprios formatos, o que limita a **acessibilidade** e a **reutilização** do recurso (ou serviço).

### Ignoring Status Code
Apesar de um rico conjunto de códigos de status de nível de aplicativo definidos adequados para vários contextos, os desenvolvedores REST tendem a evitá-los, ou seja, contam apenas com os comuns, a saber 200, 404 e 500, ou até mesmo usam os códigos de status errados ou nenhum. O uso correto dos códigos de status das classes 2xx, 3xx, 4xx e 5xx auxilia clientes e servidores a se comunicarem de forma mais semântica

### Misusing Cookies
Statelessness é outro princípio REST a ser seguido - o **estado da sessão** no lado do servidor **não é permitido** e todos os **cookies violam o RESTfulness**. O envio de **chaves** ou **tokens** no campo de cabeçalho **Set-Cookie** ou **Cookie** para a sessão do lado do servidor é um exemplo de uso indevido de cookies, que diz respeito à **segurança** e **privacidade**

### Tunnelling Through GET
Sendo o método HTTP mais fundamental em REST, o método GET recupera um recurso identificado por um URI. No entanto, muitas vezes os desenvolvedores **usam apenas** este método para realizar qualquer tipo de ação ou operação, incluindo a **criação**, **exclusão** ou até mesmo para **atualizar** um recurso. No entanto, HTTP GET é um método impróprio para qualquer ação diferente de **acessar um recurso** e não corresponde ao seu **propósito semântico**, se usado indevidamente.

### Tunnelling Through POST
Esse Anti-Pattern é muito semelhante ao anterior, exceto que, além do URI, o **corpo** da solicitação HTTP POST pode **incorporar operações** e **parâmetros** a serem aplicados ao recurso. Os desenvolvedores tendem a depender apenas do método HTTP POST para enviar qualquer tipo de solicitação ao servidor, incluindo **acesso**, **atualização** ou **exclusão** de um recurso. Em geral, o uso adequado de HTTP POST é **criar um recurso** do lado do servidor. Qualquer paramêtro que altere uma requisição de informação, deve ser enviado como Query Parameter.

## Domain Patterns

### Early Directed URI (ED_URI)

* **Descrição**: Para direcionar a requisição da URI para um grupo especifico ou único dentro da API. Pode ser um ID de organização, código de área ou nome de servidor. Normalmente é usado um nome variável no começo da _Authority_.
* **Sessões afetadas**: _Authority_
* **Formato**: `Scheme://{variable}.../Base/Main?Query`
* **Exemplo**: `https://myiothub.azure-devices.net/jobs`

### Expressive Request (ER)
* **Descrição**: Para executar as funcionalidades clássicas do CRUD ou acionar uma função específica em um recurso, ao mesmo tempo em que declara claramente a finalidade do URI e não apenas se baseia no método usado, adicione um **Nó de Ação** na seção _Main_.
* **Sessões afetadas**: _Main_
* **Formato**: 
    1. `Scheme://Authority/Base/../ActionNode?Query`
    2. `Scheme://Authority/Base/../ParentNode/ActionNode/{variable}?Query`
* **Exemplo**: `https://ioe.droplit.io/v0/api/zones/123/behaviors/456/start`

### ‘me’ Accessible Resources (MAR)
* **Descrição**:  Para apontar para o usuário autenticado no momento ao solicitar recursos ou executar ações às quais este usuário tem acesso, use um nó “me” no início da seção _Main_
* **Sessões afetadas**: _Main_
* **Formato**: `Scheme://Authority/Base/me/..?Query`
* **Exemplo**: `https://api.losant.com/me/refreshToken`

### Metadata Retrievability (MR)
* **Descrição**: Para ler informações, principalmente usando o método GET, sobre metadados para um único ou vários recursos, como: `count`, `state`, `status` ou outros dados que não podem ser modificados diretamente nem acessíveis por meio de um recurso, o URI pode ter um Nó Informativo significativo no final da seção _Main_ como uma indicação para as informações solicitadas.
* **Sessões afetadas**: _Main_
* **Formato**: `Scheme://Authority/Base/../InformationalNode?Query`
* **Exemplo**: `https://api.particle.io/v1/sims/123/status`

### Proactive Filtering (PF)
* **Descrição**: Para direcionar um grupo específico ou estado do recurso solicitado sem depender de um parâmetro de consulta dedicado, use um Nó de Filtro na seção _Main_
* **Sessões afetadas**: _Main_
* **Formato**: 
    1. `Scheme://Authority/Base/../FilteringNode/ParentNode/..?Query`
    2. `Scheme://Authority/Base/../ParentNode/FilteringNode/..?Query`
* **Exemplo**: `https://platform.clearblade.com/codeadmin/failed`

### Querified Authentication (QA)
* **Descrição**: Para fornecer a string de autenticação do usuário no URI ao usar o método GET, em vez de fornecê-la no cabeçalho ou no corpo ao usar outros métodos, use um parâmetro de consulta dedicado
* **Sessões afetadas**: _Query_ 
* **Formato**: `Scheme://Authority/Base/Main/?{authentication-key}={authentication-string-value`
* **Exemplo**: `https://api.particle.io/v1/events/123?access_token=456789`

### Versionized API (V_API)
* **Descrição**: A diferenciação de versão da API é feita na request. Esta pode ser feita com base em um nó no _Base_, que representa a versão. Ou também com um parâmetro na Query.
* **Sessões afetadas**: _Base_ e _Query_ 
* **Formato**: 
    1. `Scheme://Authority/v{number}/Main?Query`
    2. `Scheme://Authority/AccessNode(s)/v{number}/Main?Query`
    3. `Scheme://Authority//AccessNode(s)/v/{number}/Main?Query`
    4. `Scheme://Authority/v{number}/AccessNode(s)/Main?Query`
    5. `Scheme://Authority/Base/Main?{version-key}={version-data-value}`
* **Exemplo**: 
    * `https://myiothub.azure-devices.net/configurations/123?api-version=2020-03-13` 
    * `http://api.cubesensors.com/v1/devices`

### Versionized Resources (VR)
* **Descrição**: Nesse padrão, os recursos podem ter versões, e ao acessar um recurso uma versão antiga pode ser acessada. 
* **Sessões afetadas**: _Main_
* **Formato**: 
    1. `Scheme://Authority/Base/../ParentNode{number}/..?Query`
    2. `Scheme://Authority/Base/../ParentNode/v{number}/..?Query`
* **Exemplo**: `https://myiothub.azure-devices.net/jobs/v2/123`

# Conclusão

Design Patterns podem existir para qualquer área. Eles podem ser de grande ajuda se você os conhece, vão te dar repertórios tanto para novos desenvolvimentos, quando para melhorias em códigos já existentes. Eles também podem indicar pontos de melhoria no seu projeto.

---

Foto de [**Element5 Digital**](https://www.pexels.com/pt-br/foto/aprendendo-aprender-biblioteca-conhecimento-1370295/) no **Pexels**

![Biblioteca](/assets/images/biblioteca.jpg)