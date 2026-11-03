-- Dashboard KPI Summary --
SELECT 
	COUNT(*) AS total_listings,
	ROUND(AVG("Price") :: NUMERIC, 2) AS average_listing_price,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "Price") AS median_listing_price,
	ROUND(AVG("Rate_per_SqFt") :: NUMERIC, 2) AS average_rate_per_sqft -- auto ignore null
FROM property_listings pl ;

-- Locality-wise dashboard data --
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
ORDER BY 3 DESC
; -- it ignored null carpet area, as some values are in super_area


-- Price-tier dashboard data --
WITH count_per_tier AS (
	SELECT 
		"Price_Tier",
		COUNT(*) AS listing_count
	FROM property_listings
	GROUP BY "Price_Tier"  
) 
SELECT c.*,
	ROUND(
		c.listing_count :: numeric / s.t_cnt * 100, 2	
	)	AS listing_percentage
FROM count_per_tier c 
CROSS JOIN (SELECT COUNT(*) AS t_cnt FROM property_listings ) s
ORDER BY 1
;



-- Property-type dashboard data --
WITH count_per_property_type AS (
	SELECT "Property_Type",
		COUNT(*) AS listing_count
	FROM property_listings pl 
	GROUP BY "Property_Type"
)
SELECT c.*,
	ROUND(
		c.listing_count :: NUMERIC / s.t_cnt * 100, 2 
	) AS listing_percentage
FROM count_per_property_type c
CROSS JOIN (SELECT COUNT(*) AS t_cnt FROM property_listings) s
ORDER BY 2 DESC
;


-- Furnishing distribution --
WITH count_per_furnishing AS (
	SELECT COALESCE("Furnishing", 'Unknown') AS furnishing,
		COUNT(*) AS listing_count
	FROM property_listings pl 
	GROUP BY 1
)
SELECT c.*,
	ROUND(
		c.listing_count :: NUMERIC / s.t_cnt * 100, 2 
	) AS listing_percentage
FROM count_per_furnishing  c
CROSS JOIN (SELECT COUNT(*) AS t_cnt FROM property_listings) s
ORDER BY 2 DESC
;

-- listing-level detail
SELECT 
	"Title" ,
	"Locality",
	"Price" ,
	"BHK",
	"Property_Type" ,
	"Furnishing" ,
	"Area_Measurement_Type",
	"Carpet_Area" ,
	"Super_Area"
FROM property_listings
ORDER BY "Price" DESC;


-- Pune_Real_Estate_Master_Data --
SELECT * FROM property_listings pl ;