# SQL-Query-Archive

Before running an UPDATE query, it is best practice to run the desired query into a SELECT STATEMENT first. 
So instead of:

UPDATE name
SET name = UPPER(name)
WHERE name LIKE "%Z%";

Run this type of version first:

SELECT name, UPPER(name)
FROM table
WHERE name LIKE "%Z%";


This allows you to first see the outcome before making any permanent changes.


