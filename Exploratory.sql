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

