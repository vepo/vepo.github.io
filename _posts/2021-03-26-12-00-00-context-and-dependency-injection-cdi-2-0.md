---
title: Contexts and Dependency Injection (CDI) 2.0
published: true
permalink: /posts/context-and-dependency-injection-cdi-2-0
description: Nesse post vou detalhar um pouco as funcionalidades do Java CDI e como podem ser usadas para melhorar seu código.
tags: [Jakarta-EE, Java-EE, Java, Java CDI, CDI]
image: /assets/images/web.avif
series: Especificações Jakarta EE & Microprofile.io
original: https://dev.to/vepo/contexts-and-dependency-injection-cdi-2-0-1ae4
publish_date: 2021-03-26 20:00:00 +0300
---

CDI é a especificação mais básica do Jakarta EE e do Microprofile.io. Está na base de todas as outras e é utilizada por quase todas outras.

## O meu projeto tem CDI?

Pra quem não conhece a especificação, pode ficar perdido. Era o que acontecia comigo. Você se depara com classes assim:

```java
@ApplicationScoped
public class UserService {
    @Inject
    private UserRepository userRepository;

    public Optional<User> findById(long userId) {
        return Optional.ofNullable(userRepository.find(userId));
    }
}
```

E você se pergunta:
* _Tá, quem instancia essa classe?_ 
* _Como eu configuro `userRepository`?_
* _Como eu uso UserService?_ 

Se você não sabe responder essas perguntas, vamos lá....

## O que é CDI?

A primeira versão de *Contexts and Dependency Injection for Java EE (CDI)* entrou no Java EE 6, e rapidamente se tornou uma das mais importantes e populares especificações da plataforma.

CDI define um conjunto de especificações que permite uma boa modularização do código do projeto:

* Um ciclo de vida bem definidos para objetos e seu respectivo contextos. Também um conjunto extensível de contextos.
* Um sofisticado e mecanismo de injeção com tipagem forte sem configuração
* Suporte a construção de Componentes totalmente desacoplados
* Integração com JSF
* Decorators
* Interceptors
* Programação Event-Driven 

### Escopo

O Java CDI define uma API básica para que frameworks de dependency injection possam criar, gerenciar e remover TypeSafe beans automaticamente dentro de containers Jakarta EE. 

### Porque usar CDI

CDI permite desacoplar totalmente o ciclo de vida de um objeto e seu uso. O desenvolvedor que usa uma classe não precisa saber como instanciar e nem como remover estes objetos. Permitindo assim:

* Velocidade de Desenvolvimento
* Padronização do código
* Baixo acoplamento e alta coesão
* Foco na Lógica de Negócio


## Definições

Para entender o que é o Java CDI é preciso compreender algumas definições antes.

### Inversão de Controle 

