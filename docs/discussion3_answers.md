---
output: html_document
---

# Discussion 3. Analyzing an Experiment in R



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
```

### Results


```r
gotv |>
  summarise(`Percentage Voting` = mean(voted), `N of Individuals` = n(), .by = treatment)
```
