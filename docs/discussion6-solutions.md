---
output: html_document
---



# Solutions: Parametric g-formula Lab {-}

- The goal: estimate the average treatment effect (ATE) $E(Y^{a=1}) - E(Y^{a=0})$.
- If I knew both potential outcomes for everyone in the population, I could just take the averages.
- The fundamental problem of causal inference: I can only observe one potential outcome for each person. 
- A potential solution: create a model for the outcome 
  - For a person who is treated, I know their outcome under treatment. I use a model to predict what their outcome would be if they had not been treated.
- I can predict the *other* potential outcome for everyone in my dataset using a model! 

## Download the Data {-}

Follow the steps on Ed Discussion to download the data!

``` r
library(tidyverse)
```

```
## ── Attaching core tidyverse packages ──── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.5.2     ✔ tibble    3.3.0
## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
## ✔ purrr     1.0.4     
## ── Conflicts ────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
d <- readRDS("assets/discussions/d.RDS")
```

After you download the data and save it into the variable name `d`, go up top to where it says `knitr::opts_chunk$set(echo = TRUE, eval=F)` at the top of the R Markdown file and change `eval` to true, i.e. set `eval=T` so that when you knit the file, your code runs.

## Step 0: Learn a model to predict $Y$ given $\{A,\vec{L}\}$ {-}
You can learn more about the `lm` function [**here**](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/lm).
Note that this function takes several arguments. The first argument is a formula, specifically a symbolic description of the model to be fitted. 

First, we create the formula `f` which represents the outcome `y` as a function of our treatment `a` and all our confounders. Then, using the `lm()` function, we fit a model with linear regression.


``` r
f <- y ~ a*(sex + race + mom_educ + dad_educ + log_parent_income + log_parent_wealth + test_percentile)

# Estimate the model with OLS
fit <- lm(formula = f, data = d)
```

## Step 1: Create Two Copies of the Original Data {-}

Next, we are going to create two copies of our original data. The first copy will set all the treatment values `= "no_college"` and the second copy will set all the treatment values `= "college"`. 

``` r
d_all_control <- d %>%
  mutate(a = "no_college")

d_all_treated <- d %>%
  mutate(a = "college")
```


## Step 2: Predict both potential outcomes for everyone {-}
Next we will use our model (estimated above) to predict both potential outcomes for each individual using the two data.frames that we just created. We will then append the estimated potential outcomes to our original data.

To see more details on the `predict` function, see the 
[documentation here](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/predict).


``` r
# Estimate potential outcomes using our model
potential_outcomes_under_control <- predict(object = fit, newdata = d_all_control)
potential_outcomes_under_treatment <- predict(object = fit, newdata = d_all_treated)

# append the estimated potential outcomes to our original data.
conditional_average_outcomes <- d %>%
  mutate(yhat0 = potential_outcomes_under_control,
         yhat1 = potential_outcomes_under_treatment)
```

## Step 3: Estimate the causal effect {-}

Now let's compute the causal effect by taking the difference between their potential outcomes and averaging.

One way to do this is:


``` r
conditional_average_effects <- conditional_average_outcomes %>%
  mutate(effect = yhat1 - yhat0)

conditional_average_effects %>%
  select(yhat1, yhat0, effect) %>%
  summarise_all(.funs = mean)
```

```
## # A tibble: 1 × 3
##   yhat1 yhat0 effect
##   <dbl> <dbl>  <dbl>
## 1 0.404 0.163  0.241
```

An alternative way to compute the treatment effect is below

``` r
conditional_average_outcomes %>%
summarize(ate = mean(yhat1 - yhat0))
```

```
## # A tibble: 1 × 1
##     ate
##   <dbl>
## 1 0.241
```

## Extension 1: Conditional average effects {-}

Modify the procedure above to estimate the average effect in subgroups defined by mom's education:

1.  those with `sex == Male`
2.  those with `sex == Female`

Specifically this means, what is the average effect among those for whom `sex == Male`?
Among those for whom `sex == Female`? __HINT__: this should only be a slight modification
of your code above that takes the average for the whole data.frame.


``` r
conditional_average_effects %>%
  select(yhat1, yhat0, effect, sex) %>%
  group_by(sex) %>%
  summarise(across(.fns = mean))
```

```
## Warning: There was 1 warning in `summarise()`.
## ℹ In argument: `across(.fns = mean)`.
## Caused by warning:
## ! Using `across()` without supplying `.cols` was deprecated
##   in dplyr 1.1.0.
## ℹ Please supply `.cols` instead.
```

```
## # A tibble: 2 × 4
##   sex    yhat1 yhat0 effect
##   <chr>  <dbl> <dbl>  <dbl>
## 1 Female 0.348 0.129  0.219
## 2 Male   0.460 0.196  0.263
```

## Extension 2: Logistic regression {-}

In groups: Repeat the steps above with logistic regression

$$\text{log}\left(\frac{\hat{P}\left(Y\mid A = a, \vec{L} = \vec\ell\right)}{1 - \hat{P}\left(Y\mid A = a, \vec{L} = \vec\ell\right)}\right) = \hat\alpha + A\hat\beta + \vec{L}'\hat{\vec\gamma} + A\vec{L}'\hat{\vec\eta}$$ Helpful hints:

-   This should be a simple extension of all the code above that uses `lm()`.
-   Read about using `glm()` to estimate logistic regression
-   when using `predict()`, search to find out how to predict probabilities

## Extension: Logistic regression {-}

Fit a model


``` r
f <- y ~ a*(sex + race + mom_educ + dad_educ + log_parent_income +
  log_parent_wealth + test_percentile)

fit <- glm(formula = f, family = binomial, data = d)
```

## Extension: Logistic regression {-}

Predict and summarize to estimate the average effect

\footnotesize


``` r
potential_outcomes_under_control <- predict(object = fit, newdata = d_all_control, type = "response")
potential_outcomes_under_treatment <- predict(object = fit, newdata = d_all_treated, type = "response")

conditional_average_outcomes <- d %>%
  mutate(yhat1 = potential_outcomes_under_treatment,
         yhat0 = potential_outcomes_under_control,
         effect = yhat1 - yhat0) %>%
  select(yhat1, yhat0, effect) %>%
  summarise(across(.fns = mean))

conditional_average_outcomes
```

```
## # A tibble: 1 × 3
##   yhat1 yhat0 effect
##   <dbl> <dbl>  <dbl>
## 1 0.406 0.165  0.241
```
