/*
DESCRIPTION:
DELETE existing records from a table using DELETE statement.
Note: WHERE clause is used to specify which records to delete. If omitted, all records will be deleted.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
----------------- CLEANUP -----------------

-- Create the Employees table
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
-- Insert sample data into the Employees table
INSERT INTO Employees
    (id, name, age)
VALUES
    (1, 'Alice', 30),
    (2, 'Bob', 25),
    (3, 'Charlie', 35);
-- Verify the inserted data
SELECT *
FROM Employees;

-- 1) DELETE statement is used to delete specific records from a table.
-- Delete the employee with id = 2 (Bob)
-- we can use operators like =, <>, >, <, >=, <=, BETWEEN, IN, LIKE, IS NULL to conditionally delete records.
-- All operators are covered in operators section
DELETE FROM Employees
WHERE id = 2;
-- Verify the remaining records after deletion
SELECT *
FROM Employees;

-- 2) DELETE statement without WHERE clause deletes all records from the table.
-- Delete all remaining employees
DELETE FROM Employees;
-- Verify that the table is now empty
SELECT *
FROM Employees;

-- Cleanup: Drop the Employees table
DROP TABLE Employees;