# Define target density: Standard Normal N(0,1)
f <- function(x) dnorm(x)

# Define proposal density: Laplace(0,1)
g <- function(x) 0.5 * exp(-abs(x))

# Inverse CDF sampling from Laplace(0,1)
sample_laplace <- function(n) {
  u <- runif(n)
  ifelse(u < 0.5, log(2 * u), -log(2 * (1 - u)))
}

# Envelope constant M
M <- sqrt(2 * exp(1) / pi)

# Squeezing function: lower bound for f(x)
squeezing <- function(x) {
  val <- 1 - (x^2 / 2)
  ifelse(val > 0, val / sqrt(2 * pi), 0)}

# Number of samples to generate
n_samples <- 10000
samples <- numeric(n_samples)
accepted <- 0
set.seed(42)

# Counters for acceptance rates
total <- squeeze_accepts <- full_accepts <- 0

# Squeezed rejection sampling loop
while (accepted < n_samples) {
  y <- sample_laplace(1)
  u <- runif(1)
  total <- total + 1
  
  g_y <- g(y)
  s_y <- squeezing(y)
  
  # First test: squeezing acceptance
  if (u <= s_y / (M * g_y)) {
    accepted <- accepted + 1
    samples[accepted] <- y
    squeeze_accepts <- squeeze_accepts + 1
  } 
  # Second test: full evaluation of f(x)
  else if (u <= f(y) / (M * g_y)) {
    accepted <- accepted + 1
    samples[accepted] <- y
    full_accepts <- full_accepts + 1}}

# Plot histogram with theoretical normal curve
df <- data.frame(x = samples)

ggplot(df, aes(x = x)) +
  geom_histogram(aes(y = ..density..), bins = 60, fill = "aquamarine3", color = "black", alpha = 0.7) +
  stat_function(fun = dnorm, color = "maroon", size = 1.2) +
  labs(title = "Histogram of Simulated Samples from N(0,1)",
       subtitle = "Squeezed Rejection Sampling using Laplace(0,1)",
       x = "x", y = "Density") +
  theme_gray(base_size = 14) +
  theme(plot.title = element_text(face = "bold", hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))

# Print acceptance statistics
cat("Total proposals:", total, "\n")
cat("Accepted via squeezing:", squeeze_accepts, "\n")
cat("Accepted via full f(x):", full_accepts, "\n")