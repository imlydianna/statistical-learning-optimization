# Residual Bootstrap for 95% CI of the coefficient of 'rm'

# Number of bootstrap replications
B <- 2000

# Extract fitted values and residuals from M1
fitted_vals <- fitted(M1)
residuals_original <- resid(M1)

# Create vector to store bootstrap estimates of the coefficient of 'rm'
bootstrap_coefs <- numeric(B)

# Residual bootstrap loop
set.seed(123)
for (b in 1:B) {
  # Resample residuals with replacement
  resampled_residuals <- sample(residuals_original, replace = TRUE)
  
  # Generate new response values: y* = fitted + resampled residuals
  y_star <- fitted_vals + resampled_residuals
  
  # Fit the same model to the new response
  data_star <- Boston
  data_star$medv <- y_star
  
  model_star <- lm(formula(M1), data = data_star)
  
  # Extract the coefficient for 'rm'
  bootstrap_coefs[b] <- coef(model_star)["rm"]
}

# Compute the 95% percentile bootstrap confidence interval
ci_low <- quantile(bootstrap_coefs, 0.025)
ci_high <- quantile(bootstrap_coefs, 0.975)

# Print results
cat("--- 95% Bootstrap CI for coefficient of 'rm' ---\n")
cat("Lower bound (2.5%):", round(ci_low, 4), "\n")
cat("Upper bound (97.5%):", round(ci_high, 4), "\n")