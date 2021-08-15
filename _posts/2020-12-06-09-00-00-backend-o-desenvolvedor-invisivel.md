---
title: "Backend: O desenvolvedor invisível"
permalink: /posts/backend-o-desenvolvedor-invisivel
published: false
description: Apresentação do que é ser um desenvolvedor Backend e um histórico dos papeis dentro do mundo do desenvolvimento de Software
tags: [Desenvolvimento de Software, Backend, Histórico]
cover_image: /assets/images/backend/clint-eastwood-the-good-the-bad-and-the-ugly.jpg
series: Backend Roadmap
publish_date: 2020-12-06 17:00:00 +0300
---

# O Bom, O Mau e O Feio

O mundo da computação é um pouco ingrato. 

Você pode passar anos estudando, mas sempre tem que estudar mais. São novos conceitos, novas tecnologias ou novas funções que surgem a cada 5 anos e te deixam como um Australopithecus usando suas ferramentas para procurar comida enquanto há um banquete moderno ao seu lado.

![Um macaco em posição de pensador perdido](/assets/images/macaco-pensativo.jpg)

<center>Foto de <a href="https://www.pexels.com/pt-br/foto/tarde-animal-bicho-beleza-4168333/"><b>Petr Ganaj</b></a> no <b>Pexels</b>.</center>

Ou você cria um sistema magnífico, bem arquitetado e robusto. Ele não dá problemas e é fácil adicionar funcionalidades novas. Você provavelmente não terá uma boa reputação por ele, porque muitos acreditam que sistemas assim são simples e fácil. A simplicidade é elegante, mas não é valorizada. Vão achar que você é substituível: _"Olha como é simples fazer a manutenção..."_.

Quem é valorizado no mundo da computação? O **Salvador da Pátria**! Aquele cara que vai resolver a queda do servidor, ou vai investigar um bug que está parando o faturamento, ou é o único que entende do sistema. 

Em resumo, nosso mercado valoriza o vilão e não o mocinho.

O perfil do profissional pouco renomado é aquele que sempre entrega no prazo, mostra a solução, criar projetos bem arquitetado e de fácil manutenção. Já o perfil do profissional renomado é o cara que transforma uma borboleta em um dragão paga ganhar a fama de matador de dragões, foca no problema tornando-o cada vez maior, tem sempre um problema para resolver gastando inúmeras horas extras.

Você escolhe o profissional que quer ser. Você pode ser o bom profissional, mesmo que sem renome. Ou você pode ser o mau profissional que sempre está matando um leão. Sua escolha vai refletir seu carater e no dia que você tiver um bom gerente ele saberá qual profissional deve ser valorizado.

# Sobre Meninos e Lobos

Se voltarmos no tempo, vamos ver que não existiam as funções que temos hoje no mundo da computação. 20 anos atrás, só existiam desenvolvedores! Muitas vezes eles fazia software Desktop, depois iam para um projeto Web e acabavam desenvolvendo um Servidor Socket. Não existiam frameworks famosos e a linguagem era o conhecimento mais caro que um desenvolvedor possuia. Mas ainda a linguagem era relativa, nessa época era aceito um desenvolvedor trabalhar com Java, C++ ou Delphi. 

As funções que existiam ainda existem hoje. Eram básicamente Arquiteto, Engenheiro e Desenvolvedor, cada um tem sua função, mas uma mesma pessoa pode ser os três. 

É função do Arquiteto desenhar o sistema baseado na vontade dos _Stakeholders_. Este vai participar de muitas reuniões, enquanto os outros, na visão de um desenvolvedor, "trabalham". Muitas vezes o Arquiteto entra em conflito com o time de desenvolvimento, porque este tem uma visão de longo prazo ou conhece a vontade daquele que tem o poder. Enquanto o time de desenvolvedores tem que transformar a Apresentação em Código alimentado por café. _Stakeholders_ são todas as pessoas envolvidas no projeto, seja quem patrocina, seja o gerente que irá receber a promoção se o projeto for bem sucedido ou mesmo o usuário final. Eu prefiro usar o termo _Steakholders_ porque eles sempre estão em uma posição de comando, enquanto os reles mortais tem que lutar pela carne.

