/*
DESCRIPTION:
    This script demonstrates the use of HAVING in SQL.
    HAVING filters groups created by GROUP BY (similar to WHERE but for grouped data).
    WHERE filters individual rows, HAVING filters groups.
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Orders;
----------------- CLEANUP -----------------

-- Create a sample Orders table
CREATE TABLE Orders
(
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    order_amount DECIMAL(10, 2),
    order_date DATE
);

-- Insert sample data into the Orders table
INSERT INTO Orders
    (id, customer_name, product, order_amount, order_date)
VALUES
    (1, 'Alice', 'Laptop', 1200.00, '2025-01-15'),
    (2, 'Alice', 'Mouse', 25.00, '2025-01-16'),
    (3, 'Bob', 'Keyboard', 75.00, '2025-01-17'),
    (4, 'Bob', 'Monitor', 400.00, '2025-01-18'),
    (5, 'Bob', 'Desk', 300.00, '2025-01-19'),
    (6, 'Charlie', 'Chair', 150.00, '2025-01-20'),
    (7, 'Charlie', 'Lamp', 80.00, '2025-01-21');

-- 1) Find customers with more than 2 orders
SELECT
    customer_name,
    COUNT(*) AS OrderCount
FROM Orders
GROUP BY customer_name
HAVING COUNT(*) > 2;

-- 2) Find customer groups with total order amount greater than $500
SELECT
    customer_name,
    COUNT(*) AS OrderCount,
    SUM(order_amount) AS TotalSpent
FROM Orders
GROUP BY customer_name
HAVING SUM(order_amount) > 500;

-- 3) Find products with average order amount greater than $150
SELECT
    product,
    COUNT(*) AS OrderCount,
    AVG(order_amount) AS AverageAmount
FROM Orders
GROUP BY product
HAVING AVG(order_amount) > 150;

-- 4) Combine WHERE and HAVING clauses
-- WHERE filters rows before grouping, HAVING filters groups after grouping
SELECT
    customer_name,
    COUNT(*) AS OrderCount,
    SUM(order_amount) AS TotalSpent
FROM Orders
WHERE order_amount > 50
GROUP BY customer_name
HAVING COUNT(*) > 1;

-- 5) Find customers with maximum order amount greater than $500
SELECT
    customer_name,
    MAX(order_amount) AS MaxOrder
FROM Orders
GROUP BY customer_name
HAVING MAX(order_amount) > 500;

-- Cleanup the sample table after demonstration
DROP TABLE Orders;
