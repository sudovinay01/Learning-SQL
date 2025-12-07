USE SQL;
SELECT TOP 1 * FROM Employees;
SELECT TOP 1 * FROM Projects;
SELECT TOP 1 * FROM Salaries;
SELECT TOP 1 * FROM Departments;
SELECT TOP 1 * FROM Attendance;
SELECT TOP 1 * FROM EmployeeProjects;
-- 1. List all employees along with their department names.
SELECT Employees.EmpName AS EMP_NAME, Departments.DeptName AS DEPARTMENT
FROM Employees INNER JOIN Departments
ON Employees.DeptID = Departments.DeptID;

-- 2. Find employees who are NOT assigned to any project.
SELECT Employees.EmpID, Employees.EmpName, EmployeeProjects.ProjectID
FROM Employees LEFT JOIN EmployeeProjects
ON Employees.EmpID = EmployeeProjects.EmpID
WHERE EmployeeProjects.ProjectID IS NULL;

-- 3. List all projects with the names of employees working on them.
-- Using multiple Joins
SELECT Projects.ProjectID, Projects.ProjectName, Employees.EmpID, Employees.EmpName, Employees.Gender
FROM EmployeeProjects 
     INNER JOIN Projects ON EmployeeProjects.ProjectID = Projects.ProjectID
     INNER JOIN Employees ON EmployeeProjects.EmpID = Employees.EmpID
ORDER BY Projects.ProjectID;
-- Using CTE
WITH CTE AS (
    SELECT EmployeeProjects.EmpID AS EmpID, Projects.ProjectName AS ProjectName, Projects.ProjectID
    FROM EmployeeProjects INNER JOIN Projects
    ON EmployeeProjects.ProjectID = Projects.ProjectID
)
SELECT CTE.ProjectID AS ProjectID, CTE.ProjectName AS ProjectName, Employees.EmpID AS EmpID, Employees.EmpName AS EmpName, Employees.Gender AS Gender
FROM CTE INNER JOIN Employees
ON CTE.EmpID = Employees.EmpID
ORDER BY ProjectID;

-- 4. Show the total number of employees in each department.
SELECT DeptName, COUNT(Employees.EmpID) AS Total_Employees
FROM Employees INNER JOIN Departments
ON Employees.DeptID = Departments.DeptID
GROUP BY Departments.DeptName;

-- 5. List employees who are assigned to more than 2 projects.
SELECT Employees.EmpName, COUNT(EmployeeProjects.ProjectID) AS Project_Count
FROM EmployeeProjects INNER JOIN Employees
ON EmployeeProjects.EmpID = Employees.EmpID
GROUP BY EmployeeProjects.EmpID, Employees.EmpName
HAVING COUNT(EmployeeProjects.ProjectID) > 2;

