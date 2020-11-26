---
title: Configure JPA on Quarkus.io
permalink: /posts/configure-jpa-on-quarkus
published: true
description: A minimal how-to of how to configure JPA on Quarkus.io
tags: [Quarkus, Java, JPA, Hibernate]
cover_image: /assets/images/data-center.jpg
series: Quarkus Tutorial
publish_date: 2020-11-25 23:50:00 +0300
---

JPA is a specification from Jakarta EE that controls the Data Access Layer. The most common implementation for it is [Hibernate ORM](https://hibernate.org/orm/).

# Trade-offs

Choose technology involves a trade-off. I always thought that if I choose JPA, I will lose control of any generated SQL. And that is true!

JPA is an ORM, so most of the SQL is generated from a JPQL. If you do a bad design of your code, you will have SQL been generated at execution time, that is a bad design. In truth, horrible design.

But you will boost your coding speed. You will no more care about writing SQL or modelling the database. You can think in terms of objects, not tables. This does not mean that you will not care about modelling. In the first time is better to create the database model before, than design the objects according to what you want. This will avoid you creating some very commons Anti Patterns from JPA. I, have worked on a project where if you get a user from the database, you can load all objects associated with that user on the memory crashing the application.

It is important to know well the specification to create an optimal service, balancing database performance with development speed.

| Advantages | Aisadvantages |
|------------|---------------|
| Fast Coding | SQL is generated |
| Easy to change the model | Lack of support for NoSQL ¹ |
| Database agnostic | |

_¹ Use [JNoSQL](https://www.jnosql.org/) instead of JPA_

# Configuring JPA in an existent Quarkus Project

## Configure dependencies

So the first step is to configure the dependencies. For adding JPA you will have to add the Hibernate Plugin and the Database JDBC plugin. 

_Why we have two dependencies?_ This is one of the code ideas of JPA, it is database agnostic. You can change your database with almost no change on your code.

```xml
<dependency>
    <groupId>io.quarkus</groupId>
    <artifactId>quarkus-hibernate-orm</artifactId>
</dependency>
<dependency>
    <groupId>io.quarkus</groupId>
    <artifactId>quarkus-jdbc-postgresql</artifactId>
</dependency>
```

If you want to know which database you can use, just search on [mvnrepository.com](https://mvnrepository.com/search?q=jdbc&d=io.quarkus).

## Modeling the database

The next step we need to model the database. You probably have your database model using SQL, but you need to create Java POJOs that will map your data in your Java code.

For this example we will create a backend CRUD for User. That means we will create the Create, Read, Update and Delete endpoints for it.

So, to model we have to add the annotations:

| Annotation | Description |
|------------|-------------|
| `javax.persistence.Entity` | Specifies that the class is an entity. |
| `javax.persistence.Table` | Specifies the primary table for the annotated entity. |
| `javax.persistence.Id` | Specifies the primary key of an entity. |
| `javax.persistence.Column` | Specifies the mapped column for a persistent property or field. |

Not even all annotations are required, but you should do a good design of your code.

So I'm defining the User adding all required annotations, and some NamedQuery and a Builder. The builder is just a fancy code to improve the readability and the NamedQuery it will be used later to search for users.

```java
package io.vepo.tutorial.quarkus.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "tb_users", uniqueConstraints = {
    @UniqueConstraint(name = "uq_users_username", columnNames = {
        "username" }),
    @UniqueConstraint(name = "uq_users_email", columnNames = {
        "email" })
})
@NamedQuery(name = "User.findByUsernameAndHashedPassword", query = "SELECT usr FROM User usr WHERE usr.username = :username AND usr.hashedPassword = :hashedPassword AND usr.enabled = true")
@NamedQuery(name = "User.findByUsername", query = "SELECT usr FROM User usr WHERE usr.username = :username")
public class User {
    public static final class UserBuilder {
        private String email;
        private String username;
        private String firstName;
        private String lastName;
        private boolean admin;
        private String hashedPassword;

        private UserBuilder() {
        }

        public UserBuilder email(String email) {
            this.email = email;
            return this;
        }

        public UserBuilder username(String username) {
            this.username = username;
            return this;
        }

        public UserBuilder firstName(String firstName) {
            this.firstName = firstName;
            return this;
        }

        public UserBuilder lastName(String lastName) {
            this.lastName = lastName;
            return this;
        }

        public UserBuilder admin(boolean admin) {
            this.admin = admin;
            return this;
        }

        public UserBuilder hashedPassword(String hashedPassword) {
            this.hashedPassword = hashedPassword;
            return this;
        }

        public User build() {
            return new User(this);
        }
    }

    public static final UserBuilder builder() {
        return new UserBuilder();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String email;

    @Column
    private String username;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column
    private boolean admin;

    @Column(name = "hashed_password")
    private String hashedPassword;

    @Column(name = "enabled")
    private boolean enabled;

    public User() {
    }

    private User(UserBuilder builder) {
        email = builder.email;
        username = builder.username;
        firstName = builder.firstName;
        lastName = builder.lastName;
        admin = builder.admin;
        hashedPassword = builder.hashedPassword;
        enabled = true;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        User other = (User) obj;
        if (id == null) {
            if (other.id != null) {
                return false;
            }
        } else if (!id.equals(other.id)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", email=" + email + ", username=" + username + ", firstName=" + firstName
                + ", lastName=" + lastName + ", admin=" + admin + ", hashedPassword=" + hashedPassword + ", enabled="
                + enabled + "]";
    }

}
```

I want to point out some important things on this code. The `@Column` annotation is not required, if you omit does not mean that JPA will ignore, it will only read the column with the same name from the field. If you want a not persisted column, you should use create a `transient` field. If you have a compound name for the field, for example, `lastName`, if you do not specify the name in `@Column`, JPA will search for `lastName`, not `last_name`. I don't know if you have understood, but naming is important! All applications should follow naming conventions and the [SQL Naming Convetions](https://dzone.com/articles/a-guide-to-sql-naming-conventions) is different from [Java Naming Convetions](https://www.oracle.com/java/technologies/javase/codeconventions-namingconventions.html).

With the `@Column` you have more options, like `required` and `unique`. You can see all options on [Jakarta Documentation](https://jakarta.ee/specifications/persistence/2.2/apidocs/javax/persistence/Column.html).

For the `id` column, I have added two important annotations. `@Id` and `@GeneratedValue`are required to create a good design, but if you choose a different database probably it will have different values! 

I have added the Unique Constraints, this is not required, but as I'm creating the database automatically, I have to do it. In a future tutorial I will teach how to use Flyway to create automatically the database using SQL.

## Define the parameters

Hibernate requires few parameters to configure, you can put all in `src/main/resources/application.properties`. But you can also replace it using environment variables. This will take place later in a tutorial from Microprofile Config.

So we need to define the Database type and credentials and what Hibernate will do with the Schema. For production always use `quarkus.hibernate-orm.database.generation=validate`, but in our example, we will use `drop-and-create` recreating the database schema every deploy.

If you need to change more configurations properties, the [Quarkus documentation has a list of all available configurations](https://quarkus.io/guides/hibernate-orm#quarkus-hibernate-orm_configuration).

```properties
quarkus.datasource.db-kind = postgresql
quarkus.datasource.username = postgres
quarkus.datasource.password = password
quarkus.datasource.jdbc.url = jdbc:postgresql://localhost:5432/tutorial

quarkus.hibernate-orm.database.generation=drop-and-create
```

## Creating the database

To create the database, we will use Docker. So just execute the line bellow.

```bash
docker run --rm --name postgres-db -e POSTGRES_PASSWORD=password -e POSTGRES_DB=tutorial -p 5432:5432 -d postgres:13-alpine
```

If you want to use Postgres directly, just download and install it. It will work fine.

## Acessing the database

There is a lot of ways to access the database, but you should always use `javax.persistence.EntityManager`. I have created a service class called `Users` and added some methods to show the best way to access it.

```java
package io.vepo.tutorial.quarkus.user;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.transaction.Transactional;

@Transactional
@ApplicationScoped
public class Users {
    @PersistenceContext
    EntityManager em;

    public List<User> list() {
        CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
        CriteriaQuery<User> query = criteriaBuilder.createQuery(User.class);
        query.from(User.class);
        return em.createQuery(query).getResultList();
    }

    public User create(User user) {
        if (Objects.nonNull(user.getId())) {
            throw new IllegalStateException("Id should be null!");
        }
        em.persist(user);
        return user;
    }

    public Optional<User> findByUsername(String username) {
        TypedQuery<User> query = em.createNamedQuery("User.findByUsername", User.class);
        query.setParameter("username", username);
        return query.getResultStream().findFirst();
    }

    public User get(int userId) {
        return em.find(User.class, userId);
    }
}
```

### Using Criteria Builder

Using Criteria Builder is a good way when you need to generate dynamically the query. You will create the query programmatically, the API is not so easy to understand because it is very powerful.

### Using Named Query

For me, Named Queries is the best way to execute commons queries. You have to write the query on JPQL, not SQL. JPQL is very similar to SQL, but you can use the same query in different databases, Hibernate will translate it for you. It is better to use it than custom JPQL queries because it will compile it once.

### Using Query

You can create the query directly. But this is not a good approach! Every time you call `createQuery` it will compile the query.

```java
public Optional<User> findByUsername(String username) {
    TypedQuery<User> query = em.createQuery("SELECT usr FROM User usr WHERE usr.username = :username", User.class);
    query.setParameter("username", username);
    return query.getResultStream().findFirst();
}
```

### Access the data directly

If you have a Class and an Id, you can access the object directly.

```java
public User get(int userId) {
    return em.find(User.class, userId);
}
```

### Transactional Objects

As we are using a transactional object, all changes we do in the JPA object it will be updated on the database. Each object read from the database is attached to the current session.

## Executing and Testing

With the database running you only need to start the Quarkus using maven.

```bash
mvn quarkus:dev
```

In our example, we have provided 3 endpoints:

* List all Users: `GET /user`
* Create an User: `POST /user`
* Find User by Username: `GET /user/{username}`

You can find all code in the repository bellow.

{% github https://github.com/vepo/quarkus-tutorial %}

And you can test it using Postman.

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/f9fc24e64abbfb3aac90)

# Conclusion

If you want to develop fast and use databases, you should use JPA. You will not be worried about queries and knowing the JPA features and implementation, you can optimize the access from your database.

# Future Readings
* [Catálogo de Code Smells ORM](https://github.com/spgroup/ORM-Smells-Catalog)