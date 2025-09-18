
# Consistency and positivity

## Exchangeability in Observational Studies

> Sep 16. [**Slides**](assets/slides/3-1_goodQuestion_fa25.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3.4-3.5. Optionally, read [Hernán 2016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5207342/).

What makes causal inference with observational data so challenging? Why is making treatment precise so important? These are the topics we'll discuss in this lecture!


## Lab: Causal inference with interference

> Sep 17 [**Slides**](assets/discussions/discussion4-interference.pdf)

When defining causal effects, we often discuss the outcome $Y^a$ that a person would realize if they were exposed to treatment value $a$. But definitions become harder if there exists *interference*: the outcome of unit $i$ depends on the treatment assigned to unit $j$. This discussion will focus on understanding interference and why we need to update our potential outcomes notation if interference is present.


## Asking good causal questions

> Sep 18. [**Slides from 2024.**](assets/slides/3-2_good_questions.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3.3 & 3.6. 

Good causal questions are structured so that credibility is strong for two key assumptions: positivity and consistency.

1. **Positivity.** Every population subgroup receives every treatment value with non-zero probability
2. **Consistency.** Potential outcomes $Y^A$ are well-defined and linked to observable data

