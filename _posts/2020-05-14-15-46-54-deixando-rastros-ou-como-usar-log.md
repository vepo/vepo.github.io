---
title: Deixando rastros, ou como usar log
permalink: /posts/deixando-rastros-ou-como-usar-log
published: true
description: Um Sênior precisa saber usar log... minto! Qualquer desenvolvedor precisar saber usar log. Aqui apresento como usar o SLF4J em Java.
series: Coisas que todo Sênior deve saber
image: /assets/images/capas/passos.jpg
tags: [Desenvolvimento de Software, logging, Java, SLF4J]
publish_date: 2020-05-14 12:46:54 +0300
original: https://dev.to/vepo/deixando-rastros-ou-como-usar-log-peg
---

_Esse post é necessário para outro que vou escrever...._ 🤔

Log é uma ferramenta muito importante. Se você é apenas um desenvolvedor, talvez não saiba a utilidade dele, mas com certeza que cuida da operação do seu software sabe.

Com esse post, quero mostra:
1. O que é um log?
2. Porque usar log em Java?
3. Como usar SLF4J em Java?
4. Apresentar um simples benchmark entre implementações do SLF4J.

# Formato de Arquivo

Pra ser bem estrito ao nome _log_ significa registro. E esse tipo de arquivo não é necessariamente associado a um conteúdo. Há inuméros outros tipos de log, como por exemplo no Apache Kafka, cada [partition](https://kafka.apache.org/documentation/#intro_topics) é um arquivo de log, há base de dados que funcionam basicamente como um log de operações, acredito que o [Datomic](https://www.datomic.com/) é assim.

Na realidade, um arquivo de log é um arquivo que conterá registros de algo, que será sempre adicionado ao final do arquivo.

Nesse post vamos tratar de logs de execução. Esses são essenciais para qualquer aplicação. 

# Porque sua aplicação deve ter log

Existem aplicações, servidores, [agentes](https://www.researchgate.net/publication/323988067_Intelligent_Agents_and_Environment) e scripts. A diferença entre esses tipos de software está no modo como eles são executados.

## Script
No caso de script, a execução desse sempre será supervisionada por um desenvolvedor, ou alguém de suporte. Normalmente é executado pela linha de comando e as informações devem ser mostradas no console. Nesse caso não é necessário um biblioteca de log, a eficiência não é um problema.

## Aplicações
Aplicações é um que temos instalado no nosso computador ou celular. Quando um erro acontece na aplicação tempos duas coisas:
1. A descrição do erro por um usuário mal-humorado
2. Um usuário mal-humorado

Nesse caso, muitas vezes o que o usuário irá descrever pode não ser suficiente para se compreender o erro. Se esse erro ocorrer com um aplicativo de celular... você tem uma legião de usuários mal-humarados e só... Como corrigir o erro? 

Nesse caso o log deverá descrever o estado da aplicação e será bastante útil para um troubleshooting simples ou a correção do bug.

## Agentes e Servidores

Ahhh... E se você não tem um usuário? Vai dar erro, ninguém vai ver... Você não vai saber como e onde deu o erro... Como faz?

Primeiro uma definição, Agentes são softwares inteligentes que são autonomos. Eles não precisam de interação com outros softwares/usuários. Você pode ver um em ação... [o google](https://diolinux.com.br/2019/07/google-abre-codigo-de-seu-web-crawler.html)!

Nesse caso, um log de execução é essencial. Você precisa saber o estado atual do seu sistema e se der algum erro, deve ter informações suficientes para compreender o que aconteceu.

# Uma biblioteca para todos usarem

No mundo Java há uma grande preocupação com padronização. Assim até se tratando de Log também temos uma padrão:

1. Não use a biblioteca padrão do Java. Porque? [Porque não oras!](https://stackoverflow.com/questions/11359187/why-not-use-java-util-logging)
2. Use SLF4J e escolha a implementação que você quiser.

Com SFL4J você não precisa fazer quase nenhuma configuração em código, apenas instanciar em suas classes uma instância do logger.

## O SLF4J

O **Simple Logging Facade for Java** é uma biblioteca para abstrair log, assim você não precisariam ficar preso a uma implementação de biblioteca de log. Quer mudar a biblioteca de log? Só mudar umas linhas no `pom.xml`!

### Configurando o SLF4J

Para configurar o SLF4J e sua implementação, você irá precisar basicamente:

1. Adicionar a dependência [slf4j-api](https://mvnrepository.com/artifact/org.slf4j/slf4j-api)
2. Adicionar uma implementação do SLF4J
    1. Ou o [Log4J2](https://logging.apache.org/log4j/2.x/)
    2. Ou o [Logback](http://logback.qos.ch/)
    3. Ou outras [implementações](http://www.slf4j.org/manual.html)
3. Instanciar o log e deixar rastros.

Basicamente não é necessário um arquivo de configuração, apesar de ser altamente recomendável!

Vou deixar aqui um exemplo não tão básico, pois usa o variáveis de ambiente para configurar o Log:

{% gist https://gist.github.com/vepo/82b64b6cc23bc5d85f0e05cdbc36603f %}

Observe que na linha 21 e 22, estou usando as variáveis de ambiente `LOG_LEVEL` e `APPENDER`, com os respectivos valores padrão `DEBUG` e `STDOUT`. Assim essas configurações podem ser alteradas sem a necessidade de uma build! 😎

Agora para instanciar o log:

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MyClass {
	private static final Logger logger = LoggerFactory.getLogger(MyClass.class);

        public void beHappy() {
            logger.info("Yeah!");
            // being happy!
        }
}
```

## Níveis de Log

Um dos conceitos básicos do log é o Nível, ele gradua a importância da informação sendo registrada. 

No SLF4J há os seguintes níveis: ERROR, WARN, INFO, DEBUG, TRACE. Sendo o TRACE o menos importante e o ERROR o mais importante.

É nível de log deve ser ajustado de acordo com a necessidade, por exemplo. Uma aplicação no ambiente de desenvolvimento deve rodar em DEBUG ou TRACE. Uma aplicação em ambiente de testes em INFO. Já uma aplicação em produção deve rodar em ERROR ou WARN. 

Caso exista um bug em em produção e seja necessário pegar mais logs, a aplicação deve ser reiniciada para INFO.

Mas fique atento, mudar o nível de log pode impactar a performance da aplicação.

## Dicas

É normal em desenvolvedores menos experientes, criar mensagens com contatenação de strings... Mas isso não é uma boa prática, porque em código sensíveis, pode impactar a performace.

Mas há duas maneiras de resolver isso com o SLF4J.

### Usando binding

No SLF4J você pode resolver esse usando o binding. Você irá ver que as assinaturas dos métodos de log aceitam inúmeros parâmetros. Cara parametro será associado ao valor `{}` na mensagem de log. Assim, caso a mensagem não seja exibida por causa do nível de log, serão evitada as criações de algumas strings.

```java
logger.trace("This is a trace message: ctx={} other-var={}", ctx, otherVar);
```

### Verificando Nível de Log

Caso a mensagem seja realmente complicada, e você queira formatar ela dignamente... Há outra saída...

```java
logger.debug("this is a debug message. If the level is bellow debug, it will not showed");
if(logger.isDebugEnabled()) {
	logger.debug("Some message formatted: value1=" + value1 + " ctxName=" + ctx.getName());
}
```

### Não use chamadas de metodos

Uma outra dica é nunca usar chamadas de métodos como parâmetro! Porque? Porque se o esse log não estiver habilitado, o método será chamado sempre. Deixe a JVM chamar o `toString`. Segue a vida....

```java
logger.debug("This is a log registry: ctxName={}", ctx.getName()); // Wrong!
logger.debug("This is a log registry: ctx={}", ctx);               // Better now! Implement .toString correctly
```

# Benchmark

Eu fiz um benchmark rápido, mas o objetivo dele não é mostrar qual implementação é melhor. [Há algumas razões](http://logback.qos.ch/reasonsToSwitch.html) pra se escolher o logback, mas isso fica a sua escolha.

{% github https://github.com/vepo/slf4j-benchmark %}

O ponto central do meu benchmark é mostrar como o uso do nível de log impacta na performance.

No meu teste, são feitas 1.000.000 de chamadas ao log. Então...

![Alt Text](https://dev-to-uploads.s3.amazonaws.com/i/1rz55opvxepu63l54sqq.png)

Podemos ver, que se reduzirmos o nível de log podemos reduzir o tempo de execução! Isso porque:

1. Menos código é executado
2. Não há gargalo para escrita (arquivo, console, TCP, etc...)

# Conclusão

Nenhum software pode ser executado sem algum tipo de log. Para softwares mais sensíveis o log deve ser levado a sério.

Usando corretamente o log, você não terá impacto na performance, e ainda conseguirá mais informações para troubleshooting e bug fix! 

😎


