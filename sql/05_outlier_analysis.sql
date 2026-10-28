-- Inspect the flagged listings
SELECT 
	"Title",
	"Locality",
	"Rate_per_SqFt",
	"Carpet_Area",
	"Super_Area",
	"Price_Outlier_Flag"
FROM 
	property_listings 
WHERE "Price_Outlier_Flag" = TRUE
ORDER BY "Price" DESC 	
;


-- Summarize the flagged listings
SELECT 
	COUNT(*) AS flagged_cnt,
	ROUND(AVG("Price") :: NUMERIC, 2) AS avg_flagged_listing_price,
	MAX("Price")  AS highest_flag_listing_price,
	ROUND(MAX("Rate_per_SqFt") :: NUMERIC, 2) AS highest_flagged_rate_per_sqft
FROM property_listings pl 
WHERE pl."Price_Outlier_Flag" = TRUE ;
