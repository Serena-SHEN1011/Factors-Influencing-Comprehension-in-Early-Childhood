#### Preamble ####
# Purpose: Cleans the raw data
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `arrow`, `rsample` packages must be installed and loaded
#   - 02-download_data.R must have been run
# Any other information needed? Make sure you are in the `Factors-Influencing-Early-Childhood-Comprehension-of-American-English` rproj

# Load required libraries
library(arrow)
library(dplyr)
library(rsample)

# Load the raw data
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

# Remove columns that are entirely NA
cleaned_data <- raw_data %>%
  select(where(~ !all(is.na(.))))

# Rename columns by removing underscores and updating names
names(cleaned_data) <- gsub("_", "", names(cleaned_data))

# Remove unnecessary columns
cleaned_data <- cleaned_data %>%
  select(-c(downloaded, language, form, datasetname, childid,
            ethnicity, languageexposures, healthconditions, typicallydeveloping))

# Remove all rows with any missing values
cleaned_data <- na.omit(cleaned_data)

# Convert birth_order to numeric sequence
cleaned_data <- cleaned_data %>%
  mutate(birthorder = as.numeric(factor(birthorder, levels = c("First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth"))))


#### Convert Categorical Variables to 0/1 ####
# Convert categorical variables to binary (1 or 0) using dummy coding
# Convert categorical variables to binary using mutate
cleaned_data <- cleaned_data %>%
  mutate(
    isnorming = ifelse(isnorming == "TRUE", 1, 0),
    sex = ifelse(sex == "Male", 1, 0),
    monolingual = ifelse(monolingual == "TRUE", 1, 0)
  )



# Perform a stratified split based on the 'race' variable to ensure all levels are present in both sets
set.seed(123) # Set seed for reproducibility
split <- initial_split(data = cleaned_data, prop = 0.7, strata = race)

# Create training and testing sets
analysis_data_train <- training(split)
analysis_data_test <- testing(split)

# Save cleaned data in different formats
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
write_parquet(analysis_data_train, "data/02-analysis_data/train_data.parquet")
write_parquet(analysis_data_test, "data/02-analysis_data/test_data.parquet")
