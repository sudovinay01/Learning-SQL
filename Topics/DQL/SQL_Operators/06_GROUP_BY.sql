/*
DESCRIPTION:
    This script demonstrates the use of GROUP BY in SQL.
    GROUP BY groups rows with the same values in specified columns.
    Often used with aggregate functions like COUNT, SUM, AVG, MIN, MAX.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Sales;
----------------- CLEANUP -----------------

-- Create a sample Sales table
CREATE TABLE Sales
(
    id INT PRIMARY KEY,
    product VARCHAR(100),
    department VARCHAR(50),
    amount DECIMAL(10, 2),
    sale_date DATE
);

-- Insert sample data into the Sales table
INSERT INTO Sales
    (id, product, department, amount, sale_date)
VALUES
    (1, 'Laptop', 'Electronics', 1200.00, '2025-01-15'),
    (2, 'Mouse', 'Electronics', 25.50, '2025-01-16'),
    (3, 'Desk', 'Furniture', 300.00, '2025-01-17'),
    (4, 'Monitor', 'Electronics', 400.00, '2025-01-18'),
    (5, 'Chair', 'Furniture', 150.00, '2025-01-19'),
    (6, 'Keyboard', 'Electronics', 75.00, '2025-01-20'),
    (7, 'Table', 'Furniture', 250.00, '2025-01-21'),
    (8, 'Lamp', 'Furniture', 80.00, '2025-01-22');

-- 1) Count products by department
SELECT
    department,
    COUNT(*) AS ProductCount
FROM Sales
GROUP BY department;

-- 2) Sum of sales amount by department
SELECT
    department,
    SUM(amount) AS TotalSales
FROM Sales
GROUP BY department;

-- 3) Average sale amount by department
SELECT
    department,
    AVG(amount) AS AverageSale
FROM Sales
GROUP BY department;

-- 4) Multiple aggregations by department
SELECT
    department,
    COUNT(*) AS ProductCount,
    SUM(amount) AS TotalSales,
    AVG(amount) AS AverageSale,
    MIN(amount) AS MinSale,
    MAX(amount) AS MaxSale
FROM Sales
GROUP BY department;

-- 5) Group by multiple columns (department and product)
SELECT
    department,
    product,
    COUNT(*) AS Count,
    SUM(amount) AS TotalAmount
FROM Sales
GROUP BY department, product;

-- Cleanup the sample table after demonstration
DROP TABLE Sales;
