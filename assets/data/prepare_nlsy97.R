

has_tidyverse <- require("tidyverse")
if (!has_tidyverse) {
  stop("To run this code, you need tidyverse. Type install.packages('tidyverse')")
}
has_Amelia <- require("Amelia")
if (!has_Amelia) {
  stop("To run this code, you need Amelia. Type install.packages('Amelia')")
}

library(tidyverse)
library(Amelia)

set.seed(14850)

# Run code from NLSY
source("nlsy97.R")

# Rename identifier for ease of use
new_data <- new_data %>%
  rename(pubid = PUBID_1997)

# Birth month in continuous months
birth_month <- new_data %>%
  mutate(birth_month = 12*(KEY_BDATE_Y_1997 - 1980) + KEY_BDATE_M_1997) %>%
  select(pubid,birth_month)

# Age at each interview
age <- new_data %>%
  select(pubid, starts_with("CV_INTERVIEW_CMONTH")) %>%
  pivot_longer(cols = starts_with("CV")) %>%
  left_join(birth_month, by = "pubid") %>%
  mutate(wave = as.numeric(gsub("CV_INTERVIEW_CMONTH_","",name)),
         age = case_when(value > 0 ~ (value - birth_month) / 12)) %>%
  select(pubid, wave, age)

# Age at most recent interview
age_recent_interview <- age %>%
  group_by(pubid) %>%
  summarize(age_recent_interview = max(age, na.rm = T))

# Treatment: College degree by age 25
treated <- new_data %>%
  select(pubid, CVC_BA_DEGREE_XRND) %>%
  left_join(birth_month, by = "pubid") %>%
  # treated will indicate receiving a BA degree by age 25
  mutate(treated = case_when(CVC_BA_DEGREE_XRND == -4 ~ F,
                             CVC_BA_DEGREE_XRND >= 0 & CVC_BA_DEGREE_XRND <= (birth_month + 12*25) ~ T,
                             CVC_BA_DEGREE_XRND > (birth_month + 12*25) ~ F)) %>%
  mutate(a = case_when(treated ~ "college",
                       !treated ~ "no_college")) %>%
  select(pubid, a)

# Outcome: Spouse or partner at most recent interview holds college degree

# First, determine each household member's relationship to the youth
hh_relationship_to_youth <- new_data %>%
  select(pubid, starts_with("HHI_RELY")) %>%
  pivot_longer(cols = -pubid,
               values_to = "relationship_to_youth") %>%
  mutate(name = gsub("HHI_RELY.","",name)) %>%
  separate(name, into = c("member","wave")) %>%
  mutate(wave = as.numeric(wave))

# Next, determine the education of each household member
hh_education <- new_data %>%
  select(pubid, starts_with("HHI_HIGHGRADE")) %>%
  pivot_longer(cols = -pubid,
               values_to = "highestGrade") %>%
  mutate(name = gsub("HHI_HIGHGRADE.","",name)) %>%
  separate(name, into = c("member","wave")) %>%
  mutate(wave = as.numeric(wave))

# Determine the wave when partner's education will be measured
wave_for_partner <- age %>%
  # Take the observations closest to age 35,
  # among observations 30 and older
  group_by(pubid) %>%
  filter(!is.na(age) & age >= 30) %>%
  mutate(age_from_35 = abs(age - 35)) %>%
  arrange(pubid, age_from_35) %>%
  slice_head(n = 1) %>%
  select(-age_from_35) %>%
  ungroup()

# Determine whether has a partner in that wave
has_partner <- wave_for_partner  %>%
  left_join(hh_relationship_to_youth,
            by = c("pubid","wave")) %>%
  group_by(pubid) %>%
  summarize(has_partner = any(relationship_to_youth %in% c(1,2,69)))

# Determine partner college degree in that wave
partner_college_if_has <- wave_for_partner %>%
  left_join(hh_relationship_to_youth,
            by = c("pubid","wave")) %>%
  filter(relationship_to_youth %in% c(1,2,69)) %>%
  group_by(pubid) %>%
  arrange(pubid, -wave) %>%
  slice_head(n = 1) %>%
  left_join(hh_education, by = c("pubid","wave","member")) %>%
  mutate(partner_college = case_when(highestGrade %in% 16:20 ~ T,
                                     highestGrade %in% c(0:15,93:94) ~ F)) %>%
  select(pubid, partner_college)

# Define outcome as
# 1 if has partner with college degree,
# 0 if no partner or no college degree
y <- has_partner %>%
  left_join(partner_college_if_has, by = "pubid") %>%
  mutate(y = case_when(!has_partner ~ F,
                       has_partner & !partner_college ~ F,
                       has_partner & partner_college ~ T)) %>%
  select(pubid, y)