-- 6. Find employees whose salary is higher than the Departments average salary.
-- Using Window Functions
WITH CTE AS(
    SELECT *,
    AVG(Employees.Salary) OVER(PARTITION BY Employees.DeptID ORDER BY Employees.DeptID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS AVG_SALARY_DEPT_WISE
    FROM Employees
)
SELECT CTE.EmpName AS EMP_NAME, CTE.DeptID AS DEPT_ID, CTE.Salary AS EMP_SALARY, CTE.AVG_SALARY_DEPT_WISE AS AVG_SALARY_DEPT_WISE
FROM CTE
WHERE CTE.Salary > CTE.AVG_SALARY_DEPT_WISE;
-- Using CTE
WITH CTE AS (
    SELECT DeptID, AVG(Salary) AS AVG_Salary
    FROM Employees
    GROUP BY DeptID
)
SELECT Employees.EmpName AS EMP_NAME, Employees.DeptID AS DEPT,
Employees.Salary AS EMP_SALARY,
CTE.AVG_Salary AS AVG_Dept_Salary
FROM Employees INNER JOIN CTE
ON Employees.DeptID = CTE.DeptID
WHERE Employees.Salary > CTE.AVG_Salary;

-- 7. Retrieve the employee(s) with the highest salary in each department.
-- Using CTE's
WITH CTE1 AS (
    SELECT Employees.DeptID AS DEPT_ID, MAX(Employees.Salary) AS MAX_SALARY
    FROM Employees
    GROUP BY Employees.DeptID
),
CTE2 AS (
    SELECT Employees.EmpName AS Employee_with_max_salary, CTE1.DEPT_ID AS DEPT, CTE1.MAX_SALARY AS MAX_SALARY
    FROM CTE1 INNER JOIN Employees
    ON CTE1.DEPT_ID = Employees.DeptID
    WHERE Employees.Salary = CTE1.MAX_SALARY
)
SELECT CTE2.Employee_with_max_salary AS EMPLOYEE_WITH_MAX_SALARY, Departments.DeptName AS DEPARTMENT, CTE2.MAX_SALARY AS EMPLOYEE_MAX_SALARY
FROM CTE2 INNER JOIN Departments
ON CTE2.DEPT = Departments.DeptID
ORDER BY CTE2.MAX_SALARY DESC;

-- 8. List projects that have more employees assigned than the average employee count across all projects.
WITH CTE1 AS (
    SELECT EmployeeProjects.ProjectID AS PROJECT, COUNT(EmployeeProjects.EmpID) AS NUMBER_OF_EMPS
    FROM EmployeeProjects
    GROUP BY EmployeeProjects.ProjectID
),
CTE2 AS (
    SELECT PROJECT,
    NUMBER_OF_EMPS,
    AVG(NUMBER_OF_EMPS) OVER(ORDER BY PROJECT ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS AVG_EMP_COUNT
    FROM CTE1
)
SELECT CTE2.PROJECT AS PROJECT_ID, Projects.ProjectName AS PROJECT_NAME, CTE2.NUMBER_OF_EMPS AS TOTAL_EMPS, CTE2.AVG_EMP_COUNT AS ALL_PROJECTS_AVG_EMP_COUNT
FROM CTE2 INNER JOIN Projects
ON CTE2.PROJECT = Projects.ProjectID
WHERE CTE2.NUMBER_OF_EMPS > CTE2.AVG_EMP_COUNT;

-- 9. Show employees who were hired before the earliest project start date.
-- Using CTE's
WITH CTE1 AS (
    SELECT Employees.EmpID, Employees.EmpName, EmployeeProjects.ProjectID, Employees.HireDate
    FROM Employees INNER JOIN EmployeeProjects
    ON Employees.EmpID = EmployeeProjects.EmpID
)
SELECT CTE1.EmpID, CTE1.EmpName, CTE1.ProjectID, CTE1.HireDate, Projects.ProjectName, Projects.StartDate
FROM CTE1 INNER JOIN Projects
ON CTE1.ProjectID = Projects.ProjectID
WHERE CTE1.HireDate < Projects.StartDate;
-- Combining multiple tables using joins
SELECT Employees.EmpID, Employees.EmpName, EmployeeProjects.ProjectID, Employees.HireDate, Projects.ProjectName, Projects.StartDate
FROM EmployeeProjects 
INNER JOIN Employees ON EmployeeProjects.EmpID = Employees.EmpID
INNER JOIN Projects ON EmployeeProjects.ProjectID = Projects.ProjectID
WHERE Employees.HireDate < Projects.StartDate;

-- 10. Display employees earning more than the average salary of their own department.
SELECT TOP 1 * FROM Employees;
-- USING WINDOW FUNCTIONS
WITH CTE AS (
    SELECT *,
    AVG(Salary) OVER(PARTITION BY DeptID ORDER BY DeptID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS DEPT_AVG_SALARY
    FROM Employees
)
SELECT EmpID, EmpName, Salary, DEPT_AVG_SALARY
FROM CTE
WHERE Salary > DEPT_AVG_SALARY;
-- Without using window functions
WITH CTE AS (
    SELECT DeptID, AVG(Salary) AS DEPT_WISE_AVG_SALARY
    FROM Employees
    GROUP BY DeptID
)
SELECT Employees.EmpID, Employees.EmpName, Employees.Salary, CTE.DEPT_WISE_AVG_SALARY
FROM CTE INNER JOIN Employees
ON CTE.DeptID = Employees.DeptID
WHERE Employees.Salary > CTE.DEPT_WISE_AVG_SALARY;
-- 11. Use a CTE to find the second-highest salary in the company.
-- USING CTE
WITH CTE AS (
    SELECT MAX(Salary) AS MAX_SALARY
    FROM Employees
)
SELECT * 
FROM Employees
WHERE Employees.Salary IN (
    SELECT MAX(Salary) AS SECOND_HIGHEST_SALARY
    FROM Employees
    WHERE Employees.Salary < (SELECT MAX_SALARY FROM CTE)
);
-- USING WINDOW FUNCTIONS AND CTE
WITH CTE AS (
    SELECT *,
    DENSE_RANK() OVER(ORDER BY Employees.Salary DESC) AS SALARY_ORDER
    FROM Employees
)
SELECT *
FROM CTE WHERE SALARY_ORDER = 2; 
-- 12. Using a recursive CTE, generate the last 10 calendar dates.
WITH CTE AS(
    SELECT CAST(GETDATE() AS DATE) AS DT
    UNION ALL
    SELECT DATEADD(DAY, -1, DT)
    FROM CTE
    WHERE DT > DATEADD(DAY, -9, CAST(GETDATE() AS DATE))
)
SELECT *
FROM CTE;
-- 13. Use a CTE to find employee count per department and show only departments having more than 5 employees.
WITH CTE AS (
    SELECT DeptID, COUNT(EmpID) AS EMP_COUNT
    FROM Employees
    GROUP BY DeptID
    HAVING COUNT(EmpID) > 5
)
SELECT Departments.DeptName, CTE.EMP_COUNT
FROM CTE INNER JOIN Departments
ON CTE.DeptID = Departments.DeptID;
-- 14. Rank employees by salary within each department (using window functions).
SELECT *,
DENSE_RANK() OVER(PARTITION BY Employees.DeptID ORDER BY Employees.SALARY DESC) AS SALARY_WISE_RANK
FROM Employees;

-- 15. Show the running total of salary for each employee across months (using Salaries table).
SELECT *,
SUM(Salaries.Amount) OVER(PARTITION BY Salaries.EmpID ORDER BY Salaries.EmpID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RUNNING_TOTAL
FROM Salaries;

-- 16. Find the difference between current month salary and previous month salary for each employee (using LAG function).
SELECT *,
(AMOUNT - LAG(Amount, 1) OVER(PARTITION BY EmpID ORDER BY SalaryMonth)) AS DIFF_CUR_PREV_SALARY
FROM Salaries;
SELECT *,
(AMOUNT - LEAD(Amount, 1) OVER(PARTITION BY EmpID ORDER BY SalaryMonth DESC)) AS DIFF_CUR_PREV_SALARY
FROM Salaries;

-- 17. List the top 3 highest-paid employees in the entire company.
WITH CTE AS (
    SELECT *,
    RANK() OVER(ORDER BY SALARY DESC) AS SALARY_WISE_RANK
    FROM Employees
)
SELECT *
FROM CTE WHERE SALARY_WISE_RANK < 4;

-- 18. For each department, show max salary, min salary, and average salary using window functions.
-- USING WINDOW FUNCTIONS
SELECT *,
MAX(Salary) OVER(PARTITION BY DeptID ORDER BY (SELECT 0)) AS MAX_SALARY_DEPT,
MIN(Salary) OVER(PARTITION BY DeptID ORDER BY (SELECT 0)) AS MIN_SALARY_DEPT,
AVG(Salary) OVER(PARTITION BY DeptID ORDER BY (SELECT 0)) AS AVG_SALARY_DEPT
FROM Employees;
-- WITHOUT USING WINDOW FUNCTIONS
SELECT DeptID,
MAX(Salary) AS MAX_SALARY_DEPT,
MIN(Salary) AS MIN_SALARY_DEPT,
AVG(Salary) AS AVG_SALARY_DEPT
FROM Employees
GROUP BY DeptID;

-- 19. Count how many days each employee was present in the last 30 days (using Attendance table).
-- This is by taking employe's last present date as the reference point
WITH CTE AS (
    SELECT EmpID, MAX(AttendDate) AS LATEST_DATE
    FROM Attendance
    GROUP BY EmpID
)
SELECT Attendance.EmpID, COUNT(Attendance.EmpID) AS PRESENT_COUNT
FROM Attendance INNER JOIN CTE
ON Attendance.EmpID = CTE.EmpID
WHERE AttendDate <= CTE.LATEST_DATE AND AttendDate >= DATEADD(DAY, -30, CTE.LATEST_DATE) AND Status = 'Present'
GROUP BY Attendance.EmpID;
-- This is by considering last 30 days from current date
SELECT Attendance.EmpID, COUNT(Attendance.EmpID) AS PRESENT_COUNT
FROM Attendance
WHERE AttendDate >= GETDATE() - 30 AND Status = 'Present'
GROUP BY Attendance.EmpID;

-- 20. List employees who have never taken leave (Status = 'Leave').
-- USING JOINS
SELECT Employees.EmpID
FROM Employees LEFT JOIN Attendance
ON Employees.EmpID = Attendance.EmpID
AND Attendance.Status = 'Leave'
WHERE Attendance.EmpID IS NULL;

-- ANOTHER WAY
SELECT EmpID
FROM Attendance
GROUP BY EmpID
HAVING SUM(CASE WHEN Status = 'Leave' THEN 1 ELSE 0 END) = 0;

-- 21. Find the month that had the highest total salary payout (using Salaries table).
WITH CTE AS (
    SELECT DATENAME(MONTH, SalaryMonth) AS MONTH, SUM(Amount) AS TOTAL_PAY
    FROM Salaries
    GROUP BY DATENAME(MONTH, SalaryMonth)
)
SELECT *
FROM CTE
WHERE CTE.TOTAL_PAY = (
    SELECT MAX(TOTAL_PAY) AS HIGHEST_TOTAL_PAY
    FROM CTE
);
-- USING WINDOW FUNCTIONS
WITH CTE AS (
    SELECT DATENAME(MONTH, Salaries.SalaryMonth) AS MONTH,
    SUM(Salaries.Amount) OVER(PARTITION BY DATENAME(MONTH, Salaries.SalaryMonth) ORDER BY (SELECT 0)) AS TOTAL_PAY_MONTH_WISE
    FROM Salaries
)
SELECT TOP 1 *
FROM CTE
WHERE CTE.TOTAL_PAY_MONTH_WISE = (
    SELECT MAX(TOTAL_PAY_MONTH_WISE) FROM CTE
);
-- 22. Find employees who are assigned to a project that started before their hire date.
-- JOINING MULTIPLE TABLES
SELECT Employees.EmpID, Employees.EmpName, Employees.HireDate, Projects.ProjectName, Projects.StartDate
FROM EmployeeProjects 
INNER JOIN Employees ON EmployeeProjects.EmpID = Employees.EmpID
INNER JOIN Projects ON EmployeeProjects.ProjectID = Projects.ProjectID
WHERE Employees.HireDate > Projects.StartDate;

-- 23. Identify the project that has the highest number of assigned employees.
WITH CTE AS (
    SELECT ProjectID, COUNT(EmpID) AS TOTAL_EMP_FOR_PROJECT
    FROM EmployeeProjects
    GROUP BY ProjectID
)
SELECT Projects.ProjectName, CTE.TOTAL_EMP_FOR_PROJECT
FROM CTE INNER JOIN Projects
ON CTE.ProjectID = Projects.ProjectID
WHERE CTE.TOTAL_EMP_FOR_PROJECT = (
    SELECT MAX(TOTAL_EMP_FOR_PROJECT)
    FROM CTE
);

-- 24. Find employees who work on all the projects that their department employees are part of.

-- 25. Categorize employees into salary groups (Low < 40000, Medium 40000–60000, High > 60000) and count employees in each group.
WITH CTE AS (
    SELECT EmpID, EmpName, Salary,
           CASE WHEN Salary < 40000 THEN 'LOW'
                WHEN Salary > 60000 THEN 'HIGH'
                ELSE 'MEDIUM'
                END AS SALARY_CATEGORY
    FROM Employees
)
SELECT CTE.SALARY_CATEGORY, COUNT(CTE.EmpID) AS NO_OF_EMPLOYEES_WITHIN_CATEGORY
FROM CTE
GROUP BY CTE.SALARY_CATEGORY
ORDER BY NO_OF_EMPLOYEES_WITHIN_CATEGORY;