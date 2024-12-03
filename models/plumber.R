library(plumber)
library(rstanarm)
library(tidyverse)

# Load the model
model <- readRDS("comprehension_reduced_model_bayesian_linear.rds")

# Define the model version
version_number <- "0.0.1"

# Define the variables
variables <- list(
  age = "The age of the child, numeric value.",
  production = "Production score of the child, numeric value.",
  is_norming = "Whether the child is part of the norming group, binary (0 or 1).",
  birth_order = "The birth order of the child, numeric value.",
  caregiver_education = "Education level of the caregiver, categorical.",
  race = "Race of the child, categorical."
)

#* @param age
#* @param production
#* @param isnorming
#* @param birthorder
#* @param caregivereducation
#* @param race
#* @get /predict_comprehension
predict_comprehension <- function(age = 24, production = 50, isnorming = 1, birthorder = 1,
                                  caregivereducation = "HighSchool", race = "White") {
  # Prepare the payload as a data frame
  payload <- data.frame(
    age = as.integer(age),
    production = as.integer(production),
    isnorming = as.integer(isnorming),
    birthorder = as.integer(birthorder),
    caregivereducation = as.character(caregivereducation),
    race = as.character(race)
  )
  
  # Extract posterior samples
  posterior_samples <- as.matrix(model)  # Convert to matrix for easier manipulation
  
  # Define the generative process for prediction
  beta_age <- posterior_samples[, "age"]
  beta_production <- posterior_samples[, "production"]
  beta_is_norming <- posterior_samples[, "isnorming"]
  beta_birth_order <- posterior_samples[, "birthorder"]
  beta_caregiver_education <- posterior_samples[, paste0("caregivereducation", payload$caregivereducation)]
  beta_race <- posterior_samples[, paste0("race", payload$race)]
  alpha <- posterior_samples[, "(Intercept)"]
  
  # Compute the predicted value for the observation
  predicted_values <- alpha +
    beta_age * payload$age +
    beta_production * payload$production +
    beta_is_norming * payload$isnorming +
    beta_birth_order * payload$birthorder +
    beta_caregiver_education +
    beta_race
  
  # Predict
  mean_prediction <- mean(predicted_values)
  
  # Store results
  result <- list(
    "estimated_comprehension" = mean_prediction
  )
  
  return(result)
}
