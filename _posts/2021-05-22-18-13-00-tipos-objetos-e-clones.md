---
title: Tipos, Objetos e Clones
published: true
description: Como Java lida com objetos e tipos primitivos? O que é Stack e Heap? O que seria passagem por valor e por referência? Existe isso em Java?
tags: [Java, Memória, Clone]
image: /assets/images/pexels-negative-space-169573.jpg
publish_date: 2021-05-22 18:13:00 +0300
permalink: /posts/tipos-objetos-e-clones
---


Existem algumas discussões em Java que não fazem sentido para quem não entende a forma como um programa lida com dados. Por exemplo, "valor" e "referência" são conceitos altamente relevantes em C/C++, mas não fazem nenhum sentido em Java. Nesse artigo, vou falar um pouco sobre copia por valor e referência e como clonar objetos em Java.

## Tipos primitivos e Objetos

Em Java objetos são basicamente a estrutura de dados mais comum. Por estrutura podemos entender que que é a forma como o dado é armazenado afim de facilitar o desenvolvimento. Assim temos sempre em um código tipos primitivos ou objetos.

_Mas como lidamos com eles?_

Para isso é preciso entender outros conceitos, a _Heap_ e a _Stack_. 

A _Heap_ é o espaço de memória onde os objetos existem. Todo objeto Java é criado dentro da _Heap_ e só irá existir uma única instância dele enquanto ele estiver sendo utilizado. Quando ele não for mais necessário, oo _Garbage Collector_ irá remover ele da _Heap_, mas não iremos tratar disso aqui.

A _Stack_ é onde a pilha de execução é definida. Esse não é só um conceito do Java, qualquer linguagem de programação tem uma pilha de execução, mas em Java a _Stack_ tem uma significância especial, pois é a partir dela que o _Garbage Collector_ irá defini que objeto da _Heap_ pode ser eliminado. _Stack_ significa pilha, e essa estrutura tem esse nome porque o seu comportamento é como uma pilha. Vamos supor que estamos executando um metodo `x`, e nesse método tem uma chamada para outro método `y`. Ao iniciar a execução de `y` um novo contexto é criado onde variáveis podem ser definidas e alteradas. Mas ao finalizar a execução de `y`, esse contexto é removido da pilha, retornando ao contexto anterior.

![Memória Heap](/assets/images/java/heap.png)

Assim, podemos dizer que tipos primitivos são definidos como uma posição de memória na _Stack_, enquanto objetos são definidos como referência a uma posição na _Heap_. 

Foi possível compreender? Mas quais são as implicações disso?

## Passagem por valor e por referência

Assim quando criamos contextos de execução novos, isso é, ou chamamos uma função ou executamos uma nova thread, alguns objetos podem ser compartilhados entre esses contextos. Vamos supor que estamos criando um usuário e temos alguns métodos que alteram o valor do usuário como `hashPassword` e `persist`. Assim podemos afirmar o código abaixo altera o valor do objeto `User`.

```java
User user = new User(/* id */ null, /* username */ "vepo", /* password */ "12345");
System.out.println(user); // User [id=null, username=vepo, password=12345]
hashPassword(user);       // user.password <- "827ccb0eea8a706c4c34a16891f84e7b"
persist(user)             // user.id       <- 1L
System.out.println(user); // User [id=1L, username=vepo, password=827ccb0eea8a706c4c34a16891f84e7b]
```

Nos dois métodos usados acima, podemos afirmar que o parâmetro User é usado como referência. Isso significa que qualquer alteração dentro da pilha de execução dos métodos irá alterar o valor fora do método.

_Isso acontece com valores primitivos?_ Não!

Quando falamos de valores primitivos em Java, nunca temos passagem por referência. Vamos supor que temos uma função que calcula um valor de `f(x)`, essa função altera o valor de `x`, logo ao chamar `f(x)`, o valor de x não será alterado no contexto que ele foi chamado.

```java
int x = 10;
int y = f(x);
System.out.println(x);  // 10
System.out.println(y);  // 50
```

