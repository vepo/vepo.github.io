---
title: Elegant Objects, vol. 1 - I
published: true
description: Primeiras impressões do livro Elegant Objects, vol. 1 
series: Primeiras Impressões
tags: [Orientação a Objetos, Programação, Design de Código]
cover_image: /assets/images/elegant-objects.svg
publish_date: 2021-08-16 11:11:00 +0300
permalink: /posts/elegant-objects-1
---

Faz no mínimo uns 4 anos que queria ler [Elegant Objects](https://www.elegantobjects.org/). O livro não é acessível ao povo de Pindorama* por causa das politicas economicas da última decada. Mas eu não quero discutir como o dolar alto faz bem para o agro-negócio e para quem quer fazer freela na gringa, e faz um mau danado pro resto inteiro do país. Mas esse ano tomei coragem e comprei! E depois encontrei ele baratinho num sebo... 🤦‍♂️

> **pindorama**
> [pindorama]
> SUBSTANTIVO
> 1. país ou região das palmeiras
> 2. nome que os ando-peruanos e populações indígenas pampianas dão ao Brasil

Ao abrir o livro já me deparo com o impacto que ele teve na comunidade. Talvez você não saiba diretamente, mas ele resume muito do que mudou em Orientação a Objetos nos últimos anos. Não sei dizer se ele é a origem dessas novas ideias, mas é uma fonte confiável de como podemos pensar os objetos.

O livro também inova por ser multimeios, enquanto você lê ele no papel (_eu gosto de papel, me julgue!_), você pode ler mais conteúdo no blog. 

Nesse post, vou fazer um pequeno resumo do capítulo colocando o link do blog. Se você conhecer um pouco de inglês, pode tentar ler no original. 

# Objetos e Construtores

O primeiro capítulo vai procurar discutir como usar construtores e objetos. Quais seriam as regras de boas práticas a se fazer um construtor? Como podemos otimizar um construtor? É um capítulo curto.

Objetos são seres vivos. Eles tem um ciclo de vida e devem ser antropomorfizados. Por isso o autor chama objetos de ELE. Calma lá! Ele coloca objetos no masculino para não falar mau de algo no feminino. É irônico nessa hora, porque ele crê que objetos devem ser culpados de muitas coisas e para fazer isso sem ser injusto deve falar do próprio genero. 

Assim, se nós não entendemos o que um objeto sigifica ou qual o papel dele, a culpa é do objeto. Vai na conta do objeto ser de fácil entendimento, ele deve ter manutenibilidade. 

O primeiro ponto a ser levado em conta é a natureza da classe. As vezes se diz que uma classe é um template de um objeto. Na verdade a classe é a essência do objeto. Ela quem cria os objetos e define o seu comportamento. Assim quando for criar uma classe, ela sempre deve ser nomeada por aquilo que ela representa e não aquilo que ela faz ([Don't Create Objects That End With -ER](https://www.yegor256.com/2015/03/09/objects-end-with-er.html)).

Um exemplo do que está sendo dito pode ser descrito pela classe abaixo:

```java
public class CashFormatter {
    private int dollars;
    public CashFormatter(int dlr) {
        this.dollars = dlr;
    }

    public String format() {
        return String.format("$ %d", this.dollars);
    }
}
```

Ora, a classe acima é nomeada pelo seu comportamento, mas ela acaba sendo limitada por ele e não consegue nem entregar a funcionalidade completa, pois acaba se limitando a formater em dolares apenas. Essa classe pode ser extendida para representar algo e seus métodos podem representar o comportamento.

```java
public class Cash {
    private int dollars;
    public Cash(int dlr) {
        this.dollars = dlr;
    }

    public String usd() {
        return String.format("$ %d", this.dollars);
    }
}
```


Outro ponto a ser levado em conta é a natureza do construtor. O que é um construtor? Na verdade um construtor é nada mais do quem um [Factory Method](https://refactoring.guru/pt-br/design-patterns/factory-method) de um tipo de objeto só, assim podemos ser muito mais expressivos criado Factory Methods em alguns casos. 

Java possibilita o overload de construtor. Isso significa que uma mesma classe pode ter inúmeros construtores com parâmetros diferentes. Eu pessoalmente não gosto dessa abordagem, porque não é intuitivo, prefiro usar métodos estáticos para inicializar tornando todos os contrutores privados. Mas o autor defende que deve haver apenas um construtor primário por outros motivos ([There Can Be Only One Primary Constructor](https://www.yegor256.com/2015/05/28/one-primary-constructor.html)). Para ele é mais fácil dar manutenção a um código onde todos os construtores fluem para apenas um, como o exemplo abaixo.

```java
public class Cash {
    private int dollars;

    public Cash(float dlr) {
        this((int) dlr);
    }

    public Cash(String dlr) {
        this(Cash.parse(dlr));
    }

    public Cash(int dlr) {
        this.dollars = dlr;
    }
}
```

E por fim, construtores não deve ter código, somente a inicialização das variáveis. No subtópico [Constructors Must Be Code-Free](https://www.yegor256.com/2015/05/07/ctors-must-be-code-free.html), ele defende que construtores sem código são melhores por dois motivos. O primeiro é que a JVM pode otimizar a criação do objeto. E o segundo é que todo processamento pode ser procrastinado até quando for necessário. Vamos ver um exemplo usando a classe `Cash`?

```java
public class Cash {
    private Number dollars;
    public Cash(Number dlr) {
        this.dollars = dlr;
    }

    public String usd() {
        return String.format("$ %d", this.dollars.intValue());
    }
}
```

Para que essa classe aceite valores em `String`, podemos criar a classe `StringAsInteger`.

```java
public class StringAsInteger implements Number {
    private String text;
    public StringAsInteger(String txt) {
        this.text = txt;
    }

    public int intValue() {
        return Integer.parseInt(this.text);
    }
}
```

Assim ao usar um parâmetro `String`, esse só será parseado quando necessário. No exemplo, ele pode até ser parseado mais de uma vez, se tornando não ótimo, mas é apenas um exemplo. Em códigos da vida real, um cache pode ser implementado.

```java
Cash cash = new Cash(new StringAsInteger("5"));
cash.usd();
```

# Conclusão

O primeir capítulo conclui que objetos devem ser antropomorfizados, fazendo isso vamos melhorar o entendimento do seu funcionamento. Classes são a essência do objeto. Construtores são Method Factories para objetos de uma classe, devem não ter código e por fim devem sempre ser direcionado a apenas um.