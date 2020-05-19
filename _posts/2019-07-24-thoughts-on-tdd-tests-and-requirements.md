---
title: Tests and Requirements
published: true
series: Thoughts on TDD
description: How can we ensure that any new development does not create an undesired behaviour?
tags: java, tdd, bugs, requirement
cover_image: https://cdn.pixabay.com/photo/2015/05/11/13/28/software-762486_960_720.jpg
---

In the last days I'm facing a huge question: *With several teams working with several projects, how to avoid new bugs?*

In the company that I work, we have a lot of microservices, but there is no owner. Probably someone can start working in a project and a new feature should be added in a microservice. When this happen, **no bug should be added to any service in any client!**

In this post I will describe how we are handling features changes with TDD.

# TDD process review
When using TDD to develop any software we must:

1. Configure Testing Frameworks
2. Write a Test that fails
3. Write the code that fixes all the Tests
4. Refactor your code if necessary

This is what we call Red-Green-Refactor. First you make a test fail, then you fix and at least you improve your code organization.

![RGR Process](https://s3.amazonaws.com/codecademy-content/programs/tdd-js/articles/red-green-refactor-tdd.png)

# Some thoughts on Red-Green-Refactor

**Red-Green-Refactor** most of time is used for Unit Tests. And this lead some questions about requirements:
* ***How can we ensure that all the requirements are implemented by the our code?***
* ***How can we ensure that any future implementation will not change any requirement?***
* ***How can we ensure that all developers will know all requirements in any future implementation?***

![When someone change your code](https://memeworld.funnyjunk.com/pictures/When+you+have+a+group+project_a71b2c_6624638.jpg)

If we are talking about Unit Testing, this questions is not applied, because we are testing a class or a small piece of code. One change on this piece of code can change all software behaviour.

# Create Test for Requirements

For all types of tests, none apply for requirements, they are all named according with the implementation components:

* Unit testing
* Integration testing
* System testing
* Sanity testing
* Smoke testing
* Interface testing
* Regression testing
* Beta/Acceptance testing

***But...*** This names can mean nothing, we can create test for any purpose we want! So, I'm proposing a new kind of test: ***Requirement Test***... Ok, [it already exists](https://www.tutorialspoint.com/software_testing_dictionary/requirements_based_testing)! No problem.

* First create A Test Suite based on the Domain, not on the implementation. Instead of `UserManagerTests`, just a `UserTests`class. 
* Then add all Requirement with a plain and complete text descriptions. This works fine on JUnit5
* If any test are failing, correct the code

```java
class UserTests {
   @Test
   @DisplayName("It SHOULD allow create Users without a name")
   void createWithoutNameTest() {
       // Do the tests
       fail();
   }

   @Test
   @DisplayName("It SHOULD only requires username and password")
   void createWithMinimumPropertiesTest() {
       // Do the tests
       fail();
   }
}
```

It is important to keep this tests in all changes, because this tests keep a memory of all requirements.

## Tips

* The more you abuse of words like **SHOULD**, **NEVER**, **ALWAYS** or **CAN** better is your description. 
* Keep in mind the desired behaviour should be expressed as a **Test** and a **Test Description**. Any future development should know why all theses tests exists.
* Keep in mind that in a future modification, the developer cannot talk with you, but he can see what you were thinking in the moment of the change.

# Conclusion

Most of TDD approaches always talk about unit testing, but unit testing does not prevent you of any undesired requirement change. For that we purpose a Requirement Test. All requirement should be written as a Test. If any failed it cab be:
* The requirement has changed
* This change adds a bug in any other piece of code.