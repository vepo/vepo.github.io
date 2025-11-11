---
title: Entendendo a arquitetura Cliente-Servidor
published: true
description: | 
    Esse é o quinto post da série **Conversas sobre Arquitetura**. Nele, mergulhamos nos fundamentos que sustentam a web e grande parte dos sistemas distribuídos atuais: a **arquitetura Cliente-Servidor**. Você vai entender o que define os papéis de cliente e servidor, como a comunicação entre eles funciona na prática e quais são as implicações dessa relação — desde protocolos de rede até o impacto na disponibilidade do sistema. Se você já se perguntou como estilos como REST, RPC e GraphQL se relacionam com esse modelo, ou como a latência e as falhas de comunicação afetam sua aplicação, este post é um ponto de partida essencial. Vamos descomplicar os conceitos e mostrar por que essa arquitetura continua sendo a base de tantas soluções modernas.
tags: [Arquitetura de Software]
cover_image: /assets/images/capas/caderno-caneta.jpg
permalink: /posts/entendendo-a-arquitetura-cliente-servidor
series: Conversas sobre Arquitetura
publish_date: 2025-11-11 18:50:00 +0300
---

Antes de discutir os estilos arquiteturais mais comuns, é importante entender a base de muitos deles: a arquitetura Cliente-Servidor. Caracterizá-la é útil, pois ela é a compõe estilos como REST, RPC, GraphQL, entre outros. Podemos começar identificando alternativas a essa arquitetura. Existem outras formas de pensar sistemas que não sejam baseadas na relação cliente-servidor? A resposta é sim! A arquitetura Cliente-Servidor é fácil de entender e construir, pois 'pensar em termos de CLIENTES que fazem requisições a SERVIDORES ajuda a compreender e gerenciar a complexidade de sistemas distribuídos.' [Saltzer and Kaashoek, 2009] Sua principal característica é a centralização na figura do servidor, mas é possível construir arquiteturas descentralizadas, como o Peer-to-Peer (P2P).

## Definindo os papéis

Então para entendermos como funciona e caracterizar uma arquitetura cliente-servidor, vamos definir o que é um cliente e o que é um servidor? Esses são os dois principais papeis dentro dessa arquitetura.
* "Um **servidor** (_server_) é um processo implementando um servico específico, por exemplo, um serviço de sistema de arquivos ou um serviço de banco de dados." [van Steen and Tanenbaum, 2017]
* "Um **cliente** (_client_) é um processo que requisita um serviço de um servidor através do envio de uma requisição e subsequentemente esperando pela resposta do servidor." [van Steen and Tanenbaum, 2017]

A interação entre cliente e servidor é conhecida como comportamento reqsuisição-resposta (_request-response_), ela é sempre síncrona, uma vez que toda requisição precisa de uma resposta.

<!-- https://excalidraw.com/#json=36iWOKx0T_gNqjvb4lZAi,h1wqtDM0cvA9U6ek_NEuWQ -->
![Comunicação Cliente-Servicor](/assets/images/conversas-sobre-arquitetura/fig-01-client-server.png)

## Caracterizando um protocolo Cliente-Servidor

Quando falamos de requisição e respostas, estamos obrigatóriamente falando de protocolos e os protocolos de uma arquitetura **Cliente-Servidor** podem ser caracterizados como Orientado à Conexão e Protocolos sem Conexão (_connectionless_). Apesar de estarmos falando de protocolos da camada de aplicação, eles são construídos através de escolhas bem definidas de protocolos na camada de rede. Usualmente, protocolos orientados a conexão usam o protocolo TCP, e protocolos sem conexão usam o protocolo UDP. Uma exceção se dá com o uso do protocolo QUIC que é uma construção em cima do UDP para estabelecimento de uma conexão de baixa latência, este usado pelo HTTP3.

A vantagem de se usar o protocolo sem conexão é garantir que a mensagem é enviada com baixa latência, mas não há garantias de entrega da mensagem, o que pode implicar em reenvio da mensagem para o cliente e na necessidade de se implementar operações idempotente para o servidor.

Já quando temos protocolos orientados a conexão, o mesmo pode ser classificado como Sem Estado (_stateless_) ou Com Estado (_stateful_). O HTTP é um protocolo sem estado, já o SSH é um protocolo com estado.

### Conceito de idempotência

