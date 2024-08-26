
# (PART) Identification by exchangeability {-}

# Exchangeability and experiments

To see the lecture slides from Fall 2023, [click here](https://causal3900.github.io/fa23/exchangeability-and-experiments.html). Updated slides will be linked below as soon as they are available.

## Randomized experiments

> Sep 3. [**Slides.**]() After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2 through the end of 2.1.

Much of this course will address observational studies with non-randomized treatments. To set the stage, today we will first discuss why randomized experiments are so powerful when they are possible.

## Lab: Statistics review with math and simulations

> Sep 4. [**Slides.**]()

The course will use several ideas from your previous coursework in statistics, including random variables, expected values, and independence. This lab will review these concepts in math and using simulations in R.

## Exchangeability and conditional randomization

> Sep 5. [**Slides.**]() After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.2.

We will talk about why experiments are good: they help us ask precise causal questions, and they are a setting in which a key assumption (exchangeability) holds by design. We will discuss exchangeability in simple randomized experiments and in experiments that are conditionally randomized so that treatment assignment probabilities are functions of pre-existing characteristics.

## Standardization and effect measures

> Sep 10. [**Slides.**]() After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 1.3 and 2.3.

Standardization is an important statistical procedure with two steps:

* estimate the causal effect in each population subgroup
* average over the population distribution of subgroups

In conditionally randomized experiments, standardization is essential to yield unbiased estimates of the population average causal effect. This strategy will also be essential in observational studies that we will discuss soon.

By the end of class, you will be able to

* describe different ways to quantitatively measure a causal effect
* estimate the average causal effect using data from a conditionally randomized experiment

## Lab: Analyze a randomized experiment

> Sep 11. [**Slides.**]()

This lab will use R to analyze data from a randomized experiment in which households were randomized to receive mailers encouraging them to vote, and the researchers examined effects on voter turnout ([Gerber, Green, & Larimer 2008](https://doi.org/10.1017/S000305540808009X)).

## Inverse probability weighting

> Sep 12. [**Slides.**]() After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.4, 3.1, and 3.2.

This class will introduce inverse probability weighting as an approach to estimate average causal effects when conditional exchangeability holds.
