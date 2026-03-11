######### 1. Duplicate Marker and Identifier
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



######### 2. Identify Case-Sensitive Duplicates 
-- 			Identifies Case-sensitive duplicates like Google and google or McDonalds and Mcdonalds

SELECT `column1`, COUNT(*) AS Alias
FROM `table_name`
GROUP BY `column1`
HAVING COUNT(DISTINCT BINARY `column1`) > 1;




######### 3. Self-Join to update missing values based on the table itself
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



######### 4. Adding a Primary Key + Column to the staging table.
-- Use FIRST after PRIMARY KEY instead of putting the table name. This makes the column as the first column in the table.
-- Note: In this case, no need to put the column name aafter FIRST. This already makes the generated column first. (best for making Primary Keys) 

ALTER TABLE table_name
ADD `column_name` data_type
PRIMARY KEY FIRST;

-- Use the AFTER statement to put the column after an established column 
-- This puts the generated column after the specified column in AFTER. 

ALTER TABLE table_name
ADD `column1_name` data_type
PRIMARY KEY AFTER `column2_name`;



######### 5.  Extracting a substring of a string before a specified number of delimiter occurs.

-- Delimiter: The delimiter to search for (-_/|\:; etc)
-- Number: The number of times to search for the delimiter. Can be both a positive or negative number.
	--  If it is a positive number, this function returns all to the left of the delimiter. If it is a negative number, this function returns all to the right of the delimiter.

SELECT SUBSTRING_INDEX(`string or column_name`, delimiter, number)



