# Exhaustive model selection using AIC
# Load the dataset
library(MASS)
data(Boston)

# Define response and predictor variables
response <- "medv"
predictors <- names(Boston)[names(Boston) != response]
p <- length(predictors)

# Generate all possible subsets of predictors (2^p total)
all_subsets <- list()
for (k in 0:p) {
  subsets_k <- combn(predictors, k, simplify = FALSE)
  all_subsets <- c(all_subsets, subsets_k)}

# Initialize variables to track the best model
best_aic <- Inf
best_formula <- NULL

# Loop through all predictor subsets
for (vars in all_subsets) {
  # If subset is empty, model includes only the intercept
  if (length(vars) == 0) {
    formula_str <- paste(response, "~ 1")
  } else {
    formula_str <- paste(response, "~", paste(vars, collapse = " + "))  }
  
  # Fit the model and compute AIC
  current_model <- lm(as.formula(formula_str), data = Boston)
  current_aic <- AIC(current_model)
  
  # Update best model if current AIC is lower
  if (current_aic < best_aic) {
    best_aic <- current_aic
    best_formula <- formula_str}}

# Fit the final best model (M1)
M1 <- lm(as.formula(best_formula), data = Boston)

# Print the results
cat("Model M1 (Minimum AIC)\n")
cat("Model formula:", best_formula, "\n")
cat("Minimum AIC:", round(best_aic, 3), "\n")
