# Load data
data <- readRDS("data1b.rds")
n <- length(data)

# Compute the observed minimum
T_original <- min(data)

# Estimate parameters for the Student's t-distribution
mu_hat <- mean(data)
sd_hat <- sd(data)
df_hat <- fitdistr(data, densfun = "t")$estimate["df"]

# Set bootstrap parameters
B <- 2000
set.seed(123)

# Generate parametric bootstrap estimates for the minimum
parametric_mins <- numeric(B)
for (b in 1:B) {
  # Generate sample from t-distribution with estimated parameters
  sample_b <- rt(n, df = df_hat) * sd_hat + mu_hat
  parametric_mins[b] <- min(sample_b)
}

# Plot histogram 
df_parametric <- data.frame(min_values = parametric_mins)

ggplot(df_parametric, aes(x = min_values)) +
  geom_histogram(fill = "maroon", color = "black", bins = 30, alpha = 0.8) +
  geom_vline(xintercept = T_original, color = "darkred", linetype = "dashed", linewidth = 1) +
  labs(
    title = "Parametric Bootstrap Estimates for T",
    subtitle = paste("Observed minimum =", round(T_original, 4)),
    x = "Bootstrap Estimates of the Minimum",
    y = "Frequency",
    caption = paste("Parametric Bootstrap from t-distribution with df ≈", round(df_hat, 2), "\nB = 2000 samples")
  ) +
  theme_gray(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, margin = margin(b = 10)),
    axis.title = element_text(face = "bold"),
    legend.position = "none")