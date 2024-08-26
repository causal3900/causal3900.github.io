
# Problem Set 4. Statistical modeling {-}

Relevant material will be covered by **Oct 5**. Problem set is due **Oct 19**.

To complete the problem set, [**Download the .Rmd**](https://drive.google.com/file/d/12_NT4ivtZqUnACrPMc7r7ET-QtW6kg8Q/view?usp=drive_link) and complete the homework. Omit your name so we can have anonymous peer feedback. Compile to a PDF and submit the PDF on [Canvas](https://canvas.cornell.edu/courses/57329).

The learning goals of completing this problem set are

- explain the role of statistical modeling
     * with respect to causal claims
     * with respect to data sparsity
- estimate average treatment effects by
     * exact matching (in a setting with few confounders)
     * learning an outcome model
     * learning a treatment model
     * a matching method of your choosing

The reason for practicing many statistical modeling estimators is so you can see how the ideas of this class apply to all those estimators---and to future estimators you will encounter that are not part of this class!

This problem set uses data from the following paper:

> Dehejia, R. H. and Wahba, S. 1999. [Causal Effects in Nonexperimental Studies: Reevaluating the Evaluation of Training Programs](https://www-jstor-org.proxy.library.cornell.edu/stable/2669919?). Journal of the American Statistical Association 94(448):1053--1062.

The paper compares methods for observational causal inference to recover an average causal effect that was already known from a randomized experiment. You do not need to read the paper; we will just use the study's data as an illustration.

The following lines will load these data into R.


``` r
library(tidyverse)
```

```
FALSE Warning: package 'ggplot2' was built under R version 4.3.3
```

```
FALSE Warning: package 'tidyr' was built under R version 4.3.3
```

```
FALSE Warning: package 'readr' was built under R version 4.3.3
```

```
FALSE Warning: package 'dplyr' was built under R version 4.3.3
```

```
FALSE Warning: package 'stringr' was built under R version 4.3.3
```

```
FALSE Warning: package 'lubridate' was built under R version
FALSE 4.3.3
```

``` r
library(MatchIt)
```

```
FALSE Warning: package 'MatchIt' was built under R version 4.3.3
```

``` r
data("lalonde")
```

To learn about the data, type `?lalonde` in your R console.

## 1. Conceptual questions {-}

### 1.1. (5 points) Statistical modeling and causal claims {-}

Imagine that someone who has not taken our class tells you they don't need DAGs or causal assumptions because they know a really good matching method. In no more than 3 sentences, explain to them why causal assumptions are necessary for matching to yield causal conclusions.

 

## 2. Nonparametric estimation {-}

Our goal is to estimate the effect of job training `treat` on future earnings `re78` (real earnings in 1978), among those who received job training (the average treatment effect on the treated, ATT).

### 2.1.  (4 points) Exact matching with low-dimensional confounding {-}

For this part, assume that three variables comprise a sufficient adjustment set: `race`, `married`, and `nodegree`. Use `matchit` with the argument `method = "exact"` to conduct exact matching, which matches two units only if they are identical along `race`, `married`, and `nodegree`.

> Note: Here we are calling this **exact matching**. This is the same thing we previously called **nonparametric estimation**: make subgroups of units identical along confounders, estimate the treatment effect within those subgroups, and aggregate over the sample. We are using the language of matching to be parallel with what comes in Question 4.

How many control units were matched? How many treated units?



### 2.2. (4 points) Effect estimate {-}

Estimate a linear regression model using your match data from 2.1. Include the treatment and all confounders from 2.1 in a linear, additive specification. Weight by the weights from matching.

What is the estimated effect of job training on earnings?



### 2.3. (4 points) Exact matching with high-dimensional confounding {-}

Now suppose the adjustment set needs to also include 1974 earnings, `re74`. The adjustment set for this part is `race`, `married`, `nodegree`, and `re74`. Repeat exact matching as above.

How many control units were matched? How many treated units?



### 2.4. (4 points) Examining matched units {-}

Look at the `re74` values in the full data and among the matched units (no need to print this in your output).
Explain what happened: what is different about the 1974 earnings of the matched vs the unmatched cases?

Here is one way to do this:

- Using the function `summary`, look at descriptive statistics of the `re74` values in the full data.
- Using the function `summary`, look at descriptive statistics of the `re74` values in the matched data. You can get the matched data using the `match.data` function. 
- You can learn about how to use the `summary` function to look at descriptive statistics of R data [**here**](https://intro2r.com/summarising-data-frames.html).

What do you notice? What is different about the values of `re74` in the full data versus the matched data? Explain what happened and why it happened.



### 2.5. (4 points) Drawbacks of exact matching {-}

Briefly interpret the result from 2.4: what is the drawback of using exact matching in this setting?

 

## 3. Parametric estimation {-}

### 3.1. (5 points) Outcome modeling {-}

In the code below, we use `lm()` to estimate an Ordinary Least Squares regression of future earnings `re78` on treatment `treat`, interacted with confounders: `race`, `married`, `nodegree`, and `re74`.


``` r
outcome_model <- lm(re78 ~ treat * (race + married + nodegree + re74),
                    data = lalonde)
```

Use the model above to estimate the average treatment effect among the *treated*.

To do this, you should

1. Create two data frames
     - The first should contain the *treated* individuals (with their factual treatment of `1`)
     - The second should contain the same *treated* individuals, but with `treat` set to the value `0`
2. Using the model above, predict the expected outcomes for the two data frames you created in step 1.
3. Report the average treatment effect among the treated.



### 3.2. (5 points) Treatment modeling: Creating weights {-}

> Note: This part has much help from us. You should read what we have provided to understand, and you will do a small part at the end. We are doing this to maximize the learning-value-to-workload ratio of the problem.

Using the `glm()` below, we estimate the probability of treatment given confounders.


``` r
treatment_model <- glm(treat ~ race + married + nodegree + re74,
                       data = lalonde,
                       family = binomial)
```

Then, using the code below, we

- predict the probability that `treat = 1`
- generate the propensity score for each unit
- create a weight for estimating the Average Treatment Effect on the Treated, by the formula

$$w_i = \frac{P(A = 1\mid \vec{L} = \vec\ell_i)}{P(A = a_i\mid \vec{L} = \vec\ell_i)}$$

> Note: For treated units, this weight is 1. For untreated units, the value varies.


``` r
with_weight <- lalonde %>%
  # Create the propensity score
  mutate(p_a_1 = predict(treatment_model, type = "response"),
         pscore = case_when(treat == 1 ~ p_a_1,
                            treat == 0 ~ 1 - p_a_1),
         weight = p_a_1 / pscore)
```

How many treated units does the most-heavily-weighted *untreated* unit represent? To answer this, you will want to determine the maximum weight amongst untreated individuals in `with_weight.`



### 3.3. (5 points) Treatment modeling: Estimating outcomes {-}

Using the `with_weight` object, take *weighted means* of the observed outcomes `re78` weighted by `weight` to estimate the average outcome of treated units, and the weighted average outcome of control units (weighted to be comparable to the treated units).

> Hint: You will want to take a *weighted mean*, but *grouped by* treatment status.



## 4. Matching without requiring exact matches {-}

We hope that from this class you are prepared to learn new causal estimators, apply them in R, and explain what you have done. This question is a chance to practice! In class we discussed many matching approaches. For this question, you will choose your own approach. There are many correct answers, and you will be evaluated by the clarity of your code and explanations.

Task: Using `matchit`, conduct matching to estimate the ATT where `treat` is the treatment and the sufficient adjustment set is `race`, `married`, `nodegree`, and `re74`.

1. Use `matchit`, setting `method`, `distance`, and any other arguments to any values of your choosing. The only requirements are
     * `formula = treat ~ race + married + nodegree + re74`
     * `estimand = "ATT"`
2. Create matched dataset using `match.data()`
3. Estimate a linear regression model using `lm()` with the formula `re78 ~ treat + race + married + nodegree + re74` using your matched data, weighted by the `weights` that are produced by `match.data()`.

### 4.1. (4 points) Conduct the matching {-}

This is space to conduct the matching. We expect this part to be an R code chunk.



### 4.2. (2 points) Explain your choices {-}

In a few sentences, tell us about the matching approach you have chosen.



### 4.3. (2 points) How many units did you keep? {-}

Report the number of treated and control units in the original data, and how many were kept by your matching procedure.



### 4.4. (2 points) Report your causal estimate {-}

What do you estimate for the average treatment effect on the treated? This is the coefficient on `treat` in the linear regression you fit on the matched data.


