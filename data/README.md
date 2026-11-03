# Data Directory Guide

This folder contains the raw, cleaned, and exported datasets for the Pune Real Estate Analytics Dashboard project.

For the project overview, cleaning methodology, and key findings, see the [Root README](../README.md).

## Folder Structure

- [`raw/`](raw/) — Contains the initial uncleaned data extracted from the source.
- [`cleaned/`](cleaned/) — Contains the analysis-ready dataset produced by the Python cleaning workflow.
- [`exports/`](exports/) — Contains CSV summaries and tables exported from SQL analyses.

## Key Datasets

- **Raw Dataset:** [`raw/scrapped_data.csv`](raw/scrapped_data.csv)
  - Source: [Pune Real Estate Listings Dataset on Kaggle](https://www.kaggle.com/datasets/shubham001official/pune-real-estate-listings-dataset)
  - Contains 930 raw records and 18 source attributes representing advertised property listings.
- **Cleaned Dataset:** [`cleaned/clean_rent_data.csv`](cleaned/clean_rent_data.csv)
  - Contains 927 records and 28 columns after removing three duplicate rows, cleaning strings/numeric fields, and engineering features.
  - *Note:* Named `clean_rent_data.csv` for historical naming reasons; the project analyzes properties advertised **for sale**, not rental listings.

## Data-Handling Principles

- **Missing Values:** Missing values are preserved when reliable imputation is not possible, including for area fields.
- **Area Measurements:** `Carpet_Area` and `Super_Area` are treated as distinct alternative measurements rather than paired or interchangeable values.
- **Asking Prices:** Prices represent advertised listing/asking prices, not verified transaction prices.
- **Suspicious Prices:** Records flagged by the project’s price-outlier workflow are retained for review rather than automatically dropped or altered. Unusual area values are retained rather than automatically corrected or removed.

## Exports (`exports/`)

The [`exports/`](exports/) folder is reserved for generated CSV summaries and dashboard-preparation outputs. The `.gitignore` rule `data/exports/*.csv` excludes generated CSV files from Git; the folder currently contains only [`.gitkeep`](exports/.gitkeep) in the repository so the directory structure is preserved.
