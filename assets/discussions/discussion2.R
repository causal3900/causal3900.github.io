# Quantile
qnorm(0.025)


# Linear Regression
x <- rnorm(n = 50, mean = 2, sd = sqrt(5))
a <- -3
b <- 2
y <- a + b*x + rnorm(n = 50, mean = 0, sd = 2)
lm(y~x)

# plot
plot(x,y)
abline(lm(y~x), lwd=2.5)




