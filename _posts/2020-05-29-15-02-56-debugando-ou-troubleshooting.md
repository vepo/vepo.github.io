---
title: Debugando ou Troubleshooting
permalink: /posts/debugando-ou-troubleshooting
published: true
description: Um Sênior deve saber fazer troubleshooting. Aqui vão algumas dicas.
series: Coisas que todo Sênior deve saber
tags: [Troubleshooting, Debugging, Logging]
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/d84kfpnh68q6xj7kjzue.jpeg
publish_date: 2020-05-29 12:02:56 +0300
original: "https://dev.to/vepo/debugando-ou-troubleshooting-pco"
---

Uma das funções de um desenvolvedor Sênior é fazer o time andar. Além dele ser melhorar a comunicação interna do time, será responsável também por não deixar o time parar. É aí que entra o _Debug_, _Troubleshooting_... ou em bom português Resolução de Problemas.

Fazer troubleshooting é quase como investigar um crime. Você precisa tem muito conhecimento do que estava acontecendo, muito conhecimento do local e ir seguindo rastros.

Então vamos lá em dicas de como encontrar e resolver problemas.

# Não se contente com a aparência

Muito tempo atrás, um um mundo onde _git_ e _agile_ ainda eram palavras exóticas, existia o _Waterfall_. _Waterfall_ é o famoso processo de desenvolvimento que cada fase dura ao menos 3 meses. Você passa 3 semanas planejando, 2 meses desenvolvendo e uma semana testando. É uma loucura, literalmente. Mas tem uma coisa que o _Waterfall_ me ensinou que eu nunca esqueço: _Root Cause Analysis_.

Recebíamos um **CR** (_Change Request_) e antes de receber um branch pra desenvolver precisávamos fazer uma análise minuciosa da causa do problema em uma ferramenta web rudimentar. 

Vamos propor um problema: um simples _NullPointerException_.

Na hora um júnior falaria pra colocar uma verificação de `null` e pronto. 

Mas uma boa Análise de Causa Raiz, pelo nome já diz que essa solução é inválida. Para fazer essa análise, você tem que fazer perguntas ao sistema:

1. De onde vem esse valor `null`?
2. Ele pode ser `null`? Ou deve sempre vir com algum valor?
3. Caso seja `null`, qual o comportamento do sistema?

Dependendo das respostas acima, é bem provável que a solução proposta mude. Até porque você pode se perguntar: _Porque o cara que desenvolveu isso não o fez?_ Óbvio?

Pois bem, um Sênior não se contenta com análises superficiais. Vai investigar.

# Análise de logs

Um Sênior sabe ler logs, mesmo que não seja de aplicações dele. Logs são o registro factual e uma execução. O passo a passo para um bug. Um log, em si, já diz muita coisa, mas se associarmos um log com o código temos tudo! 

Mas como ler um log? Vamos lá....

1. Encontre onde deu o problema
2. Analise a código levante algumas suposições
3. Retroceda no log, acompanhando com os trechos de código e validando suas suposições
4. Caso consiga uma suposição valida, crie um teste unitário que recria o estado da execução

Fazer esses quatro passos exige muito treino. A principio é difícil analisar log, mas com o tempo vai se pegando o jeito e só de olhar o código é possível supor alguns possíveis problemas.

# Deixe Rastros

