---
output: html_document
---

# Discussion 3. Analyzing an Experiment in R - Solutions



## Get out and Vote Experiment

In this lab we are going to explore an experiment that digs into the mechanisms
underlying __why people vote__. A long-standing theory as to why many people
vote is that it is driven by social norms (e.g. the understanding that voting
is their civic duty). This theory, while being a dominant theoretical 
explanation, had very little empirical backing for a long time. This experiment
examines this very theory by asking the question:
__to what extent do social norms cause voter turnout__?

### Experimental Design

In order to answer this question, approximately 80,000 Michigan households
were randomly assigned to treatment and control groups, where the treatment
group was randomly assigned to one of four possible treatment arms. These
treatment arms varied in the intensity of social pressure that they conveyed,
and were defined as follows:

- The first treatment arm was mailed a letter that simply reminded them that
voting is a civic duty.
- The second treatment arm was mailed a letter telling them that researchers
would be studying their voting turnout based on public records.
- The third treatment arm was mailed a letter stating that their voting turnout 
would be revealed to all other members of their household.
- The fourth treatment arm was mailed a letter stating that their voting turnout
would be revealed to their household *and* to their neighbors.

## Analyze Experiment

### Necessary packages

__Note:__ If this errors you probably either don't have `dplyr` or `haven`
installed.


```r
library(dplyr)
library(haven)
```

### Import data

```r
gotv <- read_dta("https://causal3900.github.io/assets/data/social_pressure.dta")
```

Alternatively (if you really want), you could download the data
[here](assets/data/social_pressure.dta) and load it directly from your computer.


### Clean data

You'll need to construct `age` from the `yob` variable.

```r
gotv <- gotv |>
  mutate(
    age = floor(2006 - yob),
    hh_size = as.numeric(hh_size),
    treatment = case_when(
      treatment == 0 ~ "Control",
      treatment == 1 ~ "Hawthorne",
      treatment == 2 ~ "Civic Duty",
      treatment == 3 ~ "Neighbors",
      treatment == 4 ~ "Self"
    )
  ) |>
  zap_labels()
```


```r
glimpse(gotv)
```

```
## Rows: 344,084
## Columns: 17
## $ sex           <dbl> 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, …
## $ yob           <dbl> 1941, 1947, 1951, 1950, 1982, 1981, …
## $ g2000         <dbl> 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, …
## $ g2002         <dbl> 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, …
## $ g2004         <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ p2000         <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
## $ p2002         <dbl> 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, …
## $ p2004         <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, …
## $ treatment     <chr> "Civic Duty", "Civic Duty", "Hawthor…
## $ cluster       <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ voted         <dbl> 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, …
## $ hh_id         <dbl> 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 6, …
## $ hh_size       <dbl> 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 1, 2, …
## $ numberofnames <dbl> 21, 21, 21, 21, 21, 21, 21, 21, 21, …
## $ p2004_mean    <dbl> 0.09523810, 0.09523810, 0.04761905, …
## $ g2004_mean    <dbl> 0.8571429, 0.8571429, 0.8571429, 0.8…
## $ age           <dbl> 65, 59, 55, 56, 24, 25, 47, 50, 38, …
```

### Balance table


```r
covariates <- c("sex", "age", "g2000", "g2002", "p2000", "p2002", "p2004", "hh_size")

gotv_results <- gotv |>
  summarise(
    across(.cols = all_of(covariates), .fns = mean), .by = treatment
  )

# gotv |>
#   tbl_summary(
#     include = all_of(covariates),
#     type = list(everything() ~ "continuous"),
#     by = treatment,
#     statistic = list(all_continuous() ~ "{mean}"),
#     label = list(
#       sex ~ "Female",
#       age ~ "Age (in years)"
#     ),
#     digits = list(age ~ 3)
#   )
print(gotv_results)
```

```
## # A tibble: 5 × 9
##   treatment    sex   age g2000 g2002 p2000 p2002 p2004
##   <chr>      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 Civic Duty 0.500  49.7 0.842 0.811 0.254 0.389 0.399
## 2 Hawthorne  0.499  49.7 0.844 0.813 0.250 0.394 0.403
## 3 Control    0.499  49.8 0.843 0.811 0.252 0.389 0.400
## 4 Self       0.500  49.8 0.840 0.811 0.251 0.392 0.402
## 5 Neighbors  0.500  49.9 0.842 0.811 0.251 0.387 0.407
## # ℹ 1 more variable: hh_size <dbl>
```

### Results


```r
gotv |>
  summarise(`Percentage Voting` = mean(voted), `N of Individuals` = n(), .by = treatment)
```

```
## # A tibble: 5 × 3
##   treatment  `Percentage Voting` `N of Individuals`
##   <chr>                    <dbl>              <int>
## 1 Civic Duty               0.315              38218
## 2 Hawthorne                0.322              38204
## 3 Control                  0.297             191243
## 4 Self                     0.345              38218
## 5 Neighbors                0.378              38201
```

