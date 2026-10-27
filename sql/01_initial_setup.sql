--drop table if exists property_listings;

select *
from information_schema."tables" 
where table_schema = 'public'
	and table_type = 'BASE TABLE';


CREATE TABLE property_listings (
    "Title" TEXT,
    "Price" DOUBLE PRECISION,
    "Rate_per_SqFt" DOUBLE PRECISION,
    "Carpet_Area" DOUBLE PRECISION,
    "Status" TEXT,
    "Transaction" TEXT,
    "Furnishing" TEXT,
    "facing" TEXT,
    "Society" TEXT,
    "Ownership" TEXT,
    "Car_Parking" TEXT,
    "Bathroom" BIGINT,
    "Balcony" DOUBLE PRECISION,
    "Super_Area" DOUBLE PRECISION,
    "Under_Construction" TEXT,
    "Floor_Number" DOUBLE PRECISION,
    "Total_Floors" DOUBLE PRECISION,
    "Floor_Label" TEXT,
    "Overlooks_Garden_Park" BOOLEAN,
    "Overlooks_Pool" BOOLEAN,
    "Overlooks_Main_Road" BOOLEAN,
    "BHK" SMALLINT,
    "Property_Type" TEXT,
    "Locality" TEXT,
    "Area_Measurement_Type" TEXT,
    "Price_Per_Cr" DOUBLE PRECISION,
    "Price_Tier" TEXT,
    "Price_Outlier_Flag" BOOLEAN
);

-- Import cleaned csv into this table

select COUNT(*) from property_listings;

