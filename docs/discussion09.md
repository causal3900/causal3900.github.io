---
output: html_document
---
<style>li {line-height: 1.8;}</style>

# Discussion 9. Instrumental Variable {-}
## STSCI/INFO/ILRST 3900: Causal Inference {-}
#### November 11, 2026 {-}
    
  
- You can download the [**slides**](assets/discussions/discussion9-slides.pdf) for this week's discussion

- Read the paper ["Social Pressure and Voter Turnout: Evidence from a Large-scale Field Experiment."](https://pubs.aeaweb.org/doi/pdfplus/10.1257/aer.91.5.1369) in American economic review, by Daron Acemoglu, Simon Johnson, and James A. Robinson.

- Download the [**.Rmd**](assets/discussions/discussion9.Rmd)

- Answer the questions and hand in the in-class assignment


## How are institutions and economic development related? {-}


In this lab we will be examining the following question: what is the effect of institutions on economic performance? We will use data from ["Social Pressure and Voter Turnout: Evidence from a Large-scale Field Experiment."](https://pubs.aeaweb.org/doi/pdfplus/10.1257/aer.91.5.1369). 


### Load the data{-}

Let's begin by loading the data. For this we will use a package called `ivdoctr`, which you might need to install using `install.packages(ivdoctr)`. Then load the data which is called `colonial`. 


``` r
library(ivdoctr)
data(colonial)

# Take a look at the data
head(colonial)
```

```
##    shortnam africa  lat_abst rich4   avexpr logpgp95
##      <char>  <num>     <num> <num>    <num>    <num>
## 1:      AGO      1 0.1366667     0 5.363636 7.770645
## 2:      ARG      0 0.3777778     0 6.386364 9.133459
## 3:      AUS      0 0.3000000     1 9.318182 9.897972
## 4:      BFA      1 0.1444445     0 4.454545 6.845880
## 5:      BGD      0 0.2666667     0 5.136364 6.877296
## 6:      BHS      0 0.2683333     0 7.500000 9.285448
##      logem4  asia   loghjypl
##       <num> <num>      <num>
## 1: 5.634789     0 -3.4112477
## 2: 4.232656     0 -0.8722738
## 3: 2.145931     0 -0.1707883
## 4: 5.634789     0 -3.5404594
## 5: 4.268438     1 -2.0635681
## 6: 4.442651     0         NA
```

In the data, our variables of interest are the following:


- `logpgp95`: Log GDP per capita in 1995 (outcome variable)
- `avexpr`: Average protection against the risk of expropriation (measure of institutional quality)
- `logem4`: Log European settler mortality (instrumental variable)


### Estimate the causal effect of institutions {-}

We will estimate the causal effect of institutional quality (`avexpr`) on economic development (`logpgp95`) using the instrumental variable, European settler mortality (`logem4`).


#### Manually implementing Two-Stage Least Squares {-}

Follow the steps of two-stage least square on the slides:

**First stage:**

In the first stage, we use the IV to predict the treatment by regressing institutional quality (`avexpr`) on our instrument (`logem4`)


``` r
first_stage <- lm(avexpr ~ logem4, data = colonial)

# Obtain predicted institutional quality
avexpr_hat <- fitted(first_stage)
```




**Second stage:**

In the second stage, we regress the outcome on the predicted treatment from stage 1, i.e. regress economic development (`logpgp95`) on the predicted institutional quality (`avexpr_hat`).


``` r
second_stage <- lm(logpgp95 ~ avexpr_hat, data = colonial)

summary(second_stage)
```

```
## 
## Call:
## lm(formula = logpgp95 ~ avexpr_hat, data = colonial)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.7545 -0.5386  0.1412  0.4607  1.4059 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   1.9097     0.8233   2.320   0.0237 *  
## avexpr_hat    0.9443     0.1255   7.523 2.66e-10 ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.7604 on 62 degrees of freedom
## Multiple R-squared:  0.4772,	Adjusted R-squared:  0.4688 
## F-statistic:  56.6 on 1 and 62 DF,  p-value: 2.659e-10
```

The coefficient on `avexpr_hat` is our manually calculated 2SLS estimate.



#### Two-Stage Least Squares (2SLS) using `ivreg()` {-}

We can estimate the causal effect using the `ivreg()` function from the `AER` package. You will need to create a formula specifying the outcome variable, endogenous explanatory variable, and instrument. The formula has the following structure: `outcome ~ endogenous_variable | instrument`



``` r
library(AER)

iv_formula <- ... ~ ... | ...

iv_model <- ivreg(
  formula = iv_formula,
  data = colonial
)

summary(iv_model)
```

The coefficient on `avexpr` is the IV estimate of the causal effect of institutional quality on economic development.


The IV estimate obtained using `ivreg()` should be identical to the coefficient obtained from the manual two-stage procedure.

Note: The conventional standard errors reported by the second-stage OLS regression are not the correct 2SLS standard errors. The `ivreg()` function calculates the appropriate IV standard errors.
