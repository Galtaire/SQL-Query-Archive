
########## 1. For analyzing Geometric Data Values 
SELECT 
    `column1`,
    ST_asText(`column2`) AS readable_location, -- Shows as POINT(long lat)
    ST_AsGeoJSON(`column2`) AS original_json   -- Shows back as JSON
FROM table_name;


SELECT 
    `column1`,
    ST_X(`column2`) AS longitude,
    ST_Y(`column2`) AS latitude
FROM table_name;