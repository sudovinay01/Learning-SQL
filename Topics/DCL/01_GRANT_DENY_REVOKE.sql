/*
DESCRIPTION:
    This script demonstrates Data Control Language (DCL) in SQL Server.
    DCL statements are used to control access to database objects.
    Main DCL commands: GRANT, DENY, REVOKE
    
    This script creates a test user, grants permissions, and cleans up at the end.
    Requires admin privileges to execute.
*/

-- =====================================================
-- 0) CLEANUP - Check and remove user if exists
-- =====================================================

-- Drop user if already exists
IF EXISTS (SELECT 1
FROM sys.database_principals
WHERE name = 'demo_user')
    BEGIN
    DROP USER demo_user;
END;

-- Drop login if already exists
IF EXISTS (SELECT 1
FROM sys.sql_logins
WHERE name = 'demo_user')
    BEGIN
    DROP LOGIN demo_user;
END;

-- =====================================================
-- SETUP - Create test user and table
-- =====================================================

-- Create a login for the new user
CREATE LOGIN demo_user WITH PASSWORD = 'DemoPass123!';

-- Create a database user from the login
CREATE USER demo_user FOR LOGIN demo_user;

-- Create a test table for demonstration
CREATE TABLE EmployeeAccess
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    email VARCHAR(100)
);

-- Insert sample data
INSERT INTO EmployeeAccess
    (emp_id, emp_name, department, salary, email)
VALUES
    (1, 'Alice Johnson', 'Sales', 60000, 'alice@company.com'),
    (2, 'Bob Smith', 'IT', 75000, 'bob@company.com'),
    (3, 'Charlie Brown', 'HR', 55000, 'charlie@company.com'),
    (4, 'Diana White', 'Finance', 80000, 'diana@company.com');

-- =====================================================
-- 1) GRANT - Grants permissions to users or roles
-- =====================================================

-- Grant SELECT permission on a table to the test user
GRANT SELECT ON dbo.EmployeeAccess TO demo_user;

-- Grant INSERT permission
GRANT INSERT ON dbo.EmployeeAccess TO demo_user;

-- Grant UPDATE permission
GRANT UPDATE ON dbo.EmployeeAccess TO demo_user;

-- =====================================================
-- 2) DENY - Explicitly denies permissions
-- =====================================================

-- Deny DELETE permission (takes precedence over GRANT)
DENY DELETE ON dbo.EmployeeAccess TO demo_user;

-- =====================================================
-- 3) REVOKE - Removes previously granted or denied permissions
-- =====================================================

-- Revoke UPDATE permission
REVOKE UPDATE ON dbo.EmployeeAccess FROM demo_user;

-- =====================================================
-- 4) VIEW CURRENT PERMISSIONS
-- =====================================================

-- Check what permissions demo_user has on the table
SELECT *
FROM fn_my_permissions('dbo.EmployeeAccess', 'OBJECT');

-- =====================================================
-- 5) CLEANUP - Remove user and login
-- =====================================================

DROP USER demo_user;
DROP LOGIN demo_user;
DROP TABLE EmployeeAccess;
