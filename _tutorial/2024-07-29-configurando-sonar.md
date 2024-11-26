---
layout: "tutorial"
title: Configurando Sonar em projetos Java
published: true
description: 
tags: [Java, Sonar]
publish_date: 2024-07-29 10:00:00 +0300
permalink: /tutorial/configurando-sonar-em-projetos-java
cover_image: /assets/images/chaplin-modern-times-100-42.webp
---

## Análise Estática de Código e Sonar

A análise estática de código é uma técnica utilizada para examinar o código-fonte de um programa sem executá-lo. O objetivo principal é identificar possíveis erros, vulnerabilidades de segurança, violações de padrões de codificação e outras questões que possam comprometer a qualidade do software. Essa análise é realizada por ferramentas automatizadas que varrem o código e geram relatórios detalhados sobre os problemas encontrados.

Uma das ferramentas mais populares para análise estática de código é o SonarQube, frequentemente referido apenas como Sonar. O SonarQube é uma plataforma de código aberto que permite a inspeção contínua da qualidade do código. Ele suporta diversas linguagens de programação e oferece uma ampla gama de plugins que podem ser integrados ao processo de desenvolvimento, facilitando a detecção e correção de problemas desde as fases iniciais do projeto.

O SonarQube analisa o código em busca de bugs, vulnerabilidades, code smells (problemas que não são necessariamente erros, mas que indicam uma possível melhoria), duplicações de código e muito mais. Além disso, ele fornece métricas detalhadas sobre a cobertura de testes, complexidade ciclomática, entre outras, ajudando os desenvolvedores a manterem um código limpo, eficiente e seguro.

Integrar o SonarQube ao fluxo de desenvolvimento pode trazer inúmeros benefícios, como a redução de custos com manutenção, aumento da segurança do software e melhoria na qualidade geral do código. Com a análise contínua proporcionada pelo SonarQube, as equipes de desenvolvimento podem identificar e corrigir problemas rapidamente, antes que eles se tornem críticos.

## Como configurar

Para esse tutorial vamos usar o projeto criado em [Como criar um projeto Java usando Maven](/tutorial/como-criar-um-projeto-java-usando-maven).

{% github https://github.com/vepo/tutorial-java-maven %}

### 1. Criando uma conta no Sonar

Antes de configurar o Sonar, precisamos criar uma conta. Para isso, podemos usar uma instância local ou o [SonarCloud](https://sonarcloud.io), que oferece suporte gratuito para projetos open source. A infraestrutura local pode ser configurada usando o docker-compose. Execute o comando abaixo para iniciar a instância local:


```bash
docker-compose -f sonar-docker-compose.yaml up -d
```

```yaml
version: "3"

services:
  sonarqube:
    image: sonarqube:community
    depends_on:
      - db
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonar
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
    command: "-Dsonar.search.javaAdditionalOpts=-Dnode.store.allow_mmap=false"
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
    ports:
      - "9000:9000"
  db:
    image: postgres:12
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
    volumes:
      - postgresql:/var/lib/postgresql
      - postgresql_data:/var/lib/postgresql/data

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  postgresql:
  postgresql_data:
```

No primeiro login, você precisará criar um usuário e senha. Em seguida, será necessário criar um projeto. Recomendo criar um projeto local ("Create a local project") e definir o nome, a chave do projeto e o branch principal (_master_ ou _main_). Depois, você deve definir o baseline de qualidade, que servirá para comparar a qualidade do seu projeto. Recomendo usar sempre a versão anterior (_Previous version_) para acompanhar a evolução a cada release. Depois, você precisará definir como o projeto será analisado. Se você não usa Jenkins ou outra plataforma de CI/CD, pode fazer a análise localmente (_locally_). Para isso, um token será gerado, e no último passo, um script bash usando Maven será criado.

```bash
mvn clean verify sonar:sonar \
  -Dsonar.projectKey=test \
  -Dsonar.projectName='Teste' \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token=token
```

É recomendável configurar o token como uma variável de ambiente, enquanto as demais propriedades devem ser definidas dentro do arquivo `pom.xml`.

```xml
<properties>
  <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  <maven.compiler.target>21</maven.compiler.target>
  <maven.compiler.source>21</maven.compiler.source>
  <!-- SONAR -->
  <sonar.projectKey>test</sonar.projectKey>
  <sonar.projectName>Test</sonar.projectName>
  <sonar.host.url>http://localhost:9000</sonar.host.url>
</properties>
```

```bash
export SONAR_TOKEN=token
mvn clean verify sonar:sonar
```

A qualidade do projeto pode ser verificada. Como o projeto é muito simples não tem muito o que verificar, mas já existe 3 problemas existentes que não são sérios.

![Qualidade geral do projeto](/assets/images/sonar/sonar.png)

![Problemas encontrados](/assets/images/sonar/issues.png)

## Conclusão

Neste tutorial, abordamos a configuração do SonarQube para análise estática de código em um projeto Maven. Aprendemos a gerar um token de autenticação, configurar as propriedades do projeto no `pom.xml` e definir o token como uma variável de ambiente para garantir a segurança. Além disso, vimos como executar a análise de código usando o Maven e verificar a qualidade do projeto através da interface do SonarQube.

A integração do SonarQube no fluxo de desenvolvimento é uma prática recomendada para manter a qualidade do código e identificar problemas de forma proativa. Mesmo em projetos simples, como o exemplo apresentado, a análise contínua pode revelar áreas de melhoria e ajudar a manter um código limpo e eficiente.

O próximo passo é configurar o JaCoCo para medir a cobertura dos testes. O JaCoCo é uma ferramenta que permite gerar relatórios detalhados sobre a cobertura de código pelos testes, ajudando a garantir que todas as partes críticas do código sejam testadas adequadamente.

Esperamos que este tutorial tenha sido útil e que você possa aplicar essas práticas em seus próprios projetos para garantir um desenvolvimento de software mais robusto e seguro.
