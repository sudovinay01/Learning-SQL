/*
DESCRIPTION:
    This script demonstrates commonly used SQL functions in Microsoft SQL Server.
    Functions are categorized as:
    1. String Functions - manipulate text data
    2. Numeric Functions - perform mathematical operations
    3. Date Functions - work with date and time values
    4. Aggregate Functions - summarize data
    5. Conditional Functions - control flow based on conditions
*/

----------------- CLEANUP -----------------
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
----------------- CLEANUP -----------------

-- Create sample tables for demonstration
CREATE TABLE Employees
(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2)
);

CREATE TABLE Products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT
);

CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    emp_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(12, 2)
);

-- Insert sample data
INSERT INTO Employees
    (emp_id, first_name, last_name, email, hire_date, salary)
VALUES
    (1, 'Alice', 'Johnson', 'alice.johnson@example.com', '2020-01-15', 60000),
    (2, 'Bob', 'Smith', 'bob.smith@example.com', '2019-06-20', 75000),
    (3, 'Charlie', 'Williams', 'charlie.williams@example.com', '2021-03-10', 55000),
    (4, 'Diana', 'Brown', 'diana.brown@example.com', '2018-11-05', 80000);

INSERT INTO Products
    (product_id, product_name, price, stock)
VALUES
    (101, '  Laptop Computer  ', 999.99, 10),
    (102, 'USB Mouse', 25.50, 50),
    (103, 'Mechanical Keyboard', 149.99, 25),
    (104, '4K Monitor', 399.99, 8);

INSERT INTO Orders
    (order_id, emp_id, product_id, order_date, quantity, total_amount)
VALUES
    (1001, 1, 101, '2025-01-10', 2, 1999.98),
    (1002, 2, 102, '2025-01-15', 5, 127.50),
    (1003, 3, 103, '2025-01-20', 1, 149.99),
    (1004, 1, 104, '2025-01-25', 1, 399.99),
    (1005, 4, 101, '2025-02-05', 3, 2999.97);

-- =====================================================
-- 1) STRING FUNCTIONS
-- =====================================================

-- CONCAT - combines strings together
SELECT
    emp_id,
    CONCAT(first_name, ' ', last_name) AS FullName,
    CONCAT(first_name, '.', last_name, '@company.com') AS CompanyEmail
FROM Employees;

-- LEN - returns string length
SELECT
    product_name,
    LEN(product_name) AS NameLength
FROM Products;

-- UPPER - converts string to uppercase
SELECT
    emp_id,
    UPPER(first_name) AS FirstNameUpper,
    LOWER(email) AS EmailLower
FROM Employees;

-- LOWER - converts string to lowercase
SELECT
    product_name,
    LOWER(product_name) AS ProductNameLower
FROM Products;

-- SUBSTRING - extracts part of a string
SELECT
    first_name,
    SUBSTRING(first_name, 1, 3) AS FirstThreeLetters,
    SUBSTRING(email, 1, CHARINDEX('@', email) - 1) AS EmailUsername
FROM Employees;

-- TRIM - removes leading and trailing spaces
SELECT
    product_id,
    product_name AS OriginalName,
    TRIM(product_name) AS TrimmedName,
    LEN(product_name) AS OriginalLength,
    LEN(TRIM(product_name)) AS TrimmedLength
FROM Products;

-- REPLACE - replaces text within a string
SELECT
    product_name,
    REPLACE(product_name, 'Computer', 'PC') AS ReplacedName
FROM Products;

-- CHARINDEX - finds position of substring
SELECT
    email,
    CHARINDEX('@', email) AS AtSymbolPosition,
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS Domain
FROM Employees;

-- =====================================================
-- 2) NUMERIC FUNCTIONS
-- =====================================================

-- ABS - absolute value (removes negative sign)
SELECT
    salary,
    ABS(salary - 70000) AS DifferenceFrom70K
FROM Employees;

-- ROUND - rounds a number to specified decimal places
SELECT
    price,
    ROUND(price, 0) AS RoundedToInteger,
    ROUND(price, 1) AS RoundedTo1Decimal
FROM Products;

-- CEILING - rounds up to nearest integer
SELECT
    price,
    CEILING(price) AS CeilingValue
FROM Products;

-- FLOOR - rounds down to nearest integer
SELECT
    price,
    FLOOR(price) AS FloorValue
FROM Products;

-- SQRT - square root
SELECT
    stock,
    SQRT(stock) AS SquareRoot
FROM Products;

-- POWER - raises number to a power
SELECT
    quantity,
    POWER(quantity, 2) AS QuantitySquared
FROM Orders;

-- =====================================================
-- 3) DATE FUNCTIONS
-- =====================================================

-- GETDATE - returns current date and time
SELECT
    GETDATE() AS CurrentDateTime;

