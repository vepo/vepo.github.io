---
title: Escolhendo uma implementação Jakarta EE & Microprofile.io 
permalink: /posts/escolhendo-uma-implementacao-jakarta-ee-e-microprofile-io
published: true
description: Tutorial de como escolher uma implementação para Microprofile.io ou Jakarta EE. Será atualizado sempre com novas informações.
tags: [Jakarta-EE, Java-EE, Java, Framework]
publish_date: 2019-09-30 10:28:52 +0300
cover_image: /assets/images/web.avif
original: "https://dev.to/vepo/escolhendo-uma-implementacao-jakarta-ee-microprofile-io-13om"
series: Especificações Jakarta EE & Microprofile.io
---

O primeiro passo ao se desenvolver uma aplicação Jakarta EE ou Microprofile.io é escolher qual será a implementação que você irá utilizar. Ou o mais conhecido Servidor de Aplicação.

As implementações de Microprofile.io são mais leves que as implementações de Jakarta EE. Isso acontece porque o número de especificações implementadas por um servidor Jakarta EE é muito maior do que o de Microprofile.io. Logo, se você deseja implementar um simples Microsserviços, escolher um [WildFly](https://wildfly.org/) seria como escolher um canhão pra matar uma mosca.

# Starters

Um bom ponto para iniciar é por um Starter. O Microprofile.io tem seu próprio [Starter](https://start.microprofile.io/), com ele é possível escolher qual versão da especificação e qual plataforma deverá ser usada.

Não encotrei um Starter para Jakarta EE oficial, mas há muitos tutoriais na internet. Nessa série nosso foco será em projetos Microprofile.io, logo este starter é suficiente.

Caso queira um Starter Jakarta EE, há alguns:

* [generjee](http://generjee.inetseite.de/)

# Servidores de Aplicação 

Segue abaixo uma lista não exaustiva dos servidores de aplicação existente. Nesse tutorial usaremos o Thorntail.io para nossas implementações.

Todos os servidores 100% compatíveis podem ser encontrados nas paginas de cada projeto:

* [Jakarta EE](https://jakarta.ee/compatibility/)
* [Microprofile.io](https://wiki.eclipse.org/MicroProfile/Implementation)

## GlassFish

O [GlassFish](https://javaee.github.io/glassfish/download) é a implementação oficial do Jakarta EE. O mesmo será 100% compatível com as especificações.


## Payara

Compatível com Jakarta EE e Microprofile.io. [Getting started with Payara...](https://www.payara.fish/documentation/getting-started-with-payara/)

## WildFly

[Um dos mais conhecidos no mercado](https://wildfly.org/). Anteriormente conhecido como JBoss. Compatível com Jakarta EE.

## TomEE

[Compatível](https://tomee.apache.org/) com Jakarta EE e Microprofile.io.

## OpenLiberty

[Compatível](https://openliberty.io/) com Jakarta EE e Microprofile.io.

## Quakus.io

O [Quarkus.io](https://quarkus.io/) não é 100% compatível com nenhuma das duas especificações! Mas ele está caminhando nesse caminho. Sua ideia principal é prover um servidor de aplicação mais leve que os outros e de fácil desenvolvimento. Ainda é possível usar a [GraalVM](https://www.graalvm.org/).

![Quarkus.io](https://thepracticaldev.s3.amazonaws.com/i/o9mpk38fl4yl4tp0t32t.png)

## Thorntail.io

Fork do WildFly, o [Thorntail](https://thorntail.io/generator/) é voltado para implementação. Para o deploy não é necessário configurar um servidor de aplicação. O mesmo, junto com suas dependências, é configurado automaticamente pela build Maven. Assim é gerado ou um Fat-Jar ou um War + Hollow Jar. 

No Fat-Jar temos todas as dependências prontas para serem executadas. 

No Hollow-Jar temos todas as dependências empacotadas separadamente.