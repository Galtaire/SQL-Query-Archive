##### 1. Locate MySQL Folder Upload Point
-- 		This usually returns C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/

SHOW VARIABLES LIKE "secure_file_priv"; 


##### 2. Importing Data from MySQL Folder
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


