/*
DESCRIPTION:
MERGE statement is used to perform insert, update, or delete operations on a target table based on the results of a join with a source table.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS EmployeeUpdated;
----------------- CLEANUP -----------------

-- Create target table
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
-- Create source table
CREATE TABLE EmployeeUpdated
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);
-- Insert initial data into target table
INSERT INTO Employees
    (id, name, age)
VALUES
    (1, 'Alice', 30),
    (2, 'Bob', 25),
    (3, 'Charlie', 35);
-- Insert data into source table
INSERT INTO EmployeeUpdated
    (id, name, age)
VALUES
    -- This record will be updated
    (2, 'Bob', 26),
    -- This record will remain unchanged
    (3, 'Charlie', 35),
    -- This record will be inserted
    (4, 'David', 28);

-- Verify initial data in Employees table
SELECT *
FROM Employees;
-- Verify initial data in EmployeeUpdated table
SELECT *
FROM EmployeeUpdated;

-- 1) MERGE statement to synchronize Employees table with EmployeeUpdated table
MERGE INTO Employees AS TARGET
    USING EmployeeUpdated AS SOURCE

    -- a) Match records based on id, When records match, update the target table
    ON TARGET.id = SOURCE.id
    WHEN MATCHED
        AND (TARGET.age <> SOURCE.age) OR (TARGET.name <> SOURCE.name)
    THEN UPDATE SET
            TARGET.name = SOURCE.name,
            TARGET.age = SOURCE.age
    
    -- b) When records do not match, insert new records into the target table
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (id, name, age)
            VALUES (SOURCE.id, SOURCE.name, SOURCE.age)

    -- c) When records in target table do not match source table, delete them
    WHEN NOT MATCHED BY SOURCE
    THEN DELETE;

-- Verify final data in Employees table after MERGE operation
SELECT *
FROM Employees;

-- Cleanup: Drop the tables after the operations
DROP TABLE Employees;
DROP TABLE EmployeeUpdated;