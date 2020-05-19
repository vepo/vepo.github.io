---
title: Algorithms - An introduction
published: true
description: What is an algorithm? How can we define an algorithm?
tags: [Algorithms, Computer Science]
cover_image: https://thepracticaldev.s3.amazonaws.com/i/r4m1fxs9otr17hcqfcq9.png
series: Algorithms
publish_date: 2020-01-09 12:47:30 +0300
---

> _The NOTION of an algorithm is basic to all computer programming._ 
> Donald E. Knuth

Even you do not care about algorithms, if you program in any programming language you use, produce and read algorithms. 

A Programming Language is the language you can express algorithms to the computer can undestand it. So, here I want to make a difference between Programming Languages and Presentation Languages. HTML for me is not a programming language... No worries if you believe it is. 🤓

{% dev_post 82209 %}

# Defining Algorithms

The [Oxford Dictionary](https://www.oxfordlearnersdictionaries.com/definition/english/algorithm) define algorithm as:

> A set of rules that must be followed when solving a particular problem.

Any computer program is developed to solve a problem. _Or to create a problem... no worries_ 😉

So a program **SHOULD** follow a Recipe, and that is the algorithm. This is ubiquitous in any computing.

## Characteristics

An algorithm is a recipe, but a recipe is not an algorithm. Why? You can undestand a recipe, but a computer cannot! You are much smarter than a computer. 

To be an algorithm, a set of rules must have the following features

1. Finiteness
2. Definiteness
3. Input
4. Output
5. Effectiveness


### 1. Finiteness

An algorithm **SHOULD** always terminate after a finite number of steps. 

There are some algorithms that search infinitely for a optimal value. Even this kind of algorithms should have a end, probably an finite number of iteractions or an _"stable"_ value. 

### 2. Definiteness

Each step of an algorithm **SHOULD** be precisely defined. 

You can make assumptions about something you read, but a computer cannot make any assumption. Each step should be precise.

![Alt Text](https://thepracticaldev.s3.amazonaws.com/i/4du0v0ungpy4zaqbe7hr.png)

Imagine an algorithm that says:

> Divide m by n and assign x with the value

This step is defined? No! You can make questions to this step: _Is x an Integer value?_ If we have `m=4` and `n=3`, the result in `x` can be `x=1` or `x=1.333`. Depending from the algorithm it can be any value.

The correct step shuold be:

> Assign the x (interger) with the value of m divided by n

In an algorithm there is no space for questions in steps.

### 3. Input

An algorithm has zero or more _inputs_.

### 4. Output

An algorithm has one or more _outputs_.

### 5. Effectiveness

All steps need to be effective, that means it should be simple enough to be done without any other knowledge

# Notation

For writing an algorithm we need:
* Numbered steps: We should be able to reffer to steps
* Pseudocode: We should be able to translate the algorithm in any programming language
* Given inputs
* Given outputs
* Assignments: This represents when a variable assume a new value. Normaly we use the notation `x ← y`where means that `x` will be attributed the value of `y`.

# Sorting a array

How can I sort an array of integers?

```
GIVEN:
    v    → The given array
    n    → The length of the given array
    x[i] → The value stored in the position i from the array x

START:
  S1: FOR EACH i IN [0, n - 2]:
  S2:   min_index ← i
  S3:   FOR EACH j IN [i + 1, n - 1]:
  S4:     IF v[j] < v[min_index]?
  S5:       min_index ← j
  S6:   IF v[i] != v[min_index]?
  S7:     aux ← v[min_index]
  S8:     v[min_index] ← v[i]
  S9:     v[i] ← aux
```

About this algorithm we can ask:

1. **Is it finite?** Yes, it will iterate over the array.
2. **Is it definite?** Yes, every step can be done without any assumption.
3. **What is the input?** The array and it's length.
4. **What is the output?** The same array, every change is made inplace
5. **Is it effective?** Yes, it will sort any array.

## Running with the pen

```
GIVEN: 
  v = [5, 100, -6, 98, -111, 0]
  n = 6

  S1: i ← 0                                v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S2: min_index ← 0                        v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S3: j ← 1                                v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S4: v[1] < v[0] ? (100 < 5)    NO        v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S3: j ← 2                                v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S4: v[2] < v[0] ? (-6 < 5)     YES       v = [5, 100, -6, 98, -111, 0]   min_index = 0   aux = 0
  S5: min_index ← 2                        v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S3: j ← 3                                v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S4: v[3] < v[2] ? (98 < -6)    NO        v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S3: j ← 4                                v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S4: v[4] < v[2] ? (-111 < -6)  YES       v = [5, 100, -6, 98, -111, 0]   min_index = 2   aux = 0
  S5: min_index ← 4                        v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = 0
  S3: j ← 5                                v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = 0
  S4: v[5] < v[4] ? (0 < -111)   NO        v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = 0
  S6: v[0] != v[4] ? (5 != -111) YES       v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = -111
  S7: aux ← -111                           v = [5, 100, -6, 98, -111, 0]   min_index = 4   aux = -111
  S8: v[4] ← 5                             v = [5, 100, -6, 98, 5, 0]      min_index = 4   aux = -111
  S9: v[0] = -111                          v = [-111, 100, -6, 98, 5, 0]   min_index = 4   aux = -111
  S1: i ← 1                                v = [-111, 100, -6, 98, 5, 0]   min_index = 4   aux = -111
  S2: min_index ← 1                        v = [-111, 100, -6, 98, 5, 0]   min_index = 1   aux = -111
  S3: j ← 2                                v = [-111, 100, -6, 98, 5, 0]   min_index = 1   aux = -111
  S4: v[2] < v[1] ? (-6 < 100)   YES       v = [-111, 100, -6, 98, 5, 0]   min_index = 1   aux = -111
  S5: min_index ← 2                        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S3: j ← 3                                v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S4: v[3] < v[2] ? (98 < -6)    NO        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S3: j ← 4                                v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S4: v[4] < v[2] ? (5 < -6)     NO        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S3: j ← 5                                v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S4: v[5] < v[2] ? (0 < -6)     NO        v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S6: v[1] != v[2] ? (100 != -6) YES       v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -111
  S7: aux ← -6                             v = [-111, 100, -6, 98, 5, 0]   min_index = 2   aux = -6
  S8: v[2] ← 100                           v = [-111, 100, 100, 98, 5, 0]  min_index = 2   aux = -6
  S9: v[1] = -6                            v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S1: i ← 2                                v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S2: min_index ← 2                        v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S3: j ← 3                                v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S4: v[3] < v[2] ? (98 < 100)   NO        v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S3: j ← 4                                v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S4: v[4] < v[2] ? (5 < 100)    YES       v = [-111, -6, 100, 98, 5, 0]   min_index = 2   aux = -6
  S5: min_index ← 4                        v = [-111, -6, 100, 98, 5, 0]   min_index = 4   aux = -6
  S3: j ← 5                                v = [-111, -6, 100, 98, 5, 0]   min_index = 4   aux = -6
  S4: v[5] < v[4] ? (0 < 5)      YES       v = [-111, -6, 100, 98, 5, 0]   min_index = 4   aux = -6
  S5: min_index ← 5                        v = [-111, -6, 100, 98, 5, 0]   min_index = 5   aux = -6
  S6: v[2] != v[5] ? (100 != 0)  YES       v = [-111, -6, 100, 98, 5, 0]   min_index = 5   aux = -6
  S7: aux ← 0                              v = [-111, -6, 100, 98, 5, 0]   min_index = 5   aux = 0
  S8: v[5] ← 100                           v = [-111, -6, 100, 98, 5, 100] min_index = 5   aux = 0
  S9: v[2] = 0                             v = [-111, -6, 0, 98, 5, 100]   min_index = 5   aux = 0
  S1: i ← 3                                v = [-111, -6, 0, 98, 5, 100]   min_index = 2   aux = 0
  S2: min_index ← 3                        v = [-111, -6, 0, 98, 5, 100]   min_index = 3   aux = 0
  S3: j ← 4                                v = [-111, -6, 0, 98, 5, 100]   min_index = 3   aux = 0
  S4: v[4] < v[3] ? (5 < 98)     YES       v = [-111, -6, 0, 98, 5, 100]   min_index = 3   aux = 0
  S5: min_index ← 4                        v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S3: j ← 5                                v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S4: v[5] < v[4] ? (100 < 5)    NO        v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S6: v[3] != v[4] ? (98 != 5)   YES       v = [-111, -6, 0, 98, 5, 100]   min_index = 4   aux = 0
  S7: aux ← 5                              v = [-111, -6, 0, 98, 5, 100]   min_index = 5   aux = 5
  S8: v[4] ← 98                            v = [-111, -6, 0, 98, 98, 100]  min_index = 5   aux = 5
  S9: v[3] = 5                             v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S1: i ← 4                                v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S2: min_index ← 4                        v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S3: j ← 5                                v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
  S4: v[5] < v[4] ? (100 < 98)   NO        v = [-111, -6, 0, 5, 98, 100]   min_index = 5   aux = 5
```

As we can see, given the input `[5, 100, -6, 98, -111, 0]`, it returns the output `[-111, -6, 0, 5, 98, 100]`. So in the output there is no value `v[i]` and `v[j]` where `i < j` and `v[i] > v[j]`, that means the array is sorted.