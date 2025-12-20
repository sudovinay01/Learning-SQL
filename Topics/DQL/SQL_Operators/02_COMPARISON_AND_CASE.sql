/*
DESCRIPTION:
    This script demonstrates the use of basic comparison operators in SQL.
    It includes examples of equality, inequality, greater than, less than,
    greater than or equal to, and less than or equal to.
    It also demonstrates the use of CASE statements for conditional logic.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
----------------- CLEANUP -----------------

-- Create a sample table for demonstration
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2)
);

-- Insert sample data into the Employees table
INSERT INTO Employees
    (id, name, age, salary)
VALUES
    (1, 'Alice', 30, 60000.00),
    (2, 'Bob', 25, 50000.00),
    (3, 'Charlie', 35, 70000.00),
    (4, 'David', 28, 55000.00),
    (5, 'Eve', 40, 80000.00);

-- Select data with comparison operations
SELECT
    id,
    name,
    age,
    salary,
    CASE WHEN age = 30 THEN 'Age is 30' ELSE 'Age is not 30' END AS Equality,
    CASE WHEN salary <> 60000.00 THEN 'Salary is not 60000' ELSE 'Salary is 60000' END AS Inequality,
    CASE WHEN age > 30 THEN 'Older than 30' ELSE '30 or younger' END AS Greater_Than,
    CASE WHEN age < 30 THEN 'Younger than 30' ELSE '30 or older' END AS Less_Than,
    CASE WHEN age >= 35 THEN '35 or older' ELSE 'Younger than 35' END AS Greater_Than_Or_Equal,
    CASE WHEN age <= 28 THEN '28 or younger' ELSE 'Older than 28' END AS Less_Than_Or_Equal
FROM
    Employees;

-- Cleanup the sample table after demonstration
DROP TABLE Employees;