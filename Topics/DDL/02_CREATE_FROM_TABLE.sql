-- CLEAN UP
DROP TABLE IF EXISTS employees_backup;
DROP TABLE IF EXISTS employees;

-- create table employees
CREATE TABLE employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);

-- create a new table named 'employees_backup' by copying the structure and data from the existing 'employees' table
SELECT id AS id_employees_backup, name AS name_employees_backup, salary AS salary_employees_backup
INTO employees_backup
FROM employees;

-- Verify the creation of the new table
SELECT *
FROM employees;
SELECT *
FROM employees_backup;

-- Drop the backup table after verification
DROP TABLE employees_backup;
-- Clean up by dropping the original employees table
DROP TABLE employees;
