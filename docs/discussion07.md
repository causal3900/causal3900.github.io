---
output: html_document
---

# Solutions: Matching Lab {-}
View the original instructions [**here**](https://causal3900.github.io/statistical-modeling.html#lab-matching-in-r).

## Data and R Libraries {-}
The first exercise and problem set 4 use the `lalonde` dataset from the following paper:

> Dehejia, R. H. and Wahba, S. 1999. [Causal Effects in Nonexperimental Studies: Reevaluating the Evaluation of Training Programs](https://www-jstor-org.proxy.library.cornell.edu/stable/2669919?). Journal of the American Statistical Association 94(448):1053--1062.

The paper compares methods for observational causal inference to recover an average causal effect that was already known from a randomized experiment. You do not need to read the paper; we will just use the study's data as an illustration. We'll load the data into R with the first code block.



To learn about the data, type `?lalonde` in your R console.

## 2. Example: Exact Matching with low-dimensional confounding {-}

Our goal is to estimate the effect of job training `treat` on future earnings `re78` (real earnings in 1978), among those who received job training (the average treatment effect on the treated, ATT).

### 2.1.  Using `matchit()` to conduct a matching {-}

For this part, we assume that three variables comprise a sufficient adjustment set: `race`, `married`, and `nodegree`. We use `matchit` with:

- a formula `treat ~ race + married + nodegree`
- `method = "exact"` to conduct exact matching, which matches two units only if they are identical along `race`, `married`, and `nodegree`
- `data = lalonde` since we are using the `lalonde` data
-  `estimand = "ATT"` since we are targeting the average treatment effect on the treated (ATT)

We then use the `summary()` function to see how many control units and how many treatment units were matched. 


``` r
exact_low <- matchit(treat ~ race + married + nodegree,
                 data = lalonde,
                 method = "exact",
                 estimand = "ATT")
# Note: There are multiple correct ways to extract the numbers below
summary(exact_low)$nn
```

```
##                Control Treated
## All (ESS)     429.0000     185
## All           429.0000     185
## Matched (ESS) 111.5254     185
## Matched       429.0000     185
## Unmatched       0.0000       0
## Discarded       0.0000       0
```

**Question**: How many control units were matched? How many treated units?

\textbf{Answer.} All treated and control units were kept!


### 2.2. Effect estimate {-}

Here, we estimate a linear regression model using the match data from 2.1 using the `lm()` function with the formula `re78 ~ treat + race + married + nodegree`. We pass weights that come from the matching. Notice that for this piece, we have passed the matched data `match.data(exact_low)`. The coefficient in front of the variable `treat` in the linear regression is our estimated effect.


``` r
fit <- lm(re78 ~ treat + race + married + nodegree,
          data = match.data(exact_low),
          w = weights)
print(round(coef(fit)["treat"],2))
```

```
##  treat 
## 1309.9
```

**Question**: What is the estimated effect of job training on earnings?

**Answer.** The estimate suggests that job training increases future earnings by \$1309.90.

### 2.3. Assessing the Match: Balance of Covariates {-}

In matching, one thing we care about is balance across covariates. In other words, we want to see that the distributions of different covariates are about the same between the treatment and the control groups. We can check how well the balancing has been done with the `summary()` function.

- `interactions`: check interaction terms too? (T or F)
- `un`: show statistics for unmatched data as well? (T or F)


``` r
summary(exact_low, interactions = F, un = F)$sum.matched
```

```
##            Means Treated Means Control Std. Mean Diff.
## raceblack     0.84324324    0.84324324    0.000000e+00
## racehispan    0.05945946    0.05945946    6.938894e-18
## racewhite     0.09729730    0.09729730    1.387779e-17
## married       0.18918919    0.18918919    0.000000e+00
## nodegree      0.70810811    0.70810811    0.000000e+00
##            Var. Ratio    eCDF Mean     eCDF Max
## raceblack          NA 0.000000e+00 0.000000e+00
## racehispan         NA 6.938894e-18 6.938894e-18
## racewhite          NA 1.387779e-17 1.387779e-17
## married            NA 0.000000e+00 0.000000e+00
## nodegree           NA 0.000000e+00 0.000000e+00
##            Std. Pair Dist.
## raceblack                0
## racehispan               0
## racewhite                0
## married                  0
## nodegree                 0
```

**Question**: What do you notice about the means of different covariates for the treated versus control groups? 

**Answer**: Their means are the same! 

In this case, we basically have perfect balance. This doesn't always happen. Depending on the method and parameters you use, you could have "bad" matches where the covariates are unbalanced. If you conduct a matching and the covariate balance doesn't look good, try another matching procedure!

## 3. Try it Yourself: Exact matching with high-dimensional confounding {-}
You will use the results from this section in Problem Set 4.

### 3.1. Using `matchit()` to conduct a matching {-}
Now suppose the adjustment set needs to also include 1974 earnings, `re74`. The adjustment set for this part is `race`, `married`, `nodegree`, and `re74`. Repeat exact matching as above.

**Solution**

``` r
exact_high <- matchit(treat ~ race + married + nodegree + re74,
                 data = lalonde,
                 method = "exact",
                 estimand = "ATT")
# Note: There are multiple correct ways to extract the numbers below
summary(exact_high)$nn
```

```
##                 Control Treated
## All (ESS)     429.00000     185
## All           429.00000     185
## Matched (ESS)  48.73116     131
## Matched       108.00000     131
## Unmatched     321.00000      54
## Discarded       0.00000       0
```

**Question**: How many control units were matched? How many treated units?

\textbf{Answer.} Now only 108 out of 429 control units are matched, and only 131 out of 185 treated units.


### 3.2. Assessing the Match: Examining matched units {-}

Look at the `re74` values in the full data and among the matched units.

Here is one way to do this:

1. Use the `select()` function to get the `re74` column in the *full* data. Pass this to the `summary()` function to look at descriptive statistics of the `re74` values in the full data.
2. Use the `select()` function to get the `re74` column in the *matched* data. Pass this to the `summary()` function to look at descriptive statistics of the `re74` values in the full data. You can get the matched data using the `match.data` function. 

- Examples of using the `summary` function are [**here**](https://intro2r.com/summarising-data-frames.html).
- Examples of using the `select()` function are [**here**](https://benwhalley.github.io/just-enough-r/selecting-columns.html)


**Solution**

Full data:

``` r
summary(
  lalonde %>%
    select(re74)
)
```

```
##       re74      
##  Min.   :    0  
##  1st Qu.:    0  
##  Median : 1042  
##  Mean   : 4558  
##  3rd Qu.: 7888  
##  Max.   :35040
```
Matched data:

``` r
matched_data <- match.data(exact_high)
summary(
  matched_data %>%
    select(re74)
)
```

```
##       re74  
##  Min.   :0  
##  1st Qu.:0  
##  Median :0  
##  Mean   :0  
##  3rd Qu.:0  
##  Max.   :0
```

**Explain what happened**: What do you notice? What is different about the values of `re74` in the full data versus the matched data? Explain what happened and why it happened. Briefly interpret the result from 3.2: what is the drawback of using exact matching in this setting?
