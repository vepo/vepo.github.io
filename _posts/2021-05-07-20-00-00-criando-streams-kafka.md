---
title: Conhecendo o Kafka Streams
published: false
description: Diversidade cultural realmente importa? Um esboço do que vou falar no TDC Connections 2021
tags: [Sociedade, Cultura]
cover_image: /assets/images/1277px-Ponte_Metalica_Teresina.jpg
publish_date: 2021-04-28 17:00:00 +0300
permalink: /posts/conhecendo-o-kafka-streams
---

O Apache Kafka se define como uma plataforma de Streaming. Isso é um conceito novo e desenvolvedores tem muita dificuldade de encarar esse conceito. Por isso vou tentar apresentar o Kafka Stream e como ele difere tanto arquiteturalmente quanto conceitualmente de outros tipos de aplicação.

# O que faz sua aplicação

A primeira coisa que pensamos quando vamos criar uma aplicação é m certas caixinhas: back-end, front-end e base de dados. Isso porque na maioria das aplicações há as operações de leitura e escrita de dados. São os famosos CRUDs. Temos que criar uma tela de consulta, uma de cadastro, etc... São variações do mesmo tema.

Mas há algumas situações em que se aplicarmos essa padrão arquitetural vamos encontrar um gargalo facilmente. Vamos supor que temos que criar uma aplicação para monitoramento de filas em um parque de diversões. Cada visitante tem uma pulseria que emite eventos e esses eventos são transformados em dados. Esses dados podem, desde alimentar dashboards para visualização do estado do parque, quanto para disparar outros eventos. Quem sabe se uma propaganda para um determinado brinquedo vazio for exibida para pessoas que estão dirigindo para um brinquedo com muita fila, não pode diminuir o tempo médio em filas. Aliás, todo que os visitantes querem é maximizar a diversão e minimizar o tempo em fila.

Mas construir essa aplicação, não demandaria muitos CRUDs. Na verdade seria muito poucos e muitos dados sendo processados. Provavelmente esses eventos fariam transformado a pontos de se criarem outras informações derivadas deles. Se formos criar isso como uma grande base de dados, além do trabalho gigantesco de criar essa lógica de negócios, teriamos grandes gargalos e muito acoplamento.

Esse é o caso de uso ideal para Apache Kafka. Porém muitos dos passos intermediários não seriam apenas produtores e consumidores, mas Streams.

# O que é um Kafka Stream

Um Stream Kafka é um microserviço que simplesmente transforma dados. Vamos modelar o caso de uso do nosso parque? Imaginemos que cada visitante gera um evento de posição, esse evento teria o identificador do visitante, sua geolocalização e um timestamp. A geolocalização pode ser descoberta facilmente com totens e triangularização. Vamos chamar esse evento de `VisitorPosition`, ele será emitido a cada movimento relevante do visitante.

```json
{
    "visitorId": 1245,
    "geo": {
        "lat": -41.1317611,
        "long": -71.330655
    },
    "timestamp": 1620429479
}
```

Seria muito difícil salvar esses eventos em uma base de dados para ser processado posteriormente. Esse evento deve ser processado imadiatamente e ser transformado em estatística. E é aí que entra o Streams! Cada Stream vai receber e processar esses eventos de forma distribuída.

_O que podemos entender por distribuída?_ Ora, não vamos ter que nos preocupar com balanço de carga ou tentar garantir que cada evento será processado apenas uma vez. Isso é responsabilidade do Kafka! Ao desenvolvedor caberá focar na transformação do dado e quero dizer um dado de cada vez.
