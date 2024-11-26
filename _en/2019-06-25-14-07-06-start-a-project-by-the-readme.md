---
title: Start a project by the README
published: true
publish_date: 2019-06-25 14:07:06 +0300
description: Before start code, describe what you are doing...
tags: [Software Documentation, README, Documentation]
cover_image: /assets/images/docs-100-42.webp
original: "https://dev.to/vepo/start-a-project-by-the-readme-4c49"
permalink: /en/start-a-project-by-the-readme
redirect_from:
  - /posts/start-a-project-by-the-readme

---

In the last months I'm investing my time in learning how write a good documetation. 

Almost all projects I had worked had a lack of documentation. If you have already try to start develop/use any project, you probably had to face with the problem of knowing where to start.

So here is my approache of how to build a well documented project

# 1. Starting describing your project

Be short! Describe you project in few lines.

## Good Example

A good example is [Zookeeper](http://zookeeper.apache.org/) description:

_ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services._

In the first line you know what problem you an solve with this project. If you continue to reading there is a more detailed description. Good!

## Bad Example

A bad example is [Kafka](https://kafka.apache.org/intro) description:

_Apache Kafka® is a distributed streaming platform. What exactly does that mean?_

The documentation is clear that the reader will not undestand!! If you continue to read, it will describe _real time pipelines_, _clusters_, etc... But what the main porpuse of Kafka?

If I had to rewrite Kafka documentation, this will be the second item from it. The first will be a short description of **What is** Kafka and **Which type of problem it solves**.

## Tips

1. Avoid own defined terms. Use commons terms
2. Be short. Few and short lines.
3. Answer questions.

## Briefly... 
A good description is a short text that answer two question. What is and Which type of problem solves.

# 2. After describing you project, explain hidden ideas

The second section of my READMEs are the **Rational** section. Here I quickly list all ideas behind my code. 

Let's imagine we are building a new NoSQL database. 

The first thought a user can have is: _I lost all my SQL validations?_

The first thought a developer can have is: _Can we add some kind of validations?_

Both questions are welcome, but it can be answer with a single line in this session:

* This achieve a High-Throughput, no validation will be done by the database.

Any important idea **SHOULD** be described in this session shortly. If more information is need, you can add a link to another README explain it.

# 3. Explain Resources and Terms

Does your project define any term? Explain here.

Does your project uses a own file format? Explain here.

Imagine that I'm building a Business Rule Engine, all business rule must be written in a specifica file format. You should explain shortly what is this file format and create a specific README file for it:

* BR file defines a single Business Rule. (More information link)

# 4. Explain behaviour and Interactions

Explain how your code works. A user or a developer should know how your project works. If you are developing a Message Queue, here is a good place where you can describe shortly how a message will be delivered to all (or not to all) clients.

# 5. Describe which API you provide

Do you provide a REST API? An Java library? A C library? Describe the key points for the provided API. Shortly! 

# Be short!

In the main README file you **SHOULD** be shortly. This is not the place where you will deeply explain everything, this is the place to show key concepts.

# Be consistent!

What if a change on the code change something related with what is written in the README? This is the main problem that occurs in software development. The documentation is not consistent with the code.

For each project you should define your own **Definition Of Done**. If the change does not reflects the documention, so the change is not ready!

# Concluding

When you listen that *the documentation is the code*, do not touch in this code! Every line of code there is a hidden idea that sometimes are not expressed because it cannot be expressed in code. 

{% twitter https://twitter.com/unclebobmartin/status/870311898545258497 %}

The idea of Uncle Bob is well accepted in simple projects, but what if the project has some architectural complex decisions? How can express it without a README or some comments?

# More

You can add more sections to your main README file. But you should be short.
