--- 
title: "Causal Inference Course"
author: "Mayleen Cortez-Rodriguez and Sam Wang"
date: "2024-09-30"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
# url: your book url like https://bookdown.org/yihui/bookdown
# cover-image: path to the social sharing image like images/cover.jpg
description: |
  An undergraduate course on causal inference
biblio-style: apalike
csl: chicago-fullnote-bibliography.csl
---

# Welcome {-}

Cornell [STSCI](https://classes.cornell.edu/browse/roster/FA24/class/STSCI/3900) / [INFO](https://classes.cornell.edu/browse/roster/FA24/class/INFO3900) / [ILRST 3900](https://classes.cornell.edu/browse/roster/FA24/class/STSCI/3900). Causal Inference. Fall 2024.

Welcome! Together, we will learn to make causal claims by combining data with arguments.

Taught by [Y. Samuel Wang](https://ysamuelwang.com/), [Mayleen Cortez-Rodriguez](https://www.mayleencortez.com/), [Filippo Fiocchi](https://filippofiocchi.github.io/), and [Shira Mingelgrin](https://stat.cornell.edu/people/phds/shira-mingelgrin). Read about us [here](who-we-are)!

## Learning objectives {-}

As a result of participating in this course, students will be able to

* define counterfactuals as the outcomes of hypothetical interventions
* identify counterfactuals by causal assumptions presented in graphs
* estimate counterfactual outcomes by pairing those assumptions with statistical evidence

## Is this course for me? {-}

The course is designed for upper-division undergraduate students. We will assume familiarity with an introductory statistics course at the level of STSCI 2110, PAM 2100, PSYCH 2500, SOC 3010, ECON 3110, or similar courses.

Not a Cornell student? You are welcome to follow along on this site.

## Readings {-}

Especially in the beginning, this course draws heavily on

> Hernán, M.A., and J.M. Robins. 2020. [**Causal Inference: What If?**](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Boca Raton: Chapman \& Hall / CRC.

We are grateful to the authors for this excellent text.

## Organization of the site {-}

Each course module in the left panel will span several lectures. Within each module, the right panel will help you navigate. We will build this site over the course of the semester, uploading lecture slides as we go. [Who we are](Who we are) tells you a bit about the teaching team.

## Previous iterations of the course {-}
To access the course website from Fall 2023 [click here](https://causal3900.github.io/fa23). 


## Land acknowledgment {-}

We recognize the university land acknowledgment, as well as an additional emphasis from the [Cornell American Indian and Indigenous Studies Program](https://cals.cornell.edu/american-indian-indigenous-studies).

> Cornell University is located on the traditional homelands of the Gayogo̱hó:nǫɁ (the Cayuga Nation). The Gayogo̱hó:nǫɁ are members of the Haudenosaunee Confederacy, an alliance of six sovereign Nations with a historic and contemporary presence on this land. The Confederacy precedes the establishment of Cornell University, New York state, and the United States of America. We acknowledge the painful history of Gayogo̱hó:nǫɁ dispossession, and honor the ongoing connection of Gayogo̱hó:nǫɁ people, past and present, to these lands and waters.


> This land acknowledgment has been reviewed and approved by the traditional Gayogo̱hó:nǫɁ leadership.

> In addition to the Gayogo̱hó:nǫɁ land acknowledgment but separate from it, the AIISP faculty would like to emphasize: Cornell's founding was enabled in the course of a national genocide by the sale of almost one million acres of stolen Indian land under the Morrill Act of 1862. To date the university has neither officially acknowledged its complicity in this theft nor has it offered any form of restitution to the hundreds of Native communities impacted. For additional information, see the [Cornell University and Indigenous Dispossession](https://blogs.cornell.edu/cornelluniversityindigenousdispossession/) website.

<!--chapter:end:index.Rmd-->

# Defining counterfactuals

## Observing versus intervening

> Aug 27. [**Slides**](assets/slides/1-1_observing_intervening.pdf)
After class, install R and Rstudio on your computer (see slide 14 from today's lecture).

Statistical inference is about observing: if I observe a sample from a population, what can I infer about that population? Causal inference is about intervening: if I take a sample from a population and intervene to change some exposure, what average outcome would result?

Today we will discuss observing, intervening, and why the difference is so important.



## Lab: Designing a study

> Aug 28

In this lab, we will start by getting to know one another. Then, we will discuss a hypothetical scenario.

A researcher (with whom you may disagree) says to you:
  > Coming to office hours frequently causes student success in the classroom.

In groups of about 3 students, discuss the following.

1. Imagine it is the **start** of the semester. How would you design a randomized experiment to assess this claim?
     * Imagine that you can assign students to a treatment condition and they will comply
     * Consider the details: who would you enroll, how would you define frequently, how would you assess success, etc.
2. Imagine it is the **end** of the semester. No randomized study was run. You want to conduct an observational study using administrative records (and you get IRB approval to do this). How would you design an observational study to assess this claim?

There is no expectation to have clear answers now. Over the course of the semester we will learn to formalize these types of questions and their solutions.

## Defining causal effects

> Aug 29. [**Slides.**](assets/slides/1-2_defining_causal_effects.pdf)
After class, read Chapter 1 of [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/).

Today we will define average causal effects in the potential outcomes framework.

By the end of class, you will be able to

* define potential outcomes
* explain the Fundamental Problem of Causal Inference^[Holland [1986](https://doi.org/10.2307/2289064)]
* recall statistical concepts: random variables, expectation, conditional expectation

<!--chapter:end:01_defining_counterfactuals.Rmd-->

# (PART) Identification by exchangeability {-}

# Exchangeability and experiments


## Randomized experiments

> Sep 3. [**Slides.**](assets/slides/2-1_random_experiments.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2 through the end of 2.1.

Much of this course will address observational studies with non-randomized treatments. To set the stage, today we will first discuss why randomized experiments are so powerful when they are possible.

## Lab: Statistics review with math and simulations

> Sep 4. [**Slides.**](assets/discussions/discussion2-probandstatsreview.pdf)

The course will use several ideas from your previous coursework in statistics, including random variables, expected values, and independence. This lab will review these concepts in math and using simulations in R. Download the R script demo [**here**](assets/discussions/discussion2.R)

## Exchangeability and conditional randomization

> Sep 5. [**Slides.**](assets/slides/2-2_exchangeability.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.2 & 2.3.

We talk about why experiments are good: they are a setting in which a key identification assumption (exchangeability) holds by design. We further discuss why exchangeability is important: it allows us to link causal quantities to observable data. We discuss exchangeability in simple randomized experiments and in experiments that are conditionally randomized so that treatment assignment probabilities are functions of pre-existing characteristics.

## Standardization and effect measures

> Sep 10. [**Slides.**](assets/slides/2-3_standardization.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 2.4.

Stratification allows us to estimate the average causal effect within a subpopulation, or strata, also known as the conditional average treatment effect. Standardization is an important statistical procedure that allows us to estimate the population average treatment effect by taking a weighted average over the subpopulations. 

In conditionally randomized experiments, standardization is essential to yield unbiased estimates of the population average causal effect. This strategy will also be essential in observational studies that we will discuss soon.

## Lab: Analyze a randomized experiment

> Sep 11. [**Slides.**](assets/discussions/discussion3-analyzing-experiment.pdf)

This lab will use R to analyze data from a randomized experiment in which households were randomized to receive mailers encouraging them to vote, and the researchers examined effects on voter turnout ([Gerber, Green, & Larimer 2008](https://doi.org/10.1017/S000305540808009X)). Download the R Markdown file [**here**](assets/discussions/discussion3.Rmd).

## Inverse probability weighting

> Sep 12. [**Slides.**](assets/slides/2-4_ipw.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapters 3.1 and 3.2.

This class will introduce inverse probability weighting as an approach to estimate average causal effects when conditional exchangeability holds.


<!--chapter:end:02_exchangeability.Rmd-->


# Consistency and positivity

## Exchangeability in Observational Studies

> Sep 17. [**Slides.**](assets/slides/3-1_intro.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3.4-3.5. Optionally, read [Hernán 2016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5207342/).

What makes causal inference with observational data so challenging? Why is making treatment precise so important? These are the topics we'll discuss in this lecture!


## Lab: Exchangeability and Consistency Review

> Sep 18 [**Slides.**](assets/discussions/discussion4-class_activity_solutions.pdf)

You will go through an activity to really hone in on the concepts of exchangeability and consistency. Download the class assignment [**here**](assets/discussions/discussion-9-18.pdf).

## Asking good causal questions

> Sep 19. [**Slides.**](assets/slides/3-2_good_questions.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 3.3 & 3.6. 

Good causal questions are structured so that credibility is strong for two key assumptions: positivity and consistency.

1. **Positivity.** Every population subgroup receives every treatment value with non-zero probability
2. **Consistency.** Potential outcomes $Y^A$ are well-defined and linked to observable data


<!--chapter:end:03_consistency_positivity.Rmd-->

# Directed Acyclic Graphs


## Marginal independence

> Sep 24. [**Slides.**](assets/slides/4-1_dags_marginal.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 6.1 and 6.2. For historical reference, optionally see [Greenland, Pearl, and Robins 1999](https://journals.lww.com/epidem/Abstract/1999/01000/Causal_Diagrams_for_Epidemiologic_Research.8.aspx).

This class will introduce key ideas about DAGs.

1. **Directed Acyclic Graph.** A series of nodes representing variables, connected by directed edges representing direct causal effects. Any node with an edge to at least two other nodes must be drawn on the graph.
2. **Path.** A path is a sequence of edges connecting two nodes
3. **Collider along a path.** A node such as $B$ where to directed edges collide: $A\rightarrow B \leftarrow C$. A collider blocks the path.

DAGs help us know if variables $A$ and $B$ are statistically related

* $A$ and $B$ are *marginally dependent* if and only if there exists an unblocked path connecting them
* $A$ and $B$ are *marginally independent* if and only if any paths connecting them are blocked


<script type="text/tikz">
  \begin{tikzpicture}
    \node (l) at (0,0) {$L$};
    \node (a) at (1,0) {$A$};
    \node (y) at (2,0) {$Y$};
    \draw[->] (l) -- (a);
    \draw[->] (a) -- (y);
    \draw[->] (l) to[bend right] (y);
  \end{tikzpicture}
</script>

## Lab: Project Overview

> Sep 25.  [**Slides.**](assets/discussions/discussion5-task1.pdf)

You can find information about the course project [**here**](https://causal3900.github.io/course-project.html). During discussion, we will walk through the [**project overview**](https://causal3900.github.io/assets/psets/project/project_overview.pdf) and the instructions for [**Task 1**](https://causal3900.github.io/assets/psets/project/task1.pdf). *Task 1 is due Thursday, October 3rd.*

## Conditional independence

> Sep 26. [**Slides.**](assets/slides/4-2_dag_conditional.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 6.3 and 6.4, and especially Fine Point 6.1 of which this page is an abbreviation.

Often, we want to condition on some set of variables $\vec{L}$ so that conditional exchangeability holds. 

A path is blocked if any node on the path is blocked. If every node on a path is open, then the entire path is open

1. A non-collider is blocked if is conditioned on, otherwise it is open
2. A collider is open if it or any of its descendants are conditioned on. Otherwise it is blocked


## Sufficient adjustment sets

> Oct 1. [**Slides.**](assets/slides/4-3_adjustment_sets.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) 7.1--7.4.

When marginal exchangeability does not hold, we may be able to condition on some set of variables $\vec{L}$ so that conditional exchangeability holds. We can accomplish this by blocking all non-causal paths between $A$ and $Y$. A set that does that is called a sufficient adjustment set. To find a sufficient adjustment set, we will use the backdoor criterion:

1. The set $L$ blocks all backdoor paths
2. The set $L$ does not contain any descendants of $A$

<!--chapter:end:04_dags.Rmd-->


# Statistical modeling

## Why model?

> Sep 26. [**Slides.**](assets/slides/5-1_why_model.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 11.

To this point, we have not used any statistical models. Instead, we have

- taken means within subgroups
- then aggregated over subgroups

Today we will discuss how this strategy breaks down when there are many confounding variables, and thus many subgroups.

## Lab: Parametric g-formula

> Sep 27. Download the corresponding R Markdown file [**here**](assets/discussions/discussion6.Rmd).

Before discussion, make sure to download the data we'll be using. See the Ed Discussion post for more detail. 

After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 13 and 15.1.

[**Solutions**](assets/discussions/discussion6-solutions.html) for lab exercise and [**slides**](assets/discussions/discussion6-slides.pdf)

## Inverse probability of treatment weighting

> Sep 28. [**Slides.**](assets/slides/5_3_ipw.pdf) Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 12.1--12.5.

Today will introduce how to estimate causal effects by modeling the probability of treatment, also known as the propensity score.

## Matching

> Oct 3. [**Slides.**](assets/slides/5-4_matching_intro.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 15.2.

Today will introduce the idea of matching and how it allows us to estimate the average treatment on the treated.

## Lab: Matching in R

> Oct 4. [**Slides.**](assets/discussions/discussion7.pdf) [**R Markdown.**](assets/discussions/matching_lab.Rmd)

In this lab, we'll go over distance metrics when matching on multiple covariates. We'll also go over examples of using R to do matching to estimate causal effects.

## Discussion of matching

> Oct 5 [**Slides.**](assets/slides/5-5_matching_cont.pdf) [**R Markdown.**](assets/slides/matching_cont.Rmd)

We'll wrap up our discussion of matching by introducing propensity score matching and coarsened exact matching. We'll also discuss combining regression with matching methods to estimate causal effects. 

## Lab: Final Project + HW4 Q&A

> Oct 10 [**Slides**](assets/discussions/discussion8.pdf)

We'll talk about the final project!

## Worked example of statistical modeling

This section presents math and code for a worked example of statistical
modeling, including

- outcome modeling
- inverse probability of treatment weighting
- matching

We use these methods to answer a causal question:

> To what degree does completing a 4-year college degree by age 25
> increase the probability of having a college-educated spouse or
> residential partner at age 35?

The theory that motivates this question is as follows. College causes
people to personally have higher earnings. But it also affects the
probability that someone lives with a high-earning partner. A college
degree thus affects household incomes not only through its effect on
individual earnings but also through its effect on how individuals pool
into households.

### Data access

We have prepared data for you to study this question. You will need to
download these data directly from the data distributor for the [National
Longitudinal Survey of Youth 1997](https://www.bls.gov/nls/nlsy97.htm)
cohort. Here is how to do that.

First, download two supporting files from us:

- [nlsy97.NLSY97](https://drive.google.com/file/d/1YcyaC1R5u9_d0-AX4ivqDiU0bRnEsAsJ/view?usp=sharing)
  is a tagset file containing the variable names
- [prepare_nlsy97.R](https://drive.google.com/file/d/1fUdlhEsGGC0shREvu4znPPmJjtNi--Ko/view?usp=sharing)
  is an R script to prepare the data

put those files in a directory where you will work

Next, download data from the NLSY97.

- register with the survey
- log in to the NLS Investigator
- choose the NLSY97 study
- upload the tagset you downloaded from us
- download the data. When you do so, change the file name from `default`
  to `nlsy97`
- unzip the file. Find nlsy97.dat in the unzipped folder
- drag that file into the folder where you will work

In your R console, run the line of code below

``` r
install.packages("tidyverse") # if you do not have it yet
install.packages("Amelia")    # if you do not have it yet
source("prepare_nlsy97.R")
```

After following these steps, the data are in your working directory! You
can load the data quickly in the future by typing

``` r
library(tidyverse)
d <- readRDS("d.RDS")
```

Why can’t we just send you the data? Two reasons!

1.  The NLSY97 created a procedure to register users to encourage
    ethical use of the data for research
2.  By registering, you help the Bureau of Labor Statistics to know how
    many people are using the data, which is helpful for demonstrating
    the wide use of the data and is useful when securing funding for
    future surveys!

### Worked example: Outcome modeling

Outcome modeling is based on the following identification result, which
translates a causal quantity to a statistical estimand that does not
involve counterfactual outcomes.

$$\begin{aligned}
&E(Y^a) \\
&\text{by law of iterated expectation,}\\
&= E(E(Y^a\mid \vec{L})) \\
&\text{by exchangeability,}\\
&= E(E(Y^a\mid \vec{L}, A = a)) \\
&\text{by consistency,}\\
&= E(E(Y\mid \vec{L}, A = a))
\end{aligned}$$

We use the sample mean as our estimator for the outer expectation, and
we will discuss several estimators for the inner conditional
expectation. $$\begin{aligned}
\hat{E}(Y^a) &= \frac{1}{n}\sum_{i=1}^n \hat{E}(Y\mid \vec{L} = \vec\ell_i, A = a)
\end{aligned}$$

Now for intuition: that estimator tells to

1.  for each unit $i$ in our sample, estimate the expected outcome among
    people who look like this unit ($\vec{L} = \vec\ell_i$) but who got
    the treatment value of interest $A = a$.
2.  take the average of that estimate over all units

A **nonparametric** strategy in step (1) is to literally estimate the
expected outcome by taking the sample average among units who are
identical to unit $i$ along the confounders $\vec{L}$. But if there are
many confounding variables and few units, that might be few or zero
cases! A **parametric** strategy is to assume a model for the outcome,
such as

$$E(Y\mid \vec{L} = \vec\ell, A = a) = \alpha + a\beta + \vec\ell'\vec\gamma$$
where the parameters $\{\alpha,\beta,\vec\gamma\}$ could be estimated by
Ordinary Least Squares regression.

``` r
outcome_model <- lm(y ~ a + sex + race + 
                      mom_educ + dad_educ + 
                      log_parent_income +
                      log_parent_wealth +
                      test_percentile,
                    data = d)
```

Note: This could be any model you like! For example, you could add
interactions or use logistic regression instead.

With our model, we then want to predict the expected outcome under
treatment value $a$ for every unit with that unit’s observed confounder
values.

$$\hat{E}(Y\mid \vec{L} = \vec\ell_i, A = a) = \hat\alpha + a\hat\beta + \vec\ell'_i\hat{\vec\gamma}$$
In code, we would

1.  modify every unit’s treatment to the value $a$
    - intuition: if we actually intervened on this treatment in the
      world, the value of the treatment would change but the values of
      $\vec{L}$ would remain unchanged

``` r
# Make data where all are treated
d_if_treated <- d %>%
  mutate(a = "college")
# Make data where all are untreated
d_if_untreated <- d %>%
  mutate(a = "no_college")
```

2.  predict the outcome for every unit

``` r
predicted_outcome <- d %>%
  mutate(yhat1 = predict(outcome_model,
                         newdata = d_if_treated),
         yhat0 = predict(outcome_model,
                         newdata = d_if_untreated))
```

3.  average over the sample

``` r
predicted_outcome %>%
  summarize(average_yhat1 = mean(yhat1),
            average_yhat0 = mean(yhat0),
            average_effect = mean(yhat1 - yhat0))
```

    ## # A tibble: 1 × 3
    ##   average_yhat1 average_yhat0 average_effect
    ##           <dbl>         <dbl>          <dbl>
    ## 1         0.427         0.164          0.263

In the code above, we estimated three causal quantities

1.  $E(Y^1)$, the probability that a respondent would have a
    college-educated spouse or partner if we intervened to assign them
    to a college degree themselves
2.  $E(Y^0)$, the probability that a respondent would have a
    college-educated spouse or partner if we intervened to assign them
    to no college degree themselves
3.  $E(Y^1-Y^0)$, the average causal effect of a college degree on
    having a spouse or partner with a college degree

### Worked example: Treatment modeling

Using a different identification result, we can also proceed by a
parametric model for the treatment instead of the outcome. By this
strategy, the population mean outcome $E(Y^a)$ under treatment $a$
equals the weighted average over all units at their observed treatment,
weighted by a weight that equals

- when $A = a$, the inverse probability of treatment
- when $A\neq a$, zero

Below is an identification proof for inverse probability of treatment
weighting.

The math above is complicated, but the intuition is simpler: by
weighting, we create a pseudo-population in which treatment $A$ is
independent of the confounders $\vec{L}$. To do that, we need to know
the propensity score: the probability of the observed treatment value
given the confounders.

The identification result points toward an inverse probability of
treatment weighting estimator known as the Horvitz-Thompson estimator,
$$\hat{E}(Y^a) = \frac{1}{n}\sum_{i=1}^n \frac{Y_i\mathbb{I}(A_i=a)}{\hat{P}(A = a\mid\vec{L} = \vec\ell_i)}$$
A related estimator that is often used is the Hajek estimator, which
normalizes the weights to sum to 1.
$$\hat{E}(Y^a) = \frac{1}{\sum_{i=1}^n\frac{\mathbb{I}(A_i=a)}{\hat{P}(A = a \mid \vec{L} = \vec\ell_i)}}\sum_{i=1}^n \frac{Y_i\mathbb{I}(A_i=a)}{\hat{P}(A = a\mid\vec{L} = \vec\ell_i)}$$

In code, we would

1.  estimate a model for the probability of treatment given confounders,
    for example by logistic regression

``` r
treatment_model <- glm(I(a == "college") ~ 
                         sex + race + 
                         mom_educ + dad_educ + 
                         log_parent_income +
                         log_parent_wealth +
                         test_percentile,
                       data = d,
                       family = binomial)
```

2.  for every unit, predict the probability that $A = \text{College}$

``` r
predicted_p_college <- d %>%
  mutate(p_college = predict(treatment_model,
                             # the line below tells R
                             # to predict a probability
                             # rather than log odds
                             type = "response"))
```

3.  estimate the probability of the treatment observed

- for those who went to college, this equals `p_college`
- for those who did not, this equals `1 - p_college`

This quantity is often called the *propensity score*. It encapsulates
all information contained in confounders about the probability of
treatment.

``` r
predicted_p_scores <- predicted_p_college %>%
  mutate(propensity_score = case_when(
    a == "college" ~ p_college,
    a == "no_college" ~ 1 - p_college
  ))
```

4.  estimate mean outcomes among those with each treatment, weighted by
    the inverse propensity score. There are actually two ways to do
    this.

- the Horvitz-Thompson estimator relies on the fact that the true
  propensity scores sum to the number of observations

``` r
predicted_p_scores %>%
  summarize(y1 = mean(y * I(a == "college") / propensity_score),
            y0 = mean(y * I(a == "no_college") / propensity_score))
```

    ## # A tibble: 1 × 2
    ##      y1    y0
    ##   <dbl> <dbl>
    ## 1 0.374 0.164

- the Hajek estimator uses the weighted mean, thus normalizing weights
  to sum to 1

``` r
predicted_p_scores %>%
  group_by(a) %>%
  summarize(estimate = weighted.mean(y, w = 1 / propensity_score))
```

    ## # A tibble: 2 × 2
    ##   a          estimate
    ##   <chr>         <dbl>
    ## 1 college       0.401
    ## 2 no_college    0.163

While both are asymptotically valid, there are finite-sample reasons to
prefer the second estimator (Hajek).

### Worked example: Matching

We could also estimate by matching. Matching can be interpreted as an
outcome modeling strategy where the conditional mean outcome
$E(Y\mid\vec{A} = a, \vec{L} = \vec\ell_i)$ is estimated by the mean
outcome among a set of units whose confounder values are similar to
those of unit $i$ but who received the treatment value $a$ of interest.

One way of defining \`\`similar’’ is by propensity score matching: find
units whose probability of treatment given confounders was close to the
probability for unit $i$. For example, the code below,

- estimates the probability of college completion using logistic
  regression
- for each person who finished college, matches them to a non-college
  graduate whose probability of completing college was similar

``` r
library(MatchIt)
matched <- matchit(a == "college" ~ sex + race + mom_educ + 
                     dad_educ + log_parent_income + 
                     log_parent_wealth + test_percentile,
                   method = "nearest", 
                   distance = "glm",
                   estimand = "ATT",
                   data = d)
```

The variable `matched$weights` has one element for each person in the
dataset. It indicates how many times that person appears in the matched
sample. There are

- 1,533 college graduates with weight 1
- 1,533 matched non-graduates with weight 1
- 4,705 non-matched non-graudates with weight 0

``` r
table(d$a,matched$weights)
```

    ##             
    ##                 0    1
    ##   college       0 1533
    ##   no_college 4705 1533

Within the matched data, the non-graduates and graduates are similar
along confounding variables. We could then estimate

- the probability of having a college educated spouse among college
  graduates by its mean among these people
- the probability that would have persisted for them if they had not
  finished college, by its mean among their matched counterparts

``` r
d %>%
  mutate(weight = matched$weights) %>%
  group_by(a) %>%
  summarize(p_spouse_college = weighted.mean(y, w = weight))
```

    ## # A tibble: 2 × 2
    ##   a          p_spouse_college
    ##   <chr>                 <dbl>
    ## 1 college               0.528
    ## 2 no_college            0.232

An even better estimator might use linear regression to adjust for
differences within the matched pairs that exist because matches are not
identical.

``` r
matched_fit <- lm(y ~ a*(sex + race + mom_educ + 
                           dad_educ + log_parent_income + 
                           log_parent_wealth + test_percentile), 
                  data = d, 
                  weights = matched$weights)
```

Then, predict potential outcoems from that matched fit and report the
expected outcome among college graduates under their factual treatment
and under

``` r
# Create data frames for prediction
college_grads_factual <- d %>%
  filter(a == "college")
college_grads_counterfactual <- college_grads_factual %>%
  mutate(a = "no_college")

# Predict outcomes from the model
college_grads_factual %>%
  mutate(yhat_college = predict(matched_fit, 
                                newdata = college_grads_factual),
         yhat_no_college = predict(matched_fit,
                                   newdata = college_grads_counterfactual)) %>%
  # Report estimated average outcomes
  select(starts_with("yhat")) %>%
  summarize_all(.funs = mean) %>%
  # Estimate the causal effect
  mutate(effect = yhat_college - yhat_no_college)
```

    ## # A tibble: 1 × 3
    ##   yhat_college yhat_no_college effect
    ##          <dbl>           <dbl>  <dbl>
    ## 1        0.528           0.259  0.269

These results suggest that completing college increases the probability
of having a college-educated spouse or partner by about 27 percentage
points.

<!--chapter:end:05_statistical_modeling.Rmd-->

# (PART) Identification without exchangeability {-}

# Front door

> Oct 12. [**Slides.**](assets/slides/6-1_front_door.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Technical Point 7.4. Optionally, see [Glynn and Kashin 2018](https://doi.org/10.1080/01621459.2017.1398657)

This lecture is about how to engage with new methods for causal identification beyond backdoor adjustment. The learning goals are general

- engage with a new causal identification approach
- translate that method to code
- critique the identification assumptions

Front door methods for causal identification are one case that we use to show how the building blocks you already know have prepared you to learn new approaches to causal identification.

## Identification {-}

We focus on the simplest case for front door identification, depicted in the DAG below where the variables $A$, $M$, and $Y$ are binary.

<script type="text/tikz">
  \begin{tikzpicture}
    \node (a) at (0,0) {$A$};
    \node (m) at (1,0) {$M$};
    \node (y) at (2,0) {$Y$};
    \node (u) at (1,1) {$U$};
    \draw[->] (u) -- (a);
    \draw[->] (u) -- (y);
    \draw[->] (a) -- (m);
    \draw[->] (m) -- (y);
  \end{tikzpicture}
</script>

In this setting, the slides show the following identification result.

$$P(Y^a)=\sum_m P(M = m\mid A = a) \sum_{a'}P(A = a')P(Y\mid M = m, A = a')$$

## Code example {-}

The lecture slides translate this method into code in one simulated example. We are providing the code below to make it easy to copy and follow along.


``` r
library(tidyverse)
```


``` r
sim_data <- function(n = 100) {
  data.frame(U = runif(n)) %>%
    # Generate a binary treatment
    mutate(A = rbinom(n(), 
                      prob = U, 
                      size = 1)) %>%
    # Generate a binary mediator
    mutate(M = rbinom(n(), 
                      prob = .1 + .8*A, 
                      size = 1)) %>%
    # Generate a binary outcome
    mutate(Y = rbinom(n(), 
                      prob = plogis(U + .5*M), 
                      size = 1))
}
data <- sim_data(n = 10e3)
```

Examine the descriptive relationship between $A$ and $Y$.

``` r
data %>%
  group_by(A) %>%
  summarize(Y = mean(Y))
```

```
## # A tibble: 2 × 2
##       A     Y
##   <int> <dbl>
## 1     0 0.591
## 2     1 0.752
```

Estimate the probability of each $M$ given $A$. Under the causal assumptions, this corresponds to the expected value of $M$ under assignment to each value of $A$ since $M\rightarrow A$ is unconfounded.

``` r
p_M_given_A <- data %>%
  # Count size of each group
  group_by(A, M) %>%
  count() %>%
  # Convert to probability within A
  group_by(A) %>%
  mutate(p_M_under_A = n / sum(n)) %>%
  select(A,M,p_M_under_A) %>%
  print()
```

```
## # A tibble: 4 × 3
## # Groups:   A [2]
##       A     M p_M_under_A
##   <int> <int>       <dbl>
## 1     0     0      0.910 
## 2     0     1      0.0901
## 3     1     0      0.105 
## 4     1     1      0.895
```

Within the front-door identification formula, you need the marginal probability of each treatment value.

``` r
# Probability of each A
p_A <- data %>%
  # Count size of each group
  group_by(A) %>%
  count() %>%
  # Convert to probability
  ungroup() %>%
  mutate(p_A = n / sum(n)) %>%
  select(A,p_A) %>%
  print()
```

```
## # A tibble: 2 × 2
##       A   p_A
##   <int> <dbl>
## 1     0 0.501
## 2     1 0.499
```

You also need the outcome distribution given $M$ and $A$.

``` r
# Probability of Y = 1 given M and A
p_Y_given_M_A <- data %>%
  group_by(A,M) %>%
  summarize(P_Y_given_A_M = mean(Y),
            .groups = "drop") %>%
  print()
```

```
## # A tibble: 4 × 3
##       A     M P_Y_given_A_M
##   <int> <int>         <dbl>
## 1     0     0         0.580
## 2     0     1         0.707
## 3     1     0         0.644
## 4     1     1         0.765
```

Given the above, you can use backdoor adjustment to identify the outcome under intervention on $M$ by backdoor adjustment for $A$.

``` r
# Probability of Y = 1 under intervention on M
p_Y_under_M <- p_Y_given_M_A %>%
  left_join(p_A, by = "A") %>%
  group_by(M) %>%
  summarize(p_Y_under_M = sum(P_Y_given_A_M  * p_A)) %>%
  print()
```

```
## # A tibble: 2 × 2
##       M p_Y_under_M
##   <int>       <dbl>
## 1     0       0.612
## 2     1       0.736
```

Bringing the above together, we have front-door identification.

``` r
# Probability of Y = 1 under intervention on A
p_Y_under_A <- p_M_given_A %>%
  left_join(p_Y_under_M,
            by = "M") %>%
  group_by(A) %>%
  summarize(estimate = sum(p_M_under_A * p_Y_under_M)) %>%
  print()
```

```
## # A tibble: 2 × 2
##       A estimate
##   <int>    <dbl>
## 1     0    0.623
## 2     1    0.723
```

<!--chapter:end:06_front_door.Rmd-->


# Instrumental variables

## Experimental settings

> Oct 17. [**Slides.**](assets/slides/7-1_iv_experimental.pdf)

An instrumental variable (IV) identification strategy applies when a treatment effect of $A$ on $Y$ is confounded by unobserved variables ($U$), but an **instrument** $Z$ creates random unconfounded variation in $A$.

<script type="text/tikz">
  \begin{tikzpicture}
    \node (l) at (0,0) {$L$};
    \node (a) at (1,0) {$A$};
    \node (y) at (2,0) {$Y$};
    \draw[->] (l) -- (a);
    \draw[->] (a) -- (y);
    \draw[->] (l) to[bend right] (y);
  \end{tikzpicture}
</script>

A very clean setting for IV is randomized experiments with non-compliance: an experimenter randomizes the assigned treatment ($Z$) but the actual treatment ($A$) may be unequal to $Z$ because some units do not follow their assignment. Our first class will discuss this setting.

## Lab: Instrumental Variable analysis in Code

In this lab we will implement instrumental variables estimators in R.

> October 18 [**Slides.**](assets/discussions/discussion9-slides.pdf) Download the
R Markdown file [**here**](assets/discussions/discussion9.Rmd). **_Update_**:
Solutions to the coding exercise are [**here**](assets/discussions/discussion9-solutions.Rmd).

## Observational settings

> Oct 19 [**Slides.**](assets/slides/7-2_iv_observational.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 16.

On Thursday, we move on to IV analysis in observational settings. Here we focus on the casual assumptions required for IV. These assumptions often hold by design in experiments with non-compliance. In observational settings, they can be more doubtful.

<!--chapter:end:07_instrumental_variables.Rmd-->


# Regression discontinuity

## Introduction

> Oct 24. [**Slides.**](assets/slides/8-1_rdd_intro.pdf) After class, read [Huntington Klein 2021](https://theeffectbook.net/ch-RegressionDiscontinuity.html) Chapter 20, sections 20.1 and 20.3.4.

In some settings, a treatment is assigned based solely off the value of a continuous variable. In these situations, we can identify a local ATE without many additional assumptions. Today will introduce how this works using regression discontinuity designs. 

## Lab: Regression Discontinuity - Bandwidth and Examples

> Oct 25 After lab, read [Huntington Klein 2021](https://theeffectbook.net/ch-RegressionDiscontinuity.html) Chapter 20, section 20.2.1.
[**Slides**](assets/discussions/discussion10.pdf) Download today's [**.Rmd document here**](assets/discussions/discussion10.Rmd).

We'll discuss bandwidth selection and triangular weighting. We'll also apply regression discontinuity to a concrete example and give you a chance to try it out for yourself.

## Discussion

> Oct 26. [**Slides.**](assets/slides/8-2_rdd_extensions.pdf) After class, read [Huntington Klein 2021](https://theeffectbook.net/ch-RegressionDiscontinuity.html) Chapter 20, sections 20.2.2. through 20.3.1.

We'll continue our discussion of regression discontinuity designs by discussing fuzzy RDD and validation checks for RDD.

<!--chapter:end:08_regression_discontinuity.Rmd-->


# Difference in difference

## Introduction

> Oct 31. [**Slides.**](assets/slides/9-1_did.pdf) No reading is required, but for reference see [Card \& Krueger 1994](https://davidcard.berkeley.edu/papers/njmin-aer.pdf)

Today we study the effect of a policy change in New Jersey, drawing on evidence from the neighboring state of Pennsylvania.

Difference in difference is an identification strategy to be used when one or more units become treated at some time point while others do not. If we believe an assumption of **parallel trends**, then we can use the change over time for the never-treated units to estimate the change over time that would have been experienced by the units who become treated, in a counterfactual world where they had not become treated.

## Lab

> Nov 1 [**Slides.**](assets/discussions/DIDdiscussion.pdf) Download the
R Markdown file [**here**](assets/discussions/DID-discussion.Rmd).

In lab, you will implement a difference in difference estimator in a specific setting. The example comes from [Malesky, Nguyen, \& Tran 2014](https://doi.org/10.1017/S0003055413000580) and will most closely follow the re-analysis of these data by [Egami \& Yamauchi 2023](https://doi.org/10.1017/pan.2022.8).

## Extensions of DID

> Nov 2. [**Slides.**](assets/slides/9-2_did_extensions.pdf) No reading is required, but for reference see [Egami \& Yamauchi 2023](https://doi.org/10.1017/pan.2022.8)

How do we know when the parallel trends assumption holds? And what do we do if it does not hold? This class discusses recent extensions of the DID framework.


<!--chapter:end:09_difference_in_difference.Rmd-->


# Synthetic control

## Introduction

> Nov 7 [**Slides.**](assets/slides/10-1_synth_control.pdf) 


## Lab

> Nov 8 [**Slides**](assets/discussions/discussion12.pdf)

We review the main idea behind synthetic control as well as compare and contrast synthetic control with matching and difference-in-differences. We also dig deeper into how to select weights in synthetic control and review a worked out example to assess performance of the method.

## Discussion

> Nov 9 [**Slides. (Updated with explanation of interference)**](assets/slides/10-2_synth_control_example.pdf). 
After class, read Chapter 10 of the Causal Inference Mixtape [Cunningham 2021](https://mixtape.scunning.com/10-synthetic_controls)

<!--chapter:end:10_synthetic_control.Rmd-->


# (PART) Areas of active research {-}

# Data-driven methods

## Introduction

> Nov 14 [**Slides.**](assets/slides/11-1_data_driven_intro.pdf)

For any given intervention, some subgroups of people will respond more than others. Ideas from machine learning can help us target human attention toward these subgroups.

**Concrete example.** Who responds most to a nudget to go for a walk? Imagine your first conduct a survey that asks people how much they love the fall, from ($X = 1$ for least) to ($X = 10$ for most). You then randomize them to a control condition ($A = \texttt{untreated}$) or a treatment condition ($A = \texttt{treated}$) that encourages them to go for a walk outside. The outcome $Y$ is active minutes in the day, as recorded on an activity tracker.

**Simulated data.** In real data, it can be difficult to evaluate causal estimators because the truth is unknown. Today we will use data simulated from a known process in order to study the properties of estimators. The code below will prepare your R environment with a function `simulate_sample()` that will generate data with 50 observations.


``` r
library(tidyverse)
source("https://raw.githubusercontent.com/causal3900/causal3900.github.io/main/assets/data/simulate_sample.R")
```

Here is an example of the code to simulate data:

``` r
simulated <- simulate_sample()
```

```
##   X         A          Y
## 1 1 untreated  78.645588
## 2 1   treated   3.346445
## 3 1 untreated  85.462048
## 4 1   treated  78.683667
## 5 1 untreated 123.233658
## 6 2   treated  38.080125
```

**Causal estimands.** In this example, we would like to estimate $$\tau_x = E(\underbrace{Y^1 - Y^0}_{\substack{\text{effect of}\\\text{nudge to walk}\\\text{on active}\\\text{minutes}}}\mid \underbrace{X = x}_{\substack{\text{among those}\\\text{with love of}\\\text{fall = }x}})$$
for each value $x = 1,\dots,10$. These estimands are the average causal effect of a nudge to walk ($A$) on active minutes ($Y$) within subgroups defined by each value of the scale for love of fall ($X$).

**Identification.** In our simulate data, $A$ is assigned at random. There are no backdoor paths between $A$ and $Y$.

**Estimator.** An estimator is a function that takes a dataset and returns estimates. Below is a nonparametric estimator for our setting.

``` r
estimator <- function(data) {
  data %>%
    # Group by treatment A and confounder X
    group_by(A, X) %>%
    # Summarize by the average outcome within groups
    summarize(Y = mean(Y),
              .groups = "drop") %>%
    # Reshape the data
    pivot_wider(names_from = "A",
                values_from = "Y",
                names_prefix = "y_") %>%
    # Estimate the effect within groups
    mutate(effect = y_treated - y_untreated)
}
```

You can apply this estimator as follows.


``` r
estimate <- estimator(simulated)
```

**Task.** Using a sample simulated on your computer, estimate the average causal effect of $A$ on $Y$ within subgroups defined by $X$. Report two numbers to us.

- for which value of $X$ is the estimated effect of $A$ most positive?
- what is that effect estimate?

We will discuss the distribution of estimates that we get as a class.

If you are ready early, you could think about how you might evaluate performance of this approach over many repeated simulations.

## Machine learning approaches

> Nov 16 [**Slides.**](assets/slides/11-2_data_driven_ml.pdf)

Today we generalize the ideas from Tuesday. We will discuss how sample splitting makes it easier to

- choose among many estimands
- choose among many estimators
- develop new data science approaches

<!--chapter:end:11_data_driven.Rmd-->


# Current research

## Research discussion: Sam

> Nov 21 [**Slides**](assets/slides/research_sam.pdf)

Today we will be discussing causal discovery: how we might learn DAGs from data

## Research discussion: Ian

> Nov 28 [**Slides**](assets/slides/research_ian.pdf) You can optionally read more at our project page: [ilundberg.github.io/pstratreg](https://ilundberg.github.io/pstratreg/).

Sometimes the treatment causes the outcome to be undefined. This problem has been well-studied in randomized controlled trials in biostatistics, when some people die before the end of the trial. We will talk about applications of this idea in the study of inequality that require adjustment for measured confounding. This is joint work with Soonhong Cho (PhD Candidate, UCLA Political Science).

<!--chapter:end:12_current_research.Rmd-->


# Course recap

> Nov 30 [**Slides**](assets/slides/13-1_course_recap.pdf)

We will review what we have learned this semester!

<!--chapter:end:13_course_recap.Rmd-->

# (PART) Discussions {-}

# Discussion 2. Stats review {-}

[**Slides**](assets/discussions/discussion2-probandstatsreview.pdf)

To execute these simulations locally, [**download the .Rmd here**](assets/discussions/discussion2_download.Rmd)


``` r
library(ggplot2)
library(ggmosaic)
library(tibble)
```

## Sample expectations converge to population

We can generate simulations to show that sample mean and variance converge to
population values.

``` r
true_mean <- 2
true_var <- 5

sample_mean_seq <- 1:3000
sample_means <- vapply(
  sample_mean_seq,
  \(x) mean(rnorm(n = x, mean = true_mean, sd = sqrt(true_var))),
  numeric(1)
)
sample_variances <- vapply(
  sample_mean_seq,
  \(x) {
    data <- rnorm(n = x, mean = true_mean, sd = sqrt(true_var))
    sample_mean <- mean(data)
    sum((data - sample_mean)^2)/length(data)
  },
  numeric(1)
)

means <- tibble("N" = sample_mean_seq, "Sample Mean" = sample_means)
vars <- tibble("N" = sample_mean_seq, "Sample Variance" = sample_variances)

colors <- c("Sample Mean" = "lightblue", "Population Mean" = "red")

ggplot(means, aes(y = `Sample Mean`, x = N)) +
  geom_line(color = "lightblue") +
  geom_abline(slope = 0, intercept = true_mean, color = "red") +
  theme_bw()
```

<img src="discussion02_files/figure-html/unnamed-chunk-2-1.png" width="672" />

``` r
ggplot(vars, aes(y = `Sample Variance`, x = N)) +
  geom_line(color = "lightblue") +
  geom_abline(slope = 0, intercept = true_var, color = "red") +
  theme_bw()
```

<img src="discussion02_files/figure-html/unnamed-chunk-2-2.png" width="672" />

## Simulate conditional expectations

Simulate conditional expectations within groups that differ from the sample
mean.

``` r
group1_means <- rnorm(100, mean = 20, sd = 5)
group2_means <- rnorm(100, mean = 30, sd = 5)
group_means <- data.frame(
  "Group" = c(rep("Group 1", 100), rep("Group 2", 100)),
  "Values" = c(group1_means, group2_means),
  "x" = rnorm(200, 5, sd = 3)
)
ggplot(group_means, aes(x = x, y = Values, color = Group)) +
  geom_point() +
  geom_abline(
    slope = 0,
    intercept = mean(group_means$Values),
    show.legend = TRUE,
    color = "gray30"
  ) +
  geom_abline(
    slope = 0,
    intercept = mean(group_means[group_means$Group == "Group 1", ]$Values),
    show.legend = TRUE,
    color = "#F8766D"
  ) +
  geom_abline(
    slope = 0,
    intercept = mean(group_means[group_means$Group == "Group 2", ]$Values),
    show.legend = TRUE,
    color = "#00BFC4"
  ) +
  theme_bw()
```

<img src="discussion02_files/figure-html/unnamed-chunk-3-1.png" width="672" />

## Show independence of variables - example of two dice rolling


``` r
dice_1 <- sample(1:6, 100000, replace = TRUE)
dice_2 <- sample(1:6, 100000, replace = TRUE)
dice <- tibble(
  "dice" = c(rep("Die 1", 100000), rep("Die 2", 100000)),
  "value" = c(dice_1, dice_2)
)

ggplot(data = dice) +
  geom_mosaic(aes(x = product(dice, value), fill = dice)) +   
  labs(y="", x="Value Rolled", title = "Independence of dice roll") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), legend.position = "none")
```

<img src="discussion02_files/figure-html/unnamed-chunk-4-1.png" width="672" />

<!--chapter:end:discussion02.Rmd-->

---
output: html_document
---

# Discussion 3. Analyzing an Experiment in R {-}


[**Slides**](assets/discussions/discussion3-analyzing-experiment.pdf)



## Download .Rmd Document

Download today's [**.Rmd document here**](assets/discussions/discussion3.Rmd).


## Get out and Vote Experiment

In this lab, we explore an experiment that digs into the mechanisms
underlying __why people vote__. This exercise is based on: 

Gerber, Alan S., Donald P. Green, and Christopher W. Larimer. ["Social Pressure and Voter Turnout: Evidence from a Large-scale Field Experiment."](https://www.cambridge.org/core/journals/american-political-science-review/article/social-pressure-and-voter-turnout-evidence-from-a-largescale-field-experiment/11E84AF4C0B7FBD1D20C855972C2C3EB#) American Political Science Review 102.1 (2008): 33-48.

A long-standing theory as to why many people
vote is that it is driven by social norms (e.g. the understanding that voting
is their civic duty). This theory, while being a dominant theoretical 
explanation, had very little empirical backing for a long time. This experiment
examines this very theory by asking the question:
__to what extent do social norms cause voter turnout__?

### Experimental Design

In order to answer this question, approximately 80,000 Michigan households
were randomly assigned to treatment and control groups, where the treatment
group was randomly assigned to one of four possible treatment arms. These
treatment arms varied in the intensity of social pressure that they conveyed,
and were defined as follows:

1. The first treatment arm was mailed a letter that simply reminded them that
voting is a civic duty.
2. The second treatment arm was mailed a letter telling them that researchers
would be studying their voting turnout based on public records.
3. The third treatment arm was mailed a letter stating that their voting turnout 
would be revealed to all other members of their household.
4. The fourth treatment arm was mailed a letter stating that their voting turnout
would be revealed to their household *and* to their neighbors.

## Analyze Experiment

### Necessary packages

__Note:__ If this errors you probably either don't have `dplyr` or `haven`
installed.


``` r
library(dplyr)
library(haven)
```

### Import data

``` r
gotv <- read_dta("https://causal3900.github.io/assets/data/social_pressure.dta")
```

> Alternatively (if you really want), you could download the data [here](assets/data/social_pressure.dta) and load it directly from your computer. Make sure to save the data into the same directory that your RMarkdown file is in. 
> Then you can you can import the data as:
>
> `gotv <- read_dta("social_pressure.dta")`

Run the following code to get a quick peek at the dataset using the [function `glimpse`](https://dplyr.tidyverse.org/reference/glimpse.html). This returns info such as the number of rows/columns, the column names, and the type of data in each column. Notice that we have information about year of birth `yob` but not explicitly age. Also notice that the treatments are labeled with the numbers 0 through 4.

``` r
glimpse(gotv)
```

### Clean data

First, let's construct an age variable describing how old (in number of years)
each person was in the year 2006. The `yob` variable says which year each person
was born in. For this, we use the `mutate` function, which you can read about [here](https://dplyr.tidyverse.org/reference/mutate.html). 

> Given a person's year of birth, how do you calculate their age in the year 2006? Note that you can do arithmetic operations with information from the dataset. For example, if you have two columns `col_1` and `col_2` and you wanted to create a third column called `col_3` that was the sum of these two columns, you could write:
>
> `mutate(col_3 = col_1 + col_2)`

We have the code started for you below. Fill in the appropriate expression after `age = ` to add a column to `gotv` labeled `age` that contains how old each person was in 2006.


``` r
gotv <- gotv |>
  mutate(age = )
```

Now, convert the `treatment` variable from it's numeric representation to the
corresponding labels which are

- 0: "Control" 
- 1: "Hawthorne" (this is the 'researchers viewing records via public data' treatment arm)
- 2: "Civic Duty" (this is the 'voting is your civic duty' treatment arm)
- 3: "Neighbors" (this is the 'voting turnout revealed to neighbors' treatment arm)
- 4: "Self" (this is the 'voting turnout revealed to household' treatment arm)


> For this, you will want to use the function `case_when` which is described [here](https://www.sharpsightlabs.com/blog/case-when-r/).
> The general syntax is `case_when(condition ~ output-value)`
> 
> For example, a condition would be `treatement == 0` and an output value would be `"Control"`. This would search for every value in the `treatment` column that equals `0` and replace that with the string `"Control"`.


We have started the code for you below. Decide what argument(s) to pass inside the parantheses of `case_when()`.

``` r
gotv <- gotv |>
  mutate(treatment = case_when()) 
```

Now, when we use `glimpse` we see there is an added `age` variable and that the treatments have word instead of number labels.

``` r
glimpse(gotv)
```

### Balance table

Next, we're going to confirm that our control and treatment groups look pretty
much the same across a set of covariates, i.e. that the two groups are *balanced on covariates*. Specifically this means we're going to calculate the mean value of a set of covariates across each of the treatment/control
arms, and we expect them to be pretty much equal if our randomization worked. This is related to the idea of exchangeability.

In this exercise, we are going to reproduce a table similar to Table 1 from the paper. We want a table that shows the mean value of the following covariates for each of the five treatment arms: Household size, Nov 2002, Nov 2000, Aug 2004, Aug 2002, Aug 2000, Female, and Age (in years). You should create a table with 5 rows, one for each treatment arm, and 8 columns, one for each covariate of interest. 

We have started some code for you below. What you need to do is:

- Pass an argument to `group_by()` so that we calculate seperate means for each treatment arm.
  - Look [here](https://dplyr.tidyverse.org/reference/group_by.html) for documentation on the `group_by` function.
- Pass an argument to `summarise()` that computes the mean of each covariate in `covariates` for each seperate treatment arm.
  - Look [here](https://dplyr.tidyverse.org/reference/summarise.html) for documentation on the `summarise` function.
  - You may find the function [`across`](https://dplyr.tidyverse.org/reference/across.html) useful here as well. You can use this function *inside* of `summarise()`!


``` r
covariates <- c("sex", "age", "g2000", "g2002", "p2000", "p2002", "p2004", "hh_size")

gotv_balance <- gotv |>
  group_by(...) |>
  summarise(...)

print(gotv_balance)
```

Note that your numbers will not match up exactly with Table 1. What you want to notice is that the values in each column are similar across the rows.

### Results

Finally, let's replicate the final results (Table 2). For each treatment group, we calculate the percentage of individuals who got out and voted, as well as the total number of individuals in that group! We started the code for you below. You need to 

- Pass an argument to `group_by()` so that we are working with each treatment arm seperately (this should be the same as before!)
- Pass two arguments to `summarise()` to do the following:
  - Create a column titled `Percentage_Voting` that contains the percent of each group that voted
  - Create a column titled `num_of_individuals` that contains the total number of people in that group


``` r
gotv_results <- gotv |>
  group_by(...) |>
  summarise(...)

print(gotv_results)
```


<!--chapter:end:discussion03.Rmd-->

---
output: html_document
---

# Discussion 05. Course Project: Task 1 {-}
The discussion today will discuss the you through an overview of the course project and a few datasets you might use for the project.

[**Slides**](assets/discussions/discussion5-task1.pdf)



<!--chapter:end:discussion05.Rmd-->


# (PART) Assignments {-}

# Due dates {-}

We'll post due dates here throughout the semester. 

## Upcoming {-}

- Pset 2: Due Tuesday, September 24th at 11:59pm via Canvas

- Pset 2 **Peer Reviews**: Due Tuesday, October 1st at 11:59pm via Canvas

- Project Task 1: Due Thursday, October 3rd at 11:59pm via Canvas

## Past {-}

- Pset 1: Due Tuesday, September 10th at 5pm via Canvas

- Pset 1 **Peer Reviews**: Due Tuesday, September 17th at 5pm via Canvas

<!--chapter:end:pset_dates.Rmd-->

# Course Project {-}

The course project is an opportunity to engage with the course content via a real-world example. Over the course of the semester, you will walk through an entire causal analysis: starting with defining a causal question all the way to communicating the results of your analysis. Parts of this project will be done as individuals and parts will be completed as a group. We will assign parts of the project throughout the semester and we will give detailed instructions each time. We will also have plenty of check-ins along the way to make sure you're on the right track.


* [**Project Overview expectations**](assets/psets/project/project_overview.pdf)
* [**Task 1 Details**](assets/psets/project/task1.pdf) and the [.Rmd file](assets/psets/project/task1.Rmd) to fill out
* Task 2 Details
* Task 3 Details
* Task 4 Details
* Task 5 Details

<!--chapter:end:pset_project.Rmd-->

# Problem Set 1. Definitions {-}

Relevant material will be covered by **Aug 29**. Problem set is due **Sept 10** at 5pm.

Welcome to the problem set! This homework will practice conceptual and notation ideas for descriptive and causal inference.

To complete the problem set, [**Download the .Rmd**](assets/psets/pset1_download.Rmd) and complete the homework. Omit your name so we can have anonymous peer feedback. Compile to a PDF and submit the PDF on [Canvas](https://canvas.cornell.edu/courses/57329).

## 1. Practice with potential outcomes {-}

Jose says that coming to Cornell caused him to discover statistics, and it became his major! He says that if he had gone to NYU, he would have stuck with biology.

### 1.1 (7 points) {-}

In Jose's claim, what is the treatment?

**Answer.** Your answer here

### 1.2 (7 points) {-}

Using the mathematical notation we discussed in class, define the two potential outcomes to which Jose is referring

**Answer.** Your answer here

### 1.3 (7 points) {-}

In a sentence or two, say how the Fundamental Problem of Causal Inference applies to Jose's claim.

**Answer.** Your answer here

### 1.4 (7 points) {-}

Using conditional expectations or probabilities, write the following in math: the probability of majoring in statistics is higher among students who attend Cornell than among students who attend NYU.

**Answer.** Your answer here

### 1.5 (7 points) {-}

Give one reason why the average causal effect of attending Cornell versus NYU (the quantity from 1.2, averaged over all students) might be different from the average descriptive difference (from 1.4) in rates of majoring in statistics.

**Answer.** Your answer here

## 2. A sailing class {-}

You are looking into a sailing class through Cornell Wellness! For each claim below, tell us whether the claim is causal or descriptive.

### 2.1 (5 points) {-}

Last year, there was a survey of students who did and did not take the class. The proportion reporting that they felt prepared to sail on Cayuga Lake was higher among those who took the class.

**Answer.** Your answer here

### 2.2 (5 points) {-}

Last year, there was a survey of students before and after the class. The proportion reporting that they felt prepared to sail on Cayuga Lake was higher in the survey taken after the class.

**Answer.** Your answer here

### 2.3 (5 points) {-}

On average, the students in this class emerged more prepared to sail than they would have been without the class.

**Answer.** Your answer here

## Session info {-}

The chunk below will record information about your R session, which is useful for debugging issues in homework assignments that contain code.


``` r
sessionInfo()
```

```
## R version 4.4.1 (2024-06-14)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.1 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## time zone: America/New_York
## tzcode source: system (glibc)
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets 
## [6] methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] digest_0.6.35     R6_2.5.1          bookdown_0.40    
##  [4] fastmap_1.2.0     xfun_0.44         cachem_1.1.0     
##  [7] knitr_1.47        memoise_2.0.1     htmltools_0.5.8.1
## [10] rmarkdown_2.27    lifecycle_1.0.4   xml2_1.3.6       
## [13] cli_3.6.2         downlit_0.4.3     sass_0.4.9       
## [16] withr_3.0.0       jquerylib_0.1.4   compiler_4.4.1   
## [19] tools_4.4.1       evaluate_0.23     bslib_0.7.0      
## [22] yaml_2.3.8        fs_1.6.4          rlang_1.1.3      
## [25] jsonlite_1.8.8
```

<!--chapter:end:pset1.Rmd-->

# Problem Set 2. Experiments {-}

Relevant material will be covered by **Sep 11**. Problem set is due **Sep 24**.

To complete the problem set, [**Download the .Rmd**](https://drive.google.com/file/d/1Gj16YkG4Zx3kg5UiWXt-LzLqsIAlRbLF/view?usp=drive_link) and complete the homework. Omit your name so we can have anonymous peer feedback. Compile to a PDF and submit the PDF on Canvas.

This problem set is based on:

Bertrand, M \& Mullainathan, S. 2004. "[Are Emily and Greg More Employable Than Lakisha and Jamal? A Field Experiment on Labor Market Discrimination](https://www-jstor-org.proxy.library.cornell.edu/stable/3592802)." American Economic Review 94(4):991--1013.

Here's a heads-up about what will be hard in this problem set

- for some, reading a social science paper will be hard
- for some, mathematical statistics will be hard
- for some, R coding will be hard

For almost no one will all three be easy.

> We want to support you to succeed! Text in this format is here to help you.

## 1. Conceptual questions about the study design {-}

Read the first 10 pages of the paper (through the end of section 2).

### 1.1. (5 points) Fundamental Problem {-}

One submitted resume had the name "Emily Baker." It yielded a callback. The same resume could have had the name "Lakisha Washington." Explain how the Fundamental Problem of Causal Inference applies to this case (1--2 sentences).

### 1.2. (5 points) Exchangeability {-}

In a sentence, state what exchangeability means in this study. For concreteness, for this question you may suppose that the only names in the study were "Emily Baker" and "Lakisha Washington."

### 1.3. (10 points) Something you liked {-}

State something concrete that you appreciate about the study design, other than randomization.

## 2. Analyzing the experimental data {-}

Load packages that our code will use.

``` r
library(tidyverse)
library(haven)
```

**To complete the rest of this assignment, you will need to download the study's data from OpenICPSR**: [https://www.openicpsr.org/openicpsr/project/116023/version/V1/view](https://www.openicpsr.org/openicpsr/project/116023/version/V1/view). This will require creating an account and agreeing to terms for using the data ethically. Put the data in the folder on your computer where this .Rmd is located. Read the data into R using `read_dta`.


``` r
d <- read_dta("assets/data/lakisha_aer.dta")
```


``` r
d <- read_dta("assets/data/lakisha_aer_aggregated.dta")
```
> If you have an error, you might need to set your working directory first. This tells R where to look for data files. In other words, your data file needs to be in the same folder as your homework file, AND RStudio needs to be told which folder to look at. At the top of RStudio, click Session -> Set Working Directory -> To Source File Location.

You will now see `d` in your Global Environment at the top right of RStudio.

We will use four variables:

| Name | Role | Values
| ---- | ---- | ------
`call` | outcome | 1 if resume submission yielded a callback
| | | 0 if not
`firstname` | treatment | first name randomly assigned to resume
`race` | category of treatments | `b` if first name signals Black
| | | `w` if first name signals white
`sex` | category of treatments | `f` if first name signals female
| | | `m` if first name signals male

For 2.1--2.4, we will think of `race` as the treatment. For 2.5--2.6, we will think of `firstname` as the treatment.

Restrict to these variables using `select()`.


``` r
d_selected <- d %>%
  select(call, firstname, race, sex)
```

> If you are new to R, here is what just happened:
>
> - created a new object `d_selected`
> - used the assignment operator `<-` to put something in that object
> - we started with our data object `d`
> - we used the pipe operator `%>%` to hand `d` down into a new action
> - the action `select()` selected only the variables of interest
>
> We will often analyze data by starting with a data object and handing that through a series of actions connected by the pipe `%>%`

### 2.1. (5 points) Point estimates of expected potential outcomes {-}

The top of Table 1 reports callback rates: 9.65\% for white names and 6.45\% for Black names. Reproduce those numbers. To do so, take the code below but add a `group_by()` action between `d_selected` and `summarize`.

> Here's a [reference](https://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) that introduces `group_by` and `summarize`.


``` r
d_summarized <- d_selected %>%
  summarize(callback_rate = mean(call),
            number_cases = n()) %>%
  print()
```

```
## # A tibble: 1 × 2
##   callback_rate number_cases
##           <dbl>        <int>
## 1        0.0805         4870
```

### 2.2. (5 points) Inference for expected potential outcomes {-}

Use `mutate()` (see [reference page](https://dplyr.tidyverse.org/reference/mutate.html#ref-examples)) to create a new columns containing the standard error of each estimate as well as lower and upper limits of 95% confidence intervals.

> Suppose $\pi^a$ is the probability of a callback under treatment condition $a$. Let $\hat\pi^a$ be your estimate of that unknown probability, meaning that $\hat\pi^a$ is the proportion of people in that treatment condition to receive a callback in the experiment (you computed this is 2.1). You are making a confidence interval on $\hat\pi^a$, so your estimate is $\hat\pi^a$ and your standard error is the standard error of $\hat\pi^a$

> To make this easier, here is a quick math review and R functions you can use.

> **Standard error in math.** Let $Y^a$ be a Bernoulli random variable, taking the value 1 if a random resume with name $a$ yields a callback and 0 otherwise. Let $\pi^a = P(Y^a=1)$ be the probability of a callback. From statistics, you know this has variance $V(Y^a) = \pi^a (1-\pi^a)$. We have estimated by an average: $\hat\pi^a = \frac{1}{n_a}\sum_{i:A_i=a} Y_i^a$. If we did this many times in many hypothetical samples, we would not always get the same estimate. In fact, our estimate would have sampling variance $V(\hat\pi^a) = \frac{\pi^a(1-\pi^a)}{n_a}$. We know this because $\hat\pi^a$ is a mean of $n_a$ independent and identically distributed random variables $Y^a$. The standard error is the square root of the sampling variance: $SE(\hat\pi^a) = \sqrt\frac{\pi^a(1-\pi^a)}{n_a}$. We can estimate this standard error by plugging in our estimate $\hat\pi^a$ for the true unknown $\pi^a$ wherever it appears.

> **Standard error in code.** We translated the standard error formula into code for you below. This function accepts an estimated probability `p` and sample size `n` and returns the estimated standard error. You can use this `se_binary()` function in your code within `mutate()` just like how `mean()` was used within `summarize()` at the start of the problem set.

> 
> ``` r
> se_binary <- function(p, n) {
>   se <- sqrt( p * (1 - p) / n )
>   return(se)
> }
> ```

> **Sampling distribution in math.** Because $\hat\pi^a$ is a sample mean, we know something about its sampling distribution: in the limit as the sample size grows to infinity, across hypothetical repeated samples the distribution of $\hat\pi^a$ estimates becomes Normal. This is by the Central Limit Theorem! Across repeated samples, the middle 95% of estimates will fall within a known range: $\pi^a \pm \Phi^{-1}(.975) \times SE(\hat\pi^a)$, where $\Phi^{-1}()$ is the inverse cumulative distribution function of the standard Normal distribution. You might have previously learned that $\Phi^{-1}(.975) \approx 1.96$, so what might be familiar to you is the number 1.96.

> **Sampling distribution in a graph.**

> <img src="pset2_files/figure-html/unnamed-chunk-7-1.png" width="672" />

> **Confidence interval in math.** We get a 95% confidence interval by plugging in the estimates $\hat\pi^a$ and $\widehat{SE}(\hat\pi^a)$ to the limits above. This interval is centered on the estimate $\hat\pi^a$ and has a nice property: if we repeatedly made a confidence interval by this procedure using hypothetical samples from the population, our interval would contain the unknown true parameter $\pi^a$ 95% of the time.

> **Confidence interval in code.** We translated the confidence interval formula into code for you below. These functions accept an estimate and standard error and return the lower and upper bounds (respectively) of a 95% confidence interval that assumes a Normal sampling distribution. You can use these functions in your code within `mutate()` just like how `mean()` was used within `summarize()` at the start of the problem set.
> 
> ``` r
> ci_lower <- function(estimate, standard_error) {
>   estimate - qnorm(.975) * standard_error
> }
> ci_upper <- function(estimate, standard_error) {
>   estimate + qnorm(.975) * standard_error
> }
> ```

### 2.3. (5 points) Interpret your confidence interval {-}

In words, interpret the confidence intervals. Be sure to discuss what their property is over hypothetical repeated samples, and be sure to frame your answer using the numbers and variables from the actual experiment we are analyzing.

### 2.4. (5 points) Visualize expected potential outcomes {-}

Using `ggplot()`, visualize the estimated callback rate by race. Use `geom_point()` for point estimates and `geom_errorbar()` for confidence intervals, with race on the `x` axis and estimates on the `y` axis. Label the axes using full words.

> If you have never used `ggplot`, see [Ch 3](https://r4ds.had.co.nz/data-visualisation.html) of R for Data Science by Hadley Wickham.

### 2.5. (5 points) Estimate and visualize by firstname {-}

Do distinct first names yield distinct effects? Repeat the *coding* steps from 2.2--2.4, but now create estimates grouped by `race`, `sex`, and `firstname`. Visualize point estimates and confidence intervals.

> One way to visualize is by placing first names on the $x$-axis and using a `facet_wrap()` layer to facet over race and sex.

``` r
your_ggplot +
  facet_wrap(~ race + sex,
             scales = "free_x", 
             nrow = 1)
```
> Any strategy to visualize is fine, as long as it shows estimates for each `firstname` and indicates the `race` and `sex` signaled by that `firstname`
> Up through 2.4, you were making two estimates: one for white and one for Black. In 2.5, you are aggregating within a more fine-grained set of groups defined by race, sex, and firstname. So you will need to start fresh from the raw person-level data in order to answer 2.5

### 2.6. (5 points) Interpret {-}

Within race and sex, not all first names have the same effect. Suppose these are true differences (not due to sampling variability). What does this tell you about the importance of researcher decisions about which names to use as treatments? There are many possible right answers, and here we are asking you to think about what it might mean for research design that the names have different effects.

<!--chapter:end:pset2.Rmd-->


# Problem Set 3. DAGs. {-}

We have not posted this assignment yet. 

In the meantime, you may reference Problem Set 3 from [Fall 2023](https://causal3900.github.io/fa23/problem-set-3.-dags..html), but please note **there may be significant changes.**


<!--chapter:end:pset3.Rmd-->


# Problem Set 4. Statistical modeling {-}

We have not posted this assignment yet. 

In the meantime, you may reference Problem Set 4 from [Fall 2023](https://causal3900.github.io/fa23/problem-set-4.-statistical-modeling.html), but please note **there may be significant changes.**

<!--chapter:end:pset4.Rmd-->


# Problem Set 5. IV + RD {-}

We have not posted this assignment yet. 

In the meantime, you may reference Problem Set 5 from [Fall 2023](https://causal3900.github.io/fa23/problem-set-5.-iv-rd.html), but please note **there may be significant changes.**

<!--chapter:end:pset5.Rmd-->

---
output:
  pdf_document
urlcolor: blue
---

# Problem Set 6. Difference in Difference + Synthetic Control {-}

We have not posted this assignment yet. 

In the meantime, you may reference Problem Set 6 from [Fall 2023](https://causal3900.github.io/fa23/problem-set-6.-difference-in-difference-synthetic-control.html), but please note **there may be significant changes.**

<!--chapter:end:pset6.Rmd-->


# (PART) Course information {-}

# Who we are {-}

<head>
<style>
img {
  border-radius: 50%;
}
</style>
</head>

## Faculty {.unnumbered}

<div class="row">
  <div class="column"><img src="assets/Sam.jpeg" style="width:75px"></div>
  <div class="col-md-5">[**Y. Samuel Wang**](https://ysamuelwang.com/)<br>Assistant Professor<br>Statistics and Data Science<br>
[ysw7@cornell.edu](mailto:ysw7@cornell.edu)<br>Tues 4-5 Comstock 1187</div>
</div>

> I enjoy thinking about problems where the goal is to discover interpretable structure which underlies the data generating process. This includes problems in the areas of causal discovery, graphical models, and mixed membership models. In many cases, the methods are tailored for the high-dimensional setting where the number of variables considered may be large when compared to the number of observed samples. My applied interests vary but are generally social science related.

<div class="row">
  <div class="column"><img src="assets/Mayleen.jpeg" style="width:75px"></div>
  <div class="col-md-5">[**Mayleen Cortez-Rodriguez**](https://www.mayleencortez.com/)<br>PhD Candidate<br>Applied Mathematics<br>
[mec383@cornell.edu](mailto:mec383@cornell.edu)<br> Thur 11-12 Rhodes Hall 657 (Room 1)</div>
</div>

> I'm currently working on problems in causal inference under network interference. I think causal inference is really cool because it has applications across so many different fields. I'm generally interested in applications to public health, social welfare, and social good. In my free time, I enjoy singing, dancing, cooking, watching movies, and traveling to various theme parks. 

## Teaching assistants {.unnumbered}


<div class="row">
  <div class="column"><img src="assets/Filippo.jpg" style="width:75px"></div>
  <div class="col-md-5">[**Filippo Fiocchi**](https://filippofiocchi.github.io/)<br>PhD Student<br>Statistics and Data Science<br>
[ff257@cornell.edu](mailto:ff257@cornell.edu)<br> Mon 11-12 Comstock 1187</div>
</div>

> I am currently working on problem related to Causality, particularly on Causal and Graph discovery for Functional data. I am interested in how to learn interpretable structures from data with hidden confounders. In my free time I enjoy playing basketball, running and hanging out with friends.

<div class="row">
  <div class="column"><img src="assets/Shira.jpg" style="width:75px"></div>
  <div class="col-md-5">[**Shira Mingelgrin**](https://stat.cornell.edu/people/phds/shira-mingelgrin)<br>PhD Student<br>Statistics and Data Science<br>
[sm2267@cornell.edu](mailto:sm2267@cornell.edu)<br> Wed 5:30-6:30 Comstock 1187</div>
</div>

> I am currently working on graphical models with noisy measurements. I am interested in causal discovery and its applications in social science and biology. In my free time I like doing puzzles, playing pool, and baking.  


<!--chapter:end:y-who-we-are.Rmd-->


# References {-}


<!--chapter:end:z-references.Rmd-->

