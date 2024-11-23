#### Preamble ####
# Purpose: Simulates a dataset of of early childhood language development, 
  #including the variables such as age, comprehension, production, norming status, birth order, caregiver education, race, sex, and monolingual status.
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Factors-Influencing-Comprehension-in-Early-Childhood` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# Define the number of observations
num_obs <- 1000

# Define possible values for each variable
age_in_months <- unique(c(18, 24, 30, 36))
comprehension <- sample(100:300, num_obs, replace = TRUE)
production <- sample(10:150, num_obs, replace = TRUE)
is_norming <- c(0, 1)
birth_orders <- 1:4
caregiver_educations <- c("Graduate", "College", "Some College", "High School")
races <- c("White", "Black", "Asian", "Other")
sex_values <- c(0, 1) # 0 for female, 1 for male
monolingual_values <- c(0, 1)

# Generate the dataset
simulated_data <- tibble(
  age = sample(age_in_months, num_obs, replace = TRUE),
  comprehension = comprehension,
  production = production,
  is_norming = sample(is_norming, num_obs, replace = TRUE),
  birth_order = sample(birth_orders, num_obs, replace = TRUE),
  caregiver_education = sample(caregiver_educations, num_obs, replace = TRUE),
  race = sample(races, num_obs, replace = TRUE),
  sex = sample(sex_values, num_obs, replace = TRUE),
  monolingual = sample(monolingual_values, num_obs, replace = TRUE)
)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
