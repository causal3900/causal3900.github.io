library(haven)
library(dplyr)
gotv <- read_dta("https://causal3900.github.io/assets/data/social_pressure.dta")
gotv <- gotv |>
  mutate(treatment = case_when(
    treatment == 0 ~ "Control",
    treatment == 1 ~ "Hawthorne",
    treatment == 2 ~ "Civic Duty",
    treatment == 3 ~ "Neighbors",
    treatment == 4 ~ "Self")) 


gotv <- gotv |>
  mutate(age = 2006 - yob)

## Assign into age groups
gotv <- gotv |>
  mutate(ageGroup = cut(age, breaks = c(18, 30, 45, 60, 120)))

## Assign into household size groups
gotv <- gotv |>
  mutate(hhGroup = cut(hh_size, breaks = c(0,1, 2, 10)))




### ACE results from last week
gotv_results <- gotv |>
  group_by(treatment) |>
  summarise(Percentage_Voting = mean(voted), num_of_individuals = n())

print(gotv_results)

## Neighbors seems to be most effective


## Examine voting by age group

gotv_results_age <- gotv |>
  group_by(ageGroup, treatment) |>
  summarise(
    Percentage_Voting = mean(voted),
    Count = n(),
    .groups = "drop"
  ) |>
  group_by(treatment) |>
  mutate( Percentage_in_AgeGroup = Count / sum(Count))

print(gotv_results_age, n = Inf)




## Examine voting by hh size group

gotv_results_hh <- gotv |>
  group_by(hhGroup, treatment) |>
  summarise(
    Percentage_Voting = mean(voted),
    Count = n(),
    .groups = "drop"
  ) |>
  group_by(treatment) |>
  mutate( Percentage_in_hhGroup = Count / sum(Count) ) 

print(gotv_results_hh, n = Inf)

## Questions:
# Does there seem to be heterogeneity in treatment effects across age and/or house hold size? (note look not only at)
# Could you improve voting rates by assigning different treatments to different individuals?
# What would you expect the treatment effect for civic duty if we considered a population that was 
#   evenly split across the 4 age groups?


# May be useful to slightly rearrange table
gotv_results_age <- gotv |>
  group_by(ageGroup, treatment) |>
  summarise(
    Percentage_Voting = mean(voted),
    Count = n(),
    .groups = "drop"
  ) |>
  group_by(treatment) |>
  mutate(
    Percentage_in_AgeGroup = Count / sum(Count)
  ) |>
  select(-Count) |>
  group_by(ageGroup) |>
  mutate(
    Control_Voting = Percentage_Voting[treatment == "Control"],
    Difference_from_Control = Percentage_Voting - Control_Voting
  ) |>
  ungroup()

print(gotv_results_age, n = Inf)
  

