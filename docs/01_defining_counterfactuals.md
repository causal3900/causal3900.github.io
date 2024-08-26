
# Defining counterfactuals

To see the lecture slides from Fall 2023, [click here](https://causal3900.github.io/fa23/defining-counterfactuals.html). Updated slides will be linked below as soon as they are available.

## Observing versus intervening

> Aug 27. [**Slides**]()

Statistical inference is about observing: if I observe a sample from a population, what can I infer about that population? Causal inference is about intervening: if I take a sample from a population and intervene to change some exposure, what average outcome would result?

Today we will discuss observing, intervening, and why the difference is so important.

## Lab: Designing a study

> Aug 28

In this lab, we will start by getting to know one another. Then, we will discuss a hypothetical scenario.

A researcher (with whom you may disagree) says to you:
  > Coming to office hours frequently causes student success in the classroom.

In groups of about 3 students, discuss the following.

1. Imagine it is the **start** of the semester. How would you design a randomized experiment to assess this claim?
     * Imagine that you can assign students to a treatment condition and they will comply
     * Consider the details: who would you enroll, how would you define frequently, how would you assess success, etc.
2. Imagine it is the **end** of the semester. No randomized study was run. You want to conduct an observational study using administrative records (and you get IRB approval to do this). How would you design an observational study to assess this claim?

There is no expectation to have clear answers now. Over the course of the semester we will learn to formalize these types of questions and their solutions.

## Defining causal effects

> Aug 29. [**Slides.**]() After class, read Chapter 1 of [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) and begin Homework 1.

Today we will define average causal effects in the potential outcomes framework.

By the end of class, you will be able to

* define potential outcomes
* explain the Fundamental Problem of Causal Inference^[Holland [1986](https://doi.org/10.2307/2289064)]
* recall statistical concepts: random variables, expectation, conditional expectation
