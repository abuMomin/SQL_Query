--
-- Problem & Solution: https://www.w3resource.com/mysql-exercises/join-exercises/
--


-- 1. Write a MySQL query to find the addresses (location_id, street_address,
-- city, state_province, country_name) of all the departments.
SELECT d.DEPARTMENT_ID,
       d.DEPARTMENT_NAME,
       l.LOCATION_ID,
       l.STREET_ADDRESS,
       l.CITY,
       l.STATE_PROVINCE,
       c.COUNTRY_ID,
       c.COUNTRY_NAME
from departments d
         INNER JOIN locations l USING (LOCATION_ID)
         INNER JOIN countries c USING (COUNTRY_ID);

-- 2. Write a MySQL query to find the name (first_name, last name), 
-- department ID and name of all the employees.
SELECT e.FIRST_NAME,
       e.LAST_NAME,
       d.DEPARTMENT_ID,
       d.DEPARTMENT_NAME
FROM employees AS e
         INNER JOIN departments AS d USING (DEPARTMENT_ID);

--3. Write a MySQL query to find the name (first_name, last_name), job, department ID and name of the employees
-- who works in London.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS 'Full Name', j.JOB_TITLE,
       d.DEPARTMENT_ID,
       d.DEPARTMENT_NAME,
       l.CITY
FROM employees AS e
         INNER JOIN departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
         INNER JOIN jobs AS j ON e.JOB_ID = j.JOB_ID
         INNER JOIN locations AS l ON d.LOCATION_ID = l.LOCATION_ID
WHERE l.CITY = 'London';

-- 4. Write a MySQL query to find the employee id, name (last_name) along with their manager_id and name (last_name).
SELECT e.EMPLOYEE_ID,
       e.LAST_NAME AS 'Employee Name', e.MANAGER_ID,
       m.LAST_NAME AS 'Manager Name'
FROM employees AS e
         LEFT JOIN employees AS m ON e.MANAGER_ID = m.EMPLOYEE_ID;

-- 5. Write a MySQL query to find the name (first_name, last_name) and hire date of the employees
-- who was hired after 'Jones'.
SELECT FIRST_NAME,
       LAST_NAME,
       HIRE_DATE
FROM employees
WHERE HIRE_DATE >
      (SELECT HIRE_DATE
       FROM employees
       WHERE LAST_NAME = 'Jones' OR FIRST_NAME = 'Jones'
       );

-- 6. Write a MySQL query to get the department name and number of employees in the department.
SELECT d.DEPARTMENT_NAME,
       COUNT(*) AS 'No of Employee'
FROM employees e
    INNER JOIN departments d ON e.DEPARTMENT_ID  = d.DEPARTMENT_ID
GROUP BY e.DEPARTMENT_ID ;

-- 7. Write a MySQL query to find the employee ID, job title, number of days between ending date
-- and starting date for all jobs in department 90.
SELECT jh.EMPLOYEE_ID,
       j.JOB_TITLE,
       (DATE(jh.END_DATE) - DATE(jh.START_DATE)) AS 'No of Employment Days'
FROM job_history AS jh
         INNER JOIN jobs AS j USING (JOB_ID)
WHERE jh.DEPARTMENT_ID = 90;

-- 8. Write a MySQL query to display the department ID and name and first name of manager.
SELECT d.DEPARTMENT_ID,
       d.DEPARTMENT_NAME,
       e.FIRST_NAME AS 'Manager First_Name'
FROM departments d
         INNER JOIN employees e ON d.MANAGER_ID = e.EMPLOYEE_ID;

-- 9. Write a MySQL query to display the department name, manager name, and city.
SELECT d.DEPARTMENT_NAME,
       CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS 'Manager Name',
        l.CITY
FROM departments d
         INNER JOIN employees e ON d.MANAGER_ID = e.EMPLOYEE_ID
         INNER JOIN locations l USING (LOCATION_ID);

-- 10. Write a MySQL query to display the job title and average salary of employees.
SELECT j.JOB_TITLE,
       ROUND(AVG(e.SALARY)) AS 'AVG Salary'
FROM jobs AS j
         INNER JOIN employees e USING (JOB_ID)
GROUP BY e.JOB_ID
ORDER by j.JOB_TITLE;

-- 11. Write a MySQL query to display job title, employee name, and the difference between salary
-- of the employee and minimum salary for the job.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS Name,
       j.JOB_TITLE,
       (e.SALARY - j.MIN_SALARY) AS 'Salary Difference'
FROM employees e
         INNER JOIN jobs j USING (JOB_ID);

-- 12. Write a MySQL query to display the job history that were done by any employee who is currently
-- drawing more than 10000 of salary.
SELECT jh.EMPLOYEE_ID,
       e.FIRST_NAME,
       jh.START_DATE,
       jh.END_DATE,
       jh.JOB_ID,
       jh.DEPARTMENT_ID
FROM job_history jh
         INNER join employees e USING (EMPLOYEE_ID)
WHERE e.SALARY > 10000;

-- 13. Write a MySQL query to display department name, name (first_name, last_name), hire date, salary
-- of the manager for all managers whose experience is more than 15 years.
SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS Name,
       d.DEPARTMENT_NAME,
       e.HIRE_DATE,
       e.SALARY AS 'Manager Salary',
        (TO_DAYS(CURDATE()) - TO_DAYS(e.HIRE_DATE))/365 AS 'Experience (Y)'
FROM departments d
         INNER JOIN employees e ON d.MANAGER_ID = e.EMPLOYEE_ID
WHERE (TO_DAYS(CURDATE()) - TO_DAYS(e.HIRE_DATE))/365 > 15;