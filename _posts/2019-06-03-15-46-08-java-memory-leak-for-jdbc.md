---
title: "Java Memory Leak for JDBC"
permalink: /posts/java-memory-leak-for-jdbc
published: true
description: "Have you ever used custom ClassLoaders in Java? This is a troubleshooting for whom is using it."
noimage: true
publish_date: 2019-06-03 15:46:08 +0300
tags: [Java, JDBC, Memory Leak, Garbage Collector]
original: "https://dev.to/vepo/java-memory-leak-for-jdbc-5dnn"
replicated: ["https://medium.com/@vepo/outofmemory-why-occurs-and-how-to-fix-it-c28a7fa16690"]
comments: true
---

# The Context

I had written an engine using a custom ClassLoader. To do that just create a new [URLClassLoader](https://docs.oracle.com/javase/7/docs/api/java/net/URLClassLoader.html), load a jar and execute what code you want, than close the URLClassLoader. If the new ClassLoader doesn't have access to the current ClassLoader, the loaded classes does not have access to your code. Good! Very Good!

```java
URL[] jars = new URL[] { /* The jars to be loaded */ }; //
try (URLClassLoader classLoader = new URLClassLoader(jars)) {
    Job job = classLoader.loadClass(Job.class.getName());
    job.execute();
}
```


# The Problem 

But... We do not have control with the code loaded from an external Jar. That is the problem. So if you want to avoid memory leaks the your custom classloader should be released by Garbage Collector. If the loaded code uses JDBC you will soon get an OutOfMemoryError and everything will crash! Not good!

# The reason
Whe JDBC loads the driver they assumes that you will use only one ClassLoader, so  it create a reference to your ClassLoader. This reference prevents the Garbage Collector from removing your custom ClassLoader from the memory.

![](https://thepracticaldev.s3.amazonaws.com/i/789mmfr2dkp8ezgm2p91.png)

So, even if you create your ClassLoader, execute your code and close it. The total of loaded classes will never decrease.

# How to solve?

To solve this problem we have to unregister all JDBC drivers just after the execution, than close URLClassLoader.

```java
URL[] jars = new URL[] { /* The jars to be loaded */ }; //
try (URLClassLoader classLoader = new URLClassLoader(jars)) {
  Job job = classLoader.loadClass(Job.class.getName());
  job.execute();
  Collections.list(DriverManager.getDrivers()).forEach(driver -> {
    try {
      DriverManager.deregisterDriver(driver);
    } catch (SQLException e) {
      logger.error("Error unregistering driver!", e);
    }
  });
} 
```

Now, let's look for the loaded classes:

![](https://thepracticaldev.s3.amazonaws.com/i/xzaa7ftdokc0078tg9n5.png)

# Possible problems

1. If the executed code create any Thread, the URLClassLoader is not eligible for Garbage Collector.
2. If some library create any Thread, same problem from #1.
3. MongoDb client create a Thread. 😫