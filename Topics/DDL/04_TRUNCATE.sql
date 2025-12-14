/*
DESCRIPTION:
Remove all records from a table using TRUNCATE statement.
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

-- 1) TRUNCATE statement is used to remove all records from a table quickly.
TRUNCATE TABLE Employees;
-- Verify that the Employees table is empty after truncation
SELECT *
FROM Employees;


-- Clean up by dropping the Employees table
DROP TABLE Employees;