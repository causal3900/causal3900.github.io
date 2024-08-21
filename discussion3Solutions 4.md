---
output:
  pdf_document: default
  html_document: default
---

# Discussion 03. Analyzing an Experiment in R SOLUTIONS {.unnumbered}



These are *possible* solutions to the exercises from discussion. Your code may look different from ours, but as long as your output is the same that is all that matters!

You can download this file [here](assets/discussions/discussion3-solutions.Rmd).

## Necessary packages

**Note:** If this errors you probably either don't have `dplyr` or `haven` installed.


```r
library(dplyr)
library(haven)
```

### Import data


```r
gotv <- read_dta("https://causal3900.github.io/assets/data/social_pressure.dta")
```


```r
glimpse(gotv)
```

```
## Rows: 344,084
## Columns: 16
## $ sex           <dbl+lbl> 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0,…
## $ yob           <dbl> 1941, 1947, 1951, 1950, 1982, 1981, …
## $ g2000         <dbl+lbl> 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1,…
## $ g2002         <dbl+lbl> 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1,…
## $ g2004         <dbl+lbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
## $ p2000         <dbl+lbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
## $ p2002         <dbl+lbl> 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0,…
## $ p2004         <dbl+lbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,…
## $ treatment     <dbl+lbl> 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0,…
## $ cluster       <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ voted         <dbl+lbl> 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1,…
## $ hh_id         <dbl> 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 6, …
## $ hh_size       <dbl> 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 1, 2, …
## $ numberofnames <dbl> 21, 21, 21, 21, 21, 21, 21, 21, 21, …
## $ p2004_mean    <dbl> 0.09523810, 0.09523810, 0.04761905, …
## $ g2004_mean    <dbl> 0.8571429, 0.8571429, 0.8571429, 0.8…
```

### Clean data

