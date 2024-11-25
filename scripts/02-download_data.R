#### Preamble ####
# Purpose: Downloads and saves the data for analysis from Wordbank database of children’s vocabulary growth
  #Language: English(American)
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Factors-Influencing-Early-Childhood-Comprehension-of-American-English` rproj


#### Workspace setup ####
library(tidyverse)


#### Download data ####
raw_data <- read_csv(
  file = "data/01-raw_data/raw_data.csv",
  show_col_types = TRUE
)

#### Save data ####
write_csv(raw_data, "data/01-raw_data/raw_data.csv")