![Cachorro com olhar curioso](/assets/images/cachorro-curioso.jpg)

<center>Foto de <a href="https://www.pexels.com/pt-br/foto/acasalar-adoravel-animal-animal-de-estimacao-406014/"><b>Lum3n</b></a> no <b>Pexels</b>.</center>

A função do Engenheiro é ser o responsável tecnicamente pelo projeto. Engenheiro também é um desenvolvedor, mas ele não está apenas focado em entregar features. Ele deve responder a questões como: _Qual o throughput máximo a aplicação aguenta com apenas uma instância?_. Em computação, a função de engenheiro não é tão comunmente reconhecida porque muitos dos projetos são simples e nunca vão precisar da robustez que necessite um engenheiro.

A função do Desenvolvedor é a construção do sistema. Um sistema deve ser bem feito, estável, de fácil manutenção e testável. Ele deve criar código e testes para o mesmos. O código precisa ser entendível e bem documentado. Podemos falar também de robustez para um desenvolvedor, mas o conceito será outro. Para um Engenheiro robustez significa que ele aguenta carga, enquanto para um desenvolvedor significa que ele não falha constantemente. O desenvolvedor deve focar na corretude do código, ele deve fazer exatamente aquilo que é esperado.

Há alguns memes na internet que provam que algumas pessoas não entenderam exatamente o que é ser desenvolvedor. Nenhum software faz algo indesejado, ele faz exatamente o que foi programado pra fazer. O que acontece é que as vezes o desenvolvedor não tem maturidade para saber o que está sendo feito.

# O Cavaleiro Solitário

O mundo se tornou bastante completo com a digitalização, muitas tecnologias surgiram e os papeis que antes eram apenas 3 se tornaram dispersos. Hoje temos alguns silos: O Frontend, o Backend, o Mobile e o Cientista de Dados. Cada um deles vive em contextos completamentes dispersos, sendo que o mais esquecido deles é o Backend. Os outros podem construir portfólios bonitinhos, mas o Backend não. Como Arquitetos/Engenheiros/Desenvolvedores Backend ficamos responsável por tudo aquilo que está submerso no iceberg, não temos uma interface com nenhum usuário final, não podemos ser apresentado em reuniões de Sprint Review. Mas somos os responsável por muitas das funcionalidades da aplicação e por alguns requisitos muito importante: escalabilidade!

Como o resultado do trabalho do desenvolvedor Backend é muitas vezes oculto, tem-se a ideia de que pode ser feito de qualquer forma. É até comum vermos na internet memes que satirizam o trabalho, mostrando que ele pode ser feito de qualquer forma. Bom, não quero fazer julgamento morais, mas isso só pode ser piada de alguém que não entendeu o que é um trabalho sério.

| A visão do Frontend | A visão do Backend |
| ------ | ----- |
| [![Meme Backend correto](/assets/images/backend/backend-meme-correto.jpg)](https://www.reddit.com/r/ProgrammerHumor/comments/84mzyg/frontend_vs_backend_20/) | [![Meme Backend errado](/assets/images/backend/backend-meme-errado.jpg)](https://www.reddit.com/r/ProgrammerHumor/comments/7zfgwg/frontend_vs_backend/) |

O trabalho de Backend deve ser bem feito. O código pode ser bem organizado. Os frameworks de Backend evoluem em um passo mais devagar do que os de Frontend, e por isso temos menos impacto sobre a qualidade do código. Mas tudo isso depende de dois fatores: a maturidade e o conhecimento do desenvolvedor. E é isso que me proponho a compartilhar!

Vou apresentar uma série de textos sobre os principais pontos que um desenvolvedor backend deve ter domínio. Vamos começar tratando do seu código, como podemos estruturar e tornar ele mais legível. Depois vamos falar dos principais desafios de um sistema distribuído e como esses sistemas podem se conversar. Vamos abordar o Protocolo HTTP, padrões de Pub/Sub e gRPC, mostrando um estudo comparativo deles. Vamos entrar no seu sistema... Quais padrões você pode usar em código? O que são e como usar ORMs? E para finalizar vamos tratar de Arquiteturas distribuídas e Microserviços.