/*
DESCRIPTION:
    This script demonstrates the use of logical operators in SQL.
    It includes examples of AND, OR, and NOT operators to combine
    multiple conditions in SQL queries.
*/
----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
----------------- CLEANUP -----------------

-- Create a sample table for demonstration
CREATE TABLE Products
(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT
);

-- Insert sample data into the Products table
INSERT INTO Products
    (id, name, category, price, stock)
VALUES
    (1, 'Laptop', 'Electronics', 1200.00, 10),
    (2, 'Smartphone', 'Electronics', 800.00, 0),
    (3, 'Desk Chair', 'Furniture', 150.00, 5),
    (4, 'Notebook', 'Stationery', 5.00, 100),
    (5, 'Pen', 'Stationery', 2.00, 200);

-- ============================================================================
-- Setup for EXISTS, IN, and subquery-based operators
-- ============================================================================
CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);

INSERT INTO Orders
    (order_id, product_id, quantity)
VALUES
    (101, 1, 2),
    (102, 3, 1),
    (103, 1, 3);

-- ============================================================================
-- 1. ALL OPERATOR
-- ============================================================================
-- TRUE if all of a set of comparisons are TRUE.
-- Example: Find products with price greater than ALL prices of Stationery items
SELECT *
FROM Products
WHERE price > ALL (SELECT price
FROM Products
WHERE category = 'Stationery');

-- ============================================================================
-- 2. AND OPERATOR
-- ============================================================================
-- Returns TRUE if both Boolean expressions are TRUE.
-- Example: Find all products in Electronics category with price > 500
SELECT *
FROM Products
WHERE category = 'Electronics' AND price > 500;

-- ============================================================================
-- 3. ANY OPERATOR
-- ============================================================================
-- TRUE if any one of a set of comparisons are TRUE.
-- Example: Find products with price equal to ANY price in Electronics category
SELECT *
FROM Products
WHERE price = ANY (SELECT price
FROM Products
WHERE category = 'Electronics');

-- Example: Products with price > ANY (greater than at least one) Stationery price
SELECT *
FROM Products
WHERE price > ANY (SELECT price
FROM Products
WHERE category = 'Stationery');

-- ============================================================================
-- 4. BETWEEN OPERATOR
-- ============================================================================
-- TRUE if the operand is within a range.
-- Example: Find products with price between 50 and 800
SELECT *
FROM Products
WHERE price BETWEEN 50 AND 800;

-- Example: Find products with price NOT between 100 and 500
SELECT *
FROM Products
WHERE price NOT BETWEEN 100 AND 500;

-- ============================================================================
-- 5. EXISTS OPERATOR
-- ============================================================================
-- TRUE if a subquery contains any rows.
-- Example: Find products that have at least one order
SELECT *
FROM Products p
WHERE EXISTS (SELECT 1
FROM Orders o
WHERE o.product_id = p.id);

-- Example: Find products that have NOT been ordered
SELECT *
FROM Products p
WHERE NOT EXISTS (SELECT 1
FROM Orders o
WHERE o.product_id = p.id);

-- ============================================================================
-- 6. IN OPERATOR
-- ============================================================================
-- TRUE if the operand is equal to one of a list of expressions.
-- Example: Find products in specific categories (Electronics or Furniture)
SELECT *
FROM Products
WHERE category IN ('Electronics', 'Furniture');

-- Example: Find products with specific ids
SELECT *
FROM Products
WHERE id IN (1, 3, 5);

-- Example: NOT IN operator
SELECT *
FROM Products
WHERE category NOT IN ('Stationery');

-- Example: IN with Subquery - Products that have been ordered
SELECT *
FROM Products
WHERE id IN (SELECT DISTINCT product_id
FROM Orders);

-- ============================================================================
-- 7. LIKE OPERATOR
-- ============================================================================
-- TRUE if the operand matches a pattern.
-- Example: Find products whose name starts with 'L'
SELECT *
FROM Products
WHERE name LIKE 'L%';

-- Example: Find products with 'e' in their name
SELECT *
FROM Products
WHERE name LIKE '%e%';

-- Example: NOT LIKE operator
SELECT *
FROM Products
WHERE name NOT LIKE 'S%';

-- ============================================================================
-- 8. NOT OPERATOR
-- ============================================================================
-- Reverses the value of any other Boolean operator.
-- Example: Find products that are NOT in Electronics category
SELECT *
FROM Products
WHERE NOT category = 'Electronics';
-- or equivalently: WHERE category != 'Electronics'

-- ============================================================================
-- 9. OR OPERATOR
-- ============================================================================
-- Returns TRUE if either Boolean expression is TRUE.
-- Example: Find products that are either in Stationery or have price < 100
SELECT *
FROM Products
WHERE category = 'Stationery' OR price < 100;

-- ============================================================================
-- 10. SOME OPERATOR
-- ============================================================================
-- TRUE if some of a set of comparisons are TRUE.
-- SOME is a synonym for ANY in SQL Server
-- Example: Find products with stock < SOME stock values
SELECT *
FROM Products p
WHERE stock < SOME (SELECT stock
FROM Products
WHERE id != p.id);

-- ============================================================================
-- COMBINATION OF LOGICAL OPERATORS
-- ============================================================================
-- Example: Complex query combining multiple operators
SELECT *
FROM Products
WHERE (category IN ('Electronics', 'Furniture') OR price < 10)
    AND stock > 0
    AND name NOT LIKE 'Smart%';

-- ============================================================================
-- CLEANUP
-- ============================================================================
DROP TABLE Products;
DROP TABLE Orders;
