#### Preamble ####
# Purpose: Tests the structure and validity of the simulated language development data
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, `testthat` packages must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `Factors-Influencing-Early-Childhood-Comprehension-of-American-English` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("data/00-simulated_data/simulated_data_with_interaction.csv")


# Test if the data was successfully loaded
test_that("dataset was successfully loaded", {
  expect_true(exists("simulated_data"))
})

# Check if the dataset has 1000 rows
test_that("dataset has 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Check if the dataset has 11 columns
test_that("dataset has 11 columns", {
  expect_equal(ncol(simulated_data), 11)
})

# Check if there are no missing values in the dataset
test_that("dataset contains no missing values", {
  expect_true(all(!is.na(simulated_data)))
})

# Check if 'age' is within a reasonable range (11 to 28)
test_that("'age' values are within a reasonable range (11 to 28)", {
  expect_true(all(simulated_data$age >= 11 & simulated_data$age <= 28))
})

# Check if 'form' contains only valid form values ('WG', 'WS')
test_that("'form' contains only valid form values", {
  valid_forms <- c("WG", "WS")
  expect_true(all(simulated_data$form %in% valid_forms))
})

# Check if 'is_norming' contains only 0 or 1
test_that("'is_norming' contains only 0 or 1", {
  expect_true(all(simulated_data$is_norming %in% c(0, 1)))
})

# Check if 'birth_order' values are between 1 and 4
test_that("'birth_order' values are between 1 and 4", {
  expect_true(all(simulated_data$birth_order >= 1 & simulated_data$birth_order <= 4))
})

# Check if 'caregiver_education' contains only valid education levels
test_that("'caregiver_education' contains only valid education levels", {
  valid_educations <- c("Graduate", "College", "Some College", "High School")
  expect_true(all(simulated_data$caregiver_education %in% valid_educations))
})

# Check if 'race' contains only valid race categories
test_that("'race' contains only valid race categories", {
  valid_races <- c("White", "Black", "Asian", "Hispanic", "Other")
  expect_true(all(simulated_data$race %in% valid_races))
})

# Check if 'sex' contains only 0 (female) or 1 (male)
test_that("'sex' contains only 0 or 1", {
  expect_true(all(simulated_data$sex %in% c(0, 1)))
})

# Check if 'monolingual' contains only 0 or 1
test_that("'monolingual' contains only 0 or 1", {
  expect_true(all(simulated_data$monolingual %in% c(0, 1)))
})

# Check if 'ethnicity' contains only valid ethnicity categories
test_that("'ethnicity' contains only valid ethnicity categories", {
  valid_ethnicities <- c("Hispanic", "Non-Hispanic")
  expect_true(all(simulated_data$ethnicity %in% valid_ethnicities))
})
