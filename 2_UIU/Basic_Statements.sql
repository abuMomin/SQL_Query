--
-- Problem 1.a
--

-- 1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"
SELECT employees.FIRST_NAME AS 'First Name', employees.LAST_NAME AS 'Last Name' FROM employees;

-- 2. Write a query to get unique department ID from employee table.
SELECT employees.DEPARTMENT_ID FROM employees GROUP BY DEPARTMENT_ID;

-- 3. Write a query to get all employee details from the employee table order by first name, descending.
SELECT * FROM employees ORDER BY employees.FIRST_NAME DESC;

-- 4. Write a query to get the full name (first_name + “ “ + last_name), salary, PF of all the employees (PF is calculated as 15% of salary).
SELECT CONCAT_WS(' ', employees.FIRST_NAME, employees.LAST_NAME) AS 'Full Name', SALARY, 
((SALARY*15)/100) AS 'PF' FROM employees;


--
-- Problem 1.b
--

-- 1. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary.
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'FULL NAME', SALARY 
FROM employees ORDER BY SALARY ASC;

-- 2. Write a query to select first 10 records of employee.
SELECT * FROM employees LIMIT 10;

-- 3. Write a query to select the highest paid employee.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'Highest Paid Employee', MAX(SALARY) 
AS SALARY FROM employees;  

SELECT * FROM employees WHERE SALARY IN (SELECT MAX(SALARY) FROM employees); -- using subquery


-- 4. Write a query to select the second lowest paid employee.
SELECT * from employees ORDER BY SALARY ASC LIMIT 1,1;


--
-- Problem 2.a
--

-- 1. Write a query get all first name from employees table in upper case.
SELECT UPPER(FIRST_NAME) FROM employees;

-- 2. Write a query to get the length of the employee full name (first_name, last_name) from employees table.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS 'Full Name', 
CHAR_LENGTH(CONCAT(FIRST_NAME, ' ', LAST_NAME)) AS Length FROM employees;

-- 3. Write a query to get the first 3 characters of first name from employees table.
SELECT LEFT(FIRST_NAME, 3) AS 'First_Name 3 letters' FROM employees;

-- 4. Write a query to first name from employees who’s name starts with ‘B’.
SELECT FIRST_NAME FROM employees WHERE LEFT(FIRST_NAME, 1) = 'B';



--
-- Problem 2.b
--

-- 1. Write a query to first name from employees who’s name starts with a vowel.
SELECT FIRST_NAME FROM employees WHERE LEFT(FIRST_NAME, 1) IN ('A', 'E', 'I', 'O', 'U');

-- 2. Write a query to get the first name from employees table where the length of the first name is less than 5.
SELECT FIRST_NAME FROM employees WHERE CHAR_LENGTH(FIRST_NAME) < 5;

-- 3. Write a query to get the first name from employees table where the first name has the keyword ‘on’ in it.
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%on%';

-- 4. Write a query to get monthly salary (round 2 decimal places) of every employee
SELECT ROUND((SALARY + (SALARY*COMMISSION_PCT)), 2) AS 'Annual Salary With Commission', 
ROUND((SALARY + (SALARY*COMMISSION_PCT))/12, 2) AS 'Monthly Salary With Commission' 
FROM employees ORDER BY FIRST_NAME;


