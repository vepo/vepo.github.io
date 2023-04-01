---
title: Arquitetura Event-Sourcing
published: false
permalink: /posts/event-sourcing-systems
description: Nesse post vamos fazer uma pequena introdução do que é uma Arquitetura Event-Sourcing (EDA) e como ela pode ser implementada. Para minha surpresa Event-Sourcing é diferente de Event-Driven.
tags: [Event-Sourcing Systems, Arquitetura]
cover_image: /assets/images/entrega-mensagem.avif
publish_date: 2022-04-01 11:00:00 +0300
---

"Event Sourcing garante que todas as mudanças de estado da aplicação sejam armazenadas como uma sequência de eventos." <sup>[[1]](#reference-1)</sup> Martin Fowler

## Definição

Nós temos um Sistemas Event Sourcing (SES) quando toda representação de dados é modelada através de um log de eventos. Para entender melhor essa definição precisamos primeiro entrar na definição de log. Log é qualquer informação é armazenada de forma sequencial. Os dados armazenados em um log de auditoria é a forma mais eficaz de se rastrear informações temporais. A ideia é que quando acontece algo, deve ser escrito um registro sobre esse acontecimento e quando aconteceu<sup>[[2]](#reference-2)</sup>. Por definição, eventos em um log de auditória são imutáveis, eles não podem ser alterados posteriormente. Eles representarão não o estado de uma entidade, mas o acontecimento de um evento relacionado a uma entidade. Esse log de eventos pode ser segmentado em diversos pedaços para facilitar a leitura, armazenamento e indexação dos registros no disco<sup>[[3]](#reference-3)</sup>. Cada seguimento deverá conter um subconjunto do log e um número sequencial. Todos os eventos armazenados no seguimento `n` deverão ser posteriores que os eventos armazenados no seguimento `n - 1` e o seguimento deve ser um conjunto ordenados de eventos.

Para entender melhor a definição de log de eventos, vamos supor que estamos modelando um sistema gerenciamento de usuários. Ao se criar um usuário em um sistema tradicional, nós temos uma entrada na base de dados armazenando o estado atual da entidade. Assim, ao criar um usuário, um identificador é associado a ele, conforme podemos ver na <a href="#listing-1">listagem 1</a>.

```json
{
    "id": 1,
    "nome": "Victor Osório",
    "contatos": {
        "email": "victor.osorio@vepo.com.br",
        "telefone": "(01) 23456-7890"
    },
    "criadoEm": "01/03/2023 10:25:13",
    "alteradoEm": "01/03/2023 10:25:23"
}
```
<a name="listing-1">Representação no formato JSON do valor da entidade com identificador `1` ao ser criada.</a>

Ao fazermos uma alteração nessa entidade, o dado salvo na base de dados é alterado, assim não temos mais o valor anterior, somente o novo valor. Se formos consultar a base, teremos algo diferente, conforme a <a href="#listing-2">listagem 2</a>.

```json
{
    "id": 1,
    "nome": "Victor Osório",
    "contatos": {
        "email": "victor.osorio@vepo.dev",
        "telefone": "(01) 23456-7890"
    },
    "criadoEm": "01/03/2023 10:25:13",
    "alteradoEm": "31/03/2023 15:10:42"
}
```
<a name="listing-1">Representação no formato JSON do valor da entidade com identificador `1` depois de ter seu email alterado.</a>

Esse objeto é uma Entidade<sup>[[4]](#reference-4)</sup>, conforme definido no livro Domain-Driven Desing, porque sua identidade reside mais no valor do seu identificado do que no valor das suas propriedades. Ne exemplo, alteramos o valor do email de contato, mas a entidade continua a mesma. Esse termo é usado em contraste a Objeto de Valor. Um Objeto de Valor<sup>[[4]](#reference-4)</sup> é um objeto em que sua identidade consiste meramente no valor das suas propriedades. O valor do campo `contatos` é um objeto de valor que pertence a entidade Usuário.

Quando falamos de um SES, temos um log de eventos e não entidades em uma base de dados. Logo ao invés da linha abaixo teríamos

```
| offset | Data                | Evento           | Chave | Conteúdo                                                                                                         |
| ------ | ------------------- | ---------------- | ----- | ---------------------------------------------------------------------------------------------------------------- |
| 000001 | 01/03/2023 10:25:13 | Usuário Criado   | 00001 | { "nome": "Victor Osório", "contatos": { "email": "victor.osorio@vepo.com.br", "telefone": "(01) 23456-7890" } } |
| .......................................................................................................................................................................... |
| 000781 | 31/03/2023 15:10:42 | Usuário Alterado | 00001 |  { "contatos": { "email": "victor.osorio@vepo.dev" } }                                                           |
```

Nesse log de eventos temos associado a cada evento uma chave, um data e um tipo de evento. Sabemos que o evento `000781` se refere ao mesmo usuário do evento `000001` porque ambos possuem a mesma chave.

Em um SES, nós não temos uma entidade única em uma base de dados representando o estado atual de uma entidade, esse estado é representado por todas as entidades no log de eventos com um mesmo identificador.

## Caracterização de Sistemas Event Sourcing

Para termos uma definição mais formal de SES, precisamos trazer uma definição formal para cada componente que integra o sistema. Vou me basear na definição de Michiel Overeem em _An empirical characterization of event sourced systems and their schema evolution — Lessons from industry_<sup>[[5]](#reference-5)</sup>, onde ele define Evento (_Event_), Sequência de eventos (_Event sequence_), Stream de eventos (_Event stream_), Reserva de eventos (_Event store_), Função de projeção (_Project function_), Projeções (_Projections_), Função de aceitação (_Accept function_), Esboço de evento (_Event schema_), Esboço de stream de eventos (_Event stream schema_) e Reserva de esboço de eventos (_Event store schema_).

### Event

Um evento é um objeto de dados discreto especificado em termos de domínio que representa uma mudança de estado em um SES.

Por ser um objeto de domínio ele deve estar intrinsecamente ligado a regra de negócios da aplicação. Domínio<sup>[[4]](#reference-4)</sup> no contexto de Domain-Driven Desing é o conjunto de conceitos e processos especifico da área de negócios que a aplicação se insere.

```json
Usuário Criado {
    "id": 1,
    "nome": "Victor Osório",
    "contatos": {
        "email": "victor.osorio@vepo.dev",
        "telefone": "(01) 23456-7890"
    },
    "criadoEm": "01/03/2023 10:25:13",
    "alteradoEm": "31/03/2023 15:10:42"
}
```

### Sequência de eventos

Cada evento é armazenado junto com um número de sequência. Seu número de sequência representa a posição do evento no fluxo.

### Stream de eventos

Um fluxo de eventos $$s$$ é uma sequência de tuplas, cada tupla contendo um evento e seu número de sequência

## Referências

<a name="reference-1" href="https://martinfowler.com/eaaDev/EventSourcing.html" target="_blank">[1] M. Fowler, “Event Sourcing”, martinfowler.com, 12 de dezembro de 2005. https://martinfowler.com/eaaDev/EventSourcing.html (acessado 9 de agosto de 2022).</a>

<a name="reference-2" href="https://martinfowler.com/eaaDev/AuditLog.html" target="_blank">[2] M. Fowler, “Audit Log”, martinfowler.com, 7 de março de 2004. https://martinfowler.com/eaaDev/AuditLog.html (acessado 31 de março de 2023).</a>

<a name="reference-3" href="https://martinfowler.com/articles/patterns-of-distributed-systems/log-segmentation.html" target="_blank">[3] U. Joshi, “Segmented Log”. https://martinfowler.com/articles/patterns-of-distributed-systems/log-segmentation.html (acessado 31 de março de 2023).</a>

<a name="reference-4" href="https://amzn.to/40zKNc4" target="_blank">[4] E. Evans, Domain-Driven Design: Atacando as complexidades no coração do software. Alta Books, 2016.</a>

<a name="reference-5" href="https://www.sciencedirect.com/science/article/pii/S0164121221000674#sec5" target="_blank">[5] M. Overeem, M. Spoor, S. Jansen, e S. Brinkkemper, “An empirical characterization of event sourced systems and their schema evolution — Lessons from industry”, Journal of Systems and Software, vol. 178, p. 110970, ago. 2021, doi: 10.1016/j.jss.2021.110970.</a>

---

<a name="reference-5" href="https://martinfowler.com/articles/patterns-of-distributed-systems/fixed-partitions.html" target="_blank">[5] U. Joshi, “Fixed Partitions”, martinfowler.com. https://martinfowler.com/articles/patterns-of-distributed-systems/fixed-partitions.html (acessado 31 de março de 2023).</a>
