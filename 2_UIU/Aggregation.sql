--
-- Exercise
--

# 1. Write a query to list the number of jobs available in the employees table.
SELECT COUNT(DISTINCT JOB_ID) from employees;

# 2. Write a query to get the total salaries payable to employees.
SELECT SUM(salary) AS 'Total Salary Payable' from employees

# 3. Write a query to get the minimum salary from employees table.
SELECT MIN(salary) AS 'Minimum Salary' from employees

# 4. Write a query to get the maximum salary of an employee working as a
# Programmer. (Hint: JOIN jobs table)
SELECT e.EMPLOYEE_ID,
       e.FIRST_NAME,
       MAX(e.salary) AS 'Max Programmer Salary'
FROM employees AS e INNER JOIN jobs AS j USING (JOB_ID)
WHERE j.JOB_TITLE = 'Programmer';

# 5. Write a query to get the average salary and number of employees working the department 90.
SELECT AVG(SALARY),
       COUNT(EMPLOYEE_ID)
FROM employees
WHERE DEPARTMENT_ID IN (90);

# 6. Write a query to get the highest, lowest, sum, and average salary of all employees.
SELECT MAX(SALARY),
       MIN(SALARY),
       SUM(SALARY),
       AVG(SALARY)
FROM employees;

# 7. Write a query to get the number of employees with the same job.
SELECT JOB_ID,
       COUNT(EMPLOYEE_ID)
FROM employees GROUP BY JOB_ID;

# 8. Write a query to get the difference between the highest and lowest salaries.
SELECT MAX(SALARY) - MIN(SALARY) AS 'MAX-MIN Difference' FROM employees;

# 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
SELECT MANAGER_ID,
       MIN(SALARY)
FROM employees
WHERE MANAGER_ID <> 0
GROUP BY MANAGER_ID;

# 10. Write a query to get the department ID and the total salary payable in each department.
SELECT DEPARTMENT_ID,
       SUM(SALARY) AS 'TOTAL PAYABLE in the Department'
FROM employees
GROUP BY DEPARTMENT_ID;


--
-- https://www.w3resource.com/mysql-exercises/aggregate-function-exercises/
--



