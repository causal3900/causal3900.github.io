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

```r
library(tidyverse)
library(haven)
```

**To complete the rest of this assignment, you will need to download the study's data from OpenICPSR**: [https://www.openicpsr.org/openicpsr/project/116023/version/V1/view](https://www.openicpsr.org/openicpsr/project/116023/version/V1/view). This will require creating an account and agreeing to terms for using the data ethically. Put the data in the folder on your computer where this .Rmd is located. Read the data into R using `read_dta`.


```r
d <- read_dta("assets/data/lakisha_aer.dta")
```


```r
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


```r
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


```r
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
> ```r
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
> ```r
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

```r
your_ggplot +
  facet_wrap(~ race + sex,
             scales = "free_x", 
             nrow = 1)
```
> Any strategy to visualize is fine, as long as it shows estimates for each `firstname` and indicates the `race` and `sex` signaled by that `firstname`
> Up through 2.4, you were making two estimates: one for white and one for Black. In 2.5, you are aggregating within a more fine-grained set of groups defined by race, sex, and firstname. So you will need to start fresh from the raw person-level data in order to answer 2.5

### 2.6. (5 points) Interpret {-}

Within race and sex, not all first names have the same effect. Suppose these are true differences (not due to sampling variability). What does this tell you about the importance of researcher decisions about which names to use as treatments? There are many possible right answers, and here we are asking you to think about what it might mean for research design that the names have different effects.
