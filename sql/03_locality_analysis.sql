-- Compare average property prices by locality --
SELECT
	"Locality",
	ROUND(
		AVG("Price") :: NUMERIC, 2
	) AS avg_price,
	COUNT("Price") AS listing_count
FROM property_listings
GROUP BY "Locality"
ORDER BY "Locality";

SELECT COUNT(*)
FROM property_listings
WHERE "Locality" IS NULL;

SELECT COUNT(*)
FROM property_listings
WHERE TRIM("Locality") = '';

SELECT "Title", "Locality", "Price"
FROM property_listings
WHERE TRIM("Locality") = '';

-- TO:DO Solve this problem in notebooks/Pune_Real_Estate_Data_Cleaning.ipynb

UPDATE property_listings
SET "Locality" = 'Prabhat Road'
WHERE TRIM("Locality") = ''
  AND "Title" ILIKE '%Prabhat Road%';


-- Compare average property prices by locality --
SELECT
	"Locality",
	ROUND(
		AVG("Price") :: NUMERIC, 2
	) AS avg_price,
	COUNT("Price") AS listing_count
FROM property_listings
GROUP BY "Locality"
ORDER BY 2;

-- Median price by locality --
-- Why Median? -> As this Data contains some unusually high values. Which will pull avg values upward by extreme prices.

SELECT 
	"Locality",
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "Price") AS  median_price,
	ROUND(
		AVG("Price") :: NUMERIC, 2
	) AS avg_price,
	COUNT("Price") AS listing_count
FROM 
	property_listings
GROUP BY "Locality"
ORDER BY 2 DESC;


-- Price-tier analysis --
SELECT
	"Locality",
	COUNT(*) AS listing_count,
	ROUND(
		AVG("Price") :: NUMERIC, 2
	) AS avg_price,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "Price") AS median_price,
	ROUND(
		AVG("Carpet_Area" ) :: NUMERIC, 2
	) AS avg_carpet_area
FROM property_listings
GROUP BY "Locality"
; -- it ignored null carpet area, as some values are in super_area
