-- How many property listings fall into each price tier, and what is the average, median price within each tier? --

SELECT 
	"Price_Tier" ,
	COUNT("Price") AS listing_count,
	ROUND(
		AVG("Price") :: NUMERIC, 2 
	) AS avg_price,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "Price") AS median_price
FROM property_listings 
GROUP BY "Price_Tier" 
ORDER BY "Price_Tier";

-- calculate the percentage of all listings belonging to each price tier.

WITH count_per_tier AS (
	SELECT 
		"Price_Tier",
		COUNT(*) AS count_per_tier
	FROM property_listings
	GROUP BY "Price_Tier"  
) 
SELECT c.*,
	ROUND(
		c.count_per_tier :: numeric / s.t_cnt * 100, 2	
	)	AS listing_percentage
FROM count_per_tier c 
CROSS JOIN (SELECT COUNT(*) AS t_cnt FROM property_listings ) s


;