
# Consistency and positivity

## Asking good causal questions

> Sep 12. [**Slides.**](assets/slides/3-1_consistency_positivity.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3. Optionally, read [Hernán 2016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5207342/).

Good causal questions are structured so that credibility is strong for two key assumptions: positivity and consistency.

1. **Positivity.** Every population subgroup receives every treatment value with non-zero probability
2. **Consistency.** Potential outcomes $Y^A$ are well-defined and linked to observable data

After class, you will be ready for a discussion in lab related to a common violation of the consistency assumption when one unit's treatment affects another unit's outcome.

## Lab: Interference

> Sep 13

When defining causal effects, we often discuss the outcome $Y^a$ that a person would realize if they were exposed to treatment value $a$. But definitions become harder if there exists **interference**: the outcome of unit $i$ depends on the treatment assigned to unit $j$. This discussion will address how to ask and answer causal questions in the presence of interference.
