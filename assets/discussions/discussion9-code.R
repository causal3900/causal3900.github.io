#' We use net financial assets – defined as the sum of IRA balances, 401(k) 
#' balances, checking accounts, US saving bonds, other interest‐earning accounts
#' in banks and other financial institutions, other interest‐earning assets 
#' (such as bonds held personally), stocks, and mutual funds less non‐mortgage 
#' debt – as the outcome variable, Y, in our analysis. Our treatment variable, 
#' D, is an indicator for being eligible to enroll in a 401(k) plan. The vector
#' of raw covariates, X, consists of age, income, family size, years of 
#' education, a married indicator, a two‐earner status indicator, a defined 
#' benefit pension status indicator, an IRA participation indicator, and a 
#' home‐ownership indicator.

if (!require(AER, quietly = TRUE)) {
  install.packages("AER", repos = "http://cran.us.r-project.org", type = "binary")
  library(AER)
}
if (!require(dplyr, quietly = TRUE)) {
  install.packages("dplyr", repos = "http://cran.us.r-project.org", type = "binary")
}
if (!require(hdm, quietly = TRUE)) {
  install.packages("hdm", repos = "http://cran.us.r-project.org", type = "binary")
  library(hdm)
}

data(pension)
# Shuffle data around
pension <- pension[sample(1:nrow(pension), nrow(pension)), ]

# Variables
y <- "net_tfa"
a <- "p401"
z <- "e401"
X <- c("age", "inc", "fsize", "educ", "db", "marr", "twoearn", "pira", "hown")

pension <- select(pension, all_of(c(y, a, z, X)))


# IV with confounders -----------------------------------------------------

p_hat <- predict(glm(p401 ~ e401, data = pension, family = "binomial"), type = "response")

# 2SLS IV regression
reg <- ivreg(formula = net_tfa ~ . - e401 | . - p401, data = pension)
robust_ses <- summary(reg, vcov. = vcovHC)
late <- coef(robust_ses)["p401", c("Estimate", "Std. Error")]
# 95% conf. int.
ci <- c(
  late[["Estimate"]] - qnorm(0.975)*late[["Std. Error"]],
  late[["Estimate"]] + qnorm(0.975)*late[["Std. Error"]]
)

# Print the results and confidence interval
cat("LATE (Lower bound, Upper bound):\n",
    paste0("\r", round(late[["Estimate"]], 3)),
    paste0("(", round(ci[[1]], 3), ","),
    paste0(round(ci[[2]], 3), ")\n"))

# IV without confounders --------------------------------------------------

# 2SLS IV regression
reg <- ivreg(formula = net_tfa ~ p401 | e401, data = pension)
robust_ses <- summary(reg, vcov. = vcovHC)
late <- coef(robust_ses)["p401", c("Estimate", "Std. Error")]
# 95% conf. int.
ci <- c(
  late[["Estimate"]] - qnorm(0.975)*late[["Std. Error"]],
  late[["Estimate"]] + qnorm(0.975)*late[["Std. Error"]]
)

# Print the results and confidence interval
cat("LATE (Lower bound, Upper bound):\n",
    paste0("\r", round(late[["Estimate"]], 3)),
    paste0("(", round(ci[[1]], 3), ","),
    paste0(round(ci[[2]], 3), ")\n"))
