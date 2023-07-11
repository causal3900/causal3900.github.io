
# Consistency and positivity

## Two key assumptions

> Sep 12. After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3.3--3.5.

This class will introduce two key assumptions: positivity and consistency.

1. **Positivity.** Every population subgroup receives every treatment value with non-zero probability
2. **Consistency.** Potential outcomes $Y^A$ are well-defined and linked to observable data

After class, you will be ready for a discussion in lab related to the consistency assumption.

## Lab: Interference

> Sep 13

When defining causal effects, we often discuss the outcome $Y^a$ that a person would realize if they were exposed to treatment value $a$. But definitions become harder if there exists **interference**: the outcome of unit $i$ depends on the treatment assigned to unit $j$. If improperly addressed, interference can violate the consistency assumtion.

In this lab, the TA will present an example study where interference is likely to be present and we will discuss how to expand our potential outcome notation to accomodate interference.
