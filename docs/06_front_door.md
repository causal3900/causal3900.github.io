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


```r
library(tidyverse)
```


```r
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

```r
data %>%
  group_by(A) %>%
  summarize(Y = mean(Y))
```

```
## # A tibble: 2 × 2
##       A     Y
##   <int> <dbl>
## 1     0 0.596
## 2     1 0.743
```

Estimate the probability of each $M$ given $A$. Under the causal assumptions, this corresponds to the expected value of $M$ under assignment to each value of $A$ since $M\rightarrow A$ is unconfounded.

```r
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
## 1     0     0       0.894
## 2     0     1       0.106
## 3     1     0       0.104
## 4     1     1       0.896
```

Within the front-door identification formula, you need the marginal probability of each treatment value.

```r
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
## 1     0 0.498
## 2     1 0.502
```

You also need the outcome distribution given $M$ and $A$.

```r
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
## 1     0     0         0.583
## 2     0     1         0.703
## 3     1     0         0.658
## 4     1     1         0.753
```

Given the above, you can use backdoor adjustment to identify the outcome under intervention on $M$ by backdoor adjustment for $A$.

```r
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
## 1     0       0.621
## 2     1       0.728
```

Bringing the above together, we have front-door identification.

```r
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
## 1     0    0.632
## 2     1    0.717
```
