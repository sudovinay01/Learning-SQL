/*
DESCRIPTION:
    This script demonstrates the use of basic arithmetic operators in SQL.
    It includes examples of addition, subtraction, multiplication, and division.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Numbers;
----------------- CLEANUP -----------------

-- Create a sample table for demonstration
CREATE TABLE Numbers
(
    id INT PRIMARY KEY,
    value1 INT,
    value2 INT
);

-- Insert sample data into the Numbers table
INSERT INTO Numbers
    (id, value1, value2)
VALUES
    (1, 10, 3),
    (2, 20, 4),
    (3, 15, 4),
    (4, 8, 2),
    (5, 30, 6),
    (6, 25, 7);

-- Select data with arithmetic operations
SELECT
    id,
    value1,
    value2,
    (value1 + value2) AS Addition,
    (value1 - value2) AS Subtraction,
    (value1 * value2) AS Multiplication,
    (value1 / value2) AS Division,
    (value1 % value2) AS Modulus
FROM
    Numbers;

-- Cleanup the sample table after demonstration
DROP TABLE Numbers;