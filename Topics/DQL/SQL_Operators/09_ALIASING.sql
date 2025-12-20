/*
DESCRIPTION:
    This script demonstrates the use of ALIASING in SQL.
    Aliases provide temporary names for tables or columns.
    Aliases are useful for readability, shortening names, and avoiding ambiguity.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
----------------- CLEANUP -----------------

-- Create sample tables
CREATE TABLE Employees
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT,
    salary DECIMAL(10, 2)
);

CREATE TABLE Departments
(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    location VARCHAR(100)
);

-- Insert sample data
INSERT INTO Employees
    (emp_id, emp_name, dept_id, salary)
VALUES
    (1, 'Alice', 1, 60000),
    (2, 'Bob', 2, 80000),
    (3, 'Charlie', 1, 55000),
    (4, 'David', 3, 70000);

INSERT INTO Departments
    (dept_id, dept_name, location)
VALUES
    (1, 'Sales', 'New York'),
    (2, 'IT', 'San Francisco'),
    (3, 'HR', 'Boston');

-- 1) Column alias with AS keyword
SELECT
    emp_id AS EmployeeID,
    emp_name AS EmployeeName,
    salary AS AnnualSalary
FROM Employees;

-- 2) Column alias without AS keyword
SELECT
    emp_id EmployeeID,
    emp_name EmployeeName,
    salary AnnualSalary
FROM Employees;

-- 3) Alias for calculated columns
SELECT
    emp_id,
    emp_name,
    salary,
    (salary * 0.10) AS Bonus,
    (salary + salary * 0.10) AS TotalCompensation
FROM Employees;

-- 4) Table alias for self-join (comparing data within the same table)
SELECT
    e1.emp_name AS Employee1,
    e2.emp_name AS Employee2,
    e1.salary AS Salary1,
    e2.salary AS Salary2
FROM Employees e1, Employees e2
WHERE e1.emp_id < e2.emp_id
    AND e1.salary = e2.salary;

-- 5) Table alias in JOIN queries
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    d.location
FROM Employees e
    INNER JOIN Departments d
    ON e.dept_id = d.dept_id;

-- 6) Multiple aliases in complex query
SELECT
    e.emp_id AS EmpID,
    e.emp_name AS EmpName,
    d.dept_name AS Department,
    d.location AS Office,
    e.salary AS Salary,
    (e.salary * 1.05) AS NextYearSalary
FROM Employees e
    INNER JOIN Departments d
    ON e.dept_id = d.dept_id
ORDER BY e.salary DESC;

-- Cleanup the sample tables after demonstration
DROP TABLE Employees;
DROP TABLE Departments;
