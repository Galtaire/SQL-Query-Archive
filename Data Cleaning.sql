### 1. Duplicate Marker and Identifier
-- 			Allows you to assign a number to duplicates based on the column selected in the (PARTITION BY ). 
-- 			Unique rows will have 1 and duplicates will have the number 2 or 3. 
-- 			Use CTE to identify which rows are the duplicates 

SELECT *,
ROW_NUMBER() OVER(PARTITION BY column1, column2, etc ) AS Alias
FROM `table_name`;

WITH cte_name AS (
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY column1, column2, etc ) AS "Alias"
	FROM `table_name`)
SELECT  *
FROM `cte_name`
WHERE "Alias" > 1;



### 2. Identify Case-Sensitive Duplicates 
-- 			Identifies Case-sensitive duplicates like Google and google or McDonalds and Mcdonalds

SELECT `column1`, COUNT(*) AS Alias
FROM `table_name`
GROUP BY `column1`
HAVING COUNT(DISTINCT BINARY `column1`) > 1;




### 3. Self-Join to update missing values based on the table itself
-- 			fills missing values using the table itself
-- 			column1 is the priamry matching point of both tables (ex. company)
-- 			column2 is the secondary matching point of both tables (ex. location)
-- 			column 3 is where the NULL values are. 

SELECT *
FROM table1 AS t1
JOIN table1 AS t2
	ON t1.column1 = t2.column1
WHERE t1.column2 = t2.column2 
	AND t1.column3 IS NULL;
    

-- [WHERE t1.column3 IS NULL AND t2.column3 IS NOT NULL;] NULL from t1.column3 will be filled with matches from t2.column3 
-- t1.column3 NULLs
-- t2.column3 NON-NULLS 
-- takes the NON-NULLS, matches [SET] both tables and fills t1.column3 based on present values from t2.column3

UPDATE 2_layoffs t1 
JOIN table1 AS t2
	ON t1.column1 = t2.column1
SET t1.column3 = t2.column3
WHERE t1.column3 IS NULL
	AND t2.column3 IS NOT NULL;









