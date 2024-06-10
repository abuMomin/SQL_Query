-- 
--
-- Database: college_learn
--
--

-- ADD COLUMN
ALTER TABLE student ADD cgpa DECIMAL(3,2)

-- DROP COLUMN
ALTER TABLE student DROP COLUMN cgpa

-- Update COLUMN Attribute
-- column-level operation --> ALTER (can be wrong)
-- row-level operation --> UPDATE (can be wrong)
ALTER TABLE `student` CHANGE `name` `name` VARCHAR(40) NOT NULL;  -- Way 1 mariadb
ALTER TABLE student MODIFY COLUMN name varchar(40) NOT NULL;   -- Way 2 mysql

-- update data (specific)
UPDATE student SET major = 'Soft Eng' WHERE major = 'software engineering';

-- update data (all)
UPDATE student SET major = 'U/D'

-- update data (specific) + conditional 
UPDATE student SET major = 'U/D' WHERE major = 'U/D' OR major = 'data science';

-- update multiple data (specific) 
UPDATE student SET major = 'Undecided', cgpa = NULL WHERE major = 'U/D';
UPDATE student SET major = 'ICT & Soft Eng', cgpa = 3.57 WHERE id = 1;


-- 
--
-- Database: company_learn 
--
--
