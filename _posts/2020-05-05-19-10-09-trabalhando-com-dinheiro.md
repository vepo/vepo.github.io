---
title: Trabalhando com dinheiro!
permalink: /posts/trabalhando-com-dinheiro
published: true
description: Todo sênio deve saber lidar com valores monetários em seu código. Não sabe? Tem ensino! 😀
tags: [Java, Floating Point, Money, Beginners]
series: Coisas que todo Sênior deve saber
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/bk2r12dz9vix7ya9ee2f.jpg
publish_date: 2020-05-05 16:10:09 +0300
original: https://dev.to/vepo/trabalhando-com-dinheiro-52g1
---

Ninguém nasce Sênior, se torna Sênior! 

Se tornar um Sênior é um processo demorado, e requer muito suor. Como o mercado de computação tem se expandido exponencialmente, resolvi começar uma série de posts rápidos sobre tudo que um Sênior deve saber. Vamos ao primeiro....

# Como lidar com dinheiro?

Quando vamos modelar um Objeto ou qualquer outro domínio, sempre imaginamos o tipo de dado antes mesmo de começar a escrever o dado. 

Sabemos que nome é [String](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/String.html), sobrenome é String, data de nascimento é um [Date](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Date.html), data de ativação será um [long](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/System.html#currentTimeMillis()), ou [Timestamp](https://docs.mongodb.com/manual/reference/bson-types/#timestamps). Podemos até, em algumas linguagens ter dúvida se usamos um [Date ou Datetime](https://dev.mysql.com/doc/refman/8.0/en/datetime.html). Mas tudo isso depende da linguagem escolhida, certo? 

Errado!

Tudo depende da forma como o valor é armazenado em bytes. Sim! Você acha que existe um valor inteiro? Ou string? Não, existem bytes! Somente bytes! E esses valores são representados em bytes. Um inteiro por exemplo são 4 bytes alinhados. Assim um inteiro 0 é 00000000 00000000 00000000 00000000. Em Java um short 0 é 00000000 00000000. Fácil? Nem tanto...

Lembra dos [conjuntos numéricos da matemática](hhttps://pt.wikipedia.org/wiki/N%C3%BAmero#Conjuntos_num%C3%A9ricos)? Pois bem, números inteiros são fáceis, agora e os outros?

Quando eu preciso de um valor não exato, um float por exemplo? Sabe como é armazenado? Usando a notação _[floating point](https://pt.wikipedia.org/wiki/V%C3%ADrgula_flutuante)_.

Então qualquer valores de dinheiro devem ser guardados em Float, certo? 

Errado!

Vamos olhar bem de perto algumas operações do float ou double.


![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/sf352axsulk7dvwb1lsp.png)

Entendeu porque `2.01 + 2.01 + 2.01 + 2.01 + 2.001 = 10.040999999999999`? E não `‭10.041‬`? 🙄🙄🙄

## Float Point precision problem

Sim, esse é um erro bastante conhecido. Você pode pesquisar por ele na internet. Ele aparece quando são feitas várias operações com Floating Point. 

Já vi ocorrer em sistemas em produção. Era um sistema de controle de estoque e compras. Havia várias ordem de compras, mas o valor vendido não batia com o caixa. Esse erro se deu em uma conta simple com 5 valores. Agora e se tivessemos 5.000 valores?

Vamos ver... E se somassemos `5.000` vezes `2.01`? Deveria dar `10.050`.

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/hz8c16fl3d4gg0bifxp5.png)

Opa! Tivemos um erro de `0,676`! 😮😮😮😮😮

## Solução em Java

Mas vamos com calma. Em Java esse problema foi resolvido com a criação da classe `BigDecimal`. 

Nenhuma operação monetária deve ser feita com `float` ou `decimal` em hipotese alguma. Esse valores devem ser lidos como [BigDecimal](https://docs.oracle.com/javase/7/docs/api/java/math/BigDecimal.html). 

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/mqsny7pz70a1tglj2pms.png)

### Fique Atento

1. Se esse valor for instanciado com um `double` ou `float` irá herdar a imprecisão do valor original.
2. Essa classe é imutável, então fique atento. Se você chamar os metodos, não irá alterar o valor da instância, apenas criar uma nova!


![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/e7822k278vxr9gdeyc0p.png)

# Conclusão

Guarde pra vida toda. Nunca armazene valores monetários em `double` ou `float`. Não importa a linguagem ou base de dados que você está usando.

Caso não saiba como resolver esse problema. Não se preocupe é normal. Amanhã vai surgir uma linguagem nova ou uma base de dados nova e 99,99999% dos desenvolvedores não sabaerão também. [Pesquise no Google](http://letmegooglethat.com/?q=cobol+floating+point+precision).
