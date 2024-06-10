-- 
--
-- Database: college_learn
--
--

-- View Table structure
DESCRIBE 

-- Read
SELECT * FROM student;
select name, major, cgpa FROM student;
SELECT name as 'Name', major as 'Major', cgpa as 'GPA' from student;
-- column name doesn't add `student`
select student.name, student.major, student.cgpa FROM student; 

-- Where 
-- conditional operator (<=, >, <>, <, AND, OR)
SELECT name as 'Name', major as 'Major', cgpa as 'GPA' from student WHERE cgpa > 3.5;
SELECT * FROM student where mobile <> '';       -- `<>` means NOT EQUAL

-- WHERE + Conditional
SELECT * FROM student where mobile <> '' AND CGPA > 3.5;

-- ORDER BY + WHERE + Conditional
SELECT * FROM student where mobile <> '' AND CGPA > 3.5 ORDER BY name;
SELECT * FROM student where mobile <> '' AND CGPA > 3.5 ORDER BY name DESC;
SELECT * FROM student where cgpa >= 2.99 ORDER BY major ASC, cgpa DESC;
SELECT * FROM student where cgpa >= 3.5 OR mobile <> '' ORDER BY major ASC, cgpa DESC;
SELECT * FROM student where cgpa >= 3 OR mobile <> '' ORDER BY major DESC, cgpa DESC;


-- LIMIT (Limit the length of viewing) + ORDER BY + WHERE + Conditional
SELECT * FROM student where cgpa >= 2.99 ORDER BY major ASC, cgpa DESC LIMIT 5;
SELECT * FROM student where cgpa >= 2.99 AND mobile <> '' ORDER BY major ASC, cgpa DESC LIMIT 3;


-- IN (values that is IN it) + ORDER BY + WHERE + Conditional
SELECT * FROM student where major IN ('Soft Eng', 'SQA') ORDER BY cgpa DESC;
SELECT * FROM student where major IN ('Soft Eng', 'SQA') AND cgpa > 3.5 ORDER BY cgpa DESC;


-- 
--
-- Database: company_learn 
--
--


-- get all employee
SELECT * FROM employee;
-- get all clients
SELECT * FROM client;
-- get all employee order salary (asc/desc)
SELECT * FROM employee ORDER BY salary DESC;
-- get all employee order sex and full name
SELECT * FROM employee ORDER BY sex, first_name, last_name;
-- get first 5 employee with lowest salary
SELECT * FROM employee ORDER BY salary limit 5;
-- get only first and last name of all employee
SELECT first_name, last_name FROM employee;
-- get only forename and surname of all employee (use AS) among employees
SELECT first_name AS 'Forename', last_name AS 'Surname' FROM employee;
-- find all different gender (use distinct) among employees
Select DISTINCT sex from employee;
-- find all different branch_id (use distinct) among employees
Select DISTINCT branch_id from employee;
-- find distinct combination of sex and branch_id among employees
Select DISTINCT branch_id, sex from employee;


-- SQL FUNCTIONS --> (COUNT, AVG, SUM)
-- count no of emp
SELECT COUNT(emp_id) AS 'Number of Employee' from employee;
-- count no of emp has supervisor
SELECT COUNT(super_id) AS 'Has Supervisor' from employee;
-- count no of female emp born after 1970
SELECT COUNT(sex) AS 'Female EMP Born After 1970' from employee 
WHERE sex = 'F' AND birth_day > '1970-12-31';
-- find the average of all employee salary
SELECT AVG(salary) AS 'AVG EMP salary' from employee;
-- find the average of all male employee salary
SELECT AVG(salary) AS 'AVG Male EMP salary' from employee WHERE sex = 'M';
-- find the sum of all employee salary
SELECT SUM(salary) AS 'Sum of all EMP salary' from employee;


