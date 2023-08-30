
# (PART) Identification by exchangeability {-}

# Exchangeability and experiments

## Randomized experiments

> Aug 29. [**Slides**](assets/slides/2-1_random_experiments.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2 through the end of 2.1.

Much of this course will address observational studies with non-randomized treatments. To set the stage, today we will first discuss why randomized experiments are so powerful when they are possible.

## Lab: Statistics review with math and simulations

> Aug 30. [**Slides**](assets/discussions/discussion2-slides.pdf)

The course will use several ideas from your previous coursework in statistics, including random variables, expected values, and independence. This lab will review these concepts in math and using simulations in R.

## Exchangeability and conditional randomization

> Aug 31. [**Slides**](assets/slides/2-2_exchangeability.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.2.

We will talk about why experiments are good: they help us ask precise causal questions, and they are a setting in which a key assumption (exchangeability) holds by design. We will discuss exchangeability in simple randomized experiments and in experiments that are conditionally randomized so that treatment assignment probabilities are functions of pre-existing characteristics.

## Standardization

> Sep 5. After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.3.

Standardization is an important statistical procedure with two steps:

* estimate the causal effect in each population subgroup
* average over the population distribution of subgroups

In conditionally randomized experiments, standardization is essential to yield unbiased estimates of the population average causal effect. This strategy will also be essential in observational studies that we will discuss soon.

By the end of class, you will be able to

* understand the idea of standardization
* recognize equality between standardization and inverse probability of treatment weighting

## Lab: Analyze a randomized experiment

> Sep 6

This lab will use R to analyze data from a randomized experiment in which households were randomized to receive mailers encouraging them to vote, and the researchers examined effects on voter turnout ([Gerber, Green, & Larimer 2008](https://doi.org/10.1017/S000305540808009X)).

## Exchangeability

> Sep 7. After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3.1 and 3.2.

This class will introduce three key ideas:

1. **Exchangeability.** The assumption that treated and untreated units are **exchangeable** in the sense that the observed potential outcome for one set is informative about the unobserved potential outcome for the other set.
2. **Conditional exchangeability.** The assumption that exchangeability holds within subpopulations where a vector of pre-treatment variables $\vec{L}$ takes a constant value $\vec\ell$
