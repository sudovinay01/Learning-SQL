/*
DESCRIPTION:
    This script demonstrates the use of DISTINCT in SQL.
    DISTINCT removes duplicate rows from the result set.
    Returns only unique/distinct values.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
----------------- CLEANUP -----------------

-- Create a sample Employees table
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    city VARCHAR(100),
    salary DECIMAL(10, 2)
);

-- Insert sample data into the Employees table
INSERT INTO Employees
    (id, name, department, city, salary)
VALUES
    (1, 'Alice', 'Sales', 'New York', 60000),
    (2, 'Bob', 'IT', 'San Francisco', 80000),
    (3, 'Charlie', 'Sales', 'New York', 55000),
    (4, 'David', 'IT', 'San Francisco', 85000),
    (5, 'Eve', 'HR', 'Boston', 50000),
    (6, 'Frank', 'Sales', 'Boston', 58000),
    (7, 'Grace', 'IT', 'New York', 82000);

-- 1) Get all distinct departments
SELECT DISTINCT
    department
FROM Employees;

-- 2) Get distinct cities where employees work
SELECT DISTINCT
    city
FROM Employees;

-- 3) Get distinct combination of department and city
SELECT DISTINCT
    department,
    city
FROM Employees;

-- 4) Count distinct departments
SELECT
    COUNT(DISTINCT department) AS UniqueDepartments
FROM Employees;

-- 5) Find distinct employees per city
SELECT DISTINCT
    city,
    department
FROM Employees
ORDER BY city, department;

-- 6) Compare with and without DISTINCT
-- Without DISTINCT - shows all rows
SELECT
    department
FROM Employees;

-- With DISTINCT - shows only unique departments
SELECT DISTINCT
    department
FROM Employees;

-- Cleanup the sample table after demonstration
DROP TABLE Employees;
