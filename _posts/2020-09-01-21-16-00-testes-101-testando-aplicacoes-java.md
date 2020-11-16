---
title: Testes 101 - Testando aplicações Java
published: true
description: Um guia rápido para tudo o que você precisa saber para fazer testes em aplicações Java
tags: [Java, Testes, TDD, JaCoCo]
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/36whvqvlgpj79iy7lzmc.jpg
series: Level Up
publish_date: 2020-09-01 21:16:00 +0300
original: "https://dev.to/vepo/testes-101-testando-aplicacoes-java-1m8i"
---

Testes são fundamentais. Se você deseja ser desenvolvedor Java lhe recomendo pelo menos conhecer o que são TDD, Maven e JUnit. E vou te apresentar o porque.

# TDD

TDD significa Test-Driven-Development. Se você imagina que é criar o testes e depois o código, você está um pouco enganado. TDD é uma disciplina um pouco diferente.

TDD é uma disciplina, não é algo que pode ser explicado. É uma cultura que você tem que aprender, e treinar. Depois de anos você vai ver já melhorou bastante, mas tem muito mais a aprender.

## Ciclos do TDD

Pra explicar o TDD facilmente, temos que falar dos ciclos. Nem todos os testes criados serão usados e eles não devem refletir o requisito final. Você tem que usar **Baby Steps**, passos de bebê, em cara ciclo. Imagine um ciclo como um rodada de desenvolvimento de 10 a 30 minutos: 

* **[R]** Você cria um Test, ele deve falhar.
* **[G]** Você implementa o código para o teste funcionar
* **[R]** Você Refatora o código

