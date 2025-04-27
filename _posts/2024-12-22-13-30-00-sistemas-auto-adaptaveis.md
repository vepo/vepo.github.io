---
title: Sistemas Auto-Adaptáveis
published: false
description: 
tags: [Ciência da Computação, Sistemas Auto-Adaptativos]
cover_image: /assets/images/microservices/cover-100-42.webp
#series: Sistemas Distribuídos & Microsserviços
permalink: /posts/sistemas-auto-adaptaveis
publish_date: 2024-12-22 21:00:00 +0300
---

Esse post é um breve resumo de uma área de pesquisa. Nele vou descrever o conteúdo da revisão bibliográfica [Concepts and Models of Environment of Self-Adaptive Systems: A Systematic Literature Review](https://ieeexplore.ieee.org/document/9712137).

# O que é um Sistema Auto-Adaptável?

Um sistema auto-adaptável muda adaptativamente seu comportamento ou estrutura em tempo de execução para atingir seus objetivos e responder a situações imprevistas do próprio sistema ou de seu ambiente operacional. Em outras palavras é um sistema que se adapta para responder a mudanças internas ou do ambiente, essas mudanças surgem pelo grau de incertezas que existem no sistema ou no ambiente.

Um ambiente incerto por ter vários significados e essa definição não é tão certa. Pode ser um ambiente que muda com o tempo, um ambiente que é alterado por fatores externos ou um ambiente que é mal interpretado pelos sensores. O termo sensores se referem a qualquer sistema ou dispositivo que provê métricas do ambiente para os sistemas, como descrito por Barbara Hayes-Roth no seu artigo An architecture for adaptative intelligent systems. 

> A arquitetura de um agente organiza seus componentes para percepção, atuação e processos de cognição. O processo de percepção coleta, abstrai e filtra os dados detectados antes de enviar para os outros compoenentes. O sistema de atuação controla a execução de ações externas, a percepção pode influenciar diretamente a atuação através de reflexos ou processos coordenados entre percepção e atuação. Os sistemas de cognição interpretam dados da percepção, resolvem problemas, criam planos e guias estratégicos para percepção e ação.

As duas principais características de um agente são a sua racionalidade e sua autonimia. Por racionalidade, se compreende que um agente deve atuar para atingir um objetivo. Um agente é racional quando toma a decisão correta de acordo com testes e critérios, assim a racionalidade de um agente depende (i) da medida de desempenho que define o sucesso; (ii) do conhecimento do agente sobre o ambiente; (iii) das ações que ele é capaz de executar; (iv) da disponibilidade de dados de percepção. Um agente é considerado autonomo se é capaz de executar ações e ter um graude de controle não trivial sobre suas ações.

Um agente pode ser classificado como Reflexo Simples, Reflexo baseado em Modelo, Baseado em Objetivos, Baseado em Utilizade e Aprendizagem.

* **Reflexo Simples**: A decisão da ação a ser tomanda é baseada apenas na percepção atual, o histórico de percepções é neglicengiado.
* **Reflexo baseado em Modelo**: A decisão do agente é baseada em um modelo de ambiente construído pelo mesmo, visto que o ambiente não pode ser completamente observável. O histórico de percepções é usado para a construção do modelo.
* **Baseado em Objetivos**: A ações do agente são direcionadas a um proposito especifico, a suas ações dependem do estado atual e de um objetivo a ser atingido. Às vezes, atingir ao objetivo requer uma única ação, em outros casos o objetivo alcançado é complexo e decomposto em múltiplos subobjetivos, cada um dos quais requer um ou um conjunto de ações. Neste caso, a obtenção de todas os subobjetivos significa a obtenção do objetivo principal. Normalmente neste caso, estratégias, planejamento e peneiramento através de um espaço de busca por possíveis soluções são necessários.
* **Baseado em Utilidade**: pode ser visto como um modelo de suporte ou complementar ao modelo **Baseado em Objetivo** descrito anteriormente. Neste caso, o agente conhece a função de utilidade, que é continuamente monitorada e explorada para estimar a distância entre a meta e o estado atual do agente.
* **Aprendizagem**: este modelo de agente tem a capacidade de enriquecer seu “conhecimento” e habilidades observando e agindo de acordo. Isso significa que o agente é capaz de aprender com experiências passadas no ambiente para prever o futuro e, em alguns casos, afetar (pro)ativamente o ambiente.

O ambiente é uma abstração de primeira classe que fornece as condições circundantes para a existência de agentes e que medeia tanto a interação entre agentes quanto o acesso aos recursos. Um ambiente por ser caracterizado como observável, deterministico, estático e discreto.

* **Observabilidade**: os agentes podem ter acesso completo ou parcial ao estado do ambiente;
* **Determinismo**: em ambientes determinísticos, as ações dos agentes têm efeitos únicos e garantidos;
* **Dinamismo**: em um ambiente estático, os agentes podem assumir que nenhuma mudança acontece durante sua própria deliberação;
* **discrição**: a discrição pode se referir a diferentes aspectos do ambiente, a saber, seu estado, a maneira como o tempo é representado e gerenciado e as percepções e ações dos agentes; geralmente, em um ambiente discreto, há um número fixo e finito de ações e percepções.