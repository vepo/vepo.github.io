---
title: Como criar uma linguagem usando ANTLR4 e Java
published: true
description: Nesse post ensinarei como criar uma linguagem, não de programação, usando ANTLR4 em Java.
tags: [Java, Parser, ANTLR4, Tutorial]
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/uy5s6zeks2rt6gmyni63.png
publish_date: 2020-04-13 20:44:31 +0300
comments: true
original: "https://dev.to/vepo/como-criar-uma-linguagem-usando-antlr4-e-java-56g2"
---

Ao desenvolver qualquer ferramenta, você topará com a ingrata tarefa de escrever um parser. Usei o termo ingrata porque a principio pode parecer fácil, mas depois você verá que é bem complicado.

O problema na maioria das vezes não é o parser, mas a infinidade de possibilidades que surgem ao se propor uma solução tão aberta a ponto de precisar de uma linguagem.

# Antes do Parser

Para se precisar de um parser é primeiro necessário um problema que se precisa de uma linguagem. Temos dois tipos de linguagem em computação: Linguagem Formal e Linguagem Natural.

Parsers resolvem o problema de se compreender uma Linguagem Formal, mas precisamos entender o que é cada uma.

## Linguagem Natural

Vamos primeiro iniciar pela que aprendemos primeiro. Linguagem Natural é a que estamos tentando ensinar para o meu filho de 1 ano e meio 👶. Devido a uma exposição a telas, ele acabou desenvolvendo outras linguagens antes da qual será a principal em sua vida. Ele já compreende o português, compreende algumas músicas, consegue cantarolar.... Mas não consegue falar ainda. Só o papai e mamãe, mas ainda não associa a fala dele as coisas. Ele associa o som nosso as coisas. Bizarro não? 

Mas essa é a forma de compreensão nossa. Temos sons, falas, fonemas, etc... Eles existem apesar da gramática. A gramática serve como base, serve para criar uma linguagem comum onde todos podemos ser compreendidos.

Em uma linguagem natural, ela já existe antes de uma gramática. A gramática vem para normalizar ela. 

Temos inúmeras Linguagens Natural no mundo: 
* Música ➡️ Partituras
* Fala ➡️ Português, Inglês, Espanhol, etc....
* UX ➡️ Aplicativo Mobile, Aplicativo Web, etc...

Há inúmeras formas de Linguagem Natural, se formos analisar filosoficamente, uma _**Linguagem Natural** é qualquer formas de símbolos gerados e consumidor conscientemente por humanos_. 

