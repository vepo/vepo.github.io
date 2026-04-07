---
title: Microsserviços e Fordismo
permalink: /posts/microsservicos-e-fordismo
published: true
description: Qual é a relação entre a Lei de Conway e Microsserviços?
tags: [Citações, Microsserviços, Desenvolvimento]
publish_date: 2019-07-27 10:30:35 +0300
original: "https://dev.to/vepo/microservicos-e-fordismo-1fhp"
image: /assets/images/capas/fordismo.jpg
---

_A Lei de Conway Reversa também significa que os desenvolvedores serão, em muitos aspectos como Microsserviços: eles serão capazes de fazer uma tarefa e (espera-se) fazer essa tarefa muito bem, mas eles estarão isolados (em termos de responsabilidade, conhecimento do domínio e experiência) do resto do ecossistema. Quando considerados juntos, todos os desenvolvedores trabalhando **coletivamente** dentro de um ecossistema de Microsserviços saberão tudo que há pra saber sobre ele, mas individualmente eles serão extremamente especializados, conhecendo apenas as partes do ecossistema pelas  quais são responsáveis._

A citação acima foi extraída do livro **Microsserviços prontos para a produção** da página 48. Fica muito evidente a similaridade de uma arquitetura de Microsserviços com o modelo de produção Fordista! 🏭🏭🏭🏭

Há muitos pontos positivos nisso:

* Velocidade na produção
* Consistência entre as soluções abaixo da camada de Microsserviços (_visto que os desenvolvedores não tem nem dominio e nem escolha sobre essas camadas_)
* Não dá para reconstruir a estrutura do zero facilmente (_sim, isso é positivo, evita espionagem industrial_)

Mas também há alguns pontos negativos:

* O conhecimento do sistema como um todo está disperso
* Possível falta de compartilhamento entre os nós do ecossistemas.

Quando estava na faculdade, muitos professores diziam que eramos **Pedreiros do Egito** pela maneira rudimentar que o processo era controla. Agora acredito que somos trabalhadores de uma fábrica do inicio do século XX.