First, we construct an age variable describing how old (in number of years) each person was in the year 2006. The `yob` variable says which year each person was born in. \> For this, we use the `mutate` function, which you can read about [here](https://dplyr.tidyverse.org/reference/mutate.html).

Fill in the appropriate expression after `age =` to add a column to `gotv` labeled `age` that contains how old each person was in 2006.


```r
gotv <- gotv |>
  mutate(age = 2006 - yob)
```

Now, we convert the `treatment` variable from it's numeric representation to the corresponding labels which are

-   0: "Control"
-   1: "Hawthorne" (this is the 'researchers viewing records via public data' treatment arm)
-   2: "Civic Duty" (this is the 'voting is your civic duty' treatment arm)
-   3: "Neighbors" (this is the 'voting turnout revealed to neighbors' treatment arm)
-   4: "Self" (this is the 'voting turnout revealed to household' treatment arm)

> One solution uses the function `case_when` which is described [here](https://www.sharpsightlabs.com/blog/case-when-r/).


```r
gotv <- gotv |>
  mutate(treatment = case_when(
      treatment == 0 ~ "Control",
      treatment == 1 ~ "Hawthorne",
      treatment == 2 ~ "Civic Duty",
      treatment == 3 ~ "Neighbors",
      treatment == 4 ~ "Self")) 
```

> We could have done this differently. For the exercise, we split up the task into two pieces: create a new column `age` in `gotv` that contains the ages of each individual in 2006, and then replace the numeric treatment labels in the column `treatment` with alphabetic/word labels. You can actually do this all in one block of code as follows: 

```
gotv <- gotv |>
  mutate(
    age = floor(2006 - yob),
    treatment = case_when(
      treatment == 0 ~ "Control",
      treatment == 1 ~ "Hawthorne",
      treatment == 2 ~ "Civic Duty",
      treatment == 3 ~ "Neighbors",
      treatment == 4 ~ "Self")
    ) 
```

Another alternative solution
Now, when we use `glimpse` we see there is an added `age` variable and that the treatments have word instead of number labels.


```r
glimpse(gotv)
```

```
## Rows: 344,084
## Columns: 17
## $ sex           <dbl+lbl> 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0,…
## $ yob           <dbl> 1941, 1947, 1951, 1950, 1982, 1981, …
## $ g2000         <dbl+lbl> 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1,…
## $ g2002         <dbl+lbl> 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1,…
## $ g2004         <dbl+lbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
## $ p2000         <dbl+lbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
## $ p2002         <dbl+lbl> 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0,…
## $ p2004         <dbl+lbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,…
## $ treatment     <chr> "Civic Duty", "Civic Duty", "Hawthor…
## $ cluster       <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ voted         <dbl+lbl> 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1,…
## $ hh_id         <dbl> 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 6, …
## $ hh_size       <dbl> 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 1, 2, …
## $ numberofnames <dbl> 21, 21, 21, 21, 21, 21, 21, 21, 21, …
## $ p2004_mean    <dbl> 0.09523810, 0.09523810, 0.04761905, …
## $ g2004_mean    <dbl> 0.8571429, 0.8571429, 0.8571429, 0.8…
## $ age           <dbl> 65, 59, 55, 56, 24, 25, 47, 50, 38, …
```

Note, there are other ways you could have arrived here and that's totally fine as long as the results are the same!


### Balance table

Next, we confirm that our control and treatment groups look pretty much the same across a set of covariates, i.e. that the two groups are *balanced on covariates*. Specifically this means we calculate the mean value of a set of covariates across each of the treatment/control arms, and we expect them to be pretty much equal if our randomization worked. This is related to the idea of exchangeability.

> The solution below uses the functions [`group_by`](https://dplyr.tidyverse.org/reference/group_by.html), [`summarise`](https://dplyr.tidyverse.org/reference/summarise.html), and [`across`](https://dplyr.tidyverse.org/reference/across.html).
> 
> You may have done something different. If the output is the same (or very similar), then that should be fine!


```r
covariates <- c("sex", "age", "g2000", "g2002", "p2000", "p2002", "p2004", "hh_size")

gotv_balance <- gotv |>
  group_by(treatment) |>
  summarise(across(.cols = covariates, .fns = mean))

print(gotv_balance)
```

```
## # A tibble: 5 × 9
##   treatment    sex   age g2000 g2002 p2000 p2002 p2004
##   <chr>      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 Civic Duty 0.500  49.7 0.842 0.811 0.254 0.389 0.399
## 2 Control    0.499  49.8 0.843 0.811 0.252 0.389 0.400
## 3 Hawthorne  0.499  49.7 0.844 0.813 0.250 0.394 0.403
## 4 Neighbors  0.500  49.9 0.842 0.811 0.251 0.387 0.407
## 5 Self       0.500  49.8 0.840 0.811 0.251 0.392 0.402
## # ℹ 1 more variable: hh_size <dbl>
```

An alternative solution that does not explicitly use `group_by`:
```
covariates <- c("sex", "age", "g2000", "g2002", "p2000", "p2002", "p2004", "hh_size")

gotv_results <- gotv |>
  summarise(
    across(.cols = all_of(covariates), .fns = mean),
    .by = treatment
    )
print(gotv_results)
```
### Results

Finally, for each treatment group, we calculate the percentage of individuals who got out and voted, as well as the total number of individuals in that group! The solutions below use the function [`n`](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/n) which counts the number of observations in the current group for you.


```r
gotv_results <- gotv |>
  group_by(treatment) |>
  summarise(Percentage_Voting = mean(voted), num_of_individuals = n())

print(gotv_results)
```

```
## # A tibble: 5 × 3
##   treatment  Percentage_Voting num_of_individuals
##   <chr>                  <dbl>              <int>
## 1 Civic Duty             0.315              38218
## 2 Control                0.297             191243
## 3 Hawthorne              0.322              38204
## 4 Neighbors              0.378              38201
## 5 Self                   0.345              38218
```

Alternatively, you could write this without using `group_by` explicitly: 
```
gotv |>
  summarise(Percentage_Voting = mean(voted), num_of_individuals = n(), .by = treatment)
```
