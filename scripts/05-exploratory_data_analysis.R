#### Preamble ####
# Purpose: Exploratory data analyis on cleaned data.
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `ggplot2` and `ggridges` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Factors-Influencing-Comprehension-in-Early-Childhood` rproj


#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(ggridges)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

## Set theme for better aesthetics
theme_set(theme_minimal())

# Summary for selected numeric variables
summary(select(analysis_data, age, comprehension, production, birth_order))


#### Univariate Analysis ####
# Distribution of Age(months)
ggplot(analysis_data, aes(x = age)) +
  geom_histogram(bins = 20, fill = "skyblue", color = "black") +
  labs(title = "Distribution of children's age in months", x = "Age(months)", y = "Count")

# Distribution of comprehension
ggplot(analysis_data, aes(x = comprehension)) +
  geom_histogram(bins = 20, fill = "orange", color = "black") +
  labs(
    title = "Distribution of Comprehension",
    x = "Comprehension",
    y = "Count"
  )

# Distribution of production
ggplot(analysis_data, aes(x = production)) +
  geom_histogram(bins = 20, fill = "skyblue", color = "black") +
  labs(
    title = "Distribution of Comprehension",
    x = "production",
    y = "Count"
  )



#### Bivariate Analysis ####
#Comprehension by Sex
ggplot(analysis_data, aes(x = comprehension, fill = as.factor(sex))) +
  geom_area(stat = "bin", alpha = 0.6) +
  labs(
    title = "Comprehension by Sex",
    x = "Comprehension",
    y = "Count",
    fill = "Sex (0 = Female, 1 = Male)"
  )

#Density Plot of Comprehension by Race
ggplot(analysis_data, aes(x = comprehension, fill = race)) +
  geom_density(alpha = 0.4) +
  labs(
    title = "Density Plot of Comprehension by Race",
    x = "Comprehension",
    y = "Density",
    fill = "Race"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#BoxPlot of Comprehension by Caregiver Education Level
ggplot(analysis_data, aes(x = caregiver_education, y = comprehension)) +
  geom_boxplot(fill = "lightblue") +
  labs(
    title = "Box Plot of Comprehension by Caregiver Education Level",
    x = "Caregiver Education Level",
    y = "Comprehension Score"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Proportion of Norming Status by Caregiver Education
ggplot(analysis_data, aes(x = caregiver_education, fill = as.factor(is_norming))) +
  geom_bar(position = "fill") +
  labs(
    title = "Proportion of Norming Status by Caregiver Education",
    x = "Caregiver Education Level",
    y = "Proportion",
    fill = "Norming Status (0 = No, 1 = Yes)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#comprehension vs. production
ggplot(analysis_data, aes(x = production, y = comprehension)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "red") +
  labs(
    title = "Production vs Comprehension",
    x = "Production",
    y = "Comprehension"
  )

#Ridgeline Plot of Comprehension by Age Group
## Create the age_group variable by binning age into categories
seperate_age_group <- analysis_data %>%
  mutate(age_group = cut(age, breaks = c(0, 10, 15, 20, 25, 30), include.lowest = TRUE))

ggplot(seperate_age_group, aes(x = comprehension, y = age_group, fill = age_group)) +
  geom_density_ridges(alpha = 0.6) +
  labs(
    title = "Ridgeline Plot of Comprehension by Age Group",
    x = "Comprehension",
    y = "Age Group"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#comprehension vs. birth_order
ggplot(analysis_data, aes(x = as.factor(birth_order), y = comprehension)) +
  geom_boxplot(fill = "skyblue") +
  labs(
    title = "Birth Order vs Comprehension",
    x = "Birth Order",
    y = "Comprehension"
  )

#comprehension vs. caregiver_education
ggplot(analysis_data, aes(x = caregiver_education, y = comprehension)) +
  geom_boxplot(fill = "lightblue") +
  labs(
    title = "Caregiver Education Level vs Comprehension",
    x = "Caregiver Education Level",
    y = "Comprehension Score"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#comprehension vs. race
ggplot(analysis_data, aes(x = race, y = comprehension, fill = race)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Boxplot of Comprehension by Race", x = "Race", y = "Comprehension")