# Confounders
confounders <- new_data %>%
  mutate(sex = case_when(KEY_SEX_1997 == 1 ~ "Male",
                         KEY_SEX_1997 == 2 ~ "Female"),
         race = case_when(KEY_RACE_ETHNICITY_1997 == 1 ~ "Non-Hispanic Black",
                          KEY_RACE_ETHNICITY_1997 == 2 ~ "Hispanic",
                          KEY_RACE_ETHNICITY_1997 %in% 3:4 ~ "Non-Hispanic Non-Black"),
         race = as_factor(race),
         test_percentile = case_when(ASVAB_MATH_VERBAL_SCORE_PCT_1999 >= 0 ~ ASVAB_MATH_VERBAL_SCORE_PCT_1999 / 1e3),
         mom_educ = case_when(CV_HGC_RES_MOM_1997 == -4 ~ "No mom",
                              (CV_HGC_RES_MOM_1997 >= 0 & CV_HGC_RES_MOM_1997 < 12) | CV_HGC_RES_MOM_1997 == 95 ~ "< HS",
                              CV_HGC_RES_MOM_1997 == 12 ~ "High school",
                              CV_HGC_RES_MOM_1997 < 16 ~ "Some college",
                              CV_HGC_RES_MOM_1997 >= 16 ~ "College"),
         dad_educ = case_when(CV_HGC_RES_DAD_1997 == -4 ~ "No dad",
                              (CV_HGC_RES_DAD_1997 >= 0 & CV_HGC_RES_DAD_1997 < 12) | CV_HGC_RES_DAD_1997 == 95 ~ "< HS",
                              CV_HGC_RES_DAD_1997 == 12 ~ "High school",
                              CV_HGC_RES_DAD_1997 < 16 ~ "Some college",
                              CV_HGC_RES_DAD_1997 >= 16 ~ "College"),
         parent_income = case_when(CV_INCOME_GROSS_YR_1997 == -4 ~ 0,
                                   CV_INCOME_GROSS_YR_1997 == -3 ~ NA,
                                   T ~ CV_INCOME_GROSS_YR_1997),
         # Bottom-code parent income
         parent_income = case_when(parent_income >= 1e3 ~ parent_income,
                                   parent_income < 1e3 ~ 1e3),
         # Wealth. From documentation:
         # Respondents with household net worth values above $600,000 were topcoded to a value of $600,000.
         # note: not totally clear why some people are -4 (coded as missing here)
         # might have not done parent interview, might be independent children, might have no wealth
         parent_wealth = case_when(!(CV_HH_NET_WORTH_P_1997 %in% -1:-5) ~ as.numeric(CV_HH_NET_WORTH_P_1997)),
         # Bottom-code parent wealth
         parent_wealth = case_when(parent_wealth >= 1e3 ~ parent_wealth,
                                   parent_wealth < 1e3 ~ 1e3)) %>%
  mutate(log_parent_income = log(parent_income),
         log_parent_wealth = log(parent_wealth)) %>%
  select(pubid, sex, race, mom_educ, dad_educ, log_parent_income, log_parent_wealth, test_percentile)

# Merge together to make claims
d_unfilled <- age_recent_interview %>%
  left_join(treated, by = "pubid") %>%
  left_join(y, by = "pubid") %>%
  left_join(confounders, by = "pubid") %>%
  filter(age_recent_interview >= 30) %>%
  filter(!is.na(a)) %>%
  filter(!is.na(y)) %>%
  select(a, y, sex, race, mom_educ, dad_educ, log_parent_income, log_parent_wealth, test_percentile)

# Impute missing values. Using single imputation to make analysis
# more straightforward for students.
amelia.out <- amelia(d_unfilled,
                     m = 1,
                     boot.type = "none",
                     noms = c("race","sex","mom_educ","dad_educ","a"))

# Create the imputed dataset
d <- amelia.out$imputations$imp1 %>%
  # Enforce test percentile between 0 and 100
  mutate(test_percentile = case_when(test_percentile < 0 ~ 0,
                                     test_percentile <= 100 ~ test_percentile,
                                     test_percentile > 100 ~ 100)) %>%
  # Put factor variables in logical order
  mutate(race = fct_relevel(race,"Hispanic","Non-Hispanic Black","Non-Hispanic Non-Black"),
         mom_educ = fct_relevel(mom_educ,"No mom","< HS","High school","Some college","College"),
         dad_educ = fct_relevel(dad_educ,"No dad","< HS","High school","Some college","College"))
# Enforce lowest and highest values of dollar variables from raw data
for (varname in c("log_parent_wealth","log_parent_income")) {
  unfilled_range <- range(d_unfilled[[varname]], na.rm = T)
  d <- d %>%
    mutate(across(.cols = matches(varname),
                  .fns = function(x) {
                    case_when(x >= unfilled_range[1] & x <= unfilled_range[2] ~ x,
                              x < unfilled_range[1] ~ unfilled_range[1],
                              x > unfilled_range[2] ~ unfilled_range[2])
                  }))
}

# Save the data so you don't have to run this code every time
saveRDS(d, file = "d.RDS")

