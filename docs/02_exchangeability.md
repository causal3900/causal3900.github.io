# (PART) Identification by exchangeability {-}

# Exchangeability and experiments


## Randomized experiments

> Sep 2. [**Slides.**](assets/slides/2-1_random_experiments.pdf)
After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2 through the end of 2.1.

Much of this course will address observational studies with non-randomized treatments. To set the stage, today we will first discuss why randomized experiments are so powerful when they are possible.

## Lab: Analyze a randomized experiment

> Sep 3. [**Discussion**](discussion-2.-analyzing-an-experiment-in-r)

This lab will use R to analyze data from a randomized experiment in which households were randomized to receive mailers encouraging them to vote, and the researchers examined effects on voter turnout ([Gerber, Green, & Larimer 2008](https://doi.org/10.1017/S000305540808009X)). Download the R Markdown file [**here**](assets/discussions/discussion02.Rmd).

## Exchangeability and conditional randomization

> Sep 4. [**Slides.**](assets/slides/2-2_exchangeability.pdf)
After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.2 & 2.3.

We talk about why experiments are good: they are a setting in which a key identification assumption (exchangeability) holds by design. We further discuss why exchangeability is important: it allows us to link causal quantities to observable data. We discuss exchangeability in simple randomized experiments and in experiments that are conditionally randomized so that treatment assignment probabilities are functions of pre-existing characteristics.

## Standardization and effect measures

> Sep 9. [**Slides from 2024.**](assets/slides/2-3_standardization.pdf)
After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.4.

Stratification allows us to estimate the average causal effect within a subpopulation, or strata, also known as the conditional average treatment effect. Standardization is an important statistical procedure that allows us to estimate the population average treatment effect by taking a weighted average over the subpopulations. 

In conditionally randomized experiments, standardization is essential to yield unbiased estimates of the population average causal effect. This strategy will also be essential in observational studies that we will discuss soon.

## Lab: Analyze a randomized experiment

> Sep 10. [**Slides from 2024.**](assets/discussions/discussion3-analyzing-experiment.pdf)

This lab will use R to analyze data from a randomized experiment in which households were randomized to receive mailers encouraging them to vote, and the researchers examined effects on voter turnout ([Gerber, Green, & Larimer 2008](https://doi.org/10.1017/S000305540808009X)). Download the R Markdown file [**here**](assets/discussions/discussion3.Rmd).

## Inverse probability weighting

> Sep 11. [**Slides from 2024.**](assets/slides/2-4_ipw.pdf)
After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapters 3.1 and 3.2.

This class will introduce inverse probability weighting as an approach to estimate average causal effects when conditional exchangeability holds.