-- YEAR, MONTH, DAY - extract parts of date
SELECT
    emp_id,
    hire_date,
    YEAR(hire_date) AS HireYear,
    MONTH(hire_date) AS HireMonth,
    DAY(hire_date) AS HireDay
FROM Employees;

-- DATEDIFF - calculates difference between two dates
SELECT
    emp_id,
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) AS YearsEmployed,
    DATEDIFF(DAY, hire_date, GETDATE()) AS DaysEmployed
FROM Employees;

-- DATEADD - adds a time interval to a date
SELECT
    order_id,
    order_date,
    DATEADD(DAY, 7, order_date) AS DeliveryDate,
    DATEADD(MONTH, 1, order_date) AS OneMonthLater
FROM Orders;

-- EOMONTH - returns last day of the month
SELECT
    GETDATE() AS Today,
    EOMONTH(GETDATE()) AS LastDayOfMonth,
    EOMONTH(GETDATE(), 1) AS LastDayOfNextMonth;

-- =====================================================
-- 4) AGGREGATE FUNCTIONS
-- =====================================================

-- COUNT - counts rows
SELECT
    COUNT(*) AS TotalEmployees,
    COUNT(DISTINCT salary) AS UniqueSalaries
FROM Employees;

-- SUM - totals values
SELECT
    SUM(quantity) AS TotalQuantity,
    SUM(total_amount) AS TotalOrderAmount
FROM Orders;

-- AVG - calculates average
SELECT
    AVG(salary) AS AverageSalary,
    AVG(price) AS AveragePrice
FROM Employees
CROSS JOIN Products;

-- MIN and MAX - finds minimum and maximum
SELECT
    MIN(salary) AS LowestSalary,
    MAX(salary) AS HighestSalary,
    MIN(price) AS CheapestProduct,
    MAX(price) AS MostExpensiveProduct
FROM Employees
CROSS JOIN Products;

-- Aggregate functions with GROUP BY
SELECT
    emp_id,
    COUNT(*) AS NumberOfOrders,
    SUM(total_amount) AS TotalSpent,
    AVG(total_amount) AS AverageOrderAmount
FROM Orders
GROUP BY emp_id;

-- =====================================================
-- 5) CONDITIONAL FUNCTIONS
-- =====================================================

-- CASE - conditional logic
SELECT
    emp_id,
    first_name,
    salary,
    CASE
        WHEN salary >= 75000 THEN 'High'
        WHEN salary >= 60000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;

-- IIF - simpler conditional function (SQL Server)
SELECT
    product_id,
    product_name,
    stock,
    IIF(stock > 10, 'In Stock', 'Low Stock') AS StockStatus
FROM Products;

-- ISNULL - replaces NULL with a specified value
SELECT
    order_id,
    emp_id,
    product_id,
    ISNULL(CAST(total_amount AS VARCHAR), 'No Amount') AS AmountDisplay
FROM Orders;

-- COALESCE - returns first non-NULL value
SELECT
    order_id,
    COALESCE(total_amount, price * quantity, 0) AS FinalAmount
FROM Orders
    LEFT JOIN Products
    ON Orders.product_id = Products.product_id;

-- =====================================================
-- 6) COMPLEX EXAMPLES COMBINING MULTIPLE FUNCTIONS
-- =====================================================

-- Combine string and date functions
SELECT
    emp_id,
    CONCAT(UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2, LEN(first_name)))) AS FormattedName,
    hire_date,
    CONCAT(
        'Employed for ',
        DATEDIFF(YEAR, hire_date, GETDATE()),
        ' years'
    ) AS TenureDescription
FROM Employees;

-- Combine numeric and conditional functions
SELECT
    product_id,
    product_name,
    price,
    CASE
        WHEN price >= 500 THEN ROUND(price * 0.10, 2)
        WHEN price >= 100 THEN ROUND(price * 0.05, 2)
        ELSE ROUND(price * 0.02, 2)
    END AS DiscountAmount,
    CASE
        WHEN price >= 500 THEN ROUND(price * 0.90, 2)
        WHEN price >= 100 THEN ROUND(price * 0.95, 2)
        ELSE ROUND(price * 0.98, 2)
    END AS DiscountedPrice
FROM Products;

-- Combine date and aggregate functions
SELECT
    YEAR(order_date) AS OrderYear,
    MONTH(order_date) AS OrderMonth,
    COUNT(*) AS TotalOrders,
    SUM(total_amount) AS TotalRevenue,
    AVG(total_amount) AS AverageOrderValue
FROM Orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY OrderYear, OrderMonth;

-- Cleanup the sample tables after demonstration
DROP TABLE Orders;
DROP TABLE Products;
DROP TABLE Employees;
