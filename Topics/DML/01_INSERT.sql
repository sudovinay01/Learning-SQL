/*
DESCRIPTION:
INSERT new records into a table using INSERT statement.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS employees_backup;
----------------- CLEANUP -----------------

-- CREATE TABLE statement is used to create a new table in a database.
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- INSERT INTO statement is used to insert new records with all column values specified.
INSERT INTO Employees
VALUES
    (1, 'Alice', 30);

-- SELECT statement is used to retrieve records from a table.
SELECT *
FROM Employees;

-- INSERT INTO statement is used to insert new records with specific column values.
INSERT INTO Employees
    (id, name)
VALUES
    (2, 'Bob');

-- SELECT statement is used to retrieve records from a table.
SELECT *
FROM Employees;

-- INSERT MULTIPLE ROWS using a single INSERT statement.
INSERT INTO Employees
VALUES
    (3, 'Charlie', 25),
    (4, 'Diana', 28);

-- SELECT statement is used to retrieve records from a table.
SELECT *
FROM Employees;


-- INSERT INTO ... SELECT statement is used to insert records from another table.
-- create another table for demonstration
CREATE TABLE employees_backup
(
    id_unique INT PRIMARY KEY,
    name_full VARCHAR(100),
    age_number INT
);

-- INSERT INTO ... SELECT statement is used to insert records from another table.
INSERT INTO employees_backup
SELECT *
FROM employees;

-- SELECT statement is used to retrieve records from the backup table.
SELECT *
FROM employees_backup;

-- TRUNCATE TABLE statement is used to remove all records from a table.
TRUNCATE TABLE employees_backup;

-- INSERT SPECIFIC COLUMNS from Employees table into employees_backup table.
INSERT INTO employees_backup
    (id_unique, name_full)
SELECT id, name
FROM Employees;
-- SELECT statement is used to retrieve records from the backup table.
SELECT *
FROM employees_backup;

-- TRUNCATE TABLE statement is used to remove all records from a table.
TRUNCATE TABLE employees_backup;

-- INSERT based on a condition from Employees table into employees_backup table.
INSERT INTO employees_backup
    (id_unique, name_full, age_number)
SELECT id, name, age
FROM Employees
WHERE age > 27;

-- SELECT statement is used to retrieve records from the backup table.
SELECT *
FROM employees_backup;

-- Clean up by dropping the created tables
DROP TABLE employees_backup;
DROP TABLE Employees;