Quer saber como processar uma Linguagem Natural. Procure por [RNN ou LSTM](https://towardsdatascience.com/natural-language-processing-from-basics-to-using-rnn-and-lstm-ef6779e4ae66).

## Linguagem Formal

Apesar de usar a mesma palavra, uma **Linguagem Formal** ela é completamente diferente de uma **Linguagem Natural**. Uma Linguagem Formal tem um fim especifico, seja ele dar ordens a uma máquina ou a troca de informações entre sistemas. 

Agora não sei se você percebeu a principal diferença: _**Linguagens Formais são feitas para serem compreendidas por Máquinas**_.

Você pode ter a fé que for em Tecnologia, mas a grande diferença é que nunca existirá um **Guimarães Rosa** da computação, pois Linguagens Formais não aceitam neologismos. Ou a linguagem segue estritamente ao binômio gramática e sintaxe, ou ela não é compreendida. Um compilador não entende aquilo que é fora do que já conhece.

Tá, e quais são as Linguagens Formais conhecidas:
* C
* C++
* Java
* XML
* brainfuck!!! _Um dia aprenderei brainfuck!!!_

Segue o Hello World em brainfuck:
```brainfuck
+[-[<<[+[--->]-[<<<]]]>>>-]>-.---.>..>.<<<<-.<+.>>>>>.>.<<.<-.
```

# A Necessidade

Tá, mais porque vou precisar de uma nova linguagem? Bom, antes disso é preciso de uma necessidade. Eu acabei desenvolvendo uma em casa nos últimos dias como um exercício. A necessidade era: em uma reunião, todos odeia o JMeter.

A razão de todos odiarem o JMeter era óbvia, o JMeter usa o XML como Linguagem e XML é apenas uma Linguagem para armazenar informações, ela não é desenvolvida para se processar testes. 

Então fiz esse exercício: Como seria uma Linguagem de Testes?

**Observação**: Esse é um exercício e existem outras linguagens para Testes. Mas poucas substituem o que o JMeter faz...

# Criando o Parser

A partir desse ponto, irei me referir a essa linguagem que estou desenvolvendo como **PlainTest**.

## Imaginar

O primeiro passo para se projetar uma Linguagem Formal é imaginar uma gramática básica. 

Para a **PlainTest**, eu imaginei duas unidades básicas: 

* A **Suite**: É um agrupamento ordenado de passos ou suites. Serve como agrupamento lógico. Seria o _CriarUsuário_.
* O **Step**: É a únidade básica do Teste, ou seja a realização dele. Executar um comando, enviar uma Request HTTP, etc...

Segue o meu primeiro exemplo de **PlainTest**:

```
Suite UserTest {
    HTTP CreateUser {
        url   : "http://127.0.0.1"
        method: "POST"
        body  : """
                   {
                       "id": 123,
                       "firstName": "John",
                       "lastName" : "Doe"
                   }
                """
        assert responseCode Equals 200
    }
}
```

## Extrair

Imaginada a gramática, é preciso extrair dela algumas informações: seu léxico e sua gramática. Para isso precisaremos de uma Linguagem Formal, e por isso escolheremos o [ANTLR4](https://www.antlr.org/). O ANTLR4 tem uma gramática própria onde o desenvolvedor pode declarar a gramática e o léxico da sua linguagem.

## Léxico

Vamos definir grosseiramente o Léxico, ou Tokenização, como a identificação de cada elemento da Linguagem.

Assim podemos definir na nossa linguagem:
* Reserved Words: `Suite`, `assert`
* Identifier: Serve para identificar elementos
* Número: sim, um número....
* String: sim, uma string...
* MultilineString: String definida por `"""` e que não necessita _escapes_.

Para definir um [Token](https://github.com/antlr/antlr4/blob/master/doc/lexicon.md#identifiers) em ANTLR4, é preciso definir um identificar com letra maiúscula:


```g4
grammar TestSuite;

STRING : DQUOTE (ESC | ~["\\])* DQUOTE;

VERB: 'Contains' | 'Equals';

IDENTIFIER: [A-Za-z] [._\-A-Za-z0-9]*;

NUMBER: '-'? INT '.' [0-9]+ EXP? | '-'? INT EXP | '-'? INT;

fragment DQUOTE: '"';

fragment ESC: '\\' (["\\/bfnrt] | UNICODE);

fragment UNICODE: 'u' HEX HEX HEX HEX;

fragment HEX: [0-9a-fA-F];

fragment INT: '0' | [1-9] [0-9]*; // no leading zeros

fragment EXP: [Ee] [+\-]? INT; // \- since - means "range" inside [...]

// Just ignore WhiteSpaces
WS: [ \t\r\n]+ -> skip;
```
Na gramática acima definimos apenas alguns tokens. Observe que existem Tokens e fragmentos. No ANTLR4, o _fragment_ deve ser usado porque um identificador não aceita ser composto por identificadores, ele deve ser composto por algo similar a um Regex e fragmentos.

## Sintático

Quando me refiro a Sintático em ANTLR4, estou falando da gramática em si, as regras. No nosso caso iremos criar os seguintes valores:

* Suite: Composto por Suites e Steps 
* Step: Unidade básica do test
* Attribute: Um par de Chave/Valor
* Assertion: Um par de Chave/Valor
* Value: Um valor que pode ser de Attribute ou Assertion.

Cada regra dessa será uma [Parser Rule](https://github.com/antlr/antlr4/blob/master/doc/parser-rules.md#parser-rules) na gramática do ANTLR4. Na definição da gramática elas são diferenciadas pela primeira letra. O Léxico é maiúscula, enquanto o Sintático é minúsculo. Posteriormente veremos a diferença na prática.

Segue o exemplo de como ficaria nossa Suite definida:

```g4
grammar TestSuite;

suite:
	'Suite' IDENTIFIER '{'
		(suite | step)* 
	'}'
;

step:
	IDENTIFIER IDENTIFIER '{'
		(assertion | attribute)* 
	'}'
;

assertion: 'assert' IDENTIFIER VERB value;

attribute: IDENTIFIER ':' value;

value: NUMBER | STRING;

STRING : DQUOTE (ESC | ~["\\])* DQUOTE;

VERB: 'Contains' | 'Equals';

IDENTIFIER: [A-Za-z] [._\-A-Za-z0-9]*;

NUMBER: '-'? INT '.' [0-9]+ EXP? | '-'? INT EXP | '-'? INT;

fragment DQUOTE: '"';

fragment ESC: '\\' (["\\/bfnrt] | UNICODE);

fragment UNICODE: 'u' HEX HEX HEX HEX;

fragment HEX: [0-9a-fA-F];

fragment INT: '0' | [1-9] [0-9]*; // no leading zeros

fragment EXP: [Ee] [+\-]? INT; // \- since - means "range" inside [...]

// Just ignore WhiteSpaces
WS: [ \t\r\n]+ -> skip;
```
## Gerando o Código

Essa Gramática não ir se _plugar_ automaticamente no código, antes disso é necessário gerar alguns códigos antes. 

Nesse ponto recomendo fortemente usar o Maven para gerenciar o ANTLR4, assim você já terá tudo configurado facilmente.

Mas caso queira gerar manualmente...

### Gerando Código Manualmente

1. Faça o download do ANTLR4 Tool em [
Download ANTLR](https://www.antlr.org/download.html), procura por **ANTLR tool itself**
2. Depois execute o ANTLR4 Tool:
    ```bash
java -jar ~/Downloads/antlr-4.8-complete.jar -package io.vepo.tutorial.antlr4.generated src/main/antlr4/io/vepo/tutorial/antlr4/generated/TestSuite.g4
    ```
3. Use os arquivos gerados no seu projeto, conforme abaixo:
![Arquivos ANTLR4](https://dev-to-uploads.s3.amazonaws.com/i/wbw4yg3ntuv7bhha3ms8.png)

### Gerando usando o Maven

Usando o Maven é bem mais simples. Crie seu arquivo `.g4` no diretório similar ao pacote. Por exemplo, em nosso exemplo está:

![ANTLR4 Gramática](https://dev-to-uploads.s3.amazonaws.com/i/iuughcd323jeemn01d2f.png)

E depois configure o plugin do ANTLR4 em seu `pom.xml`

```xml
<plugin>
	<groupId>org.antlr</groupId>
	<artifactId>antlr4-maven-plugin</artifactId>
	<version>${version.antlr4}</version>
	<configuration>
		<arguments>
			<argument>-package</argument>
			<argument>io.vepo.tutorial.antlr4.generated</argument>
		</arguments>
	</configuration>
	<executions>
		<execution>
			<goals>
				<goal>antlr4</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

## Usando o Código Gerado

Do código gerado, será preciso apenas reimplementar uma classe. Veja a interface `TestSuiteListener`, para cada Regra é chamado um Método antes e depois de processado. Em cada método há um objeto de contexto onde podemos acessar todos os Tokens. 

Esses métodos são chamados em ordem, assim para o exemplo abaixo, qualquer metodo do atributo `url` será chamado antes de `method` e assim por diante. Todos como tem apenas uma suite, o `enterSuite` e  o `exitSuite` serão o primeiro e último a serem chamados.

```
Suite UserTest {
    HTTP CreateUser {
        url   : "http://127.0.0.1"
        method: "POST"
        body  : """
                   {
                       "id": 123,
                       "firstName": "John",
                       "lastName" : "Doe"
                   }
                """
        assert responseCode Equals 200
    }
}
```

Por fim, para transformar texto em Objetos, basta chamar o parser?

```java
TestSuiteParser parser = new TestSuiteParser(
		new CommonTokenStream(new TestSuiteLexer(CharStreams.fromString(contents))));
ParseTreeWalker walker = new ParseTreeWalker();
SuiteCreator creator = new SuiteCreator();
walker.walk(creator, parser.suite());
Suite suite = creator.getTestSuite();
```

# Conclusão

Existem problemas que só podem ser resolvidos criando uma linguagem. Se usarmos padrões como JSON ou XML vamos complicar mais que simplificar.

Para essas soluções, é mais fácil usar o ANTLR. Assim criamos uma linguagem facilmente.

# Recursos

Todo o código usado nesse post está disponível no repositório [github.com/vepo/antlr4-post](https://github.com/vepo/antlr4-post)

Continuarei o desenvolvimento dessa tool em [Plain Test github.com/vepo/plain-test](https://github.com/vepo/plain-test). Qualquer ajuda é bem vinda....