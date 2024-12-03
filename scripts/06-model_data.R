#### Preamble ####
# Purpose: Models Children's English(American) Cpmprehension by using stan_glm.
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `rstanarm`, `arrow`, `car` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Factors_Influencing_Early_Childhood_Comprehension_of_American_English` rproj


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(car)
library(arrow)

#### Read Data ####
analysis_data_train <- read_parquet("data/02-analysis_data/train_data.parquet")

#### Fit Bayesian Model ####
# Assuming 'comprehension' is the dependent variable
# Create a Full model
full_model <- stan_glm(
    formula = comprehension ~ age + production + isnorming + birthorder + caregivereducation + race +
      sex + monolingual,
    data = analysis_data_train,
    family = gaussian(),  # For a continuous outcome
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

# Summary of the model
summary(full_model)

# By seeing results of summary of full model, create a reduced model without these non-significant predictors
model_reduced <- stan_glm(
  formula = comprehension ~ age + production + isnorming + birthorder + caregivereducation + race,
  data = analysis_data_train,
  family = gaussian(),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 853
)

# Compare Models
loo_full <- loo(full_model)
loo_reduced <- loo(model_reduced)

loo_compare(loo_full, loo_reduced)


#### Model Diagnostics ####
# Calculate Variance Inflation Factor to check multicollinearity
vif(model_reduced)


# Posterior predictive checks
pp_check(model_reduced)

#### Save Model ####
saveRDS(
  full_model,
  file = "models/comprehension_full_model_bayesian_linear.rds"
)


saveRDS(
  model_reduced,
  file = "models/comprehension_reduced_model_bayesian_linear.rds"
)
