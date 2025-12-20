/*
DESCRIPTION:
    This script demonstrates the use of LIMIT and OFFSET in SQL.
    LIMIT restricts the number of rows returned.
    OFFSET skips a specified number of rows before returning results.
    Note: In SQL Server, OFFSET and FETCH are used instead of LIMIT/OFFSET.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Products;
----------------- CLEANUP -----------------

-- Create a sample Products table
CREATE TABLE Products
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    quantity INT
);

-- Insert sample data into the Products table
INSERT INTO Products
    (id, name, price, quantity)
VALUES
    (1, 'Laptop', 999.99, 10),
    (2, 'Mouse', 25.50, 50),
    (3, 'Keyboard', 75.00, 30),
    (4, 'Monitor', 299.99, 15),
    (5, 'Headphones', 150.00, 25),
    (6, 'Webcam', 89.99, 20),
    (7, 'USB Cable', 9.99, 100),
    (8, 'External HDD', 79.99, 12);

-- 1) Return only the first 3 rows (FETCH FIRST in SQL Server)
SELECT TOP 3
    id,
    name,
    price
FROM Products
ORDER BY id;

-- 2) Skip the first 2 rows and return the next 3 rows (OFFSET...FETCH in SQL Server)
SELECT
    id,
    name,
    price
FROM Products
ORDER BY id
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY;

-- 3) Skip the first 5 rows and return all remaining rows
SELECT
    id,
    name,
    price
FROM Products
ORDER BY id
OFFSET 5 ROWS;

-- 4) Pagination example: Get page 2 with 2 products per page
SELECT
    id,
    name,
    price
FROM Products
ORDER BY id
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;

-- 5) Pagination example: Get page 3 with 2 products per page
SELECT
    id,
    name,
    price
FROM Products
ORDER BY id
OFFSET 4 ROWS
FETCH NEXT 2 ROWS ONLY;

-- Cleanup the sample table after demonstration
DROP TABLE Products;
