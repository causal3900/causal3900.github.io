---
  output: html_document
---
  <style>li {line-height: 1.8;}</style>
  
  # Discussion 11. Difference in Differences {-}
  ## STSCI/INFO/ILRST 3900: Causal Inference {-}
  #### November 5, 2025 {-}
  
  You can download the [**slides**](assets/discussions/discussion11-DID.pdf) for this week's discussion and the [**.Rmd**](assets/discussions/DID-discussion.Rmd).


## Empirical Application: How the Abolition of Elected Councils Affects Local Public Services in Vietnam {-}

Here's a [link](https://www.cambridge.org/core/journals/american-political-science-review/article/impact-of-recentralization-on-public-services-a-differenceindifferences-analysis-of-the-abolition-of-elected-councils-in-vietnam/3477854BAAFE152DC93C594169D64F58) to the paper from the original experiment and a [link](https://www.cambridge.org/core/journals/political-analysis/article/using-multiple-pretreatment-periods-to-improve-differenceindifferences-and-staggered-adoption-designs/747F618FD4AD82A536823521D89310F7) to the paper that re-analyzed this experiment, which we're basing this lab on. 

### Download the data {-}
All you need to do in this section is run the code block.

```{r, message = FALSE, warning = FALSE}
# Recall that lines starting with hashtags are called comments

# The next few lines a code create a function called install that installs and loads a package/library
install <- function(package) {
  if (!require(package, quietly = TRUE, character.only = TRUE)) {
    install.packages(package, repos = "http://cran.us.r-project.org", type = "binary")
    library(package, character.only = TRUE)
  }
}

# We are using the function created above to install and load some libraries
install("cowplot")
install("dplyr")
install("tidyverse")

# Read in the raw data file
malesky2014 <- read_csv("https://github.com/causal3900/causal3900.github.io/raw/main/assets/data/malesky2014.csv")

# some data cleaning (drop rows with missing values in particular columns)
malesky2014 <- drop_na(malesky2014, lnarea, lnpopden, city) 
```


### About the data {-}
All you need to do in this section is read the text and run the code block.

Variables in the data set:

- `treatment`: binary variable indicating if the record is from the treatment group ($1$) or the control group ($0$)
- `pro4`: educational and cultural program number 4 outcome variable (binary: $1$ if they participated in the program, $0$ if not)
- `tapwater`: tap water outcome variable (binary: $1$ if they drink tap water, $0$ if not)
- `agrext`: agricultural center outcome variable (binary: $1$ if they use the center, $0$ if not)
- `year`: the year the record is from
- `post_treat`: binary variable indicating if the record is from the pre-treatment period ($0$) or the post-treatment period ($0$)

```{r}
# show the first few lines of the dataset
head(malesky2014)
```


### Visualizing Trends in the Treatment and Control Groups {-}

In a DID design, the first step is to visualize the trends of the treatment and control groups to check if the parallel trends assumption is credible. Here, we look at one possible outcome: "Education and Cultural Program."

All you need to do in this section is run the code block and look at the plot. What is going on in the plot?

```{r}
# Plot the outcome for `Education and Cultural Program`
ed_and_culture <- malesky2014 %>%
  mutate(treatment = ifelse(treatment == 1, "Treated in 2009","Untreated")) %>%
  group_by(treatment, year) %>%
  summarize(estimate = mean(pro4)) %>%
  ggplot(aes(x = year, y = estimate, color = treatment)) + 
  geom_point() + 
  geom_line() + 
  ggtitle("Ed. and Cultural Program") +
  theme_minimal() +
  theme(legend.position = "none",
        legend.background = element_rect(fill = "white", colour = "white"),
        plot.title = element_text(hjust = 0.5))

ed_and_culture + 
    guides(color = guide_legend(nrow = 1)) +
    theme(legend.position = "bottom")
```

### Basic Difference in Differences Analysis with One Pretreatment Period  {-}
All you need to do in this section is read the text and fill in the TASK pieces within the code.

In the data our treatment indicator variable is called `treatment`, and our
post-treatment time period indicator is called `post_treat`. You will need to
create the interaction variable that is `treatment`*`post_treat`. Call this
new variable `did`. 

```{r, eval = F}
# remove the extra pretreatment periods from the dataset
onePerMalesky <- malesky2014 %>%
  filter(year==2008 | year ==2010) # keep only 2008 and 2010

# TASK: create the interaction term between treatment and post_treat
onePerMalesky <- onePerMalesky %>%
  mutate(did = ...create your interaction variable here...)
```

Now that you have your `treatment`, `post_treat`, and `did` variables, you are
ready to estimate the causal effect of de-centralizing government on whether or
not people participate in an Educational and Cultural Program. Your outcome
variable in this case is `pro4`. We will estimate the causal effect with an 
OLS regression. Use the formula that we discussed in the slides to create 
your model formula.

```{r, eval = F}
# TASK: regression for Education and Cultural Program on treatment, time period, and interaction term
didReg <- lm(...put your formula here..., data = onePerMalesky)

# TASK
summary(...put your DiD model object here...) # hint: what did you create above?

# estimate
print(didReg$coefficients["did"])

```
