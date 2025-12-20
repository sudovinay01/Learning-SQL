/*
SELECT statement examples for DQL (Data Query Language)
*/
----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
----------------- CLEANUP -----------------

-- Create Employees table
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- Insert initial data into Employees table
INSERT INTO Employees
    (id, name, age)
VALUES
    (1, 'Alice', 30),
    (2, 'Bob', 25),
    (3, 'Charlie', 35),
    (4, 'David', 28),
    (5, 'Eve', 22);


-- 1) Select all columns from Employees
SELECT *
FROM Employees;

-- 2) Select specific columns (name and age) from Employees
SELECT name, age
FROM Employees;

-- 3) Select with WHERE employees older than 28
-- we can use operators like =, <>, >, <, >=, <=, BETWEEN, IN, LIKE, IS NULL to filter results
-- All operators are covered in operators section
SELECT *
FROM Employees
WHERE age > 28;

----------------- CLEANUP -----------------
DROP TABLE Employees;
----------------- CLEANUP -----------------