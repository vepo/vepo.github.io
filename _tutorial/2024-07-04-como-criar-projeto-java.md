---
layout: "tutorial"
title: Como criar um projeto Java usando Maven
published: true
description: 
tags: [Java]
publish_date: 2024-07-04 15:00:00 +0300
permalink: /tutorial/como-criar-um-projeto-java-usando-maven
cover_image: /assets/images/chaplin-modern-times.jpg
---


### Introdução
Neste tutorial, você aprenderá como criar um projeto Java usando Maven, uma poderosa ferramenta de automação e gerenciamento de dependências. O Apache Maven simplifica o processo de construção de projetos Java ao fornecer uma estrutura padrão e automatizar tarefas comuns, como compilação, empacotamento, teste e gerenciamento de bibliotecas externas.

Para compreender melhor um projeto Maven, é preciso entender que o Maven funciona sob o paradiga "Convenção sobre Configuração". Um projeto Maven possui certas convenções que facilitam o desenvolvimento ao se evitar configurações. Sabemos, por exemplo, que todo arquivo em `src/main` será usado em produção, enquanto todo arquivo em `src/test` será usados para testes.

Outra funcionalidade do Maven é gerenciar as dependências do projeto. Assim, se você já teve dificuldades em gerenciar as dependências de um projeto manualmente ou deseja uma maneira eficiente de organizar e construir seu código, Maven é a solução ideal. Este guia passo a passo levará você desde a configuração inicial até a criação e execução de um projeto Java básico, utilizando o Maven.

Vamos começar criando a estrutura do projeto, em seguida, exploraremos como adicionar dependências e empacotar seu aplicativo para distribuição. Ao final deste tutorial, você terá uma base sólida para desenvolver e gerenciar seus projetos Java com eficiência usando Maven.

Preparado? Então, vamos lá!

{% github https://github.com/vepo/tutorial-java-maven %}

### Pré-requisitos

1. Java Development Kit (JDK): Certifique-se de ter o JDK instalado em sua máquina.
2. Apache Maven: Instale o Maven. Você pode baixar o Maven [aqui](https://maven.apache.org/download.cgi) e seguir as instruções de instalação.

## Passo 1 - Crie a estrutura do projeto

Navegue até o diretório onde deseja criar seu projeto e execute o seguinte comando:

```bash
mvn archetype:generate -DgroupId=com.exemplo -DartifactId=meu-projeto -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

Isso criará um projeto Maven básico com a seguinte estrutura de diretórios:

```
meu-projeto
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── exemplo
    │               └─── App.java
    └── test
        └── java
            └── com
                └── exemplo
                    └─── AppTest.java

```

## Passo 2 - Entenda o arquivo `pom.xml`

O arquivo `pom.xml` (Project Object Model) é o coração do projeto Maven. Ele contém todas as informações sobre o projeto e as dependências necessárias. Aqui está um exemplo básico de um `pom.xml`:

```xml`
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.exemplo</groupId>
    <artifactId>meu-projeto</artifactId>
    <version>1.0-SNAPSHOT</version>
    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```

## Passo 3 - Adicione dependências

Para adicionar dependências ao seu projeto, você precisa editar o arquivo `pom.xml` e incluir as dependências necessárias dentro da tag `<dependencies>`. Por exemplo, para adicionar a biblioteca Jackson para manipulação de JSON adicione as **Coordenadas Maven** `com.fasterxml.jackson.core:jackson-core:2.17.1`.

```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databing</artifactId>
    <version>2.17.1</version>
</dependency>
```
> ## Coordenadas Maven
>
> O Maven gerencia automaticamente as dependências do projeto. No `pom.xml` podemos definir uma sessão chamada `dependencies` onde todas as dependências podem ser definidas. Existem inúmeras bibliotecas disponíveis para serem usadas em projetos Java, muitas delas podem ser encontradas através do site [mvnrepository.com](https://mvnrepository.com/).
> 
> Para identificar um artefato especifico, o Maven define o conceito de Coordenada Maven. Uma coordenada é definda por todos elementos necessáios para identificar um artefato, as principais são `groupId`, `artifactId` e `version`. Mas também podem ser definidos os elementos `classifier` e `type`.
> * **groupId**: Identificador de agroupamento, normalmente referindo-se a uma organização, uma empresa e pode incluir um tema básico para um ou mais projetos. 
> * **artifactId**: Nome para o projeto. Entre os muitos projetos que existem no grupo, o artifactId pode identificar exclusivamente  artefato. 
> * **version**: Um identificador que rastreia builds exclusivas de um artefato. Uma versão é uma string construída pela equipe de desenvolvimento do projeto para identificar builds, diferenciado novos artefatos e catalogando alterações.

Para fazer busca por dependências, procure no site [MVN Repository](https://mvnrepository.com/).

## Passo 4 - Compile o projeto

Para compilar o projeto, navegue até o diretório do projeto (meu-projeto) e execute:

```bash
mvn compile
```
Isso irá compilar as classes Java no diretório `src/main/java`.

## Passo 5 - Execute os testes

Para executar os testes, use o comando:

```bash
mvn test
```

## Passo 6 - Execute o projeto

```bash
mvn clean compile exec:java -Dexec.mainClass="com.exemplo.App"
```

Isso irá compilar e executar as classes de teste localizadas em src/test/java.
## Passo 7 - Empacote o projeto

Para criar um arquivo JAR do seu projeto, execute:

```bash
mvn package
```

Isso irá gerar um arquivo JAR dentro do diretório target.
## Passo 8 - Execute o aplicativo

Para executar o aplicativo, use o seguinte comando:

```bash
java -cp target/meu-projeto-1.0-SNAPSHOT.jar com.exemplo.App
```

### Conclusão

Você criou com sucesso um projeto Java básico usando Maven. A partir daqui, você pode adicionar mais dependências, configurar plugins e desenvolver sua aplicação conforme necessário. Maven oferece uma poderosa ferramenta de automação para gerenciamento de projetos, simplificando o processo de construção e gerenciamento de dependências.

Se precisar de mais ajuda ou tiver alguma dúvida, sinta-se à vontade para perguntar!