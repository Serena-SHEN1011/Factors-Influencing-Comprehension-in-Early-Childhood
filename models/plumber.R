library(plumber)
library(rstanarm)
library(tidyverse)

# Load the model
model <- readRDS("comprehension_model_bayesian_linear.rds")

# Define the model version
version_number <- "0.0.1"

# Define the variables
variables <- list(
  age = "The age of the child, numeric value.",
  production = "Production score of the child, numeric value.",
  is_norming = "Whether the child is part of the norming group, binary (0 or 1).",
  birth_order = "The birth order of the child, numeric value.",
  caregiver_education = "Education level of the caregiver, categorical.",
  race = "Race of the child, categorical.",
  sex = "Sex of the child, numeric value (e.g., 0 for Male, 1 for Female).",
  monolingual = "Whether the child is monolingual, binary (0 or 1)."
)

#* @param age
#* @param production
#* @param is_norming
#* @param birth_order
#* @param caregiver_education
#* @param race
#* @param sex
#* @param monolingual
#* @get /predict_comprehension
predict_comprehension <- function(age = 24, production = 50, is_norming = 1, birth_order = 1,
                                  caregiver_education = "HighSchool", race = "White", sex = 0,
                                  monolingual = 1) {
  # Prepare the payload as a data frame
  payload <- data.frame(
    age = as.integer(age),
    production = as.integer(production),
    is_norming = as.integer(is_norming),
    birth_order = as.integer(birth_order),
    caregiver_education = as.character(caregiver_education),
    race = as.character(race),
    sex = as.integer(sex),
    monolingual = as.integer(monolingual)
  )
  
  # Extract posterior samples
  posterior_samples <- as.matrix(model)  # Convert to matrix for easier manipulation
  
  # Define the generative process for prediction
  beta_age <- posterior_samples[, "age"]
  beta_production <- posterior_samples[, "production"]
  beta_is_norming <- posterior_samples[, "is_norming"]
  beta_birth_order <- posterior_samples[, "birth_order"]
  beta_caregiver_education <- posterior_samples[, paste0("caregiver_education", payload$caregiver_education)]
  beta_race <- posterior_samples[, paste0("race", payload$race)]
  beta_sex <- posterior_samples[, paste0("sex", payload$sex)]
  beta_monolingual <- posterior_samples[, "monolingual"]
  alpha <- posterior_samples[, "(Intercept)"]
  
  # Compute the predicted value for the observation
  predicted_values <- alpha +
    beta_age * payload$age +
    beta_production * payload$production +
    beta_is_norming * payload$is_norming +
    beta_birth_order * payload$birth_order +
    beta_caregiver_education +
    beta_race +
    beta_sex +
    beta_monolingual * payload$monolingual
  
  # Predict
  mean_prediction <- mean(predicted_values)
  
  # Store results
  result <- list(
    "estimated_comprehension" = mean_prediction
  )
  
  return(result)
}
