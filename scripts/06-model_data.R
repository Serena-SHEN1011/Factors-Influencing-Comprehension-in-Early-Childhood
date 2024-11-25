#### Preamble ####
# Purpose: Models Children's English(American) Cpmprehension by using stan_glm.
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `rstanarm`, `arrow`, `car` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Factors-Influencing-Early-Childhood-Comprehension-of-American-English` rproj


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(car)
library(arrow)

#### Read Data ####
analysis_data_train <- read_parquet("data/02-analysis_data/train_data.parquet")

#### Fit Bayesian Model ####
# Assuming 'comprehension' is the dependent variable
model <- stan_glm(
    formula = comprehension ~ age + production + is_norming + birth_order + caregiver_education + race +
      sex + monolingual,
    data = analysis_data_train,
    family = gaussian(),  # For a continuous outcome
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

#### Model Diagnostics ####
# Calculate Variance Inflation Factor to check multicollinearity
vif(model)

# Summary of the model
summary(model)

# Posterior predictive checks
pp_check(model)

#### Save Model ####
saveRDS(
  model,
  file = "models/comprehension_model_bayesian_linear.rds"
)
