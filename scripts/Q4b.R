# Lasso Regression using glmnet and Cross-Validation 

# Load required libraries
library(glmnet)
library(MASS)

# Define response and predictor matrix
y <- Boston$medv
X <- as.matrix(Boston[, names(Boston) != "medv"])

# Fit Lasso model with cross-validation (10-fold by default)
set.seed(123)
cv_lasso <- cv.glmnet(X, y, alpha = 1, standardize = TRUE)

# Plot the cross-validation curve (optional)
plot(cv_lasso)
title("Cross-Validation Curve for Lasso", line = 2.5)

# Lambda that minimizes CV error
lambda_min <- cv_lasso$lambda.min

# Lambda using 1-standard-error rule (simpler model)
lambda_1se <- cv_lasso$lambda.1se

# Fit final model using lambda_1se
lasso_model <- glmnet(X, y, alpha = 1, lambda = lambda_1se, standardize = TRUE)

# Extract coefficients
lasso_coefs <- coef(lasso_model)

# Print results
cat("Lasso Regression Results\n")
cat("Lambda (min):", round(lambda_min, 5), "\n")
cat("Lambda (1-SE rule):", round(lambda_1se, 5), "\n\n")

cat("Selected predictors (non-zero coefficients):\n")
selected <- rownames(lasso_coefs)[lasso_coefs[, 1] != 0]
print(selected[-1])  # exclude intercept

# print(lasso_coefs) # to see all coefficients