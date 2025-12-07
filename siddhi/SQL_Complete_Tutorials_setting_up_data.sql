-- Create database SQL only if it doesn't exist
IF NOT EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = 'SQL'
)
BEGIN
    CREATE DATABASE SQL;
END;
GO
-- Use the created database
USE SQL;
GO

-- 1. Departments table
-- Stores the list of all company departments so employees can be grouped based on where they work.
CREATE TABLE Departments (
    DeptID INT IDENTITY(1,1) PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);

-- 2. Employees
-- Stores employee details such as name, department, salary, and hire date.
CREATE TABLE Employees (
    EmpID INT IDENTITY(1,1) PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    DeptID INT NOT NULL,
    HireDate DATE NOT NULL,
    Gender CHAR(1),
    Salary INT NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- 3. Projects
-- Contains information about all projects running in the company, including start and end dates.
CREATE TABLE Projects (
    ProjectID INT IDENTITY(1,1) PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL
);


-- 4. EmployeeProjects
-- Acts as a bridge table that connects employees to the projects they are assigned to (many-to-many relationship).
CREATE TABLE EmployeeProjects (
    EmpID INT NOT NULL,
    ProjectID INT NOT NULL,
    AssignedDate DATE NOT NULL,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);


-- 5. Salaries
-- Stores month-wise salary payment records for each employee to analyze salary trends over time.
CREATE TABLE Salaries (
    SalaryID INT IDENTITY(1,1) PRIMARY KEY,
    EmpID INT NOT NULL,
    SalaryMonth DATE NOT NULL,
    Amount INT NOT NULL,
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- 6. Attendance
-- Keeps daily attendance status (Present/Absent/Leave) for each employee to track their workdays.
CREATE TABLE Attendance (
    AttendID INT IDENTITY(1,1) PRIMARY KEY,
    EmpID INT NOT NULL,
    AttendDate DATE NOT NULL,
    Status VARCHAR(10) CHECK (Status IN ('Present','Absent','Leave')),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- Insert data into above created tables
-- Insert 5 departments
INSERT INTO Departments (DeptName)
VALUES ('IT'), ('HR'), ('Finance'), ('Marketing'), ('Operations');

-- Insert 50 employees
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Employees (EmpName, DeptID, HireDate, Gender, Salary)
    VALUES (
        CONCAT('Employee ', @i),
        (ABS(CHECKSUM(NEWID())) % 5) + 1,                      -- Dept 1–5
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 2000, GETDATE()), -- Random hire date (5 yrs)
        CASE WHEN @i % 2 = 0 THEN 'M' ELSE 'F' END,            -- Alternate genders
        (ABS(CHECKSUM(NEWID())) % 50000) + 30000               -- Salary 30k–80k
    );

    SET @i += 1;
END;

-- Insert 10 projects
INSERT INTO Projects (ProjectName, StartDate, EndDate)
VALUES
('AI System', '2022-01-10', NULL),
('Mobile App', '2021-05-20', NULL),
('Billing Platform', '2020-03-15', '2023-08-10'),
('HR Portal', '2019-02-28', NULL),
('Chatbot System', '2023-04-01', NULL),
('Web Redesign', '2022-06-15', '2024-01-12'),
('Cloud Migration', '2020-09-01', NULL),
('E-Commerce System', '2021-11-10', NULL),
('Data Warehouse', '2019-06-20', NULL),
('Payment Gateway', '2022-03-27', NULL);

-- Map 80 employee project assignments
DECLARE @x INT = 1;

WHILE @x <= 80
BEGIN
    DECLARE @emp INT = (ABS(CHECKSUM(NEWID())) % 50) + 1;
    DECLARE @proj INT = (ABS(CHECKSUM(NEWID())) % 10) + 1;

    IF NOT EXISTS (
        SELECT 1 
        FROM EmployeeProjects 
        WHERE EmpID = @emp AND ProjectID = @proj
    )
    BEGIN
        INSERT INTO EmployeeProjects (EmpID, ProjectID, AssignedDate)
        VALUES (
            @emp,
            @proj,
            DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 1000, GETDATE())
        );

        SET @x = @x + 1;   -- only increment when insert succeeds
    END
END;

-- Insert 200 monthly salary rows
DECLARE @m INT = 1;
WHILE @m <= 200
BEGIN
    INSERT INTO Salaries (EmpID, SalaryMonth, Amount)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 50) + 1,                      -- emp 1–50
        DATEADD(MONTH, -ABS(CHECKSUM(NEWID())) % 36, GETDATE()), -- last 3 years
        (ABS(CHECKSUM(NEWID())) % 50000) + 30000
    );

    SET @m += 1;
END;

-- Insert 300 attendance rows
DECLARE @a INT = 1;
WHILE @a <= 300
BEGIN
    INSERT INTO Attendance (EmpID, AttendDate, Status)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 50) + 1,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
        CASE 
            WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN 'Present'
            WHEN ABS(CHECKSUM(NEWID())) % 3 = 1 THEN 'Absent'
            ELSE 'Leave'
        END
    );

    SET @a += 1;
END;

---