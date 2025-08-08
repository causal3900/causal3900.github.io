---
output: html_document
---

# Discussion 10: RDD Lab Solutions {-}

Download the discussion slides [**here**]() and the RMarkdown File [**here**](assets/discussions/rdd_lab.Rmd). You may need to copy and paste into a .Rmd file.

The goal of today's activity is to interact with regression discontinuity through a real-world example using R. The first section is more conceptual, to help you understand the particular application. Afterwards, there is a mix of conceptual and coding questions. Most of the coding is already done for you and we instead ask that you explore the code by changing some variables.

## 1. Background: An Application to Party Advantages in the U.S. Senate {-}
Let's apply a regression discontinuity analysis to data. This example follows the analysis ``Randomization Inference in the Regression Discontinuity Design: An Application to Party Advantages in the U.S. Senate'' by Cattaneo, Frandsen, and Titiunik (2015) and their replication file.

Political scientists are interested in the effect of being an incumbent (the currently elected politician) on the share of votes in an election. Being the current public official means increased name recognition, fundraising opportunities, etc. On the other hand, being an incumbent means you can get blamed for all the bad things that have happened during your term. Elections also give a natural setting where you have a cutoff: if you only win 49.9% of the votes, you're out of luck... but win 50.1% of the votes and you've won the whole election!

The data we analyze considers US senators. Each state in the US has two senators with 6 year terms, and the election for each of the two senators alternates every 3 years. So for instance, there are two senate seats: A and B. In 2000 senate seat A undergoes an election, in 2003 senate seat B undergoes an election but senate seat A continues, in 2006 senate seat A undergoes an election but senate seat B continues on, etc. 

_Causal question_: Does being an incumbent affect your vote share the next time you run for office?

_Treatment_: Being an incumbent (in other words, being in office)

_Outcome_: Vote share in your next election (i.e. what percentage of votes did you get?)

_Running variable_: Margin of victory (by how much did you win in your last election)

_Cutoff_: 0 (you win, i.e. become incumbent, if your margin of victory is greater than 0; otherwise, you lost!)

### 1.1 Check Your Understanding {-}

**Question:** In your own words, explain how we might use regression discontinuity to provide an answer to the question. 

**Answer:** *Using data from senators who just barely won or just barely lost an election, we can use regression discontinuity to compute the effect that being in office has on your outcome in the next election. In other words, we can answer the question "What effect does just barely winning or just barely losing the election have on your outcome in the next election?" Critically, this estimate only applies to senators who just barely won or just barely lost, and would not generalize to other senators without further assumptions.*

## 2. Data {-}
For this section, run the code block below and read through the comments inside the code block. The following code installs and loads some libraries into R, then reads in data from an online fine, and finally prints out the first few rows of the data table.


``` r
# Lines like this (starting with a hashtag) are called comments
# Comments are meant to help explain what is going on
# Comments are not always necessary, but can be helpful

# Below, we create a function that loads in libraries, but first checks if it is installed
# The piece of code below is not necessary, but it makes loading libraries more convenient 
install <- function(package) {
  if (!require(package, quietly = TRUE, character.only = TRUE)) {
    install.packages(package, repos = "http://cran.us.r-project.org", type = "binary")
    library(package, character.only = TRUE)
  }
}

# install and load some libraries using the function created above
install("ggplot2")
install("lpdensity")
install("rddensity")
install("rdrobust")
install("rdlocrand")

# read in the datafile
data <- read.csv("https://raw.githubusercontent.com/rdpackages-replication/CIT_2020_CUP/master/CIT_2020_CUP_senate.csv")

# the head function shows us the first few rows of our data
head(data)
```

```
##         state year dopen population presdemvoteshlag1
## 1 Connecticut 1914     0    1233000          39.15937
## 2 Connecticut 1916     0    1294000          39.15937
## 3 Connecticut 1922     0    1431000          33.02737
## 4 Connecticut 1926     0    1531000          27.52570
## 5 Connecticut 1928     1    1577000          27.52570
## 6 Connecticut 1932     0    1637000          45.57480
##         demmv demvoteshlag1 demvoteshlag2 demvoteshfor1
## 1  -7.6885610            NA            NA      46.23941
## 2  -3.9237082      42.07694            NA      36.09757
## 3  -6.8686604      36.09757      46.23941      35.64121
## 4 -27.6680560      45.46875      36.09757      45.59821
## 5  -8.2569685      35.64121      45.46875      48.47606
## 6   0.7324815      45.59821      35.64121      51.74687
##   demvoteshfor2 demwinprv1 demwinprv2 dmidterm dpresdem
## 1      36.09757         NA         NA        1        1
## 2      45.46875          0         NA        0        1
## 3      45.59821          0          0        1        0
## 4      48.47606          0          0        1        0
## 5      51.74687          0          0        0        0
## 6      39.80264          0          0        0        0
```
Here is what some of these column names (variables) mean:

- `demmv` is the democratic margin of victory in the current senate election (i.e., democratic percentage - next closest percentage)
    - so a value just above 0 indicates a very close victory, a value just below 0 indicates a very close loss
- `demovoteshlag1` and `demovoteshlag2` indicates the vote share 1 and 2 election cycles ago, respectively
- `demovoteshfor1` and `demovoteshfor2` indicates the vote share 1 and 2 elections cycles in the future, respectively


