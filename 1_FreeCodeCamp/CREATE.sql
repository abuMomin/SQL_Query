-- 
--
-- Database: college_learn
--
--



-- DATABASE
CREATE DATABASE college; 


-- TABLE
CREATE TABLE student(
    id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40),
    major VARCHAR(40)
); 

-- Constraints : UNIQUE, NOT NULL, DEFAULT, PRIMARY KEY, AUTO_INCREMENT
CREATE TABLE student(
    id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    cgpa DECIMAL(3,2),
    major VARCHAR(30) DEFAULT 'undecided',
    mobile VARCHAR(11) NOT NULL UNIQUE
);

-- Insert data (all attributes must be specified)
INSERT INTO student VALUES(
    NULL,
    'shabab',
    3.9,
    'data science', 
    '0184121800'
);
INSERT INTO student VALUES(
    NULL,
    'momin',
    NULL,
    '', 
    '01841218218'
);

-- Insert data by attributes
INSERT INTO student(name, cgpa, major, mobile) VALUES(
    'momin',
    3.76,
    'software engineering', 
    '01841218210'
);
INSERT INTO student(name, cgpa, mobile) VALUES(
    'Nafi',
    3.92,
    '01841218100'
);


-- 
--
-- Database: company_learn 
--
--

CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  -- ON DELETE SET NULL = if an entry is deleted, and it's ID is used as foreign key on some table, 
  -- the foreign_key cell of that table will become NULL
  -- set mgr_id as foreign_key of emp_id from employee table 
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

-- after creating both table, establish foreign key and relationships
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;


-- now create CLIENT table
CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  --   COMPOSITE PRIMARY KEY 
  PRIMARY KEY(emp_id, client_id),
  -- ON DELETE CASCADE = if a data is deleted, and it's ID is used as foreign key on some table, 
  -- the entire row of that table (who has the foreign_key of deleted data) will be DELETED
  -- Mostly when the foreign key act as a component of another table's primary key
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);



-- INSERT data into tables (as foreign key specificed, need to apply technique)

-- insert first employee without branch --> add 1st branch --> update employee branch_id
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');
UPDATE employee SET branch_id = 1 WHERE emp_id = 100;
-- insert 2nd employee for 1st branch
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- insert first employee without branch --> add 2nd branch --> update employee branch_id
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');
UPDATE employee SET branch_id = 2 WHERE emp_id = 102;
-- insert other employees for 2nd branch
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- insert first employee without branch --> add 3rd branch --> update employee branch_id
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');
UPDATE employee SET branch_id = 3 WHERE emp_id = 106;
-- insert other employees for 3rd branch
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

INSERT INTO branch VALUES (4, 'Buffallo', NULL, NULL);

-- insert BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

-- insert CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- insert WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);



-- trigger test
CREATE TABLE trigger_test(
	action_name VARCHAR(40) NOT NULL,
    emp_name VARCHAR(40) NOT NULL, 
    id INT(11)
);

-- CREATE TRIGGER on INSERT
DELIMITER $$
CREATE 
	TRIGGER before_insert BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
    	INSERT INTO trigger_test(action_name, emp_name) VALUES('new Emp Added', NEW.first_name);
    END$$
DELIMITER ;


DELIMITER $$
CREATE
	TRIGGER after_trigger AFTER INSERT
    ON employee
    FOR EACH ROW BEGIN
    	UPDATE trigger_test SET trigger_test.id = NEW.emp_id WHERE emp_name=NEW.first_name;
    END $$
DELIMITER ;


-- TRIGGER on INSERT + IF-ELSE
DELIMITER $$
CREATE 
	TRIGGER before_trigger_branch BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
    	IF NEW.branch_id = 1 THEN
        	INSERT INTO trigger_test(action_name, emp_name) VALUES('Corporate EMP added',NEW.first_name);
        ELSEIF NEW.branch_id = 2 THEN
        	INSERT INTO trigger_test(action_name, emp_name) VALUES('Scranton EMP added',NEW.first_name);
        ELSEIF NEW.branch_id = 3 THEN
        	INSERT INTO trigger_test(action_name, emp_name) VALUES('Stamford EMP added',NEW.first_name);
        ELSE
        	INSERT INTO trigger_test(action_name, emp_name) VALUES('Buffallo EMP added',NEW.first_name);
        END IF;
    END $$
DELIMITER ;
            


-- TRIGGER on DELETE
DELIMITER $$
CREATE
	TRIGGER on_delete AFTER DELETE
    ON employee
    FOR EACH ROW BEGIN
    	INSERT trigger_test VALUES ('Deleted Employee', OLD.first_name, OLD.emp_id);
    END $$
DELIMITER ;