Porque isso acontece? Porque esse valor é diretamente definido na _Stack_ e não há uma referência para ele.

Isso pode nos levar a dois questionamentos:

1. É possível fazer passagem por referência para tipos primitivos em Java?
2. É possível fazer passagem por valor para objetos em Java?

## Primitivos como Referência

Para responder a primeira pergunta, podemos supor algumas soluções. A primeira seria usar os objetos que encapsulam tipos primitivos (por exemplo, para `int` temos `java.lang.Integer`), mas essa solução não é válida porque esses valores são imutáveis. Eles foram criados para que outras estruturas que dependem da classe `Oject` pudessem referenciar tipos primitivos.

_Ora, o que é um objeto imutável?_ Um objeto imutável é um objeto em que seu estado interno não pode ser alterado. Ele reside na _Heap_, mas seu estado interno é protegido.

A segunda solução seria usar classes que implementam `java.lang.ref.Reference`. Mas essas classes também não resolvem o problema, pois essas classes foram criadas para permitirem controle da referência em relação ao _Garbage Collector_, que não está no escopo da nossa discussão agora. Essas classes são bastante úteis se você deseja criar uma referência fraca, ou saber quando um objeto é elegível para o _Garbage Collector_.

A última solução, e única possível, é usar as classes do pacote `java.util.concurrent.atomic`. Essas classes são um referência única e _thread safe_ para qualquer objeto ou tipo primitivo. 

```java
AtomicInteger x = new AtomicInteger(10);
System.out.println(x);  // 11
inc(x);
System.out.println(x);  // 11
```

Caso você não conheça essa classes, vale a pena fazer alguns exercícios com elas. Elas são bastante úteis para contextos onde é necessário uma referência do tipo `final` ou variáveis compartilhada entre várias threads. Como um exemplo da necessidade delas, quando precisavamos de algo similar no Java 4, era necessário criar um vetor com uma posição, assim era como ver código como:

```java
int[] resultado = new int[]{ 0 };  // Não faça isso. Nunca! 
Thread t = new Thread(new ThreadImpl(resultado));
t.start();
t.join();
System.out.println(resultado[0]); // Era a única forma de obter um valor antes do AtomicInteger.
```

## Objetos como valor

E para respondermos a segunda pergunta, não temos uma solução pronta na linguagem Java. Quando falamos de objetos sendo passado como valor, logos supomos que eles não são imutáveis. Mas ainda resta uma dúvida: em quais contextos precisamos passar um objeto como valor para um método? Aqui vou supor alguns contextos:

1. Operações ACID (_**A**tomicity, **C**onsistency, **I**solation, **D**urability_)
2. Contextos desconhecidos
3. Verificação de conteúdo

Quanto temos uma operação ACID, isso significa que o objeto em questão pode passar por uma série de modificações, mas elas só serão efetivadas caso a operação seja bem sucedida. Para isso é preciso manter o valor inicial do objeto, isso significa que toda operação será feita em uma cópia do objeto que depois poderá substituir o original. Essas operações são bem comuns em frameworks, mas normalmente não vamos implementações delas em código de negócio.

Já contextos desconhecidos, são contextos desconhecidos. 🤷‍♂️ Mas há uma forma de explicar... Vamos supor que temos uma aplicação que pode definir pontos de extensões, esses pontos vão ser definidos por usuários e podem ter várias definições. Se vamos ter código que podem ser carregados em tempo de execução que não temos o controle, as vezes pode ser bom garantir que os valores iniciais não são alterados. Principalmente quando esses pontos de extensão se comportam como ouvinte e não como devem alterar o valor inicial.

E por fim a verificação do conteúdo pode ser definida como um código que se deseja ver apenas o que foi alterado. Vamos supor que estamos implementando uma implementação do JPA, mas não desejamos alterar na base os valores não alterados durante a execução, assim o código abaixo não atualizaria todos os valores necessários, apenas aqueles que foram definitivamente alterados.

