# Load data
data <- readRDS("data1b.rds")
n <- length(data)

# Compute the observed minimum
T_original <- min(data)

# Set bootstrap parameters
B <- 2000
set.seed(123)

# Compute bootstrap estimates of the minimum
bootstrap_mins <- numeric(B)
for (b in 1:B) {
  sample_b <- sample(data, size = n, replace = TRUE)
  bootstrap_mins[b] <- min(sample_b)
}

df_boot <- data.frame(min_values = bootstrap_mins)
# Plot histogram 
ggplot(df_boot, aes(x = min_values)) +
  geom_histogram(fill = "brown2", color = "black", bins = 30, alpha = 0.8) +
  geom_vline(xintercept = T_original, color = "darkred", linetype = "dashed", linewidth = 1) +
  labs(
    title = "Bootstrap Estimates for T",
    subtitle = paste("Observed minimum =", round(T_original, 4)),
    x = "Bootstrap Estimates of the Minimum",
    y = "Frequency",
    caption = "Nonparametric Bootstrap with B = 2000 samples" ) +
  theme_gray(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, margin = margin(b = 10)),
    axis.title = element_text(face = "bold"),
    legend.position = "none")