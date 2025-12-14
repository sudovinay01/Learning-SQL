/*
DESCRIPTION:
Alter existing database objects using ALTER statement.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
----------------- CLEANUP -----------------

-- Create the Employees table
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age VARCHAR(100)
);

-- Verify the creation of the Employees table
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employees';

-- Alter the Employees table to add a new column 'position'
ALTER TABLE Employees
ADD position VARCHAR(100);
-- Alter the Employees table to drop the 'position' column
ALTER TABLE Employees
DROP COLUMN name;
-- Alter the Employees table to modify the 'age' column data type
ALTER TABLE Employees
ALTER COLUMN age INT;

-- Verify the alterations by querying the INFORMATION_SCHEMA system view
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employees';


-- Clean up by dropping the Employees table
DROP TABLE Employees;