############### 1. Locate MySQL Folder Upload Point
-- 		This usually returns C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/

SHOW VARIABLES LIKE "secure_file_priv"; 





############### 2. Importing Data from MySQL Folder
-- 		CHARACTER SET utf8mb4 = Enables special Characters like Ñ/ñ. 
-- 		IGNORE 1 ROWS = Ignores 1 row (assumed as the Title Headers) when importing Data
-- 		'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/file_name' = Folder Path for file

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/file_name'
INTO TABLE `table_name`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(column1, column2, column3, etc);





############### 3. To figure out if your file uses Windows (\r\n) or Unix (\n) line endings. Run this on Powershell 
--> "Unix (LF)" - Change your SQL script to use: LINES TERMINATED BY '\n'
--> "Windows (CRLF)" - Keep your SQL script as:  LINES TERMINATED BY '\r\n'
  
Get-Content "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\csv_file.csv" -Raw | ForEach-Object { if ($_ -match "\r\n") { "Windows (CRLF)" } else { "Unix (LF)" } }
-- Change "csv_file.csv" to the name of the csv file or add the folder directory then the file name with the extension.
-- Do not forget the file extension (.csv)





############### 4. Importing CSV Data with GeoJSON/Geometric values like longitudes and latitudes 
-- Example: CSV Column has this value for longitude/latitude =      '{"type": "Point", "coordinates": [20.520641, 44.638223]}'
-- The value is GeoJSON
  
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/file_name' 
INTO TABLE `table_name` 
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' -- "Optionally" is key for mixed text/JSON
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS 
(column1, column2, @temp_column3) -- "@temp_" Loads the GeoJSON string into a variable first
SET `port_location` = ST_GeomFromGeoJSON(@temp_port_location);





############### 4. Importing CSV Data (ignoring extra columns
-- CSV has 5 columns while your MySQL table has 6. This ignores that extra column
  
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/file_name' 
INTO TABLE `your_table`
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' -- "Optionally" is key for mixed text/JSON
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(col_from_csv_1, col_from_csv_2, col_from_csv_3) -- These match the file
SET 
  id = NULL,              -- Generates Auto-Increment. This column is not in CSV. Adding this makes the column ignored in the Import Phase




############### 4. Creating an exact copy of a table
-- Faster than using with INSERT INTO
-- Useful for Staging 
  
CREATE TABLE `new_table_name` AS
SELECT * FROM `table_to_copy`;




############### 5. Assigning Primary and Foreign Keys 

-- Primary Key:
ALTER TABLE table_name
MODIFY COLUMN `column1` INT AUTO_INCREMENT,
ADD PRIMARY KEY (`column1`);

-- Foreign Key: 
ALTER TABLE table_name1
ADD CONSTRAINT constraint_name
    FOREIGN KEY (`fk_column`) REFERENCES table_name2 (`column1`)
    ON DELETE SET NULL ON UPDATE CASCADE,

-- Primary + Foreign Key: 

ALTER TABLE table_name1
MODIFY COLUMN `column1` INT AUTO_INCREMENT,
ADD PRIMARY KEY (`column1`),
  
ADD CONSTRAINT constraint_name
FOREIGN KEY (`fk_column`) REFERENCES table_name2 (column1)
ON DELETE SET NULL ON UPDATE CASCADE,

-- ON DELETE RESTRICT ON UPDATE CASCADE 
  -- ON DELETE updates the Foreign Key table when the Primary key table is updated (e.g. deleted a row or change an ID Number)
  -- ON UPDATE CASCADE automatically updates the Foreign Key Table when an update is given to the primary key table. 




############### 6. Importing data without getting error 
-- Getting an error where data from CSV is present but MySQL shows otherwise
-- This LOAD DATA INFILE query can fix that
-- This makes the column with the error imported as a variable

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/file_name'
INTO TABLE `table_name`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  `column1`
  `column2`,
  @variable1, -- Variable for numeric handling
  `column4`
  `column5`
  @variable2, -- Variable for datetime handling
  )
SET   `column3` = NULLIF(@variable1, ''), -- Convert empty strings to NULL for Numbers/Dates
      `column4` = NULLIF(@variable2, ''); -- Convert empty strings to NULL for Numbers/Dates

