Pior do que analisar logs é não ter logs para analisar. [Nesse post expliquei como usar Log em Java](https://dev.to/vepo/deixando-rastros-ou-como-usar-log-peg).

Log consome performance, caso você não use log por causa disso, você não sabe usar log!

Antes vamos entender os níveis de log...

## Níveis de log

Em Java temos uma biblioteca padrão de log, a [SLF4J](http://www.slf4j.org/), eu recomendo que você a use, escolha uma implementação, mas pode olhar um benchmark.

Cada mensagem de log tem um nível associado. No SLF4J há os seguintes:

| Nivel | Descrição |
|-------|-----------|
| TRACE | O mais interno. Use-o quando você quer marcar trechos de código executados. Por exemplo: "Iniciando getUsers"|
| DEBUG | Use-o para imprimir valores de variáveis durante a execução. |
| INFO | Use-o para imprimir informações uteis para a execução de informações. Em casos excepcionais, esse nível de log pode ser usado em produção. |
| WARN | Opa! Alguma coisa não devia ter acontecido. Porque? É bom investigar! Use esse nível para marcar comportamento inesperado, mas que não deram erro. Normalmente é aquela situação que pode ser contornada. |
| ERROR | Opa! Erro inesperado! Não fique logando com log erros esperados. Um ERROR já é sinal de um Bug.... Ou é um erro na lógica, ou algum serviço falhou! |

Use esses serviços sem cerimonia, para garantir a performance você deve configurar o nível de log de acordo com os ambientes. E, por favor, faça a [configuração ser por variável de ambiente](https://12factor.net/pt_br/config), [nada de uma build pra cada ambiente!](https://12factor.net/pt_br/dev-prod-parity).

O que eu costumo fazer:

| Nivel | Ambiente |
|-------|----------|
| TRACE | Desenvolvimento em debugging |
| DEBUG | Desenvolvimento, Staging |
| INFO | Testes, Staging, UAT |
| WARN | Produção |
| ERROR | Oi? Vai ignorar os warnings? |

Os Níveis de log da produção eu baixo esporadicamente para determinados modulos somente quando há um Bug em Produção que não consigo reproduzir localmente. Mas é somente até conseguir encontrar registro do erro. Depois volta para WARN.

# Conheça o Código

Muitos desenvolvedores consideram um produto/biblioteca/framework uma caixa preta. Trabalham na base do input/output. Essa abordagem é necessária quando se tem muito conhecimento a reter. Quando eu inicio o uso de um produto/biblioteca/framework eu tomo essa abordagem, mas com o andamento do projeto precisamos de mais informações. 

O conhecimento do funcionamento interno de todo o projeto é necessário para entender possíveis erros. Quando há um erro em produção, 1h é bastante tempo, logo tem que se ter uma boa ideia de tudo. O que pode tá errado?

Um dica é aos poucos ir lendo os códigos que você usa como caixa preta. Mesmo que você não entenda, vá lendo e vendo o que ele faz com seus inputs.

Quando estava desenvolvendo a Engine de Processos de Negócios de uma antiga empresa que trabalhei, enfretamos um grande problema de Memory Leak. Em resumo, toda intergração de negócio era escrita em XML e associado código Java. Assim um cara do comercial podia entender as integrações bizarras que existiam. 

Para fazer com que `if`, `case`, `switch`, `for`, etc... fosse colocados em XML, usamos o [**Java Expression Language (JEXL)**](http://commons.apache.org/proper/commons-jexl/) da Apache. 

Estava tudo indo certo até ir para Produção. Mas o negócio não ficava de pé por alguns dias. Estourava a memória. Depois de uma analise bem detalhada, percebi que não era no nosso código. Até encontrar que na limpesza do cache do JEXL, eles não limpavam as referências as classes utilizadas. Assim, se usassemos ClassLoaders dinamicos, como era uma escolha arquitetural nossa, ficavamos com muito lixo na Heap. Entendeu? Se não depois falo sobre Gerenciamento de Memória no Java.

E agora, como resolver? Bom, tive que abrir os objetos pro Reflection, violando todos os principios de OOP para limpar o cache. E funcionou! 

Não dá pra garantir que exista um software sem erros, conhecer as suas dependências é um requisito.

# Conclusão

Um Sênior deve saber resolver os problemas do time. Deve ser um guia para criar meios de deixar rastros e entender o que está acontecendo. Troubleshooting é difícil, mas é uma prática. 

Leia código, tente executar eles na sua mente. Simule execuções baseada em logs.