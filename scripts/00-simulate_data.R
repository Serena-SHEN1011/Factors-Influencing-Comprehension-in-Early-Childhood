#### Preamble ####
# Purpose: Simulates a dataset of of early childhood language development, 
  #including the variables such as age, comprehension, production, norming status, birth order, caregiver education, race, sex, and monolingual status.
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Factors-Influencing-Early-Childhood-Comprehension-of-American-English` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)

#### Simulate data with dependencies ####
# Define the number of observations
num_obs <- 1000

# Define possible values for each variable
age_in_months <- unique(c(18, 24, 30, 36))
form <- c("WG", "WS")
comprehension <- sample(100:300, num_obs, replace = TRUE)
production <- sample(10:150, num_obs, replace = TRUE)
is_norming <- c(0, 1) # 1 for TRUE, 0 for FALSE
birth_orders <- 1:4
ethnicity <- c("Hispanic", "Non-Hispanic")
caregiver_educations <- c("Graduate", "College", "Some College", "High School")
races <- c("White", "Black", "Asian", "Other")
sex_values <- c(0, 1) # 0 for female, 1 for male
monolingual_values <- c(0, 1) # 1 for TRUE, 0 for FALSE

# Generate child's gender (0: female, 1: male)
sex <- sample(c(0, 1), num_obs, replace = TRUE)

# Generate child's age based on gender
age <- ifelse(
  sex == 1,
  rnorm(num_obs, mean = 20, sd = 2.5),  # Males: mean age 20, sd 2.5
  rnorm(num_obs, mean = 18, sd = 2.5)   # Females: mean age 18, sd 2.5
)


# Generate comprehension and production scores based on age and sex
comprehension <- ifelse(
  sex == 1,
  sample(100:300, num_obs, replace = TRUE) + (age * 0.5),  # Males: larger effect of age
  sample(100:300, num_obs, replace = TRUE) + (age * 0.3)   # Females: smaller effect of age
)

production <- ifelse(
  sex == 1,
  sample(10:150, num_obs, replace = TRUE) + (age * 0.3),  # Males: larger effect of age
  sample(10:150, num_obs, replace = TRUE) + (age * 0.2)   # Females: smaller effect of age
)

# Simulate other variables
form <- sample(c("WG", "WS"), num_obs, replace = TRUE)
is_norming <- sample(c(0, 1), num_obs, replace = TRUE)
birth_order <- sample(1:4, num_obs, replace = TRUE)
caregiver_education <- sample(c("Graduate", "College", "Some College", "High School"), num_obs, replace = TRUE)
race <- sample(c("White", "Black", "Asian", "Other"), num_obs, replace = TRUE)
monolingual <- sample(c(0, 1), num_obs, replace = TRUE)
ethnicity <- sample(c("Hispanic", "Non-Hispanic"), num_obs, replace = TRUE)

# Create the dataset with interaction-based variables
simulated_data_with_interaction <- tibble(
  age = round(age),  # Round age to whole numbers for consistency
  sex = sex,
  form = form,
  comprehension = round(comprehension, 2),  # Round to two decimal place for readability
  production = round(production, 2),        # Round to two decimal place for readability
  is_norming = is_norming,
  birth_order = birth_order,
  caregiver_education = caregiver_education,
  race = race,
  monolingual = monolingual,
  ethnicity = ethnicity
)

# Save the simulated data
write_csv(simulated_data_with_interaction, "data/00-simulated_data/simulated_data_with_interaction.csv")
