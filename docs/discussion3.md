---
output: html_document
---

# Discussion 3. Analyzing an Experiment in R {-}



## Get out and Vote Experiment

In this lab, we explore an experiment that digs into the mechanisms
underlying __why people vote__. This exercise is based on the article [Social Pressure and Voter Turnout: Evidence from a Large-scale Field Experiment](https://www.cambridge.org/core/journals/american-political-science-review/article/social-pressure-and-voter-turnout-evidence-from-a-largescale-field-experiment/11E84AF4C0B7FBD1D20C855972C2C3EB#) by Gerber, Green, and Larimer (2008). A long-standing theory as to why many people
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
Download this RMarkdown file [here]().

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

> Alternatively (if you really want), you could download the data [here](assets/data/social_pressure.dta) and load it directly from your computer. Make sure to save the data into the same directory that your RMarkdown file is in. 
> Then you can you can import the data as:
>
> `gotv <- read_dta("social_pressure.dta")`

Run the following code to get a quick peek at the dataset using the [function `glimpse`](https://dplyr.tidyverse.org/reference/glimpse.html). This returns info such as the number of rows/columns, the column names, and the type of data in each column. Notice that we have information about year of birth `yob` but not explicitly age. Also notice that the treatments are labeled with the numbers 0 through 4.

```r
glimpse(gotv)
```

### Clean data

First, let's construct an age variable describing how old (in number of years)
each person was in the year 2006. The `yob` variable says which year each person
was born in. For this, we use the `mutate` function, which you can read about [here](https://dplyr.tidyverse.org/reference/mutate.html). 

> Given a person's year of birth, how do you calculate their age in the year 2006? Note that you can do arithmetic operations with information from the dataset. For example, if you have two columns `col_1` and `col_2` and you wanted to create a third column called `col_3` that was the sum of these two columns, you could write:
>
> `mutate(col_3 = col_1 + col_2)`

We have the code started for you below. Fill in the appropriate expression after `age = ` to add a column to `gotv` labeled `age` that contains how old each person was in 2006.


```r
gotv <- gotv |>
  mutate(age = ) |>
```

Now, convert the `treatment` variable from it's numeric representation to the
corresponding labels which are

- 0: "Control" 
- 1: "Hawthorne" (this is the 'researchers viewing records via public data' treatment arm)
- 2: "Civic Duty" (this is the 'voting is your civic duty' treatment arm)
- 3: "Neighbors" (this is the 'voting turnout revealed to neighbors' treatment arm)
- 4: "Self" (this is the 'voting turnout revealed to household' treatment arm)

For this, you will want to use the function `case_when` which is described [here](https://www.sharpsightlabs.com/blog/case-when-r/) and [here](https://www.rdocumentation.org/packages/dplyr/versions/1.0.10/topics/case_when). We have started the code for you below.

```r
gotv <- gotv |>
  mutate(treatment = case_when()) |> 
```

### Balance table

Next, we're going to confirm that our control and treatment groups look pretty
much the same across a set of covariates. Specifically this means we're going to
calculate the mean value of a set of covariates across each of the treatment/control
arms, and we expect them to be pretty much equal if our randomization worked.

__Hint__: The [`group_by`](https://dplyr.tidyverse.org/reference/group_by.html)
and [`summarize`](https://dplyr.tidyverse.org/reference/summarise.html) functions
from dplyr are your friend here!


```r
covariates <- c("sex", "age", "g2000", "g2002", "p2000", "p2002", "p2004", "hh_size")

gotv_results <- gotv |>
  group_by(...) |>
  summarise(...)
```

### Results

Finally, let's replicate the final results. Simply, for each treatment/control
subgroup, we calculate the percentage of individuals who got out and voted!


```r
gotv |>
  ...
```

