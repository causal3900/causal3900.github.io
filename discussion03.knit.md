---
output: html_document
---
<style>li {line-height: 1.8;}</style>

# Discussion 3. Treatment effect heterogneity in an Experiment {-}
## STSCI/INFO/ILRST 3900: Causal Inference {-}
#### September 10, 2025 {-}




## Get out and Vote Experiment

Last week, we explored an experiment that digs into the mechanisms
underlying __why people vote__. This exercise is based on: 

Gerber, Alan S., Donald P. Green, and Christopher W. Larimer. ["Social Pressure and Voter Turnout: Evidence from a Large-scale Field Experiment."](https://www.cambridge.org/core/journals/american-political-science-review/article/social-pressure-and-voter-turnout-evidence-from-a-largescale-field-experiment/11E84AF4C0B7FBD1D20C855972C2C3EB#) American Political Science Review 102.1 (2008): 33-48.

A long-standing theory as to why many people
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

1. The first treatment arm was mailed a letter that simply reminded them that
voting is a civic duty.
2. The second treatment arm was mailed a letter telling them that researchers
would be studying their voting turnout based on public records.
3. The third treatment arm was mailed a letter stating that their voting turnout 
would be revealed to all other members of their household.
4. The fourth treatment arm was mailed a letter stating that their voting turnout
would be revealed to their household *and* to their neighbors.

## Analyze Experiment

### Necessary packages

__Note:__ If this errors you probably either don't have `dplyr` or `haven`
installed.


``` r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

``` r
library(haven)
```

### Import data

``` r
gotv <- read_dta("https://causal3900.github.io/assets/data/social_pressure.dta")
```

> Alternatively (if you really want), you could download the data [here](assets/data/social_pressure.dta) and load it directly from your computer. Make sure to save the data into the same directory that your RMarkdown file is in. 
> Then you can you can import the data as:
>
> `gotv <- read_dta("social_pressure.dta")`

Run the following code to get a quick peek at the dataset using the [function `glimpse`](https://dplyr.tidyverse.org/reference/glimpse.html). This returns info such as the number of rows/columns, the column names, and the type of data in each column. Notice that we have information about year of birth `yob` but not explicitly age. Also notice that the treatments are labeled with the numbers 0 through 4.

``` r
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

First, let's construct an age variable describing how old (in number of years)
each person was in the year 2006. The `yob` variable says which year each person
was born in. For this, we use the `mutate` function, which you can read about [here](https://dplyr.tidyverse.org/reference/mutate.html). 

> Given a person's year of birth, how do you calculate their age in the year 2006? Note that you can do arithmetic operations with information from the dataset. For example, if you have two columns `col_1` and `col_2` and you wanted to create a third column called `col_3` that was the sum of these two columns, you could write:
>
> `mutate(col_3 = col_1 + col_2)`

We have the code started for you below. Fill in the appropriate expression after `age = ` to add a column to `gotv` labeled `age` that contains how old each person was in 2006.











