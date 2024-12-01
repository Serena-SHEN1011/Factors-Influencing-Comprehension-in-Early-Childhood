#### Preamble ####
# Purpose: Tests structure of the analysis data.
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
#  Pre-requisites: 
#   - The `tidyverse`, `testthat` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Factors-Influencing-Early-Childhood-Comprehension-of-American-English` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####
# Test that the dataset has 3511 rows
test_that("dataset has 3511 rows", {
  expect_equal(nrow(analysis_data), 3511)
})

# Test that the dataset has 9 columns
test_that("dataset has 9 columns", {
  expect_equal(ncol(analysis_data), 9)
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test that the 'age' column is numeric
test_that("'age' is numeric", {
  expect_type(analysis_data$age, "double")
})

# Test that the 'birth order' column is between 1 and 8
test_that("'birthorder' values are between 1 and 8", {
  expect_true("birthorder" %in% names(analysis_data))
  expect_true(all(analysis_data$birthorder >= 1 & analysis_data$birthorder <= 8, na.rm = TRUE))
})


# Test that the 'caregivereducation' column is character type
test_that("'caregivereducation' is a character", {
  expect_type(analysis_data$caregivereducation, "character")
})

# Test that the 'race' column is character type
test_that("'race' is character", {
  expect_type(analysis_data$race, "character")
})


# Test that there are no empty strings in 'caregivereducation' or 'race' columns
test_that("no empty strings in 'caregivereducation' or 'race' columns", {
  expect_false(any(analysis_data$caregivereducation == "" | analysis_data$race == ""))
})

# Test that the 'caregivereducation' column contains at least 3 unique values
test_that("'caregivereducation' column contains at least 3 unique values", {
  expect_true(length(unique(analysis_data$caregivereducation)) >= 3)
})

# Test that the 'age' column values are within a realistic range (e.g., 8 to 30)
test_that("'age' values are within the range 18 to 36", {
  expect_true(all(analysis_data$age >= 8 & analysis_data$age <= 30))
})


# Test that 'sex' contains only 0 or 1 (0: female, 1: male)
test_that("'sex' contains only 0 or 1", {
  expect_true(all(analysis_data$sex %in% c(0, 1)))
})

# Test that 'monolingual' contains only 0 or 1
test_that("'monolingual' contains only 0 or 1", {
  expect_true(all(analysis_data$monolingual %in% c(0, 1)))
})

# Test that 'production' and 'comprehension' values are non-negative
test_that("'production' and 'comprehension' values are non-negative", {
  expect_true(all(analysis_data$production >= 0))
  expect_true(all(analysis_data$comprehension >= 0))
})
