###########################################################################################################################################################################

#################### 1. For analyzing Geometric Data Values 
-- Returns the raw value and the readable value. Useful when the GeoJSON Data/Geometry Data returns "BLOB"
-- the difference between a Point and a LineString is essentially the difference between a "destination" and a "journey."

    
-- ########## FOR POINT    
SELECT 
    `column1`,
    ST_asText(`column2`) AS readable_location, -- Shows as POINT(long lat)
    ST_AsGeoJSON(`column2`) AS original_json   -- Shows back as JSON
FROM table_name;

-- Returns X and Y Values
SELECT 
    `column1`,
    ST_X(`column2`) AS longitude,
    ST_Y(`column2`) AS latitude
FROM table_name;


-- ########## FOR LINESTRING   
-- you have to tell MySQL which specific dot in that line you want to look at. Think of ST_PointN as a "picker" for line segments.

SELECT ST_PointN(geometry, index)
FROM table_name;    

-- Index: 
--     1 = The starting point
--     2 = The second coordinate
-- ST_PointN(geometry):
--    The very last point (the destination)

-- By wrapping it like this: ST_X(ST_PointN(column_name, 1)), you are saying: "Find the Route LineString." - "Pick the First Point (Point 1)." - "Now, tell me the Longitude (X) of just that one point."

###########################################################################################################################################################################

#################### 2. COALESCE: It goes through a list of values from left to right and stops the moment it finds one that is not empty (NULL).
-- Imagine you are building a contact list for a marketing campaign. You want to reach the customer by any means necessary. 
-- You prefer their Mobile Number, but if they didn't provide one, you'll take their Home Phone. 
-- If they didn't provide that either, you'll just show "No Contact Available."
  
SELECT 
    customer_name,
    COALESCE(mobile_phone, home_phone, 'No Contact Available')
FROM customers;

-- LOGIC: Use Office Phone → If NULL, use Mobile → If NULL, use Home

-- Prevents "Math Crashes": In SQL, 5 + NULL = NULL. By using COALESCE(column, 0), you turn that NULL into a zero so your addition and division actually work.
-- Data Tiering: It allows you to set a hierarchy of backups (e.g., Use Office Phone → If NULL, use Mobile → If NULL, use Home).

-- In a traditional IF-THEN (or CASE statement), you usually check for a specific condition (like Price > 100). 
-- COALESCE is a specialized, high-speed version of that logic that is hard-coded to only check for one thing: "Is this value missing?"
-- Think of it as a Waterfall. Your data "falls" through a series of buckets. If a bucket is empty (NULL), the data keeps falling until it hits a bucket that actually has something in it.

###########################################################################################################################################################################




