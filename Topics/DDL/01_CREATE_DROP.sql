-- drop table if it already exists
DROP TABLE IF EXISTS Employees;

-- CREATE TABLE statement is used to create a new table in a database.
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);


-- show all tables in the current database
SELECT *
FROM INFORMATION_SCHEMA.TABLES AS AFTER_CREATE
WHERE TABLE_NAME = 'Employees';

-- DROP table statement is used to delete a table from a database.
DROP TABLE Employees;

-- verify that the table has been dropped
SELECT *
FROM INFORMATION_SCHEMA.TABLES AS AFTER_DROP
WHERE TABLE_NAME = 'Employees';