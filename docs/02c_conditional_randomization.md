
# Conditional randomization

**Aug 31**

> Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.2.

In a conditionally randomized experiment, treatment $A$ is assigned to units randomly with assignment probabilities that differ as a function of pre-existing characteristics $\vec{L}$. Conditional randomization is useful for two reasons.

1. **Improved precision.** If the potential outcome $Y^1$ has higher variance than the outcome $Y^0$ in some population subgroup with $\vec{L} = \vec\ell$, then assigning more units to $A = 1$ in this subgroup will improve precision
2. **Analogy to observational studies.** For our purposes, conditional randomization is the notion that makes observational studies possible: when treatment is not actually randomized, we often hope that it is approximately random within population subgroups. We discuss conditional randomization to set the stage for coming classes that will make use of this analogy.

