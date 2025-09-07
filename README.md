# statistical-learning-optimization

Semester Project – NTUA MSc in Data Science & Machine Learning

This repository contains the implementation and experiments from my coursework project in Computational Statistics & Stochastic Optimization.  
It showcases advanced methods such as non-parametric regression, bootstrap resampling, EM algorithm, Monte Carlo simulations, and model selection techniques — all written in R with a focus on reproducibility and visualization.

## Topics Covered

- **Non-Parametric Regression (Nadaraya–Watson):**  
  - Implemented with Gaussian kernel.  
  - Automatic bandwidth tuning through cross-validation and PRESS criterion.  
  - Comparison of bias–variance trade-off at boundary cases.

- **Resampling Approaches**  
  - Non-parametric bootstrap for sampling distributions.  
  - Parametric bootstrap for extreme statistics (minimum).  
  - Studied when classical bootstrap fails and how parametric bootstrap resolves the issue.

- **Simulation with Squeezed Rejection Sampling:**  
  - Efficient generation of samples from the Normal distribution.  
  - Analysis of acceptance probability and computational savings.

- **Simulation Techniques**  
  - Random number generation via Squeezed Rejection Sampling.  
  - Efficiency analysis: acceptance rates and computational gains.  
  - Monte Carlo estimation and importance sampling with variance reduction. 

- **Latent Variable Models**  
  - EM algorithm for exponential mixtures.  
  - Tracking convergence and stability of iterative updates.  

- **Model Selection & Regularization:**  
  - Submodel selection with AIC.  
  - Variable selection with Lasso + Cross-Validation.  
  - Confidence intervals via residual bootstrap.
 
## Tools & Libraries

- **Language:** R  
- **Main packages:** ggplot2, dplyr, MASS, glmnet  
- Focus on: Simulation • Resampling • Non-parametric methods • Model selection  
