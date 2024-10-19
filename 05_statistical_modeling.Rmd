# Statistical modeling

## Why model?

> Oct 3. [**Slides.**](assets/slides/5-1_why_model.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 11.

To this point, we have not used any statistical models. Instead, we have

- taken means within subgroups
- then aggregated over subgroups

Today we will discuss how this strategy breaks down when there are many confounding variables, and thus many subgroups.

## Parametric Modeling

> Oct 8. [**Slides.**](assets/slides/5-3_ipw.pdf) Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 12.1--12.5.

Today will introduce how to estimate causal effects by directly modeling the outcome based on covariates. In addition, we will discuss how to model the probability of treatment, also known as the propensity score.


## Lab: Parametric g-formula

> Oct 9. [**Slides.**](assets/discussions/discussion6-gformula-.pdf)

Download the corresponding R Markdown file [**here**](assets/discussions/discussion6.Rmd).

Before discussion, make sure to download the data we'll be using. See the [Ed Discussion post](https://edstem.org/us/courses/62970/discussion/5445307) for more detail. 

After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 13 and 15.1.

Solutions to the lab exercise are [here](https://causal3900.github.io/solutions-parametric-g-formula-lab.html).


## Matching

> Oct 10. [**Slides.**](assets/slides/5-4_matching_intro.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 15.2.

Today will introduce the idea of matching and how it allows us to estimate the average treatment on the treated.


## Lab: Matching in R

> Oct 16. [**Slides.**](assets/discussions/matching_lab_slides.pdf)

In this lab, we'll go over distance metrics when matching on multiple covariates. We'll also go over examples of using R to do matching to estimate causal effects.

Download the [**R Markdown.**](assets/discussions/matching_lab.Rmd) file for today's lab; view the knit file [**here**](assets/discussions/matching_lab.html). *Submit your work on Canvas before you leave discussion!* [**Solutions**](assets/discussions/matching_lab_solutions.html)

If you finish the exact matching exercise early, work through this [R Markdown Notebook](assets/matching_examples.html) with further examples (download the [.Rmd file here](assets/matching_examples.Rmd)). There is also a video walking through the examples on canvas.


## Discussion of matching

> Oct 17 [**Slides.**](assets/slides/5-5_matching_cont.pdf) 

We'll wrap up our discussion of matching by introducing propensity score matching and coarsened exact matching. We'll also discuss combining regression with matching methods to estimate causal effects. 

