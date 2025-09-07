# Load required libraries
library(ggplot2)
library(dplyr)

# 1. Read the data
data <- readRDS("data1pairs.rds")
x <- data[, 1]
y <- data[, 2]
n <- length(x)

# 2. Define a grid of bandwidth values
h_grid <- seq(0.05, 1, by = 0.01)
cv_mse <- numeric(length(h_grid))

# 3. Perform Leave-One-Out Cross-Validation for each h
for (j in seq_along(h_grid)) {
  h <- h_grid[j]
  predictions <- numeric(n)
  
  for (i in 1:n) {
    # Leave one observation out
    x_train <- x[-i]
    y_train <- y[-i]
    
    # Estimate y_i using ksmooth on the rest of the data
    pred <- ksmooth(x_train, y_train, kernel = "normal", bandwidth = h, x.points = x[i])
    predictions[i] <- pred$y
  }
  
  # Calculate MSE for current h
  cv_mse[j] <- mean((y - predictions)^2)
}

# 4. Select the optimal bandwidth (h that minimizes CV MSE)
best_h <- h_grid[which.min(cv_mse)]
cat("Optimal bandwidth h:", best_h, "\n")

# 5. Use ksmooth with the optimal h to compute final fitted values
fit <- ksmooth(x, y, kernel = "normal", bandwidth = best_h)

# 6. Prepare data for plotting
df_points <- data.frame(x = x, y = y)
df_fit <- data.frame(x = fit$x, y_hat = fit$y)


# 7. Plot using ggplot2
ggplot() +
  geom_point(data = df_points, aes(x = x, y = y), color = "cornflowerblue", size = 2.5, alpha = 0.7) +
  geom_line(data = df_fit, aes(x = x, y = y_hat), color = "deeppink4", linewidth = 1.2) +
  labs(
    title = "Nadaraya-Watson Regression Estimate (Gaussian kernel)",
    subtitle = paste("Optimal bandwidth h =", round(best_h, 3)),
    x = "x",
    y = "y",
    caption = "LOOCV used for bandwidth selection"
  ) +
  theme_gray(base_size = 14)   +
  theme(
    #panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, margin = margin(b = 10)),
    axis.title = element_text(face = "bold"),
    plot.caption = element_text(size = 10, face = "italic", hjust = 1))