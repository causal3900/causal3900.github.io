---
output: html_document
---
<style>li {line-height: 1.8;}</style>

# Discussion 3. Treatment effect heterogeneity in an Experiment {-}
## STSCI/INFO/ILRST 3900: Causal Inference {-}
#### September 9, 2026 {-}

You can download the [**slides.**](assets/discussions/discussion3-causalQ.pdf) for this week's discussion.

### Get out and Vote Experiment {-}
- Why do people vote?
- One long-standing theory: People vote due to social norms (civic duty)
- Empirical evidence for this theory was extremely thin
- __Research Question:__ to what extent do social norms cause voter turnout?
- Article: ["Social Pressure and Voter Turnout: Evidence from a Large-scale Field Experiment."](https://www.cambridge.org/core/journals/american-political-science-review/article/social-pressure-and-voter-turnout-evidence-from-a-largescale-field-experiment/11E84AF4C0B7FBD1D20C855972C2C3EB#)in American Political Science Review
- Authors: Alan S. Gerber, Donald P. Green, and Christopher W. Larimer


### Experimental Design {-}
- Approximately 80k Michigan households were randomly assigned 1 of 4 mailings encouraging them to vote
  1. Simply reminded them that voting is a civic duty
  2. Told that researchers would be studying their turnout based on public records
  3. Received record of voting turnout *within* their household
  4. Received record of voting turnout within their household *and* their neighbors’ households.
- Third and fourth treatment arms were told that their turnout would be revealed as well


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
  mutate(age = 2006 - yob)

gotv <- gotv |>
  mutate(treatment = case_when(
    treatment == 0 ~ "Control",
    treatment == 1 ~ "Hawthorne",
    treatment == 2 ~ "Civic Duty",
    treatment == 3 ~ "Neighbors",
    treatment == 4 ~ "Self")) 
```


### Average Causal Effect {-}

Finally, for each treatment group, we calculate the percentage of individuals who got out and voted, as well as the total number of individuals in that group! The solutions below use the function [`n`](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/n) which counts the number of observations in the current group for you.


``` r
gotv_results <- gotv |>
  group_by(treatment) |>
  summarise(Per_Voting = mean(voted), num_of_individuals = n())

gotv_results |>
  kbl() |>
  kable_styling(font_size = 12,full_width = FALSE)
```

<table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> treatment </th>
   <th style="text-align:right;"> Per_Voting </th>
   <th style="text-align:right;"> num_of_individuals </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.3145377 </td>
   <td style="text-align:right;"> 38218 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.2966383 </td>
   <td style="text-align:right;"> 191243 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.3223746 </td>
   <td style="text-align:right;"> 38204 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3779482 </td>
   <td style="text-align:right;"> 38201 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3451515 </td>
   <td style="text-align:right;"> 38218 </td>
  </tr>
</tbody>
</table>


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

gotv_results_age|>
  kbl() |>
  kable_styling(font_size = 12, full_width = FALSE) |>
  scroll_box(width = "100%", height = "500px",fixed_thead = T)
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; "><table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> ageGroup </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> treatment </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Per_Voting </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Count </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Per_in_AgeGroup </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.1661575 </td>
   <td style="text-align:right;"> 4255 </td>
   <td style="text-align:right;"> 0.1113350 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 20650 </td>
   <td style="text-align:right;"> 0.1079778 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.1583068 </td>
   <td style="text-align:right;"> 4087 </td>
   <td style="text-align:right;"> 0.1069783 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.1933636 </td>
   <td style="text-align:right;"> 4189 </td>
   <td style="text-align:right;"> 0.1096568 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.1751631 </td>
   <td style="text-align:right;"> 4139 </td>
   <td style="text-align:right;"> 0.1082998 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.2933172 </td>
   <td style="text-align:right;"> 9921 </td>
   <td style="text-align:right;"> 0.2595897 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 49917 </td>
   <td style="text-align:right;"> 0.2610135 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.2965843 </td>
   <td style="text-align:right;"> 10159 </td>
   <td style="text-align:right;"> 0.2659146 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3561739 </td>
   <td style="text-align:right;"> 10026 </td>
   <td style="text-align:right;"> 0.2624539 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3168376 </td>
   <td style="text-align:right;"> 10043 </td>
   <td style="text-align:right;"> 0.2627819 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.3197190 </td>
   <td style="text-align:right;"> 16086 </td>
   <td style="text-align:right;"> 0.4209011 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 80330 </td>
   <td style="text-align:right;"> 0.4200415 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.3383147 </td>
   <td style="text-align:right;"> 15926 </td>
   <td style="text-align:right;"> 0.4168673 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3906578 </td>
   <td style="text-align:right;"> 15735 </td>
   <td style="text-align:right;"> 0.4119002 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3569639 </td>
   <td style="text-align:right;"> 15968 </td>
   <td style="text-align:right;"> 0.4178136 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.4098793 </td>
   <td style="text-align:right;"> 7956 </td>
   <td style="text-align:right;"> 0.2081742 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 40346 </td>
   <td style="text-align:right;"> 0.2109672 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.4068725 </td>
   <td style="text-align:right;"> 8032 </td>
   <td style="text-align:right;"> 0.2102398 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.4738820 </td>
   <td style="text-align:right;"> 8251 </td>
   <td style="text-align:right;"> 0.2159891 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.4442241 </td>
   <td style="text-align:right;"> 8068 </td>
   <td style="text-align:right;"> 0.2111047 </td>
  </tr>
</tbody>
</table></div>


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

gotv_results_hh |>
  kbl() |>
  kable_styling(font_size = 12, full_width = FALSE) |>
  scroll_box(width = "100%", height = "500px",fixed_thead = T)
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; "><table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> hhGroup </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> treatment </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Per_Voting </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Count </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Per_in_hhGroup </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (0,1] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.3538348 </td>
   <td style="text-align:right;"> 5398 </td>
   <td style="text-align:right;"> 0.1412423 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (0,1] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3306144 </td>
   <td style="text-align:right;"> 26481 </td>
   <td style="text-align:right;"> 0.1384678 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (0,1] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.3698163 </td>
   <td style="text-align:right;"> 5281 </td>
   <td style="text-align:right;"> 0.1382316 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (0,1] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.4226324 </td>
   <td style="text-align:right;"> 5364 </td>
   <td style="text-align:right;"> 0.1404152 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (0,1] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3998117 </td>
   <td style="text-align:right;"> 5310 </td>
   <td style="text-align:right;"> 0.1389398 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (1,2] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.3267335 </td>
   <td style="text-align:right;"> 23536 </td>
   <td style="text-align:right;"> 0.6158355 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (1,2] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3029272 </td>
   <td style="text-align:right;"> 119022 </td>
   <td style="text-align:right;"> 0.6223600 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (1,2] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.3257771 </td>
   <td style="text-align:right;"> 23998 </td>
   <td style="text-align:right;"> 0.6281541 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (1,2] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3907659 </td>
   <td style="text-align:right;"> 23738 </td>
   <td style="text-align:right;"> 0.6213973 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (1,2] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3516728 </td>
   <td style="text-align:right;"> 23792 </td>
   <td style="text-align:right;"> 0.6225339 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (2,10] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.2607712 </td>
   <td style="text-align:right;"> 9284 </td>
   <td style="text-align:right;"> 0.2429222 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (2,10] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.2606034 </td>
   <td style="text-align:right;"> 45740 </td>
   <td style="text-align:right;"> 0.2391722 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (2,10] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.2851541 </td>
   <td style="text-align:right;"> 8925 </td>
   <td style="text-align:right;"> 0.2336143 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (2,10] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3181668 </td>
   <td style="text-align:right;"> 9099 </td>
   <td style="text-align:right;"> 0.2381875 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (2,10] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.2962922 </td>
   <td style="text-align:right;"> 9116 </td>
   <td style="text-align:right;"> 0.2385263 </td>
  </tr>
</tbody>
</table></div>


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
  group_by(ageGroup) |>
  mutate(
    Control_Voting = Per_Voting[treatment == "Control"],
    Difference_from_Control = Per_Voting - Control_Voting
  ) |>
  ungroup()


gotv_results_age |>
  arrange(treatment,ageGroup) |>
  kbl() |>
  kable_styling(font_size = 12, full_width = FALSE) |>
  scroll_box(width = "100%", height = "500px",fixed_thead = T)
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; "><table class="table" style="font-size: 12px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> ageGroup </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> treatment </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Per_Voting </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> Count </th>
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
   <td style="text-align:right;"> 4255 </td>
   <td style="text-align:right;"> 0.1113350 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0098863 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.2933172 </td>
   <td style="text-align:right;"> 9921 </td>
   <td style="text-align:right;"> 0.2595897 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0253925 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.3197190 </td>
   <td style="text-align:right;"> 16086 </td>
   <td style="text-align:right;"> 0.4209011 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0101460 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Civic Duty </td>
   <td style="text-align:right;"> 0.4098793 </td>
   <td style="text-align:right;"> 7956 </td>
   <td style="text-align:right;"> 0.2081742 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0316262 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 20650 </td>
   <td style="text-align:right;"> 0.1079778 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 49917 </td>
   <td style="text-align:right;"> 0.2610135 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 80330 </td>
   <td style="text-align:right;"> 0.4200415 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 40346 </td>
   <td style="text-align:right;"> 0.2109672 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.1583068 </td>
   <td style="text-align:right;"> 4087 </td>
   <td style="text-align:right;"> 0.1069783 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0020356 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.2965843 </td>
   <td style="text-align:right;"> 10159 </td>
   <td style="text-align:right;"> 0.2659146 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0286596 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.3383147 </td>
   <td style="text-align:right;"> 15926 </td>
   <td style="text-align:right;"> 0.4168673 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0287417 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Hawthorne </td>
   <td style="text-align:right;"> 0.4068725 </td>
   <td style="text-align:right;"> 8032 </td>
   <td style="text-align:right;"> 0.2102398 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0286194 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.1933636 </td>
   <td style="text-align:right;"> 4189 </td>
   <td style="text-align:right;"> 0.1096568 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0370924 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3561739 </td>
   <td style="text-align:right;"> 10026 </td>
   <td style="text-align:right;"> 0.2624539 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0882492 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.3906578 </td>
   <td style="text-align:right;"> 15735 </td>
   <td style="text-align:right;"> 0.4119002 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0810848 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Neighbors </td>
   <td style="text-align:right;"> 0.4738820 </td>
   <td style="text-align:right;"> 8251 </td>
   <td style="text-align:right;"> 0.2159891 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0956288 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.1751631 </td>
   <td style="text-align:right;"> 4139 </td>
   <td style="text-align:right;"> 0.1082998 </td>
   <td style="text-align:right;"> 0.1562712 </td>
   <td style="text-align:right;"> 0.0188919 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3168376 </td>
   <td style="text-align:right;"> 10043 </td>
   <td style="text-align:right;"> 0.2627819 </td>
   <td style="text-align:right;"> 0.2679248 </td>
   <td style="text-align:right;"> 0.0489128 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.3569639 </td>
   <td style="text-align:right;"> 15968 </td>
   <td style="text-align:right;"> 0.4178136 </td>
   <td style="text-align:right;"> 0.3095730 </td>
   <td style="text-align:right;"> 0.0473909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:left;"> Self </td>
   <td style="text-align:right;"> 0.4442241 </td>
   <td style="text-align:right;"> 8068 </td>
   <td style="text-align:right;"> 0.2111047 </td>
   <td style="text-align:right;"> 0.3782531 </td>
   <td style="text-align:right;"> 0.0659710 </td>
  </tr>
</tbody>
</table></div>



### Answers: {-}
- Does there seem to be heterogeneity in treatment effects across age and/or house hold size?

> We say there is treatment effect heterogeneity if the treatment effect varies across sub-population. To check if there's treatment effect heterogeneity across age groups, we look at $E[Y^{a=j}|L=l]-E[Y^{a=0}|L=l]$ for each age group $l$, and treatment $j$.
> For example, the "Civic Duty" treatment effect for individuals ages 18-30 is
\begin{align*}
E\big[Y^{a=\text{Civic Duty}}|L=(18-30]\big]-&E\big[Y^{a=\text{Control}}|L=(18-30]\big]]\\ &= 0.166-0.156\\&=0.01
\end{align*}

> These values can be found in the following table, `gotv_results_ageGroup`

``` r
gotv_results_ageGroup <- gotv |>
  group_by(ageGroup, treatment) |>
  summarise(
    Per_Voting = mean(voted),
    Count = n())
```

> A nice way to present this table would be using the variable `Difference_from_Control`, created above. This table makes it easier to look at the causal effect across age groups and examining whether the effect is fixed or not
<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> ageGroup </th>
   <th style="text-align:right;"> Civic Duty </th>
   <th style="text-align:right;"> Control </th>
   <th style="text-align:right;"> Hawthorne </th>
   <th style="text-align:right;"> Neighbors </th>
   <th style="text-align:right;"> Self </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> (18,30] </td>
   <td style="text-align:right;"> 0.0098863 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.0020356 </td>
   <td style="text-align:right;"> 0.0370924 </td>
   <td style="text-align:right;"> 0.0188919 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> (30,45] </td>
   <td style="text-align:right;"> 0.0253925 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.0286596 </td>
   <td style="text-align:right;"> 0.0882492 </td>
   <td style="text-align:right;"> 0.0489128 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> (45,60] </td>
   <td style="text-align:right;"> 0.0101460 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.0287417 </td>
   <td style="text-align:right;"> 0.0810848 </td>
   <td style="text-align:right;"> 0.0473909 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> (60,120] </td>
   <td style="text-align:right;"> 0.0316262 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.0286194 </td>
   <td style="text-align:right;"> 0.0956288 </td>
   <td style="text-align:right;"> 0.0659710 </td>
  </tr>
</tbody>
</table>


- What would you expect the treatment effect for civic duty if we considered a population that was evenly split across the 4 age groups?

> First, let's consider the average treatment effect for Civic Duty, which is given by:
$$E[Y|a=\text{Civic Duty}]-E[Y|a=\text{Control}]$$
> Standardization allows us to estimate the ACE by combining
estimates from each sub-population
$$\sum_l P(L=l)E[Y|a=\text{Civic Duty},L=l]-\sum_l P(L=l)E[Y|a=\text{Control},L=l]$$
$$\sum_l P(L=l) \Big(E[Y|a=\text{Civic Duty},L=l]-E[Y|a=\text{Control},L=l]\Big)$$
For the age group the ACE looks like:
\begin{align*} ACE =& 0.111 \times (0.166-0.156)  \\  &+0.260 \times (0.293-0.268)\\&+0.421\times (0.320-0.310)\\&+ 0.208\times (0.410-0.378)
\end{align*}

> 
> ``` r
> gotv_results_age |>
>    filter(treatment=="Civic Duty") |>
>    summarise(ACE = sum(Per_in_AgeGroup*Difference_from_Control))
> ```
> 
> ```
> ## # A tibble: 1 × 1
> ##      ACE
> ##    <dbl>
> ## 1 0.0185
> ```
To estimate the treatment effect for civic duty if the population was evenly split across the 4 age group, we replace the share of each age group with $0.25$.
> 
> ``` r
> gotv_results_age |>
>    filter(treatment=="Civic Duty") |>
>    summarise(ACE_even = sum(.25*Difference_from_Control))
> ```
> 
> ```
> ## # A tibble: 1 × 1
> ##   ACE_even
> ##      <dbl>
> ## 1   0.0193
> ```

