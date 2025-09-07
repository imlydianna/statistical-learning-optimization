# 1. Read the data
data <- readRDS("data1pairs.rds")
x <- data[, 1]
y <- data[, 2]
n <- length(x)

# 2. Define grid of bandwidth values
h_vals <- seq(0.05, 1, by = 0.01)
press_errors <- numeric(length(h_vals))  # Store PRESS errors for each h

# 3. Efficient PRESS computation for each h
for (j in seq_along(h_vals)) {
  h <- h_vals[j]
  
  # Construct the Smoother Matrix S (n x n)
  S <- matrix(0, nrow = n, ncol = n)
  
  for (i in 1:n) {
    # Compute Gaussian kernel weights for the i-th observation
    weights <- dnorm((x[i] - x) / h)
    # Normalize weights to sum to 1 (row of smoother matrix S)
    S[i, ] <- weights / sum(weights)
  }
  
  # Compute fitted values: y_hat = S * y
  y_hat <- S %*% y
  
  # Extract diagonal elements S_ii (self-influence)
  S_ii <- diag(S)
  
  # Apply PRESS formula
  residuals <- y - y_hat
  press_residuals <- residuals / (1 - S_ii)
  
  # Compute mean squared PRESS error for current h
  press_errors[j] <- mean(press_residuals^2)
}

# 4. Find optimal h minimizing PRESS error
best_h <- h_vals[which.min(press_errors)]
cat("Optimal bandwidth h:", best_h, "\n")

# Plot PRESS criterion 
df_press <- data.frame(h = h_vals, press_mse = press_errors)

ggplot(df_press, aes(x = h, y = press_mse)) +
  geom_line(color = "brown4", linewidth = 1.2) +
  geom_vline(xintercept = best_h, color = "darksalmon", linetype = "dashed", linewidth = 1) +
  labs(
    title = "Bandwidth Selection via PRESS Criterion for Nadaraya-Watson",
    subtitle = paste("Optimal bandwidth h =", round(best_h, 3)),
    x = "Bandwidth (h)",
    y = "PRESS Error (MSE)",
    caption = "Efficient PRESS computation using smoother matrix S") +
  theme_gray(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, margin = margin(b = 10)),
    axis.title = element_text(face = "bold"),
    plot.caption = element_text(size = 10, face = "italic", hjust = 1))

# Prepare dataframes for plotting Nadaraya-Watson regression estimate
df_points <- data.frame(x = x, y = y)

# Compute fitted values directly on observed x using optimal h
h_opt <- best_h
y_hat <- numeric(n)

for (i in 1:n) {
  weights <- dnorm((x[i] - x) / h_opt)
  y_hat[i] <- sum(weights * y) / sum(weights)}

df_fit <- data.frame(x = x, y_hat = y_hat)

# Plot Nadaraya-Watson regression estimate
ggplot() +
  geom_point(data = df_points, aes(x = x, y = y), color = "darksalmon", size = 2.5, alpha = 0.7) +
  geom_line(data = df_fit, aes(x=x, y=y_hat), color = "brown4", linewidth = 1.2)+
  labs(
    title = "Nadaraya-Watson Regression Estimate (Gaussian kernel)",
    subtitle = paste("Optimal bandwidth h =", round(h_opt, 3), "(from PRESS criterion)"),
    x = "x",
    y = "y",
    caption = "Efficient bandwidth selection using PRESS formula") +
  theme_gray(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, margin = margin(b = 10)),
    axis.title = element_text(face = "bold"),
    plot.caption = element_text(size = 10, face = "italic", hjust = 1))