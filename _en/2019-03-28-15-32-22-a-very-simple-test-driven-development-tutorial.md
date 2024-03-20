---
title: A very simple Test Driven Development Tutorial
published: true
description: Some small tips for who wants to beggan with TDD
tags: [Testing, Java, Test, TDD]
cover_image: https://thepracticaldev.s3.amazonaws.com/i/jkocbutap8qvhdod7jbv.jpg
series: Thoughts on TDD
publish_date: 2019-07-24 15:32:22 +0300
original: "https://dev.to/vepo/a-very-simple-test-driven-development-tutorial-3309"
replicated: ["https://medium.com/@vepo/a-very-simple-test-driven-development-tutorial-d11d22276bad"]
permalink: /en/a-very-simple-test-driven-development-tutorial
redirect_from:
  - /posts/a-very-simple-test-driven-development-tutorial
---

Now I'm addicted with Test Driven Development, but... Somewhere in the past I thought it was a bad idea. Now I can't develop any code without this technique.

In this post I will present some steps to starting using TDD in your daily work.

# Tips

## Tip 1: Know which tools you must use 

Which language you use? I work mostly using Java and for many years I never heard about Maven and how integrate Maven with JUnit. So JUnit without Maven or Gradle or any other building tool is nothing! _Nobody in the company I was working kwen Maven or any building tool... It was some kind of amateur craftsmanship software_.

When I was introduced to Maven, after some years using Gradle by my own, I only asked: _"Ok. It make the build, run the tests and make the application deployable?_". That was I was looking for! 😀

When start a new project make a roadmap:

1. Set up building tool: _Maven or Gradle for Java_
2. Configure the Testing tool: _Why not using JUnit 5_
3. Create your first Test with an assert and check if works!

## Tip 2: Know the TDD Cycles

Red, Green, Refactor! This makes senses? No, so [read about it!](https://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html) This is the way you will develop using TDD. Write a falling test, write the code for make the test works and refactor it. 

Until the test works, do not worry about replicated code, or bad smells, or if your code is good and beautiful! Just solve the problem. This is not the moment for that.

Make small steps. Do not worry about write the full feature before tests. Test every step of your code. If you should save a entity on your database, first save it, then test every kind of input for this entity, then write all business rules. It is a waste of time write the full feature and then tests. Making small steps you can fix an error before it gets bigger, and you make sure that the code you wrote a hour ago works well.

## Tip 3: Validate your code 

What means pass the test? For a development team a work with, it means giving a Coverage Report with at least 80%! Is that correct? No! You should validate what you have done.

```java
User user = givenUser();
userService.createUser(user); // here I have 100% of Code Coverage

List<User> users = userService.list();
assertThat(users).hasSize(1) // But I do not know if it was save
                 .allMatch(this::passwordIsEncrypted); // And if the password is correctly encrypted
```

## Tip 4: Know Good Test Libraries

Mockito, AssertJ, To String Verifier, etc... This will help you. Trust in me! Do not reinvent a library, reuse. There is a lot of good libraries for tests.

## Tip 5: Organize your code for testing

Write your production code thinking who can you test it. 

Imagine that you have a code with a lot of Services Consumers and Providers (Kafka, *MQ, Aws*, Google*, etc..). Every time you create a new producer or consumer, it should be created by the same piece of code! When you do it, it is easy to create a Mock for this class. If you have a KafkaClientFactory, you do need to worry about a new KafkaProducer, just use Mockito to mock KafkaClientFactory and be happy

How to build a Singleton?

```java
public class SomeSingleton {

    private static final instance AtomicReference<SomeSingleton> ref = new AtomicReference<>();

    public static SomeSingleton get() {
        return instance.updateAndGet(e -> {
            return isNull(e) ? new SomeSingleton() : e;
        });
    }
}
```

Is this implementation good? No! Why? If I want to cleanup this singleton and recreated? How can I access the field `ref`? You can't! You have to options, or you let the field `ref` as a `package private` or you create a cleanup method as package private, and create a SomeSingletonHelper in the same package as a code test to reset all values.

The intention is thinking, how can I test my code when you are writing the code.

## Tip 6: Know the input and output

When creating tests, you should known with type of input your code will received, and which type of output should provide. Use known inputs, not only auto-generated. This helps you to make sure its working

## Tip 7: Use real inputs

Use real inputs, not only generated/dummy inputs. Found a production bug? Get what input produces the bug, create a test with it!

## Tip 8: Testing language

Create a Test DSL for your code.

```java
User user = new User();
user.setName(randomString());
user.setPassword(randomString());
userService.create(user)

List<User> allUsers = userService.list();
assertThat(allUsers).hasSize(1);
```

Compare the code above with the code bellow

```java
userService.create(givenRandonUser())

assertThat(thenAllUsers()).hasSize(1);
```

Build a High Level [Given-When-Then](https://en.wikipedia.org/wiki/Given-When-Then) library for your code

# Conclusion

Testing is not a waste of time! When you had never done TDD you will think that, but with TDD you use better your time. 
