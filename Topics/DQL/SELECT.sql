/*
SELECT statement examples for DQL (Data Query Language)
*/

-- Create Employees table
CREATE TABLE Employees
(
    id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- Insert initial data into Employees table
INSERT INTO Employees
    (id, name, age)
VALUES
    (1, 'Alice', 30),
    (2, 'Bob', 25),
    (3, 'Charlie', 35),
    (4, 'David', 28),
    (5, 'Eve', 22);
