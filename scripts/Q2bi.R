# Classical Monte Carlo Estimator for E[φ(X)]
# Define the function φ(x)
phi <- function(x) {
  return(4 / (1 + x^2))
}

# Number of simulations (Monte Carlo estimates)
num_simulations <- 1000

# Sample size per estimation
n <- 200

# Use replicate to generate 1000 estimates of θ̂₁
set.seed(123)
theta_hat_1_values <- replicate(num_simulations, {
  x <- runif(n)
  mean(phi(x))
})

# Estimate the standard error: standard deviation of the estimates
se_theta_hat_1 <- sd(theta_hat_1_values)

# True value of the integral (E[φ(X)]) = π
true_value <- pi
mean_estimate <- mean(theta_hat_1_values)

# Create histogram + density + vertical lines

df_theta1 <- data.frame(theta_hat_1 = theta_hat_1_values)

ggplot(df_theta1, aes(x = theta_hat_1)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.005, fill = "cornflowerblue", color = "black", alpha = 0.7) +
  geom_density(color = "darkred", size = 1.2, alpha = 0.9) +
  geom_vline(aes(xintercept = true_value, color = "True Value (π)"), linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = mean_estimate, color = "Mean Estimate"), linetype = "dotted", size = 1) +
  scale_color_manual(name = "", values = c("True Value (π)" = "forestgreen", "Mean Estimate" = "darkorange")) +
  labs(
    title = expression(paste("Distribution of Classical Monte Carlo Estimator ", hat(theta)[1])),
    subtitle = paste0(num_simulations, " simulations with n = ", n, " samples from U(0,1)"),
    x = expression(hat(theta)[1]),
    y = "Density" ) +
  theme_gray(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5),
    legend.position = "bottom")

# Print numerical results
cat("Estimated standard error of θ̂₁:", round(se_theta_hat_1, 5), "\n")
cat("Mean of simulated θ̂₁ values:", round(mean_estimate, 5), "\n")
cat("True value (π):", round(true_value, 5), "\n")
