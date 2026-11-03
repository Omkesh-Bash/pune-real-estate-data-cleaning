# Pune Real Estate Analytics Dashboard

A focused analytics project on advertised property listings for sale in Pune. It uses Python and pandas to clean and enrich listing data, PostgreSQL and SQL to investigate pricing and listing characteristics, and Looker Studio to present the results interactively.

## Dashboard

The Looker Studio dashboard is available here: **[Open the Pune Real Estate Analytics Dashboard](https://datastudio.google.com/reporting/05a8e70b-1d24-484e-b707-717e11fc982d)**

Access may depend on the dashboard’s sharing settings.

## Problem and objective

The project asks: **What patterns appear in the collected Pune property listings when they are grouped by asking-price tier, locality, property type, and BHK?**

The analysis is intended to make the collected listings easier to inspect and compare. It does not represent every property in Pune and does not measure completed transactions.

## Dataset

- **Source:** [Pune Real Estate Listings Dataset on Kaggle](https://www.kaggle.com/datasets/shubham001official/pune-real-estate-listings-dataset)
- **Raw file:** [`data/raw/scrapped_data.csv`](data/raw/scrapped_data.csv)
- **Cleaned file:** [`data/cleaned/clean_rent_data.csv`](data/cleaned/clean_rent_data.csv)
- **Final master data:** 927 rows and 28 columns in the cleaned CSV currently stored in the repository.
- The raw file contains 930 collected records and 18 source fields. Three exact duplicate rows were removed during cleaning, leaving 927 records for analysis.
- Prices are advertised listing/asking prices, not verified sale prices. The cleaned filename includes `rent` for historical reasons; this project analyzes properties advertised **for sale**, not rental listings.

The cleaned data includes source fields such as `Price`, `Rate_per_SqFt`, `Carpet_Area`, `Super_Area`, `BHK`, `Property_Type`, and `Locality`, along with engineered fields for floor details, views, price tiers, and outlier flags. The notebook contains an earlier intermediate 21-column cleaned-data checkpoint; the current 28-column CSV and its header are the repository output used by the SQL schema.

## Workflow

1. **Python / pandas:** audit the raw CSV, clean strings and numeric values, handle duplicate records, preserve meaningful missing values, and engineer analysis-ready fields.
2. **PostgreSQL:** load the cleaned master data into the `property_listings` table defined in [`sql/01_initial_setup.sql`](sql/01_initial_setup.sql).
3. **SQL analysis:** run data-quality, locality, price-tier, outlier, and dashboard-preparation queries in the [`sql/`](sql/) directory.
4. **Dashboard preparation:** use the resulting summaries and listing-level data in Looker Studio for interactive exploration.

## Cleaning and feature engineering

The cleaning work in [`notebooks/Pune_Real_Estate_Data_Cleaning.ipynb`](notebooks/Pune_Real_Estate_Data_Cleaning.ipynb) includes:

- removing three exact duplicate rows from the 930-row raw extract;
- converting formatted price and area values into numeric fields where they can be interpreted reliably;
- extracting `Floor_Number`, `Total_Floors`, and `Floor_Label` from the source floor text;
- deriving `BHK`, `Property_Type`, `Locality`, and `Area_Measurement_Type` for analysis;
- splitting the source overlooking field into Boolean indicators such as `Overlooks_Garden_Park`, `Overlooks_Pool`, and `Overlooks_Main_Road`;
- deriving `Price_Per_Cr`, `Price_Tier`, and `Price_Outlier_Flag`; and
- preserving missing values when a reliable inference was not possible.

`Carpet_Area` and `Super_Area` are treated as alternative area measurements, not paired or interchangeable measures. Suspicious values are flagged for review rather than silently corrected or removed. The notebook also drops `Dimensions` because it is mostly missing and is not consistently interpretable.

## SQL analysis

The SQL work is organized as follows:

- [`01_initial_setup.sql`](sql/01_initial_setup.sql) — creates `property_listings` and checks the loaded row count.
- [`02_data_quality_checks.sql`](sql/02_data_quality_checks.sql) — checks missing area values, area completeness, and floor values.
- [`03_locality_analysis.sql`](sql/03_locality_analysis.sql) — summarizes localities, missing locality values, prices, areas, and selected locality price tiers.
- [`04_price_tier_analysis.sql`](sql/04_price_tier_analysis.sql) — compares listing counts and price statistics across `Budget`, `Mid-Range`, and `Premium` tiers.
- [`05_outlier_analysis.sql`](sql/05_outlier_analysis.sql) — inspects listings flagged by `Price_Outlier_Flag`.
- [`06_dashboard_views.sql`](sql/06_dashboard_views.sql) — prepares listing-level and grouped outputs for dashboard use.

## Key insights

The following observations come from the 927 records and the outputs documented in the project’s working analysis notes. They describe this collected dataset, not the Pune market as a whole.

- **Premium listings dominate the collected records:** 624 of 927 listings (67.31%) are in the project-defined `Premium` tier, compared with 240 (25.89%) in `Mid-Range` and 63 (6.80%) in `Budget`.
- **Premium listings have a higher average than median asking price:** across 624 Premium listings, the average listing price is about **₹2.28 crore** and the median is **₹1.715 crore**. For comparison, the average is about **₹77.25 lakh** across 240 Mid-Range listings and **₹35.89 lakh** across 63 Budget listings. These are descriptive listing-price statistics, not property valuations or sale prices.
- **Three listings were flagged for price investigation:** the flagged records have an average asking price of about **₹13.97 crore**, with the highest at **₹16.38 crore**. One Kharadi record has a reported rate of **₹1,50,000 per sq. ft.** The flags identify records for review; they do not prove that the listings are errors.
- **Area fields have substantial and different missingness:** all 927 records have a price, while 843 (90.94%) lack `Carpet_Area` and 84 (9.06%) lack `Super_Area`. The project’s area check found no records with both `Carpet_Area` and `Super_Area` populated or both missing. `Rate_per_SqFt` is missing for 107 listings (11.54%).
- **Tathawade Pimpri Chinchwad is Premium-heavy in this extract:** 9 of 16 listings (56.25%) are Premium, 6 (37.50%) are Mid-Range, and 1 (6.25%) is Budget. The small sample means this is only a description of the 16 collected listings.

## Dashboard contents

The prepared dashboard data supports KPI cards, filters and grouped charts for price tiers, property types, furnishing, and localities, plus a listing-detail table with fields such as title, locality, price, BHK, property type, furnishing, measurement type, and area values. The exact visible layout should be checked in Looker Studio because the dashboard itself is not stored in this repository.

Two source listings have the same values across the fields shown in the dashboard detail table, so the table groups them together. They are not exact duplicates across the full master dataset. The Record Count reflects the grouped listings.

## Technology

- Python
- pandas and NumPy
- Jupyter Notebook
- PostgreSQL
- SQL
- DBeaver
- Google Sheets
- Looker Studio
- Git and GitHub

## Repository structure

```text
.
├── data/
│   ├── cleaned/
│   │   └── clean_rent_data.csv
│   └── raw/
│       └── scrapped_data.csv
├── notebooks/
│   └── Pune_Real_Estate_Data_Cleaning.ipynb
├── sql/
│   ├── 01_initial_setup.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_locality_analysis.sql
│   ├── 04_price_tier_analysis.sql
│   ├── 05_outlier_analysis.sql
│   └── 06_dashboard_views.sql
└── README.md
```

## How to explore or reproduce

1. Open the cleaning notebook and review or run its cells in Jupyter to follow the audit, cleaning, and feature-engineering decisions.
2. Use the cleaned CSV at [`data/cleaned/clean_rent_data.csv`](data/cleaned/clean_rent_data.csv) as the input for PostgreSQL.
3. In PostgreSQL or DBeaver, create the `property_listings` table with [`01_initial_setup.sql`](sql/01_initial_setup.sql), then manually import the cleaned CSV into that table.
4. Run the remaining SQL scripts in numerical order to reproduce the quality checks, analyses, and dashboard-ready outputs.

The repository does not contain an automated import pipeline, database credentials, or Looker Studio configuration, so the database load and dashboard connection require manual setup.

## Limitations

- Listings contain asking prices, not confirmed transaction prices.
- The collected records are not a statistically representative sample of all Pune properties.
- Sample sizes vary substantially by locality, property category, and price tier; small groups should not be generalized.
- Missing values are preserved where values could not be reliably inferred, especially for area-related fields.
- `Carpet_Area` and `Super_Area` use different measurement concepts and should not be compared as interchangeable values.
- `Price_Outlier_Flag` identifies suspicious records for review; it does not confirm that a record is erroneous.
