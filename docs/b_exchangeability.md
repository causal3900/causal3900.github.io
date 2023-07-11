
# Exchangeability and experiments

## Randomized experiments (Aug 29)

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2 through the end of 2.1.

Much of this course will address observational studies with non-randomized treatments. To set the stage, today we will first discuss why randomized experiments are so powerful when they are possible.

## Lab: Using R to analyze an experiment (Aug 30)

## Conditional randomization (Aug 31)

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.2.

In a conditionally randomized experiment, treatment $A$ is assigned to units randomly with assignment probabilities that differ as a function of pre-existing characteristics $\vec{L}$. Conditional randomization is useful for two reasons.

1. **Improved precision.** If the potential outcome $Y^1$ has higher variance than the outcome $Y^0$ in some population subgroup with $\vec{L} = \vec\ell$, then assigning more units to $A = 1$ in this subgroup will improve precision
2. **Analogy to observational studies.** For our purposes, conditional randomization is the notion that makes observational studies possible: when treatment is not actually randomized, we often hope that it is approximately random within population subgroups. We discuss conditional randomization to set the stage for coming classes that will make use of this analogy.

## Standardization (Sep 5)

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.3.

Standardization is an important statistical procedure with two steps:

* estimate the causal effect in each population subgroup
* average over the population distribution of subgroups

In conditionally randomized experiments, standardization is essential to yield unbiased estimates of the population average causal effect. This strategy will also be essential in observational studies that we will discuss soon.

By the end of class, you will be able to

* understand the idea of standardization
* recognize equality between standardization and inverse probability of treatment weighting

## Lab: Standardization with `group_by()` and `summarize()` (Sep 6)

This lab will practice standardization, using the `group_by()` and `summarize()` functions that are available as part of the [`tidyverse`](https://www.tidyverse.org/).

## Exchangeability (Sep 7)

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3.1 and 3.2.

This class will introduce three key ideas:

1. **Exchangeability.** The assumption that treated and untreated units are **exchangeable** in the sense that the observed potential outcome for one set is informative about the unobserved potential outcome for the other set.
2. **Conditional exchangeability.** The assumption that exchangeability holds within subpopulations where a vector of pre-treatment variables $\vec{L}$ takes a constant value $\vec\ell$