```java
User user = em.find(User.class, userId);                // User[id=10L, username=vepo, name=Victor Osório, roles=[USER]]
user.setUsername("vepo");                               // mesmo valor
user.setName("Victor Osório");                          // mesmo valor
user.setRoles(Arrays.asList(Role.USER, Role.ADMIN));    // Adicionando ADMIN
em.persist(user);                                       // INSERT INTO user_roles (user_id, role) values (10L, "ADMIN");
```

Ora, mas eu ainda não falei em como fazer uma passagem de valor usando a JVM, certo? Porque isso não é possível! Para isso é preciso clonar o objeto, e isso podemos sim fazer pela JVM. Vamos aqui enumerar as formas de se fazer um clone:

1. Programaticamente
2. Programaticamente usando `Object.clone`
2. Programaticamente usando `Object.clone` em classe `Cloneable`
3. Por reflexão

O primeiro método é o mais declarativo e de forma nenhuma orientada a objeto. O código deve copiar o objeto campo a campo, e isso deve somente acontece quando não tempos o controle sobre a classe a ser clonado. Essa solução, em geral, é péssima, pois é altamente acoplada, isso significa que qualquer alteração da classe sendo clonada, precisa refletir na classe que a está clonando.

```java
User clone = new User();
clone.setId(original.getId());
clone.setUsername(original.getUsername());
clone.setName(original.getName());
clone.getRoles(original.getRoles());
```

Quando temos o controle sobre a classe a ser clonada, devemos sobrescrever o metodos `clone`. Assim, podemos simplesmente fazer conforme o segundo método listado acima. Dessa forma termos o total controle sobre o método de clonagem e ele é encapsulado dentro da própria classe a ser clonada.

```java
public class User {
    // [...]

    @Override
    public User clone() {
        User clone = new User();
        clone.id = this.id;
        clone.username = this.username;
        clone.name = this.name;
        clone.roles = this.roles.clone();
        return clone;
    }
}
```

Uma outra maneira de se fazer um clone é usando a interface `Cloneable`. Apesar dessa interface não definir nenhum método, quando chamamos `super.clone()` para classes que a implementam, a JVM cria uma copia do objeto copiando campo a campo.

```java
public class User implements Cloneable {
    // [...]

    @Override
    public User clone() {
        try {
            return (User) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new RuntimeException("A classe implementa Cloneable?", e);
        }
    }
}
```

Essa implementação também tem seus desafios, um deles é que essa copia que a JVM faz é simples. Vamos supor que no caso do nosso usuário, se alterarmos o valor de roles, que é uma lista, esse valor seria alterado nos dois objetos. Isso acontece porque os valores são apenas copiados e não clonados, assim qualquer valor que não seja imutável será compartilhado entre ambas as instâncias. No caso, para termos controle sobre esse comportamente, é preciso abdicar da interface `Cloneable` e usar a implementação anterior. Outra desvantagem é, que usando essa implementação, o construtor da classe não é chamado, assim a JVM apenas copia os campos da classe.

```java
User original = new User(10L, "vepo", "Victor Osório", new ArrayList<>(Arrays.asList(Roles.USER, Roles.ADMIN)));
User clone = original.clone();
original.getRoles().add(Roles.EDITOR);
System.out.println(clone); // User[id=10L, username=vepo, name=Victor Osório, roles=[USER, ADMIN, EDITOR]]
```

Por último, podemos fazer o clone de uma classe usando Reflexão. Reflexão, ou _Reflection_, é a forma de se inspecionar um objeto em tempo de execução, é a API do Java que dá a possibilidade de se criar a grande maioria dos frameworks. Então usando reflexão, é possível criar uma nova instância da classe e copiar campo a campo. 

```java 
@SuppressWarnings("unchecked")
public static <T> T clone(T original) {
    try {
        T clone = (T) original.getClass().getDeclaredConstructor().newInstance();
        for (Field field : original.getClass().getDeclaredFields()) {
            if (!Modifier.isStatic(field.getModifiers())) {
                field.setAccessible(true);
                field.set(clone, field.get(original));
            }
        }
        return clone;
    } catch (InstantiationException | IllegalAccessException | IllegalArgumentException | InvocationTargetException
            | NoSuchMethodException | SecurityException e) {
        throw new RuntimeException("Não consigo clonar!", e);
    }
}
```

