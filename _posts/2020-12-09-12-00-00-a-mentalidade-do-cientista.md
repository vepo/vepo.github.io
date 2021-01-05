---
title: A Mentalidade do Cientista
permalink: /posts/a-mentalidade-do-cientista
published: false
description: Como vai o seu código? Exitem formas de melhorar ele? Será que sua empresa se preocupa com isso também?
tags: [Desenvolvimento de Software, Backend, Linguagem de Programação, Qualidade de Código]
cover_image: /assets/images/pexels-negative-space-169573.jpg
series: Backend Roadmap
publish_date: 2020-12-08 23:00:00 +0300
---

Creio que uma das palavras mais faladas em 2020 foi _Mindset_. Eu me recuso a usar ela! Não porque ela não tem sentido, mas muito pelo contrário, ela tem muito sentido e pode ser muito útil. Mas nós temos modos de se expressar em Português que não precisam dessa palavra. E é sobre isso que vamos falar, **Mentalidade**. Um desenvolvedor Backend tem que ter a **Mentalidade de um Cientista** ao olhar para o seu produto do trabalho.

# Como não pensar...

É comum aos desenvolvedores de primeira viagem sair testando as coisas pra ver como elas funcionam. Se você faz isso, pode ficar calmo, todos o fazem. É normal você querer brincar com um novo framework, ou uma nova linguagem. O que você não pode fazer é se dar por satisfeito ao conseguir ver o _**"Hello World"**_ na tela.

Tentativa e erro é algo válido, mas em circustâncias muito limitadas. Pode ser usado quando você não tem a absoluta ideia do que deve fazer. Ou quando você está cansado e seus neurônios não estão funcionando. Ou quando você tem um problema de escopo limitado e respostas mapeadas. Vamos focar nessa para explicar.

Eu chamaria de **"Problema de Escopo Limitado"** qualquer problema que você tenha que já tem suas fronteiras e requisitos bem definidos. Vamos supor que você esteja escrevendo uma função para definir se um Aluno é elegível ou não para uma bolsa. Entre os requisitos está lógicas booleanas bem complexas como: "_Ele deve ser de familia de baixa renda (inferior R$2.500,00/mes) ou ser arrimo de familia com renda inferior a R$3.000,00, deve ter menos de 23 anos e não ter nenhuma nota inferior a 5_". Ao escrever essa função, você consegue criar algumas personas e imagina o resultado que vai dar. Por exemplo: "_Lucas é arrimo de familia, mas ganha R$ 3.570,00 por mês, logo não deve receber bolsa_", "_Maria é de uma familia com renda de R$ 2.499,00, logo é eligível pela renda, mas tirou 3 em Lógica de Programação_" ou "_Silvia é de uma humilde com renda de R$2.000,00 e todas a notas acima de 7, logo pode receber a bolsa_".

Vejam que os três casos podem ser mapeados em Casos de Testes, onde a função pode retornar `true` ou `false` para se ele é elegível para a bolsa ou não. Criando essas personas você pode, dentro dessa função verificar ajustar os parâmetros e ver se as condições estão sendo atendidas.

Mas... Observe que antes de sair fazendo a tentativa e erro, você precisa mapear todas as condições que devem ser supridas. Não dá pra fazer irracionalmente, mas se colocarmos testes, dá pra fazer com mais facilidade. Você reduziu o escopo do seu teste e criou casos de usos onde consegue validar cada condição.

# Como um Cientista Pensa?