-- GROUP BY --> used for aggregation
-- count how many male and female employee the company has
SELECT sex, count(sex) AS 'No of Employee' from employee GROUP BY sex;
-- find the total sales of each sales man
SELECT emp_id AS 'Employee', SUM(total_sales) AS 'Total Sales' from works_with GROUP BY emp_id;
-- find the total spend of each client
SELECT client_id AS 'Employee', SUM(total_sales) AS 'Total Spend' from works_with GROUP BY client_id;



-- LIKE --> for finding string
-- (`%` --> any num of character , `_` --> one character)
-- FInd any clients who are an LLC (use %)
SELECT * from client WHERE client_name LIKE '%LLC';
-- find any branch suppliers who are in the LABEL business (use %)
SELECT * from branch_supplier where supplier_name LIKE '%Label%';
-- Find employee born in October (use _ and %)
SELECT * FROM employee where birth_day LIKE '____-10-__';
SELECT * FROM employee where birth_day LIKE '%-10-%';
-- find any client who are in school (use %)
SELECT * from client where client_name LIKE '%School';



-- UNION command --> must have same number of column and simillar datatype 
-- combines 2 select statement in one column
-- Find a list of employee and branch name and client name in one column
SELECT first_name as 'Employee/Branch/Client Name' from employee UNION 
SELECT branch_name FROM branch UNION SELECT client_name FROM client;
-- Find a list of all clients and all the suppliers name using union and on side show branch_id
SELECT client.client_name AS 'Client/Supplier Name', client.branch_id AS 'Branch ID' FROM client 
UNION SELECT branch_supplier.supplier_name, branch_supplier.branch_id FROM branch_supplier;
-- FInd the list of all money spent or earned by the company
SELECT employee.emp_id AS 'Earned/Spent By', employee.salary AS 'Amount' FROM employee 
UNION SELECT works_with.client_id, works_with.total_sales FROM works_with;
-- FIND total money spend and total money earned by the company
SELECT SUM(employee.salary) AS 'Amount' FROM employee 
UNION SELECT SUM(works_with.total_sales) FROM works_with;



-- JOIN/INNER JOIN command --> combining data from different tables 
-- Find all branches and the name of their manager.
SELECT branch.branch_id, branch.branch_name, CONCAT(employee.first_name, ' ' ,employee.last_name) 
AS 'Manager Name' FROM branch JOIN employee ON branch.mgr_id = employee.emp_id;
-- LEFT JOIN --> the Left is which that is in FROM, Left table includes all its data
SELECT branch.branch_id, branch.branch_name, CONCAT(employee.first_name, ' ' ,employee.last_name) 
AS 'Manager Name' FROM branch LEFT JOIN employee ON branch.mgr_id = employee.emp_id;
-- RIGHT JOIN --> the Right is which is in RIGHT JOIN, Right table include all its data (including the unmatched data)
SELECT branch.branch_id, branch.branch_name, CONCAT(employee.first_name, ' ' ,employee.last_name) 
AS 'Manager Name' FROM branch RIGHT JOIN employee ON branch.mgr_id = employee.emp_id;



-- NESTED Queries 
-- Find names of all employees who have sold over 30K to a single client  (IN + subquery)
SELECT CONCAT(employee.first_name, ' ', employee.last_name) AS 'Employee Name' FROM employee 
WHERE employee.emp_id IN (
	SELECT works_with.emp_id FROM works_with WHERE works_with.total_sales > 30000
);
-- Find all clients who are handled by the branch that Michael Scott manages. 
-- assume you know Michael Scott's ID (WHERE + subquery, LIMIT) || (WHERE + IN + subquery)
SELECT client.client_name FROM client WHERE client.branch_id IN 
(SELECT branch.branch_id FROM branch WHERE branch.mgr_id = 102);

SELECT client.client_name FROM client WHERE client.branch_id = (
    SELECT branch.branch_id FROM branch WHERE branch.mgr_id = 102 LIMIT 1
);



 