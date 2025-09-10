---
output: html_document
---
<style>li {line-height: 1.8;}</style>

# Discussion 3. Treatment effect heterogneity in an Experiment {-}
## STSCI/INFO/ILRST 3900: Causal Inference {-}
#### September 10, 2025 {-}


You can download the [**slides.**](assets/discussions/discussion3-addHealth.pdf) for this week's discussion.

## Get out and Vote Experiment {-}

Last week, we explored an experiment that digs into the mechanisms
underlying __why people vote__. This exercise is based on: 

Gerber, Alan S., Donald P. Green, and Christopher W. Larimer. ["Social Pressure and Voter Turnout: Evidence from a Large-scale Field Experiment."](https://www.cambridge.org/core/journals/american-political-science-review/article/social-pressure-and-voter-turnout-evidence-from-a-largescale-field-experiment/11E84AF4C0B7FBD1D20C855972C2C3EB#) American Political Science Review 102.1 (2008): 33-48.

A long-standing theory as to why many people
vote is that it is driven by social norms (e.g. the understanding that voting
is their civic duty). This theory, while being a dominant theoretical 
explanation, had very little empirical backing for a long time. This experiment
examines this very theory by asking the question:
__to what extent do social norms cause voter turnout__?

### Experimental Design {-}

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

## Analyze Experiment {-}

### Necessary packages {-}


``` r
library(dplyr)
library(haven)
library(kableExtra)
```

### Import data {-}

``` r
gotv <- read_dta("https://causal3900.github.io/assets/data/social_pressure.dta")
```

### Clean data {-}

First, we construct an age variable describing how old (in number of years) each person was in the year 2006. The `yob` variable says which year each person was born in. \> For this, we use the `mutate` function. 
Then, we convert the `treatment` variable from it's numeric representation to the corresponding labels which are

-   0: "Control"
-   1: "Hawthorne" (this is the 'researchers viewing records via public data' treatment arm)
-   2: "Civic Duty" (this is the 'voting is your civic duty' treatment arm)
-   3: "Neighbors" (this is the 'voting turnout revealed to neighbors' treatment arm)
-   4: "Self" (this is the 'voting turnout revealed to household' treatment arm)

For this, we use the `case_when` function. 


``` r
gotv <- gotv |>
  mutate(treatment = case_when(
    treatment == 0 ~ "Control",
    treatment == 1 ~ "Hawthorne",
    treatment == 2 ~ "Civic Duty",
    treatment == 3 ~ "Neighbors",
    treatment == 4 ~ "Self")) 


gotv <- gotv |>
  mutate(age = 2006 - yob)
```


### Average Causal Effect {-}

Finally, for each treatment group, we calculate the percentage of individuals who got out and voted, as well as the total number of individuals in that group! The solutions below use the function [`n`](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/n) which counts the number of observations in the current group for you.


``` r
gotv_results <- gotv |>
  group_by(treatment) |>
  summarise(Per_Voting = mean(voted), num_of_individuals = n())

print(gotv_results)
```

```
## # A tibble: 5 × 3
##   treatment  Per_Voting num_of_individuals
##   <chr>           <dbl>              <int>
## 1 Civic Duty      0.315              38218
## 2 Control         0.297             191243
## 3 Hawthorne       0.322              38204
## 4 Neighbors       0.378              38201
## 5 Self            0.345              38218
```


### Conditional Average Causal Effect {-}

Now, we look into the treatment effect across sub-population, so we can determine if there is treatment effect heterogeneity

First, we assign into age groups and household size groups

``` r
gotv <- gotv |>
  mutate(ageGroup = cut(age, breaks = c(18, 30, 45, 60, 120))) |>
  mutate(hhGroup = cut(hh_size, breaks = c(0,1, 2, 10)))
```

#### Examine voting by age group {-}

``` r
gotv_results_age <- gotv |>
  group_by(ageGroup, treatment) |>
  summarise(
    Per_Voting = mean(voted),
    Count = n(),
    .groups = "drop"
  ) |>
  group_by(treatment) |>
  mutate( Per_in_AgeGroup = Count / sum(Count))

print(gotv_results_age, n = Inf)
```

```
## # A tibble: 20 × 5
## # Groups:   treatment [5]
##    ageGroup treatment  Per_Voting Count Per_in_AgeGroup
##    <fct>    <chr>           <dbl> <int>           <dbl>
##  1 (18,30]  Civic Duty      0.166  4255           0.111
##  2 (18,30]  Control         0.156 20650           0.108
##  3 (18,30]  Hawthorne       0.158  4087           0.107
##  4 (18,30]  Neighbors       0.193  4189           0.110
##  5 (18,30]  Self            0.175  4139           0.108
##  6 (30,45]  Civic Duty      0.293  9921           0.260
##  7 (30,45]  Control         0.268 49917           0.261
##  8 (30,45]  Hawthorne       0.297 10159           0.266
##  9 (30,45]  Neighbors       0.356 10026           0.262
## 10 (30,45]  Self            0.317 10043           0.263
## 11 (45,60]  Civic Duty      0.320 16086           0.421
## 12 (45,60]  Control         0.310 80330           0.420
## 13 (45,60]  Hawthorne       0.338 15926           0.417
## 14 (45,60]  Neighbors       0.391 15735           0.412
## 15 (45,60]  Self            0.357 15968           0.418
## 16 (60,120] Civic Duty      0.410  7956           0.208
## 17 (60,120] Control         0.378 40346           0.211
## 18 (60,120] Hawthorne       0.407  8032           0.210
## 19 (60,120] Neighbors       0.474  8251           0.216
## 20 (60,120] Self            0.444  8068           0.211
```


#### Examine voting by hh size group {-}


``` r
gotv_results_hh <- gotv |>
  group_by(hhGroup, treatment) |>
  summarise(
    Per_Voting = mean(voted),
    Count = n(),
    .groups = "drop"
  ) |>
  group_by(treatment) |>
  mutate( Per_in_hhGroup = Count / sum(Count) ) 

print(gotv_results_hh, n = Inf)
```

```
## # A tibble: 15 × 5
## # Groups:   treatment [5]
##    hhGroup treatment  Per_Voting  Count Per_in_hhGroup
##    <fct>   <chr>           <dbl>  <int>          <dbl>
##  1 (0,1]   Civic Duty      0.354   5398          0.141
##  2 (0,1]   Control         0.331  26481          0.138
##  3 (0,1]   Hawthorne       0.370   5281          0.138
##  4 (0,1]   Neighbors       0.423   5364          0.140
##  5 (0,1]   Self            0.400   5310          0.139
##  6 (1,2]   Civic Duty      0.327  23536          0.616
##  7 (1,2]   Control         0.303 119022          0.622
##  8 (1,2]   Hawthorne       0.326  23998          0.628
##  9 (1,2]   Neighbors       0.391  23738          0.621
## 10 (1,2]   Self            0.352  23792          0.623
## 11 (2,10]  Civic Duty      0.261   9284          0.243
## 12 (2,10]  Control         0.261  45740          0.239
## 13 (2,10]  Hawthorne       0.285   8925          0.234
## 14 (2,10]  Neighbors       0.318   9099          0.238
## 15 (2,10]  Self            0.296   9116          0.239
```


### Questions: {-}
- Does there seem to be heterogeneity in treatment effects across age and/or house hold size?
- Could you improve voting rates by assigning different treatments to different individuals?
- What would you expect the treatment effect for civic duty if we considered a population that was evenly split across the 4 age groups?


To answer these questions it might be useful to slightly rearrange table:

``` r
gotv_results_age <- gotv |>
  group_by(ageGroup, treatment) |>
  summarise(
    Per_Voting = mean(voted),
    Count = n(),
    .groups = "drop"
  ) |>
  group_by(treatment) |>
  mutate(
    Per_in_AgeGroup = Count / sum(Count)
  ) |>
  select(-Count) |>
  group_by(ageGroup) |>
  mutate(
    Control_Voting = Per_Voting[treatment == "Control"],
    Difference_from_Control = Per_Voting - Control_Voting
  ) |>
  ungroup()


gotv_results_age %>%
  kbl() %>%
  kable_styling(font_size = 12, full_width = FALSE) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; "><table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> ageGroup </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> treatment </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Per_Voting </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Per_in_AgeGroup </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Control_Voting </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Difference_from_Control </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.1661575 </td>
   <td style="text-align:right;"> 0.1113350 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0098863 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.1079778 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.1583068 </td>
   <td style="text-align:right;"> 0.1069783 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0020356 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.1933636 </td>
   <td style="text-align:right;"> 0.1096568 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0370924 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.1751631 </td>
   <td style="text-align:right;"> 0.1082998 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0188919 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.2933172 </td>
   <td style="text-align:right;"> 0.2595897 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0253925 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.2610135 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.2965843 </td>
   <td style="text-align:right;"> 0.2659146 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0286596 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3561739 </td>
   <td style="text-align:right;"> 0.2624539 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0882492 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3168376 </td>
   <td style="text-align:right;"> 0.2627819 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0489128 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.3197190 </td>
   <td style="text-align:right;"> 0.4209011 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0101460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.4200415 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.3383147 </td>
   <td style="text-align:right;"> 0.4168673 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0287417 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3906578 </td>
   <td style="text-align:right;"> 0.4119002 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0810848 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3569639 </td>
   <td style="text-align:right;"> 0.4178136 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0473909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.4098793 </td>
   <td style="text-align:right;"> 0.2081742 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0316262 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.2109672 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.4068725 </td>
   <td style="text-align:right;"> 0.2102398 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0286194 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.4738820 </td>
   <td style="text-align:right;"> 0.2159891 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0956288 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.4442241 </td>
   <td style="text-align:right;"> 0.2111047 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0659710 </td>
  </tr>
</tbody>
</table></div>

