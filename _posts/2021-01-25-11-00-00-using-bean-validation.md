---
title: Using Bean Validation on Quarkus.io
permalink: /posts/using-bean-Validation-on-quarkus
published: true
description: A minimal how-to of how to use Bean Validation on Quarkus.io
tags: [Quarkus, Java, Bean Validation, Hibernate]
cover_image: /assets/images/data-center.jpg
series: Quarkus Tutorial
publish_date: 2021-01-25 11:00:00 +0300
---

[Jakarta Bean Validation](https://beanvalidation.org/latest-draft/spec/) is a very useful specification. I can't find any reason to do not use it. If you know, please share with me.

## The worst way to do it

Validation is a boring feature. It is important, but most of the time it pollutes the code. You have to check function by function if all values are according to the expected.

So, let's imagine the in the code of our Step 02 we need to validate that the `username` is a String not empty, with a minimum size of 4 and a maximum of 15 and no whitespace. How can we do it?

```java
@POST
@Produces(MediaType.APPLICATION_JSON)
public User create(CreateUserRequest request) {
    Objects.requireNonNull(request.getUsername(), "\"username\" cannot be null!");
    if (request.getUsername().isBlank()) {
        throw new BadRequestException("\"username\" may not be blank");
    } else if (!request.getUsername().matches("^[a-zA-Z][a-zA-Z0-9]+$")) {
        throw new BadRequestException("\"username\" should start with a letter and should only accept letters and numbers");
    } else if (request.getUsername().length() < 4 || request.getUsername().length() > 15) {
        throw new BadRequestException("\"username\" should have size [4,15]");
    }
    return users.create(User.builder()
                            .email(request.getEmail())
                            .username(request.getUsername())
                            .firstName(request.getFirstName())
                            .lastName(request.getLastName()).admin(request.isAdmin())
                            .hashedPassword(request.getHashedPassword())
                            .build());
}
```

Jakarta Bean Validation allow us to remove all this code and replace with simple annotations.

## Configuring JPA in an existent Quarkus Project

To enable Jakarta Bean Validation, you should add it's implementation to Quarkus, that is [Hibernate Validator](https://hibernate.org/validator/).

```xml
<dependency>
    <groupId>io.quarkus</groupId>
    <artifactId>quarkus-hibernate-validator</artifactId>
</dependency>
```

That is all you need! Now you just need to configure where you will use and what fields you want to validate.

## Requiring Valid Parameters

The next step, you should inform Quarkus, where you want to use the validate. From the example above, we can remove all validation lines and just add the annotation `javax.validation.Valid`.

```java
@POST
@Produces(MediaType.APPLICATION_JSON)
public User create(@Valid CreateUserRequest request) {
    return users.create(User.builder()
                            .email(request.getEmail())
                            .username(request.getUsername())
                            .firstName(request.getFirstName())
                            .lastName(request.getLastName()).admin(request.isAdmin())
                            .hashedPassword(request.getHashedPassword())
                            .build());
}
```

Then we need to inform Quarkus the logic for this validation, it can be done inside CreataUserRequest class. We will use the annotations `Email`, `NotBlank`, `Pattern` and `Size`.

```java
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class CreateUserRequest {

    @Email
    @NotBlank(message = "email may not be blank")
    private String email;

    @Size(min = 4, max = 15, message = "username should have size [{min},{max}]")
    @NotBlank(message = "username may not be blank")
    @Pattern(regexp = "^[a-zA-Z][a-zA-Z0-9]+$", message = "\"username\" should start with a letter and should only accept letters and numbers")
    private String username;

    @NotBlank(message = "firstName may not be blank")
    private String firstName;

    @NotBlank(message = "lastName may not be blank")
    private String lastName;

    private boolean admin;

    @NotBlank(message = "hashedPassword may not be blank")
    private String hashedPassword;

    // [Getters and Setters]
}
```

This can be used in any Managed Bean inside Quarkus, but if you used on Endpoints it will enable HTTP validation returning a Bad Request response, as we can see in the response bellow. This is not a good way to present errors on a REST API, but at least follow some patterns as returning the correct HTTP Status Code and informing all constraint violations.

```json
{
    "classViolations": [],
    "parameterViolations": [
        {
            "constraintType": "PARAMETER",
            "message": "\"username\" should start with a letter and should only accept letters and numbers",
            "path": "create.request.username",
            "value": "2vepo"
        }
    ],
    "propertyViolations": [],
    "returnValueViolations": []
}
```

If you need to add validation for a parameter that you do not implement the class, like a `String` or a primitive type, you can use the annotations directly on the bean parameter. In this case, you can omit the `Valid`.

```java
public Optional<User> findByUsername(@Size(min = 4, max = 15) String username) {
    TypedQuery<User> query = em.createNamedQuery("User.findByUsername", User.class);
    query.setParameter("username", username);
    return query.getResultStream().findFirst();
}
```

## Creating Custom Validations

Now that we are able to use the Built-in validations, let's create some custom validators. First, we need to define the annotation for it. It should have the following pattern.

```java
@Documented
@Constraint(validatedBy = ReservedWordValidator.class)
@Target({
    METHOD,
    FIELD,
    ANNOTATION_TYPE,
    CONSTRUCTOR,
    PARAMETER,
    TYPE_USE })
@Retention(RUNTIME)
@Repeatable(ReservedWords.class)
@SupportedValidationTarget(ANNOTATED_ELEMENT)
@ReportAsSingleViolation
public @interface ReservedWord {
    String value();

    String message() default "You are using a Reserved Word";

    Class<? extends Payload>[] payload() default {};

    Class<?>[] groups() default {};
}
```

In our case, we are creating a `Repeatable` just for an example, but you can set any kind of Type for value. Then we need to declare and implement the Validator. As you can see, we are already linking the Validator with the Annotation using `@Constraint(validatedBy = ReservedWordValidator.class)`, now we only need to implement it.

```java
public class ReservedWordValidator implements ConstraintValidator<ReservedWord, String> {

    private String word;

    @Override
    public void initialize(ReservedWord wordAnnotation) {
        this.word = wordAnnotation.value();
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return value.compareToIgnoreCase(word) != 0;
    }

}
```

Now you can use it in your service.

## Executing and Testing

With the database running you only need to start the Quarkus using maven.

```bash
mvn quarkus:dev
```

In our example, we have provided 2 endpoints where you can test with valid and invalid parameters.

* Create an User: `POST /user`
* Find User by Username: `GET /user/{username}`

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/f9fc24e64abbfb3aac90)

You can find all the code on github.com/vepo/quarkus-tutorial.

{% github https://github.com/vepo/quarkus-tutorial %}

## Design by Contract

The most important concept on Validating parameters is **Design By Contract**. A contract defines your rights and responsibility, if you define a contract you will not handle values outside that contract. And using Bean Validation enables you to implement Orthogonal Contracts, keeping your code clear. You do not mix validation with business logic. And you don't need to replicate code, only adding an annotation you can spread validation in all your Managed Beans.

## Conclusion

Quarkus is easy to configure. You can remove a lot of code, only creating validations.

![Man drawing a Software Architecture diagram](https://dev-to-uploads.s3.amazonaws.com/i/e65xl1069bgqs8ge87wm.jpg)
Foto de Startup Stock Photos no Pexels