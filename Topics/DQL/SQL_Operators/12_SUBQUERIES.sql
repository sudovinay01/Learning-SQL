/*
DESCRIPTION:
    This script demonstrates the use of SUBQUERIES in SQL.
    Subqueries (also called inner queries) are queries within other queries.
    Can be used in SELECT, FROM, WHERE, and HAVING clauses.
    Types: Scalar subquery, Row subquery, Table subquery, Correlated subquery.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Salaries;
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
    dept_name VARCHAR(100)
);

CREATE TABLE Salaries
(
    salary_id INT PRIMARY KEY,
    emp_id INT,
    salary DECIMAL(10, 2),
    salary_date DATE
);

-- Insert sample data
INSERT INTO Employees
    (emp_id, emp_name, dept_id, salary)
VALUES
    (1, 'Alice', 1, 60000),
    (2, 'Bob', 2, 80000),
    (3, 'Charlie', 1, 55000),
    (4, 'David', 2, 85000),
    (5, 'Eve', 1, 65000);

INSERT INTO Departments
    (dept_id, dept_name)
VALUES
    (1, 'Sales'),
    (2, 'IT');

INSERT INTO Salaries
    (salary_id, emp_id, salary, salary_date)
VALUES
    (1, 1, 60000, '2025-01-01'),
    (2, 2, 80000, '2025-01-01'),
    (3, 1, 62000, '2025-07-01'),
    (4, 2, 82000, '2025-07-01');

-- 1) Subquery in WHERE clause - find employees with salary above average
SELECT
    emp_id,
    emp_name,
    salary
FROM Employees
WHERE salary > (SELECT AVG(salary)
FROM Employees);

-- 2) Subquery in SELECT clause - display average salary with each employee
SELECT
    emp_id,
    emp_name,
    salary,
    (SELECT AVG(salary)
    FROM Employees) AS AverageSalary
FROM Employees;

-- 3) Subquery in FROM clause - create a virtual table
SELECT
    department_id,
    AVG(emp_salary) AS AvgSalary
FROM
    (
        SELECT
        dept_id AS department_id,
        emp_name,
        salary AS emp_salary
    FROM Employees
    ) AS EmployeeSubquery
GROUP BY department_id;

-- 4) Correlated subquery - inner query references outer query
SELECT
    e1.emp_id,
    e1.emp_name,
    e1.salary
FROM Employees e1
WHERE salary > (SELECT AVG(salary)
FROM Employees e2
WHERE e2.dept_id = e1.dept_id);

-- 5) Subquery with IN operator
SELECT
    emp_id,
    emp_name,
    dept_id
FROM Employees
WHERE dept_id IN (SELECT dept_id
FROM Departments
WHERE dept_name = 'IT');

-- 6) Subquery with EXISTS operator
SELECT
    e.emp_id,
    e.emp_name,
    e.salary
FROM Employees e
WHERE EXISTS (SELECT 1
FROM Salaries s
WHERE s.emp_id = e.emp_id);

-- 7) Subquery with NOT EXISTS operator
SELECT
    d.dept_id,
    d.dept_name
FROM Departments d
WHERE NOT EXISTS (SELECT 1
FROM Employees e
WHERE e.dept_id = d.dept_id);

-- 8) Multiple subqueries in WHERE clause
SELECT
    emp_id,
    emp_name,
    salary
FROM Employees
WHERE salary > (SELECT AVG(salary)
    FROM Employees)
    AND dept_id IN (SELECT dept_id
    FROM Departments
    WHERE dept_name IN ('Sales', 'IT'));

-- 9) Subquery with aggregate functions
SELECT
    emp_id,
    emp_name
FROM Employees
WHERE salary = (SELECT MAX(salary)
FROM Employees);

-- 10) Union of subqueries
    SELECT
        emp_name,
        'High Earner' AS Category
    FROM Employees
    WHERE salary > 75000
UNION
    SELECT
        emp_name,
        'Low Earner' AS Category
    FROM Employees
    WHERE salary < 60000;

-- Cleanup the sample tables after demonstration
DROP TABLE Employees;
DROP TABLE Departments;
DROP TABLE Salaries;