![Ciclo RGR](https://dev-to-uploads.s3.amazonaws.com/i/pfjgroqac0hnojyt7vmj.png)

Ao final de um tempo de desenvolvimento você terá vários testes. Alguns podem ser descartados, outros vão ficar. Eu recomento ficar apenas os que representem a funcionalidades do código. E recomendo também que cubram o máximo possível o seu código.

# Maven

Se estamos falando de testes, estamos falando de Processo de Build. Se você cria os seus testes e não os colocar para serem executados automaticamente, você não fez praticamente nada. 

O Maven abstrai cada build criando um ciclo com fases. Então os testes sempre serão executados se você deseja executar ou empacotar o seu projeto.

Para criar um projeto usando Maven, instale o Maven e execute:

```bash
mvn archetype:generate -DgroupId=io.vepo.tests -DartifactId=testsExample -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=true
```

Você vai observar duas coisas: 
* o Maven criou um arquivo pom.xml colocando como dependência o JUnit, e que versão antiga! 🙄
* o Maven criou duas pastas de código: `src/main/java` e `src/test/java`.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>io.vepo.tests</groupId>
  <artifactId>testsExample</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>testsExample</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>
```

![Estrutura de diretório](https://dev-to-uploads.s3.amazonaws.com/i/g21r9j3qm38eh6eh95cd.png)

Mas onde o Maven configura que os testes devem ser executados durante a build ou como ele descobre os testes? O Maven se baseia na ideia convention-over-configuration, ou seja, Convenção acima de Configuração. Para realizar certas configurações basta apenas usar a convenção apropriada. 

O projeto criado já vem com alguns testes JUnit configurado, porém é usado a versão `3.8.1`... Alguém por favor atualiza o [github.com/apache/maven-archetypes](https://github.com/apache/maven-archetypes), por favor!

# JUnit 5

O JUnit é o framework que irá gerenciar o ciclo de vida de seus testes. Cara classe dentro de `src/test/java` contendo um método com a annotation [`org.junit.jupiter.api.Test`](https://junit.org/junit5/docs/current/api/org.junit.jupiter.api/org/junit/jupiter/api/Test.html) será executado como testes. Assim para migrarmos o arquivo gerado automaticamente, basta mudar o seguinte conteúdo:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>io.vepo.tests</groupId>
  <artifactId>testsExample</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>testsExample</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-engine</artifactId>
      <version>5.5.2</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <plugins>
        <!-- Need at least 2.22.0 to support JUnit 5 -->
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>3.0.0-M3</version>
        </plugin>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version>
            <configuration>
                <source>1.8</source>
                <target>1.8</target>
            </configuration>
        </plugin>
    </plugins>
</build>
</project>
```

```java
package io.vepo.tests;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

public class AppTest 
{   
    @Test
    @DisplayName("Test if it works")
    public void simpleTest() {
        assertEquals("OK", "OK");
    }
}
```

Observe que com o JUnit 5 eu consigo dar nomes aos testes, isso facilita em muito a identificação de um erro. Eu costumo usar frases que definem as features testadas. Isso facilita quando preciso fazer manutenção em código escrito meses, ou anos, antes.

## Ciclo de Vida

O ciclo de vida de um teste passa pela execução métodos antes/depois da classe ser criada e métodos antes/depois da execução de cada teste. Dê uma olhada na [documentação](https://junit.org/junit5/docs/current/user-guide/#writing-tests-classes-and-methods). Há vários exemplos de como usar [@BeforeAll](https://junit.org/junit5/docs/current/api/org.junit.jupiter.api/org/junit/jupiter/api/BeforeAll.html), [@BeforeEach](https://junit.org/junit5/docs/current/api/org.junit.jupiter.api/org/junit/jupiter/api/BeforeEach.html), [@AfterEach](https://junit.org/junit5/docs/current/api/org.junit.jupiter.api/org/junit/jupiter/api/AfterEach.html) e [@AfterAll](https://junit.org/junit5/docs/current/api/org.junit.jupiter.api/org/junit/jupiter/api/BeforeAll.html).

Se eu for detalhar cada feature do JUnit 5, esse post não terá fim. São muitas, conheça elas, assim você pode construir bons testes.

## Asserções

O mais importante do JUnit não é apenas a execução dos testes, mas a validação dos resultados.

O JUnit provê uma classe com métodos estáticos para realizar isso. Na [documentação oficial](https://junit.org/junit5/docs/current/user-guide/#writing-tests-assertions) há vários exemplos.


```java
@Test
void standardAssertions() {
    assertEquals(2, calculator.add(1, 1));
    assertEquals(4, calculator.multiply(2, 2),
            "The optional failure message is now the last parameter");
    assertTrue('a' < 'b', () -> "Assertion messages can be lazily evaluated -- "
            + "to avoid constructing complex messages unnecessarily.");
}
```

# Tests DSL

DSL significa _Domain-Specific Language_. Você cria uma DSL seu código pode ser lido como uma linguagem. Em testes é comum se construir uma DSL usando os termos [Given-When-Then](https://www.agilealliance.org/glossary/gwt). Você pode fazer isso em português Dado-Quando-Então:

* (**Dado**) Qual o contexto que o teste é executado?
* (**Quando**) Qual ação vai ser testada?
* (**Então**) O que deve ser validado?

Um bom exemplo pode ser:

```java
dadoNovoUsuário()
    .executaChecking()
        .validaReserva();
```

Aí fica de você implementar cada método e reutilizar ele quando possível.

## AssertJ

Há algumas bibliotecas que auxiliam na construção dessa DSL. Eu gosto muito da [AssertJ](https://assertj.github.io/doc/). Com ela é possível usar uma DSL para validação de resultados complexos. 

```java
// extracting multiple values at once grouped in tuples
assertThat(fellowshipOfTheRing).extracting("name", "age", "race.name")
                               .contains(tuple("Boromir", 37, "Man"),
                                         tuple("Sam", 38, "Hobbit"),
                                         tuple("Legolas", 1000, "Elf"));
```

# Mocks

Mock significa Imitação. Imagina no caso de estarmos acessando uma base de dados. Você tem duas opções, ou liga a base de dados e testa diretamente nela, ou você mocka o acesso a base. O problema da primeira abordagem é que ela torna o teste mais abrangente. Não estaremos fazendo um Teste Unitário, mas um Teste de Integração.

Não há problema em fazer Testes de Integração, mas eles serão muito mais lentos. Outro problema é que muitas vezes você não precisa testar uma base de dados. Mas as vezes é bom testar a integração, sempre evita um NullPointerException! ☠️

Há algumas boas bibliotecas para Mock, vou falar um pouco do [Mockito](https://site.mockito.org/) e [PowerMock](https://github.com/powermock/powermock)

# Mockito

Mockito serve para criar classes onde o código original pode ou não ser executado. 

Quando você quer executar o código orignal, estamos falando de um spy. O código é executado e você pode validar o que foi feito.

Um Spy pode ser criado usando [`Mockito.spy`](https://javadoc.io/doc/org.mockito/mockito-core/latest/org/mockito/Mockito.html#spy) ou usando o Jupiter Extension para o JUnit 5.

```java
@Test
@DisplayName("Testa o exemplo de Mock para UserRepository")
public void addUserInMemoryTest() {

    User userWithoutId = new User();
    userWithoutId.setEmail("vepo@vepo.com");
    userWithoutId.setUsername("vepo");

    assertThat(userRepositoryInMemory.add(userWithoutId)).hasFieldOrPropertyWithValue("id", 1L);

    verify(userRepositoryInMemory).add(userWithoutId);
}
```

Observe que um Spy serve para verificar se o método foi chamado com um valor especifico. Ou seja, precisamos ter uma implementação concreta da classe.

Agora quando falamos de Mocks não precisamos de implementações concretas. Podemos usar em interfaces. Quando é criado um mock, o código real não é chamado, são sempre retornados valores vazios ou nulls. Então é preciso definir o que será retornado e quando.

```java
@Test
@DisplayName("Testa o exemplo de Mock para UserRepository")
public void addUserTest() {
    User userWithoutId = new User();
    userWithoutId.setEmail("vepo@vepo.com");
    userWithoutId.setUsername("vepo");

    User userWithId = new User();
    userWithId.setId(1L);
    userWithId.setEmail("vepo@vepo.com");
    userWithId.setUsername("vepo");
    
    when(userRepository.add(userWithoutId)).thenReturn(userWithId);
    
    assertThat(userRepository.add(userWithoutId)).hasFieldOrPropertyWithValue("id", 1L);
}
```

# Cobertura de Testes

As coisas não andam se não tivermos estatisticas! Então para testes, precisamos saber com exatidão qual é a cobertura de testes do nosso projeto. Se não colocarmos isso em prática, muito rapidamente a cobertura irá cair e nem perceberemos.

Uma ferramenta para gerar um relatório de cobertura é o [JaCoCo](https://www.jacoco.org/jacoco/)

Para configurar o JaCoCo no Maven, basta adicionar ele como um plugin e configurar quando será executado.

```xml
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.8.1</version>
    <executions>
        <execution>
            <id>prepare-agent</id>
            <goals>
                <goal>prepare-agent</goal>
            </goals>
        </execution>
        <execution>
            <id>report</id>
            <phase>test</phase>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

Depois para executar: 

```bash
mvn clean test jacoco:report
```

![Relatório de Tests](https://dev-to-uploads.s3.amazonaws.com/i/tlsl5nnyppc2ikfbzr6v.png)

No caso será gerado um relatório. Esse relatório pode ser armazenado no Jenkins ou mesmo usado pela próxima ferramenta que vamos ver.

# Code Smells

Antes de partir para última ferramenta, vamos definir uma coisa.

**Code Smells** são construções que podem trazer má qualidade ao código. Eliminando eles, você pode melhorar a qualidade do seu código.

# Análise Estática de Código

Como última ferramenta, vamos falar de Análise Estática de Código. Imagina se você pudesse analisar o seu código e encontrar bugs ou Code Smells. Seria bom, não?

Mas temos isso e de graça. Você pode usar o [SonarQube](https://www.sonarqube.org/). Com esse plugin para o Maven você pode criar um servidor para armazenar a qualidade atual do seu código e construir uma timeline dele. Assim você pode desafiar o time a reduzir o número de Code Smells em 50%. Ou em aumentar a covertura de testes até um determinado patamar.

Para integrar no Maven, basta colocar:

```xml
<plugin>
    <groupId>org.sonarsource.scanner.maven</groupId>
    <artifactId>sonar-maven-plugin</artifactId>
    <version>3.7.0.1746</version>
    <executions>
        <execution>
            <phase>verify</phase>
            <goals>
                <goal>sonar</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

Ao adicionar o plugin, crie o projeto no Github e já inicialize ele no [SonarCloud](https://sonarcloud.io). Ao iniciar um projeto, você pode pegar um Token que deve ser usado na build.

```bash
mvn -Dsonar.login=<SONAR_TOKEN> verify sonar:sonar
```

Caso queira rodar o [Sonar](https://www.sonarqube.org/downloads/) em projetos internos da sua empresa, você só precisa de um servidor e uma instalação do Sonar. É simples de configurar.

# Tudo Junto

Agora vamos responder a última pergunta. Quem vai rodar tudo isso? Você pode configurar algumas ferramentas. Entre elas podemos citar:

| Ferramenta | Contexto |
|------------|----------|
| Jenkins | Para rodar projetos internos. Não é um serviço cloud. |
| Github Actions | Excelentes para projetos Github. |
| TravisCI | Could e facilmente integrado com o Github. |

# Conclusão

Testes são fundamentais e você não precisa saber fazer antes de começar a desenvolver. MAS... Se você souber criar testes, seu código terá muita estabilidade. 

Treine fazer testes. Treine TDD. Conheça as ferramentas e boa sorte!

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/36whvqvlgpj79iy7lzmc.jpg)
