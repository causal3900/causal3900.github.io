---
output: html_document
---
<style>li {line-height: 1.8;}</style>

# Discussion 9. Instrumental Variable {-}
## STSCI/INFO/ILRST 3900: Causal Inference {-}
#### October 22, 2025 {-}

You can download the [**slides**](assets/discussions/discussion9-instrumental-variables.pdf) for this week's discussion and the [**.Rmd**](assets/discussions/discussion9.Rmd).



In this lab we will be examining the following question: does participating in a 401(k) increase an individual's net wealth? One difficulty in answering this question is that whether or not people participate in a 401(k) is  probably not random. However, whether or not somebody is eligible to participate in a 401(k) is arguably random. Additionally, the only way that 401(k) eligibility affects an individual's net wealth is by affecting whether or not they participate in the 401(k). Given this setup, we can use Instrumental Variables to estimate the Local Average Treatment Effect (average treatment effect on the compliers) of participating in a 401(k).

## Load the data{-}

Let's begin by loading the data, which will be called `pension`. If 

``` r
library(hdm)
data(pension)
# Shuffle data around
pension <- pension[sample(1:nrow(pension), nrow(pension)), ]
```

## Set the data up for our analysis {-}

In the data, our variables of interest are the following:
`net_tfa`: This is our outcome variable showing an individual's net wealth.
`p401`: This is our treatment variable showing whether or not an individual participated in a 401(k).
`e401`: This is our instrument showing whether or not an individual was eligible to participate in a 401(k).
`age`, `inc`, `fsize`, `educ`, `db`, `marr`, `twoearn`, `pira`, `hown`: These are
potential confounders, but we will ignore them for right now. Remember we are assuming our instrument is randomly assigned.

## How are 401(k) eligibility and participation related {-}

We want to see how 401(k) eligibility and participation are related to build our intuition for this exercise. In particular it'll be helpful to see how many people that are eligible to participate in a 401(k) actually do so.


``` r
table(pension[, c("e401", "p401")])
```

```
##     p401
## e401    0    1
##    0 6233    0
##    1 1088 2594
```

## Estimate the Local Average Treatment Effect {-}

Finally, we will estimate the Local Average Treatment Effect (average treatment effect on the compliers) of participating in a 401(k) using the Wald Estimator and two-stage least squares. 

### Wald Estimator {-}
The estimator we discussed in class is also called the Wald estimator. This happens to be the same person, [Abraham Wald](https://en.wikipedia.org/wiki/Abraham_Wald), whose work is the inspiration of the [survivorship bias airplane meme](https://knowyourmeme.com/memes/survivorship-bias-plane)]  It proceeds by (1) estimating the effect of the instrument on the outcome, (2) estimating the effect of the instrument on the treatment, and (3) dividing (1) / (2).
$$\begin{aligned}
\hat{E}(Y^{a=1}-Y^{a=0}) &= \frac{\hat{E}(Y^{z=1}-Y^{z=0})}{\hat{E}(A^{z=1}-A^{z=0})}\\
&= \frac{\hat{E}(Y\mid Z = 1) - \hat{E}(Y\mid Z = 0)}{\hat{E}(A\mid Z = 1) - \hat{E}(A\mid Z = 0)}
\end{aligned}$$

First let's calculate the effect of the instrument on the outcome:

``` r
mean_outcome_by_instrument <- pension |>
  group_by( ... put the instrument here ...) |>
  summarise(net_tfa = mean(...put your outcome variable here...), .groups = "drop")

instrument_on_outcome <- (
  mean_outcome_by_instrument$net_tfa[2] - mean_outcome_by_instrument$net_tfa[1]
)
```

Now, calculate the effect of the instrument on the treatment:

``` r
mean_treatment_by_instrument <- pension |>
  group_by( ... put the instrument here ...) |>
  summarise(p401 = mean(...put your treatment variable here...), .groups = "drop")

instrument_on_treatment <- (
  mean_treatment_by_instrument$p401[2] - mean_treatment_by_instrument$p401[1]
)
```

Calculate the LATE by dividing these two:

``` r
wald_late <- instrument_on_outcome/instrument_on_treatment

wald_late
```


### Two stage least squeares {-}

We can also estimate the LATE with a procedure called two stage least squares. To do that we will use the `ivreg`
function from the AER package. When the treatment and instrument are both binary, this should give the exact same answer as the Wald estimator above. However, when the treatment or instrument are continuous, the Wald estimator may not work and two stage least squares can be used instead. To see the help file for this function, run `?ivreg` in your console and take a look at the documentation.

You will have to create a formula that tells `ivreg` what your outcome variable, treatment variable, and instrument variable are. **NOTE**: This formula should look something like `outcome ~ treatment | instrument`.

``` r
library("AER")
iv_formula <- ...make your formula here...
iv_model <- ivreg(formula = iv_formula, data = pension)

# Print the model
iv_model
```

The Local Average Treatment Effect is the `p401` coefficient that is in the printed summary above!

## Calculate robust standard errors and create 95% conf. interval {-}

Of course, since we want to understand how much uncertainty is in our estimates, we will calculate the standard errors for our estimate. **NOTE** The `vcov. = vcovHC` argument below is telling R to calculate robust standard errors, which we typically want to do in our statistical analyses.

``` r
standard_err <- summary(...put the necessary variable here..., vcov. = vcovHC)
late <- coef(standard_err)["p401", c("Estimate", "Std. Error")]
# 95% conf. int.
ci <- c(
  late[["Estimate"]] - qnorm(0.975)*late[["Std. Error"]],
  late[["Estimate"]] + qnorm(0.975)*late[["Std. Error"]]
)

# Print the results and confidence interval
cat("LATE (Lower bound, Upper bound):\n",
    paste0("\r", round(late[["Estimate"]], 3)),
    paste0("(", round(ci[[1]], 3), ","),
    paste0(round(ci[[2]], 3), ")\n"))
```

