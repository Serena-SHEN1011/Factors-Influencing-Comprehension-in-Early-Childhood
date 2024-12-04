#### Preamble ####
# Purpose: Exploratory data analyis on cleaned data.
# Author: Ziyuan Shen
# Date: 23 November 2024 
# Contact: ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `ggplot2`, `ggridges` and `arrow` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Factors_Influencing_Early_Childhood_Comprehension_of_American_English` rproj


#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(ggridges)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

## Set theme for better aesthetics
theme_set(theme_minimal())

# Summary for selected numeric variables
summary(select(analysis_data, age, comprehension, production, birthorder))


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
    title = "Distribution of production",
    x = "production",
    y = "Count"
  )



#### Bivariate Analysis ####
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
ggplot(analysis_data, aes(x = caregivereducation, y = comprehension)) +
  geom_boxplot(fill = "lightblue") +
  labs(
    title = "Box Plot of Comprehension by Caregiver Education Level",
    x = "Caregiver Education Level",
    y = "Comprehension Score"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Proportion of Norming Status by Caregiver Education
ggplot(analysis_data, aes(x = caregivereducation, fill = as.factor(isnorming))) +
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

# caregivereducation vs. comprehension with corrected colors
ggplot(analysis_data, aes(y = caregivereducation, x = comprehension, fill = as.factor(caregivereducation))) +
  stat_summary(fun = mean, geom = "bar", alpha = 0.8) +
  scale_fill_brewer(palette = "Set3") +
  labs(
    y = "Caregiver Education Level",
    x = "Mean Comprehension (Number of Understanding Words)"
  ) +
  theme_minimal() +
  theme(axis.text.y = element_text(angle = 0, vjust = 0.5),
        legend.position = "none") 

