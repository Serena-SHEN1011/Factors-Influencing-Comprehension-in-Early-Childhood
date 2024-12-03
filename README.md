# Factors Influencing Early Childhood Comprehension of American English

## Overview

This repository contains code, data, and analyses used to study factors influencing early childhood vocabulary comprehension skills, with a focus on English (American). The analysis is performed using R, and the data comes from publicly available datasets, including the Wordbank Administration Data. The objective of the project is to build models that identify the factors impacting vocabulary comprehension, focusing on predictors such as caregiver education, birth order, and 
race.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains the raw data as obtained from [Wordbank Database-An open database of children's vocabulary development](https://wordbank.stanford.edu/).
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models and API for the model.
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to download, simulate, clean, model, and test data.


## Statement on LLM usage

The ChatGPT-4 model assisted with data validation, test creation, data cleaning, simulation generation, plot generation, and the polishing of wording. The entire chat history is available in `other/llm_usage/usage.txt`.


------------------------------------------------------------------------

*Note: The dataset used in this analysis was downloaded from the [Worldbank Database](https://wordbank.stanford.edu/) using the Data Export Tools. Due to the deprecation of the wordbankr package, it was not possible to install and use this package directly. Additionally, the alternative approach of reading datasets directly from the Worldbank website did not meet the specific requirements of this analysis. Therefore, the dataset was downloaded from the Worldbank database and saved as `data/01-raw_data`.

------------------------------------------------------------------------