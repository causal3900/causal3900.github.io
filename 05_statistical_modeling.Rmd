# Statistical modeling

## Why model?

> Oct 3. [**Slides from 2024.**](assets/slides/5-1_why_model.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 11.

To this point, we have not used any statistical models. Instead, we have

- taken means within subgroups
- then aggregated over subgroups

Today we will discuss how this strategy breaks down when there are many confounding variables, and thus many subgroups.

## Parametric Modeling

> Oct 8. [**Slides from 2024.**](assets/slides/5-3_ipw.pdf) Reading: After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 12.1--12.5.

Today will introduce how to estimate causal effects by directly modeling the outcome based on covariates. In addition, we will discuss how to model the probability of treatment, also known as the propensity score.


## Lab: Parametric g-formula

> Oct 9. [**Slides from 2024.**](assets/discussions/discussion6-gformula-.pdf)

Download the corresponding R Markdown file [**here**](assets/discussions/discussion6.Rmd).

Before discussion, make sure to download the data we'll be using. See the [Ed Discussion post](https://edstem.org/us/courses/62970/discussion/5445307) for more detail. 

After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 13 and 15.1.

Solutions to the lab exercise are [here](https://causal3900.github.io/solutions-parametric-g-formula-lab.html).


## Matching

> Oct 10. [**Slides from 2024.**](assets/slides/5-4_matching_intro.pdf) After class, read [Hernán and Robins 2020](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/) Chapter 15.2.

Today will introduce the idea of matching and how it allows us to estimate the average treatment on the treated.


## Lab: Matching in R

> Oct 16. [**Slides from 2024.**](assets/discussions/matching_lab_slides.pdf)

In this lab, we'll go over distance metrics when matching on multiple covariates. We'll also go over examples of using R to do matching to estimate causal effects.

Download the [**R Markdown.**](assets/discussions/matching_lab.Rmd) file for today's lab; view the knit file [**here**](assets/discussions/matching_lab.html). *Submit your work on Canvas before you leave discussion!* [**Solutions**](assets/discussions/matching_lab_solutions.html)

If you finish the exact matching exercise early, work through this [R Markdown Notebook](assets/matching_examples.html) with further examples (download the [.Rmd file here](assets/matching_examples.Rmd)). There is also a video walking through the examples on canvas.


## Discussion of matching

> Oct 17 [**Slides from 2024.**](assets/slides/5-5_matching_cont.pdf) 

We'll wrap up our discussion of matching by introducing propensity score matching and coarsened exact matching. We'll also discuss combining regression with matching methods to estimate causal effects. 

## Worked example of statistical modeling

This section presents math and code for a worked example of statistical
modeling, including

- outcome modeling
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

Then, predict potential outcomes from that matched fit and report the
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


