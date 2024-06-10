-- 
--
-- Database: college_learn
--
--

--DATABASE
DROP DATABASE college;

-- TABLE
DROP TABLE student;

-- Delete data (all)
DELETE FROM student

-- Delete data (specific)
DELETE FROM student WHERE id = 6;

-- Delete data (specific) + conditional
DELETE FROM student WHERE major = 'U/D' AND cgpa < 3.5;


-- 
--
-- Database: company_learn 
--
--


-- `ON DELETE SET NULL` = if an entry is deleted, and it's ID is used as foreign key on some table, 
-- the foreign key of that table will become NULL. 

 -- ON DELETE CASCADE = if a data is deleted, and it's ID is used as foreign key on some table, 
  -- the entire row of that table (who has the foreign_key of deleted data) will be DELETED
  -- Mostly when the foreign key act as a component of another table's primary key


  -- DELETE TRIGGER
  DROP TRIGGER my_trigger;

  