Quando falamos de idempotência estamos caracterizando uma operação que pode ser repetida multiplas vezes sem efeitos colaterais. Qualquer operação que não altere o estado interno da aplicação é idempotente, mas uma operação potencialmente altere o estado da aplicação, para ser idempotente tem que identificar se ela já foi aplicada e responder como se fosse aplicada.

### Diferentes Camadas e suas implicações

Uma aplicação pode ser facilmente dividida em camadas, não estamos falando sobre arquitura em camadas, mas apenas em camadas como um estrutura de analise. O mais comum é a divisão em interface de usuário, aplicação e base de dados. É interessante notar que camadas mais superiores tendem a ter as caracteristicas de clientes enquanto camadas mais inferiores se comportam cada vez mais como servidores. Dessa forma, em algum momento uma dessas camadas ou interfaces implementará uma comunicação cliente-servidor, separando a aplicação fisicamente. E quais as implicações disso?

A primeira implicação é a adição de latência na comunicação. Cada vez que uma camada se comunica com outra através de uma interface de rede, essa comunicação é mais lenta do que uma comunicação local. A segunda implicação é a possibilidade de falhas de comunicação. Toda comunicação através de rede está sujeita a falhas, seja por perda de pacotes, indisponibilidade do servidor, etc...

No artigo ["The Calculus of Service Availability"](https://queue.acm.org/detail.cfm?id=3096459) o autor descreve como a adição de camadas pode reduzir significativamente a disponibilidade de um serviço. Quando dependemos de um serviço que tem disponibilidade de 99.99%, a disponibilidade do nosso serviço já está limitado por esse valor, ao depender de outro, o que implicaria em uma indisponibilida de ao menos 52 minutos em um ano. Ao se depender de mais serviços, essa disponibilidade pode aumentar, visto que os mesmo podem ficar também indisponíveis.

O calculo da disponbilidade é feito através da formula abaixo onde `MTTF` significa o tempo médio até falhar (do inglês _mean time to failure_) e `MTTR` significa tempo médio até o reparo (do inglês _mean time to repair_). A formua `A = MTTF / (MTTF + MTTR)` pode ser calculada usando qualquer unidade de medida, desde que `MTTF` e `MTTR` possuam a mesma unidade.

![Formula do calculo da disponbilidade: A=MTTF/(MTTF+MTTR)](/assets/images/conversas-sobre-arquitetura/fig-02-calculo-disponibilidade.png)

Fazendo um calculo hipotético de uma aplicação que falha a cada 2 meses e leva 3 horas para se recuperar, essa aplicação está disponível por 1440 horas a cada 1443 horas, ou seja, ela tem disponibilidade de apenas 99,8% do tempo, o que é uma disponibilidade considerada baixa para alguns serviços, como provedores de nuvem que pedem disponbilidade de 99,999%, ou seja, aproximadamente 5 minutos ao ano de indisponibilidade.

<!-- https://excalidraw.com/#json=unD4F6EHvF0nkDjZg1EbQ,tIckKWssfycFnr-3Kz1GIw -->
![Aplicação](/assets/images/conversas-sobre-arquitetura/fig-03-calculo-disponibilidade-exemplo.png)

### Processos Síncronos vs Assíncronos

Uma característica importante de uma arquitetura cliente-servidor é que a comunicação entre cliente e servidor é sempre síncrona, ou seja, o cliente envia uma requisição e espera pela resposta do servidor. Isso não significa que o cliente ou o servidor não possam ser assíncronos internamente, ou que a requisição não possa iniciar um processo assíncrono no servidor, mas a comunicação é sempre síncrona.

Isso levanta algumas discussões interessantes, pois podemos implementar nossos sistemas assincronamente, usando clientes assincronos, ou implmentar no servidor operações assíncronas que podem ser respondidas imediatamentes porém sem a operação ser finalizada.

No primeiro caso, é necessário que o cliente seja assíncrono, isso significa que ao invés de bloquear a thread da aplicação enquanto a resposta não chega, o cliente envia a requisição com um callback associado, liberando a thread para que outra operação seja realizada. 

No segundo caso, o servidor não processa a requisição, mas adiciona ela a uma fila de execução respondendo com um identificador para verificar o estado da execução,


## Conclusão

Entender a arquitetura Cliente-Servidor é um dos pilares fundamentais para se compreender o desafio de construir sistemas distribuídos. Sua simplicidade conceitual — baseada em requisições e respostas — facilita a implementação e o entendimento de sistemas complexos, porém adiciona desafios quando se trata de escalabilidade e disponibilidade.