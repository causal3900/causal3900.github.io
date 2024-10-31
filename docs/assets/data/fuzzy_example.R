# This example follows the replication file for
# `A guide to regression discontinuity designs in medical applications' 
# by Cattaneo, Keele, Titiunik
# In
# Statistics in Medicine (2023)
# https://github.com/rdpackages-replication/CKT_2023_SIM/blob/master/CKT_2023_SIM--ART.R
#
# Original article:
# `Treatment eligibility and retention in clinical HIV care: A regression 
# discontinuity study in South Africa'
# by Jacob Bor ,Matthew P. Fox, Sydney Rosen, Atheendar Venkataramani, 
# Frank Tanser, Deenan Pillay, Till Bärnighausen
# In
# Plos Medicine (2017)
#



# load in some libraries
library(foreign)
library(rdrobust)
library(rddensity)
library(ggplot2)
library(xtable)


### Fuzzy Analysis ####

# read in dta file (which can be found and downloaded from https://github.com/rdpackages-replication/CKT_2023_SIM/blob/master/CKT_2023_SIM--ART.dta)
data <- foreign::read.dta("CKT_2023_SIM--ART.dta")
# some data cleaning: only use cases where all relevant data is present
dd <- data[complete.cases(data[,c("visit_test_6_18", "art_6m", "cd4")]),]


# Plot CD4 load (running variable) against retention probability (outcome) 
rdplot(data$visit_test_6_18, data$cd4, c=350, 
       y.lim=c(0,1),
       x.lim=c(0,1000), 
       y.label="Proportion Retained in Treatment", 
       x.label="CD4 Count", 
       title="CD4 count vs Retention")

# Plot CD4 load (running variable) against starting ART within 6 months (treatment)
p2 <- rdplot(data$art_6m, data$cd4,
             c=350, 
             y.lim=c(0,1),
             x.lim=c(0,1000), 
             y.label="Proportion with ART Initiation", 
             x.label="CD4 Count", 
             title="CD4 count vs ART Inititation")


# Run fuzzy analysis first and save bandwidths to report first-stage and reduced form within same bandwidth
# rdrbost can handle a fuzzy analysis on its own
fzy <- rdrobust(dd$visit_test_6_18, dd$cd4, c=350, fuzzy=dd$art_6m)
# Save bandwidth used
h = fzy$bws[1]
summary(fzy)

# First Stage: effect of assignment on ART Initiation (treatment)
itt1 <- rdrobust(dd$art_6m, dd$cd4, c=350, h=h)
summary(itt1) #-0.212

# Reduced form: effect of assignment on program retention (outcome)
itt2 <- rdrobust(dd$visit_test_6_18, dd$cd4, c=350, h=h)
summary(itt2)
#-0.142

# Dividing -0.142/-0.212 gives us something very close to what you get when you run rdrobust with the "fuzzy" argument!

##### Check for heaping: is there possibly manipulation?

# Checks for heaping using rddensity
mtest <- rddensity(X = data$cd4, c=350)
summary(mtest)

rdplotdensity(mtest,X = data$cd4)$Estplot + 
  geom_vline(xintercept=350, linetype="dashed") +
  labs(x="CD4 Count", y="Density")


### Placebo Checks: is the continuity assumption reasonable?

# Clinic A
rdplot(dd$clinic_a, dd$cd4, c = 350)
# Female
rdplot(dd$female, dd$cd4, c = 350)
# 2011 Qtr 3 
rdplot(dd$qtr1, dd$cd4, c = 350)
summary(rdrobust(dd$qtr1, dd$cd4, c=350, fuzzy=dd$art_6m))
# Age 18-25
rdplot(dd$age2, dd$cd4, c = 350)
summary(rdrobust(dd$age2, dd$cd4, c=350, fuzzy=dd$art_6m))

