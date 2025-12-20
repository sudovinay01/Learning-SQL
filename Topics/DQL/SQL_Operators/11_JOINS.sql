/*
DESCRIPTION:
    This script demonstrates different types of JOINs in SQL.
    JOINs combine rows from two or more tables based on related columns.
    Types: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, CROSS JOIN.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Projects;
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

CREATE TABLE Projects
(
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    emp_id INT,
    budget DECIMAL(12, 2)
);

-- Insert sample data
INSERT INTO Employees
    (emp_id, emp_name, dept_id, salary)
VALUES
    (1, 'Alice', 1, 60000),
    (2, 'Bob', 2, 80000),
    (3, 'Charlie', 1, 55000),
    (4, 'David', 3, 70000),
    (5, 'Eve', NULL, 65000);

INSERT INTO Departments
    (dept_id, dept_name, location)
VALUES
    (1, 'Sales', 'New York'),
    (2, 'IT', 'San Francisco'),
    (3, 'HR', 'Boston'),
    (4, 'Finance', 'Chicago');

INSERT INTO Projects
    (project_id, project_name, emp_id, budget)
VALUES
    (101, 'Website Redesign', 2, 50000),
    (102, 'Mobile App', 1, 75000),
    (103, 'Database Upgrade', 2, 100000),
    (104, 'Training Program', 4, 25000),
    (105, 'Cloud Migration', 6, 150000);

-- 1) INNER JOIN - returns only matching rows from both tables
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    d.location
FROM Employees e
    INNER JOIN Departments d
    ON e.dept_id = d.dept_id;

-- 2) LEFT JOIN - returns all rows from left table, matching rows from right table
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    d.location
FROM Employees e
    LEFT JOIN Departments d
    ON e.dept_id = d.dept_id;

-- 3) RIGHT JOIN - returns all rows from right table, matching rows from left table
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    d.location
FROM Employees e
    RIGHT JOIN Departments d
    ON e.dept_id = d.dept_id;

-- 4) FULL OUTER JOIN - returns all rows from both tables
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    d.location
FROM Employees e
    FULL OUTER JOIN Departments d
    ON e.dept_id = d.dept_id;

-- 5) CROSS JOIN - returns cartesian product of both tables
SELECT
    e.emp_name,
    d.dept_name
FROM Employees e
CROSS JOIN Departments d;

-- 6) Multiple JOINs - joining three or more tables
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    p.project_name,
    p.budget
FROM Employees e
    INNER JOIN Departments d
    ON e.dept_id = d.dept_id
    LEFT JOIN Projects p
    ON e.emp_id = p.emp_id;

-- 7) Self JOIN - joining table with itself
SELECT
    e1.emp_name AS Employee,
    e2.emp_name AS Colleague
FROM Employees e1
    INNER JOIN Employees e2
    ON e1.dept_id = e2.dept_id
        AND e1.emp_id < e2.emp_id;

-- 8) JOIN with WHERE clause
SELECT
    e.emp_name,
    d.dept_name,
    e.salary
FROM Employees e
    INNER JOIN Departments d
    ON e.dept_id = d.dept_id
WHERE e.salary > 60000
ORDER BY e.salary DESC;

-- Cleanup the sample tables after demonstration
DROP TABLE Employees;
DROP TABLE Departments;
DROP TABLE Projects;
