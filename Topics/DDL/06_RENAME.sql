/*
DESCRIPTION:
RENAME database objects (table, index, function, views, store procedure and triggers) using RENAME statement
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees_Old;
DROP TABLE IF EXISTS Employees_New;
----------------- CLEANUP -----------------

-- CREATE TABLE statement is used to create a new table in a database.
CREATE TABLE Employees_Old
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- show all tables in the current database
SELECT *
FROM INFORMATION_SCHEMA.TABLES AS AFTER_CREATE
WHERE TABLE_NAME = 'Employees_Old';


-- RENAME TABLE statement is used to rename an existing table in a database.
EXEC sp_rename 'Employees_Old', 'Employees_New';
-- show all tables in the current database
SELECT *
FROM INFORMATION_SCHEMA.TABLES AS AFTER_RENAME
WHERE TABLE_NAME IN ('Employees_Old', 'Employees_New');


-- DROP table statement is used to delete a table from a database.
DROP TABLE IF EXISTS Employees_New;
-- verify that the table has been dropped
SELECT *
FROM INFORMATION_SCHEMA.TABLES AS AFTER_RENAME
WHERE TABLE_NAME IN ('Employees_Old', 'Employees_New');
