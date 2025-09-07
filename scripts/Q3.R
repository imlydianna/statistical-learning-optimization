# Load the data
x <- readRDS("data3em.rds")

# EM algorithm for estimating parameter p
em_algorithm <- function(x, p_initial = 0.5, tol = 1e-10, max_iter = 1000) {
  
  # Initialize parameter p with the value p(0)
  p_current <- p_initial
  
  # Precompute densities for efficiency:
  # f(x_i | Z_i = 1) = 1 * exp(-x_i)
  # f(x_i | Z_i = 0) = 5 * exp(-5x_i)
  f_z1 <- dexp(x, rate = 1)
  f_z0 <- dexp(x, rate = 5)
  
  # Vector to store the history of p estimates
  p_history <- numeric(max_iter)
  
  # Begin EM iterations
  for (r in 1:max_iter) {
    
    # E-Step: Compute the weights wi(r) = P(Zi=1 | xi,p(r))
    numerator <- p_current * f_z1
    denominator <- numerator + (1 - p_current) * f_z0
    w <- numerator / denominator
    
    # M-Step: Update parameter p: p(r+1) = (1/n) * sum wi(r)
    p_new <- mean(w)
    
    # Store new value and check for convergence
    p_history[r] <- p_new
    if (abs(p_new - p_current) <= tol) {
      p_history <- p_history[1:r] # Trim the history vector
      break
    }
    
    # Update for the next iteration
    p_current <- p_new
  }
  
  return(list(p_hat = p_new, iterations = r, p_history = p_history))
}

# Run the EM algorithm
result <- em_algorithm(x, p_initial = 0.5)

# Print final results
cat("Estimated p (p_hat):", format(result$p_hat, digits = 11), "\n")
cat("EM iterations:", result$iterations, "\n")

# Visualization of convergence

df_plot <- data.frame(iteration = 1:result$iterations, p_value = result$p_history)

ggplot(df_plot, aes(x = iteration, y = p_value)) +
  geom_line(color = "dodgerblue3", linewidth = 1) +
  geom_point(color = "dodgerblue4", size = 2) +
  labs(title = "Convergence of EM Algorithm for Parameter p",
       x = "Iteration (r)", 
       y = expression(p^"(r)")) +
  theme_gray(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.title = element_text(face = "bold")
  )
