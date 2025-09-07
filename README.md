# statistical-learning-optimization

Semester Project – NTUA MSc in Data Science & Machine Learning

This repository contains the implementation and experiments from my coursework project in Computational Statistics & Stochastic Optimization.  
It showcases advanced methods such as non-parametric regression, bootstrap resampling, EM algorithm, Monte Carlo simulations, and model selection techniques — all written in R with a focus on reproducibility and visualization.

## Project Highlights

- **Non-Parametric Regression (Nadaraya–Watson):**  
  - Implemented with Gaussian kernel.  
  - Optimal bandwidth selected via **LOOCV** and the efficient **PRESS formula**.  
  - Comparison of bias–variance trade-off in extreme cases of bandwidth.

- **Bootstrap & Parametric Bootstrap:**  
  - Studied the distribution of extreme statistics (minimum of a sample).  
  - Highlighted when classical bootstrap fails and how parametric bootstrap resolves the issue.

- **Simulation with Squeezed Rejection Sampling:**  
  - Efficient generation of samples from the Normal distribution.  
  - Analysis of acceptance probability and computational savings.

- **Monte Carlo & Importance Sampling:**  
  - Estimation of expectations (e.g. π) using different sampling strategies.  
  - Compared efficiency and variance reduction.

- **Expectation-Maximization (EM Algorithm):**  
  - Parameter estimation for mixtures of exponential distributions.  
  - Illustrated convergence properties.

- **Model Selection & Regularization:**  
  - Submodel selection with AIC.  
  - Variable selection with **Lasso + Cross-Validation**.  
  - Confidence intervals via residual bootstrap.
 
## Tech Stack

- **Language:** R  
- **Packages:** `ggplot2`, `glmnet`, `fitdistrplus`, `dplyr`  
- **Focus Areas:** Statistical Modeling · Simulation · Optimization · Visualization