## 3. RDD in R {-}
We are considering whether being the incumbent affects vote share in the next election. Thus, the outcome of interest is `demvoteshfor2` because the next time the same seat goes up for election is 2 cycles in the future. The running variable is `demmv`.


``` r
# Save the column "demvoteshfor2" from data into a variable called "outcome"
outcome <- data$demvoteshfor2

# Save the column "demmv" from data into a variable called "running_variable"
running_variable <- data$demmv

# plot the data
rdplot(y = outcome, x =  running_variable, nbins = c(1000, 1000), 
       p = 0, col.lines = "red", col.dots = "lightgray", 
       title = "Incumbency Advantage", y.lim = c(0,100), 
       x.label = "Dem Margin of Victory", y.label = "Dem Vote Share in next election")
```

<img src="discussion10_files/figure-html/unnamed-chunk-2-1.png" width="672" />

Optional: Explore the documentation for the function [`rdplot()`](https://rdrr.io/cran/rdrobust/man/rdplot.html) Read the description and the arguments. What do the arguments (`y`, `x`, `nbins`, `p`, `col.lines`, etc) in the function mean? Are any of them optional? Do any of them have default values?

### 3.1 Is there a discontinuity? {-}
**Question:** In the code above, compare what happens when you run the code with $p=0$ versus $p=1$ versus $p=2$. To do this, look for `p` in the function `rdplot` above. It is currently set to `p = 0` so if you run the code, it will give you results for `p = 0`. Then, you can change the value of `p` and re-run the code. What changes? Is there a discontinuity (jump) at the cutoff?

**Answer:** *Changing the value of `p` changes the degree of the polynomial we are assuming for the data. As we increase `p`, the curves on the left and right of the cutoff seem to possibly fit the data a little better. However, this may indicate overfitting. In all instances, there is a clear jump at the cutoff.*


### 3.2 Estimating the causal effect using rdrobust {-}
Getting the estimates aren't so difficult once we've selected a bandwidth, but selecting a good bandwidth can be tricky and getting standard errors on the estimate are also difficult. The R package `rdrobust` selects the bandwidth, estimates the causal effect quantities, and give standard errors with just a couple of lines of code. 

For `rdrobust`, the syntax is `rdrobust(y, x, kernel, p, h)` where y is the outcome, x is the running variable, kernel says what types of weights to use, p says what degree model (e.g. p = 1 means linear model), and h is the bandwidth. 


``` r
# uniform kernel with bandwidth 10 and a linear (degree 1) model
out <- rdrobust(outcome, running_variable, kernel = 'uniform',  p = 1, h = 10)

# print the results
summary(out)
```

```
## Sharp RD estimates using local polynomial regression.
## 
## Number of Obs.                 1297
## BW type                      Manual
## Kernel                      Uniform
## VCE method                       NN
## 
## Number of Obs.                  595          702
## Eff. Number of Obs.             245          206
## Order est. (p)                    1            1
## Order bias  (q)                   2            2
## BW est. (h)                  10.000       10.000
## BW bias (b)                  10.000       10.000
## rho (h/b)                     1.000        1.000
## Unique Obs.                     595          702
## 
## =====================================================================
##                    Point    Robust Inference
##                 Estimate         z     P>|z|      [ 95% C.I. ]       
## ---------------------------------------------------------------------
##      RD Effect     6.899     3.891     0.000     [5.156 , 15.624]    
## =====================================================================
```

#### 3.2.1 Questions {-}
**Question:** In both mathematical notation and in your own words, describe the causal effect that is being estimated. What is the estimated value?

**Answer:** *The estimated value is 6.899. We are estimating the local average treatment effect. In this example, this is the average treatment effect of being an incumbent on vote share for the group of senators who just barely won or just barely lost (these are the senators around the cutoff).* 

## 4. Try coding on your own {-}

For this next piece, the question is "If the other sitting senator is from your same party, what is the effect on your vote share?" In other words, if I am a democrat (resp, republican) senator, what is the effect of the other senator also being a democrat (resp, republican) on my share of votes when I run for office? Recall that I would not be competing with the other senator, because elections are every 3 years and alternate between senators.

Now try on your own and estimate the causal effect of the senator who is not up for election being a democrat on the democratic vote share of the senator who is up for election. In this case, the outcome of interest is `demvoteshfor1` since we are interested in the immediately following election. The running variable is still margin of victory `demmn`. We've plotted the data for you below. 

``` r
outcome_2 <- data$demvoteshfor1
running_variable_2 <- data$demmv

# plot the data
# Set p = 0 for a straight line (i.e., regression with X^p)
rdplot(y = outcome_2, x =  running_variable_2, nbins = c(1000, 1000), p = 0, col.lines = "red", col.dots = "lightgray", title = "Incumbency Advantage", y.lim = c(0,100), x.label = "Dem Margin of Victory", y.label = "Dem Vote Share in next election")
```

<img src="discussion10_files/figure-html/unnamed-chunk-4-1.png" width="672" />

Your task is to use `rdrobust()` to get an estimate of the LATE by specifying a kernel, model degree (`p`) and bandwidth size (`h`). Can you explain what you did and why? Can you explain what quantity you estimated?


``` r
# Your code goes here
```


**Question:** Does the estimate change if you change the value of `kernel` (see what happens when you set to 'uniform' versus 'triangular')? What if you change the value of `p`? What happens if you change `h` or remove it completely? Do the standard errors change? How does what you see relate to bias and variance?
