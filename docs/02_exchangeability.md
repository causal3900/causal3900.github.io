
# (PART) Identification by exchangeability {-}

# Exchangeability and experiments

## Randomized experiments

> Aug 29. [**Slides.**](assets/slides/2-1_random_experiments.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2 through the end of 2.1.

Much of this course will address observational studies with non-randomized treatments. To set the stage, today we will first discuss why randomized experiments are so powerful when they are possible.

## Lab: Statistics review with math and simulations

> Aug 30. [**Slides.**](assets/discussions/discussion2-slides.pdf)

The course will use several ideas from your previous coursework in statistics, including random variables, expected values, and independence. This lab will review these concepts in math and using simulations in R.

## Exchangeability and conditional randomization

> Aug 31. [**Slides.**](assets/slides/2-2_exchangeability.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.2.

We will talk about why experiments are good: they help us ask precise causal questions, and they are a setting in which a key assumption (exchangeability) holds by design. We will discuss exchangeability in simple randomized experiments and in experiments that are conditionally randomized so that treatment assignment probabilities are functions of pre-existing characteristics.

## Standardization and effect measures

> Sep 5. [**Slides.**](assets/slides/2-3_standardization.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 1.3 and 2.3.

Standardization is an important statistical procedure with two steps:

* estimate the causal effect in each population subgroup
* average over the population distribution of subgroups

In conditionally randomized experiments, standardization is essential to yield unbiased estimates of the population average causal effect. This strategy will also be essential in observational studies that we will discuss soon.

By the end of class, you will be able to

* describe different ways to quantitatively measure a causal effect
* estimate the average causal effect using data from a conditionally randomized experiment

## Lab: Analyze a randomized experiment

> Sep 6. [**Link to Materials**](discussion-3.-analyzing-an-experiment-in-r.html).

This lab will use R to analyze data from a randomized experiment in which households were randomized to receive mailers encouraging them to vote, and the researchers examined effects on voter turnout ([Gerber, Green, & Larimer 2008](https://doi.org/10.1017/S000305540808009X)).

## Inverse probability weighting

> Sep 7. [**Slides.**](assets/slides/2-4_exchangeability.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.4, 3.1, and 3.2.

This class will introduce inverse probability weighting as an approach to estimate average causal effects when conditional exchangeability holds.