Inversão de controle, [segundo Martin Fowler](https://martinfowler.com/bliki/InversionOfControl.html), é o que difere Frameworks de Bibliotecas. Ao usar uma biblioteca, deve ser explicitamente carregado no código as dependências de cada componente. Ao se usar um componene, as dependências de cada componente são carregadas pelo mesmo, sendo **apenas** responsabilidade do desenvolvedor usar o compomenente.

### Programação por Aspectos

Quando se fala de AOP, há inúmeros conceitos, mas podemos ser bem simples em definir. Ao se escrever um código, o desenvolvedor pode separar vários níveis de tipos de códigos. Aqueles que definem o que está sendo feito, requisitos funcionais e requisitos básicos. 

Vamos imaginar que você está desenvolvendo um endpoint para tratar de reservar um item em um carrinho de compra. Existe o código de reservar o item (1), existe o código que implementará o protocolo HTTP (2) e existe outras funcionalidades que darão segurança ao serviço (3). **1** é o código principal, **2** e **3** são apenas aspectos desse código e podem ser definidos ortogonalmente ao código. Como fazer isso? Vamos ver a seguir: Decorators ou Interceptors!


## Criando um Projeto CDI

Para criar um projeto CDI, basta adicionar o arquivo `src/main/resources/META-INF/beans.xml` a um projeto Maven.

```xml
<beans xmlns="http://xmlns.jcp.org/xml/ns/javaee" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/beans_1_1.xsd" 
    bean-discovery-mode="all">
</beans>
```

Isso fará com que automaticamente TODOS os objetos definidos nesse projeto sejam considerados um bean e carregados aotumaticamente.

## Instanciando Objetos CDI

Objetos CDI são automaticamente carregados. Para isso é preciso que sigam os seguintes requisitos:
* Não seja uma Inner Class
* Não seja uma Classe abstrata e não possui a Annotation @Decorator
* Não implementa a interface javax.enterprise.inject.spi.Extension
* Não possui a Annotation @Vetoed e nem está em um pacote com @Vetoed
* Tem um construtor apropriado
    * Um construtor sem parâmetros
    * ~~Um construtor com parâmetros com @Inject~~
        * Está na especificação, mas não funciona! 🤔 🤦‍♂️


### Escopo e Contexto

Cada objeto deve definir qual o seu escopo. Isso impactará diretamente quando cada objeto será criado e removido. Ou se existirá apenas um ou várias ao mesmo tempo. Os escopos pre definidos pelo Java CDI são:

| Scope | Annotation | Duration |
| ----- | ---------- | -------- |
| Request | @RequestScoped | A user’s interaction with a web application in a single HTTP request. |
| Session | @SessionScoped | A user’s interaction with a web application across multiple HTTP requests. |
| Application | @ApplicationScoped | Shared state across all users’ interactions with a web application. |
| Dependent | @Dependent | The default scope if none is specified; it means that an object exists to serve exactly one client (bean) and has the same lifecycle as that client (bean). |
| Conversation | @ConversationScoped | A user’s interaction with a JavaServer Faces application, within explicit developer-controlled boundaries that extend the scope across multiple invocations of the JavaServer Faces lifecycle. All long-running conversations are scoped to a particular HTTP servlet session and may not cross session boundaries. |

Nesse tutorial, para facilitar os exemplos, vamos tratar apenas dos escopos Request e Application.

O `SessionScoped` é usado em projetos JSF onde há uma sessão de usuário ativa.

### Diretamente

Qualquer objeto que cumpra todos os requisitos acima. Como você pode ver em [UserRepository.java](https://github.com/vepo/cdi-tutorial/blob/master/src/main/java/io/vepo/access/user/UserRepository.java), o campo `collection` é inserido e inicializado apenas usando a annotation `@Inject`.

```java
@Dependent
public class UserRepository {
    [...]

    @Inject
    private MongoCollection<User> collection;

    [...]
}
```

### Ciclo de Vida

Juntamente com a instanciação, o Java CDI permite controlar o ciclo de vida de um objeto. Se for preciso limpar o objeto ao mesmo ser removido ou instanciar objetos não CDI, como faz?

Para isso podemos usar as annotations `@PostConstruct` e `@PreDestroy`.

Veja o exemplo de [MongoClientFactory](https://github.com/vepo/cdi-tutorial/blob/master/src/main/java/io/vepo/access/infra/MongoClientFactory.java). Observe que ao ser inicializado, é chamado automaticamente o metodo `buildMongoClient` e ao ser removido o metodo `cleanup`. 

## Factory

_E se a classe não for definida no meu código, como faço?_ 

Para isso, podemos inicializar ela através de uma [**Factory**](https://refactoring.guru/pt-br/design-patterns/factory-method/java/example).

Em CDI ela é definida pela annotation `@Produces`.

Veja o caso de `MongoClientFactory`, a classe é usada pelo CDI para instanciar qualquer instancia de [MongoCollection](https://github.com/vepo/cdi-tutorial/blob/master/src/main/java/io/vepo/access/infra/MongoClientFactory.java#L84).

Se a classe MongoCollection fosse Closeable, eu precisaria também implementaro um metodo pra isso, logo:

```java
public <T> void disposeMongoCollection(@Dispose MongoCollection<T> collection) {
    // close if possible
}
```

## Usando Qualifiers

E se agora eu precisar escolher entre implementações distintas? Como faço?

O CDI também tem a solução para isso com baixo acoplamento. Primeiro você vai ter que definir uma interface ou uma class abstrata. Em nosso exemplos vamos criar o `HelloService` com a unica intenção de dizer _Oi_.

```java
public interface HelloService {

	public String sayHello(String username);
}
```

Nessa interface não é necessário praticamente nada.

Depois é necessário definir quais serão os qualifiers usados:

```java
@Qualifier
@Retention(RUNTIME)
@Target({ TYPE, ElementType.FIELD })
public @interface PtBr {

}
```

O proximo passo é definir as implementações, segue abaixo as duas que fiz:

```java
@ApplicationScoped
@PtBr
public class HelloServicePtBr implements HelloService {

	@Override
	public String sayHello(String username) {
		return String.format("Olá! %s", username);
	}

}
```

E

```java
@ApplicationScoped
public class HelloServiceUs implements HelloService {

	@Override
	public String sayHello(String username) {
		return String.format("Hello! %s", username);
	}

}
```

Nos dois casos acima, você pode observar que `HelloServiceUs` é a implementação padrão, enquanto `HelloServicePtBr` seria uma alternativa. Assim podemos usar:

```java
public class SayHelloEndpoing {

    @Inject
    private HelloService helloService;

    // something

}
```

Para usar a implementação padrão, e apenas adicionando `@PtBr` podemos alterar a implementação.

```java
public class SayHelloEndpoing {

    @Inject
    @PtBr
    private HelloService helloService;

    // something

}
```

Assim é possível trocar a implementação de um componente com minimas alterações nas classes.

## Interceptando

Uma última feature do CDI é a possibilidade de se interceptar. Essa é a implementação do que podemos chamar de AOP. 

Vamos deixar claro, qual a intenção de se usar um interceptador? Remover do código funcionalidades que não fazem parte da intenção direta do código. Por exemplo: Uma criação de usuário, exitem as regras de negócio e transações, transações são elegíveis para um interceptador, enquantoas regras de negócio DEVEM estar expressas no código.

Como fazer uma interceptação?

1. Sua classe a ser interceptada deve ser provida pelo CDI
2. Uma `Annotation`, usando `@Inherited` e `@InterceptorBinding`, para marcar o metodo/classe 
3. Sua classe a ser interceptada deve ter algum qualifier associado (a ela ou ao método)
4. Deve ser declarado um interceptador tanto na classe como no `beans.xml`.

Vamos supor que em algumas classes eu desejo gerar estatisticas, então observe a implementação abaixo: 

```java
@Measured
@Interceptor
public class StatisticInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(StatisticInterceptor.class);

    @AroundInvoke
	public Object calculateExecutionTime(InvocationContext invocationContext) throws Exception {
        long startTime = System.currentTimeMillis();
        Object returnedValue = invocationContext.proceed();
        long endTime = System.currentTimeMillis();
        logger.info("The execution of {}.{} took {}ms", invocationContext.getMethod().getName(),
        invocationContext.getMethod().getDeclaringClass().getName(), endTime - startTime);
        return returnedValue;
    }
}
```

Observe a execução! Sucesso! 😀

```
2020-05-27 13:37:16,263 INFO  [i.v.a.i.s.StatisticInterceptor] (default task-1) The execution of findByUsernameAndPassword.io.vepo.access.user.UserRepository took 6ms
2020-05-27 13:37:16,333 INFO  [i.v.a.i.s.StatisticInterceptor] (default task-1) The execution of login.io.vepo.access.user.UserEndpoint took 113ms
2020-05-27 13:37:35,087 INFO  [i.v.a.i.s.StatisticInterceptor] (default task-1) The execution of findByUsernameAndPassword.io.vepo.access.user.UserRepository took 2ms
2020-05-27 13:37:35,088 INFO  [i.v.a.i.s.StatisticInterceptor] (default task-1) The execution of login.io.vepo.access.user.UserEndpoint took 4ms
2020-05-27 13:37:40,430 INFO  [i.v.a.i.s.StatisticInterceptor] (default task-1) The execution of findByUsernameAndPassword.io.vepo.access.user.UserRepository took 2ms
2020-05-27 13:37:40,431 INFO  [i.v.a.i.s.StatisticInterceptor] (default task-1) The execution of login.io.vepo.access.user.UserEndpoint took 3ms
```

## Events e Observers

Uma última feature para usar do CDI são os eventos. O CDI habilita a comunicação asincrona e desacoplada dentro de uma mesma JVM. 

Um evento pode ser qualquer objeto Java, de preferência um que representa o evento em si. No meu exemplo usei o `UserCreated` e `UserRemoved` para representar essas ações.

Como enviar? Basta instanciar um producer usando o `@Inject` e pronto:

```java
@Inject
private Event<UserCreated> createdEvent;


@POST
@Secured
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public User createUser(User user) {
	logger.info("Credentials: {}", credentials);
	user.setPassword(this.passwordEncrypter.encrypt(user.getPassword()));
	this.userRepository.create(user);
	this.createdEvent.fire(new UserCreated(user.getUsername()));
	return user;
}
```

Para consumir esse evento, basta criar um método com `@Observes UserCreated userCreatedEvent`.

Vejamos a implementação:

```java
@ApplicationScoped
public class SendEmailHandler {

	private static final Logger logger = LoggerFactory.getLogger(SendEmailHandler.class);

	public void sendUserCreatedEmail(@Observes UserCreated userCreatedEvent) {
		logger.info("Sending User Created email! {}", userCreatedEvent);
	}

	public void sendUserRemovedEmail(@Observes UserRemoved userRemovedEvent) {
		logger.info("Sending User Removed email! {}", userRemovedEvent);
	}
}
```


## Conclusão

CDI ajudar a controlar o ciclo de vida de um objeto e com isso diminui o acomplamento do seu código. Para quem não o conhece parece mágica, por isso é importante que seu equipe tenha total conhecimento da especificação antes de usa-lo.

Com os Intercepts do CDI é possível remover códigos que são ortogonais a lógica de negócio para que estes não atrapalhem o entendimento. Deixando a base de código clara e compartimentada.

Com os Eventos CDI é possível fazer com que seu código seja mais desacoplado e que novas funcionalidades não precisem alterar códigos antigos.

Bom uso!

_Está faltando mais alguma coisa? Está achando confuso? Pergunte que eu posso melhorar!_ 😀

Todos os exemplos desse post estão em: 

{% github https://github.com/vepo/cdi-tutorial %}
