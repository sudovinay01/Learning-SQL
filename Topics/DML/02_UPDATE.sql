/*
DESCRIPTION:
UPDATE existing records in a table using UPDATE statement.
Note: WHERE clause is used to specify which records to update. If omitted, all records will be updated.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
----------------- CLEANUP -----------------

-- CREATE TABLE statement is used to create a new table in a database.
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
-- INSERT INTO statement is used to insert new records into the Employees table.
INSERT INTO Employees
VALUES
    (1, 'Alice', 30),
    (2, 'Bob', 25),
    (3, 'Charlie', 28);

-- SELECT statement is used to retrieve records from the Employees table.
SELECT *
FROM Employees;

-- 1) UPDATE statement is used to modify existing records in a table.
-- Update the age of the employee with id = 2
-- we can use operators like =, <>, >, <, >=, <=, BETWEEN, IN, LIKE, IS NULL to conditionally update records.
-- All operators are covered in operators section
UPDATE Employees
SET age = 26
WHERE id = 2;
-- SELECT statement is used to retrieve records from the Employees table to verify the update.
SELECT *
FROM Employees;

-- 2) UPDATE statement with multiple column updates.
-- Update the name and age of the employee with id = 3
UPDATE Employees
SET name = 'Charles', age = 29
WHERE id = 3;
-- SELECT statement is used to retrieve records from the Employees table to verify the update.
SELECT *
FROM Employees;

-- CLEANDUP: Drop the Employees table after the demonstration.
----------------- CLEANUP -----------------
DROP TABLE Employees;
----------------- CLEANUP -----------------