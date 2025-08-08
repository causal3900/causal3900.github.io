
# (PART) Areas of active research {-}

# Current research

## Research discussion: Mayleen

> Dec 3 [**Slides**](assets/sliinterference_lecture.pdf)

Today we will be discussing interference, the challenges it brings to causal inference, and some proposed solutions. 

<<<<<<< HEAD
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
##   X         A         Y
## 1 1 untreated 17.676929
## 2 1   treated 21.682697
## 3 1 untreated 56.491525
## 4 1   treated 75.296173
## 5 1 untreated  5.405076
## 6 2   treated 75.194258
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
=======
>>>>>>> 3bf8b6387dd83de7ad9793602f027f9869ce047e
