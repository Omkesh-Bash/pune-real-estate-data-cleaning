select * from property_listings;

--Check total records
select COUNT(*) 
from property_listings;

-- Check missing values
SELECT 
	SUM(case when "Price" is null then 1 else 0 END) AS missing_price, 
	SUM(case when "Super_Area"  is null then 1 else 0 END) AS missing_super_area,
	SUM(case when "Carpet_Area"  is null then 1 else 0 END) AS missing_carpet_area,
	SUM(case when "Rate_per_SqFt"  is null then 1 else 0 END) AS missing_rate_per_sqft
FROM 
	property_listings;

-- Check area completeness
select 
    SUM(
        case 
            when  ("Carpet_Area" IS NOT NULL
             and "Super_Area" IS NOT null )
             or 
             ("Carpet_Area" IS NULL
             and "Super_Area" IS NULL)
            THEN 1
            ELSE 0
        END
    ) AS invalid_area_rows
FROM property_listings;


-- Check duplicate listings-- Check duplicate listings
SELECT
    "Title",
    "Price",
    "Society",
    "Floor_Number",
    "Rate_per_SqFt",
    "Car_Parking",
    COUNT(*) AS occurrences
FROM property_listings
GROUP BY
    "Title",
    "Price",
    "Society",
    "Floor_Number",
    "Rate_per_SqFt",
    "Car_Parking"
HAVING COUNT(*) > 1;