Com a implementação usando reflexão, podemos ter mais liberdade, não sendo necessário alterar ou implementar em cada classe seu método `clone`. A única penalidade é no tempo de execução. Por inspecionar a classe em tempo de execução, ela é mais demorada que a simples cópia dos campos.

## Possíveis tipos de clone

Para finalizar a nossa discussão, precisamos debater os tipos de clones que são possíveis. Logo de imediato podemos supor que existe dois tipos de clones, o _Shallow Clone_ e o _Deep Clone_. No primeiro apenas copiamos os valores de todos os campos do objeto a ser clonado, enquanto no segundo, precisamos verificar se um campo precisa se copiado ou clonado, caso necessário a clonagem, esta deve ser feito.

Para uma representação mais detalhada, vamos supor que cada campo é um nó de um grafo. Assim, ao se fazer o clone precisamos ou copiar o vertice ou a aresta. Quando fazemos o Shallow Clone, apenas copiamos os vertices, apontando para as mesmas arestas. Mas quando fazemos o Deep Clone, criamos uma nova aresta e apontamos o vertice para essa nova aresta.

![Deep Clone e Shallow Clone usando grafos](/assets/images/clones.png)

O Shallow Clone deve ser usado na maioria das vezes, pois não tem complexidade. Se decidirmos criar um clone usando o Deep é preciso algumas verificações. Como não conhecemos a natureza do objeto a ser clonado, deve ser feita uma verificação de unicidade e ciclos. O que isso significa? Quando falamos de unicidade, se temos dois campos apontando para um mesmo objeto, durante a operação de clone, esses dois campos devem apontar para o mesmo objeto clonado. Quando falamos de ciclo, devemos clonar os objetos verificando se não existem ciclos, caso um ciclo seja identificado, a clonagem deve ser interrompida e o mesmo objeto, que já foi clonado, deve ser usado.

O Deep Clone, na grande maioria das vezes, é usado através da serialização. Os objetos são serializados e depois lidos. Essa não é a melhor forma, pois todos os valores não primitivos devem implementar a interface serializer, tem uma péssima performance e há o grande risco dessa operação nunca terminar, caso exista um ciclo no grafo. Um exemplo pode ser encontrado no projeto [imixs/imixs-workflow](https://github.com/imixs/imixs-workflow/blob/master/imixs-workflow-core/src/main/java/org/imixs/workflow/ItemCollection.java#L219)

```java
/**
 * This method makes a deep copy of a single item value from a given source
 * ItemCollection. The method can be used in cases the item to copy represents a
 * complex data structure and can not be copied by reference. See also
 * deepCopyOfMap.
 * 
 * @param itemvalue
 * @return
 */
@SuppressWarnings("unchecked")
public void cloneItem(String itemName, ItemCollection source) {
    try {
        List<Object> sourceValue = source.getItemValue(itemName);
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(bos);
        // serialize and pass the object
        oos.writeObject(sourceValue);
        oos.flush();
        ByteArrayInputStream bais = new ByteArrayInputStream(bos.toByteArray());
        ObjectInputStream ois = new ObjectInputStream(bais);
        List<Object> copy = (List<Object>) ois.readObject();
        hash.put(itemName, copy);
    } catch (IOException | ClassNotFoundException e) {
        logger.warning("Unable to clone values of Item '" + itemName + "' - " + e);
    }
}
```

## Conclusão

Nesse pequeno artigo, discutimos desde o que é Tipos primitios e Objetos, até o que é a _Heap_ e a _Stack_. Com isso foi possivel analisar o que é passagem por valor ou por referência, conceitos que são fundamentais em linguagens como C, mas nem sempre são possíveis de se implementar em Java.

Por fim, vimos quando e como clonar objetos e quais são as possíveis forma de se clonar um objeto.