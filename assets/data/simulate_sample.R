simulate_sample <- function(n = 50) {
  if (n %% 10 != 0) {
    stop("Error: sample size should be a multiple of 10")
  }
  data.frame(X = rep(1:10, each = n / 10),
             A = rep(c("untreated","treated"), n / 2)) %>%
    mutate(Y0 = 180*rbeta(n, 1, 2),
           Y1 = Y0 + X,
           Y = ifelse(A == "untreated", Y0, Y1)) %>%
    select(X, A, Y)
}

