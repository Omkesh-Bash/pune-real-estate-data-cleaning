# SQL Analysis Guide

This folder contains PostgreSQL scripts for analyzing the cleaned Pune property-listings dataset. For the project overview and selected findings, see the [root README](../README.md).

## Workflow and execution order

1. Run [`01_initial_setup.sql`](01_initial_setup.sql) to create the `property_listings` table schema.
2. Manually import [`../data/cleaned/clean_rent_data.csv`](../data/cleaned/clean_rent_data.csv) into PostgreSQL using DBeaver.
3. Run the relevant numbered analysis scripts in order:
   - [`02_data_quality_checks.sql`](02_data_quality_checks.sql) checks missing values, area-field completeness, and floor values.
   - [`03_locality_analysis.sql`](03_locality_analysis.sql) summarizes locality prices and areas, checks blank locality values, updates blank locality values to `Prabhat Road` when the title contains `Prabhat Road`, and analyzes selected locality price tiers.
   - [`04_price_tier_analysis.sql`](04_price_tier_analysis.sql) compares counts, percentages, averages, and medians for the project-defined `Budget`, `Mid-Range`, and `Premium` tiers.
   - [`05_outlier_analysis.sql`](05_outlier_analysis.sql) lists and summarizes records where `Price_Outlier_Flag` is `TRUE`.
   - [`06_dashboard_views.sql`](06_dashboard_views.sql) runs dashboard-ready KPI, locality, price-tier, property-type, furnishing, listing-detail, and master-data queries. Despite its filename, it contains `SELECT` queries rather than database `VIEW` definitions.

## Setup assumptions and caveats

- The scripts expect a PostgreSQL table named `property_listings`, created by `01_initial_setup.sql` and populated from the cleaned CSV.
- Column names use quoted mixed-case identifiers such as `"Price_Tier"` and `"Carpet_Area"`, matching the cleaned CSV header.
- Results describe advertised listing/asking prices, not confirmed sale prices or rents.
- `Price_Outlier_Flag` identifies records for review; it does not prove that a value is erroneous or fraudulent.
