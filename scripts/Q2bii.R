# Importance Sampling Estimator for E[φ(X)]
# Define phi(x)
phi <- function(x) 4 / (1 + x^2)

# Importance sampling density g(x)
g_pdf <- function(x) (1/3)*(4 - 2*x)

# Inverse CDF sampling from g(x)
generate_from_g <- function(n) {
  u <- runif(n)
  2 - sqrt(4 - 3 * u)}

# Importance sampling weight ψ(x)
psi <- function(x) phi(x) / g_pdf(x)

# Simulation parameters
num_sim <- 1000
n <- 200

# Generate estimates of θ̂₂
set.seed(456)
theta_hat_2 <- replicate(num_sim, {
  x <- generate_from_g(n)
  mean(psi(x))})

# Compute standard error and mean estimate
se_theta_hat_2 <- sd(theta_hat_2)
mean_estimate <- mean(theta_hat_2)
true_value <- pi

# Plot distribution of θ̂₂
df <- data.frame(theta = theta_hat_2)

ggplot(df, aes(x = theta)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.001, fill = "cadetblue3", color = "black", alpha = 0.7) +
  geom_density(color = "maroon", size = 1.2) +
  geom_vline(xintercept = true_value, color = "forestgreen", linetype = "dashed", size = 1) +
  geom_vline(xintercept = mean_estimate, color = "darkorange", linetype = "dotted", size = 1) +
  labs(
    title = expression(paste("Distribution of Importance Sampling Estimator ", hat(theta)[2])),
    subtitle = paste(num_sim, "simulations with n =", n, "samples from g(x)"),
    x = expression(hat(theta)[2]), y = "Density"
  ) +
  theme_gray(base_size = 14) +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position = "none")

# Print results
cat("Standard error of θ̂₂:", round(se_theta_hat_2, 5), "\n")
cat("Mean estimate:", round(mean_estimate, 5), "\n")
cat("True value (π):", round(true_value, 5), "\n")