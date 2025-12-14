/* 
DESCRIPTION:
Create database or its objects (table, index, function, views, store procedure and triggers) using CREATE statement
and delete them using DROP statement. 
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
----------------- CLEANUP -----------------

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