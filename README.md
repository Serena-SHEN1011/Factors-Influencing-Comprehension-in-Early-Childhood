# Factors-Influencing-Comprehension-in-Early-Childhood

## Overview

This repository contains code, data, and analyses used to study factors influencing early childhood vocabulary comprehension skills, with a focus on English (American). The analysis is performed using R, and the data comes from publicly available datasets, including the Wordbank Administration Data. The objective of the project is to build models that identify the factors impacting vocabulary comprehension, focusing on predictors such as caregiver education, birth order, and 
race.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains the raw data as obtained from [Wordbank Database-An open database of children's vocabulary development](https://wordbank.stanford.edu/).
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to download, simulate, clean, model, and test data.


## Statement on LLM usage

The ChatGPT-4 model assisted with data validation, test creation, data cleaning, simulation generation, plot generation, and the polishing of wording. The entire chat history is available in `other/llm_usage/usage.txt`.

## Some checks

- [ ] Change the rproj file name so that it's not starter_folder.Rproj
- [ ] Change the README title so that it's not Starter folder
- [ ] Remove files that you're not using
- [ ] Update comments in R scripts
- [ ] Remove this checklist