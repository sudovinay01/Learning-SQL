/*
DESCRIPTION:
    This script demonstrates the use of ORDER BY in SQL.
    ORDER BY sorts the result set by one or more columns.
    Can sort in ascending (ASC) or descending (DESC) order.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Students;
----------------- CLEANUP -----------------

-- Create a sample Students table
CREATE TABLE Students
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    score INT,
    department VARCHAR(50)
);

-- Insert sample data into the Students table
INSERT INTO Students
    (id, name, score, department)
VALUES
    (1, 'Alice', 85, 'Science'),
    (2, 'Bob', 92, 'Mathematics'),
    (3, 'Charlie', 78, 'Science'),
    (4, 'David', 88, 'English'),
    (5, 'Eve', 95, 'Mathematics'),
    (6, 'Frank', 81, 'Science');

-- 1) Sort by name in ascending order (default)
SELECT
    id,
    name,
    score,
    department
FROM Students
ORDER BY name;

-- 2) Sort by score in descending order (highest scores first)
SELECT
    id,
    name,
    score,
    department
FROM Students
ORDER BY score DESC;

-- 3) Sort by department in ascending, then by score in descending order
SELECT
    id,
    name,
    score,
    department
FROM Students
ORDER BY department ASC, score DESC;

-- 4) Sort by multiple columns
SELECT
    id,
    name,
    score,
    department
FROM Students
ORDER BY department, score DESC;

-- 5) Sort by column position (column 2 = name)
SELECT
    id,
    name,
    score,
    department
FROM Students
ORDER BY 2;

-- 6) Sort by calculated expression
SELECT
    id,
    name,
    score,
    (100 - score) AS PointsNeeded
FROM Students
ORDER BY (100 - score);

-- Cleanup the sample table after demonstration
DROP TABLE Students;
