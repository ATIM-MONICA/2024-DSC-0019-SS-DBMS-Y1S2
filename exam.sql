-- Qn.3
CREATE DATABASE IF NOT EXISTS zoo_db;
USE zoo_db;
DROP TABLE IF EXISTS animal;
DROP TABLE IF EXISTS habitat;
DROP TABLE IF EXISTS feeding_schedule;

CREATE TABLE habitat (
  habitat_id INT PRIMARY KEY,
  habitat_name VARCHAR(50),
  environment VARCHAR(50)
);
CREATE TABLE animal (
  animal_id INT PRIMARY KEY,
  animal_name VARCHAR(50),
  species VARCHAR(50),
  habitat_id INT NOT NULL,
FOREIGN KEY (habitat_id) REFERENCES habitat(habitat_id)
);

CREATE TABLE feeding_schedule (
  schedule_id INT PRIMARY KEY,
  food VARCHAR(50),
 feeding_time varchar(50),
 animal_id INT NOT NULL,
FOREIGN KEY (animal_id) REFERENCES animal(animal_id)
);
-- Insert data into habitat table
INSERT INTO habitat(habitat_id, habitat_name, environment) VALUES
(1, 'Savannah', 'Grassland'),
(2, 'Tiger Trail', 'Forest'),
(3, 'Bird Paradise', 'Tropical'),
(4, 'Petile House', 'Temperate');

-- Insert data into animal table
INSERT INTO animal(animal_id, animal_name, species, habitat_id) VALUES
(1, 'Leo', 'Lion', 1),
(2, 'Stripes', 'Tiger', 2),
(3, 'Polly', 'Parrot', 3),
(4, 'Slithers', 'Snake', 4);

-- Insert data into feeding_schedule table
INSERT INTO feeding_schedule(schedule_id, food, feeding_time, animal_id) VALUES
(1, 'Meat', '14:00', 1),
(2, 'Chicken', '12:00', 2),
(3, 'Seeds', '08:00', 3),
(4, 'Fruits', '15:00', 3),
(5, 'Mice', '20:00', 4);
-- a)
SELECT animal.animal_name,habitat.habitat_name FROM animal
INNER JOIN habitat ON animal.habitat_id = habitat.habitat_id;

-- b)
SELECT food, COUNT(*) AS total_feedings FROM feeding_schedule
GROUP BY 
    food;

-- c)
SELECT  a.animal_name FROM feeding_schedule fs JOIN animal a ON fs.animal_id = a.animal_id
GROUP BY 
    fs.animal_id, a.animal_name
HAVING 
    COUNT(fs.schedule_id) > 1;

-- d) Four applications of DBMS
-- RDBMS
-- Maria DB
-- Mongo DB
-- Redis

-- e)
-- Primary key is the unique identifier of a record for example the identifier of animal is animal_id
-- The primary key must not be null

-- Foreign Key is the primary of one table referenced in another table for purpose of keepimg the consistent relationship between the tables. 
-- Example FOREIGN KEY (animal_id) REFERENCES animal(animal_id)

-- Qn.4
--a ) MySQL components
--Log files; Provides the error information and hint on fixing bug
-- MySQL server; handling sql queries
-- MySql worbench; connects the database to be queried or query excecution
-- MySQL client
-- Information schema; stores data about the databse for example tables and columns
-- b)
CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;


CREATE TABLE Course (
  Code varchar(50) PRIMARY KEY NOT NULL,
  Title varchar(50)
);
CREATE TABLE Student (

  Stud_id INT PRIMARY KEY,
  Name VARCHAR(50),
  Code varchar(50) NOT NULL,
  FOREIGN KEY (Code) REFERENCES Course(Code)
  
);
-- Insert data into Course table
INSERT INTO Course (Code, Title) VALUES
( 'IMIS', 'Info. Systems'),
( 'BIT', 'Bachelor of IT'),
( 'CIT', 'Cert in IT'),
( 'DIT', 'Dip in IT');

-- Insert data into Student table
INSERT INTO Student (Code,Stud_id, Name) VALUES
( 'IMIS', 001,  'Info. Systems'),
( 'BIT',  002, 'Bachelor of IT'),
( 'BIT',  003, 'Cert in IT'),
( 'CIT',  004, 'Dip in IT');

-- i)
SELECT * FROM Student_db.course;
SELECT * FROM Student_db.student;
-- ii)
INSERT INTO Student (Code,Stud_id, Name) VALUES ( 'IMIS', 001,  'Info. Systems');

-- iii)
-- UPDATE student SET Name = 'Monica' WHERE Code = 'IMIS';

-- iv)
DELETE FROM Student WHERE Stud_id = 001;

-- c) Ordering Display
SELECT * FROM Student ORDER BY  Code ASC; 
SELECT * FROM Student ORDER BY  Code DESC;

-- Qn.1
-- e)
DROP DATABASE IF EXISTS examDB;
CREATE DATABASE examDB;
USE examDB;
CREATE TABLE tblstudent (
    StudentName VARCHAR(100) NOT NULL,
    StudentID INT NOT NULL PRIMARY KEY,
    BirthDate DATE NOT NULL,
    Year VARCHAR(10) NOT NULL,
    MobileNo VARCHAR(10) NOT NULL UNIQUE
);
INSERT INTO tblstudent VALUES ('Jane',    235, '1987/01/12', 'Y1S2',  '0722245321');
INSERT INTO tblstudent VALUES ('Nicholas', 26, '2002/07/22', 'Y1S1',  '072045867');
INSERT INTO tblstudent VALUES ('Cyrus',     1, '1989/06/15', 'Y2S1',  '0704231345');
INSERT INTO tblstudent VALUES ('Neema',     2, '2008/11/29', 'Y2S1',  '0733876987');
INSERT INTO tblstudent VALUES ('Caroline',  3, '2002/10/18', 'Y1S1',  '0732568448');
INSERT INTO tblstudent VALUES ('Judith',   29, '2003/06/19', 'Y1S2',  '0711234567');
INSERT INTO tblstudent VALUES ('Grace',   127, '2000/01/14', 'Y1S2',  '0733765987');

CREATE TABLE tblfinance (
    StudentID INT NOT NULL PRIMARY KEY,
    Tuition_Fee INT NOT NULL,
    Administration_Fee INT NOT NULL DEFAULT 5000,
    Exams_Fee INT NOT NULL,
    Medical_Fee INT NOT NULL DEFAULT 4000,
      FOREIGN KEY (StudentID) REFERENCES tblstudent(StudentID)
);

-- Administration_Fee and Medical_Fee are omitted from these INSERT statements.
-- MySQL will automatically apply their DEFAULT values (5000 and 4000 respectively)
INSERT INTO tblfinance (StudentID, Tuition_Fee, Exams_Fee) VALUES (235,  30000, 3000);
INSERT INTO tblfinance (StudentID, Tuition_Fee, Exams_Fee) VALUES (26,  40000, 2000);
INSERT INTO tblfinance (StudentID, Tuition_Fee, Exams_Fee) VALUES (1,  34000, 3000);
INSERT INTO tblfinance (StudentID, Tuition_Fee, Exams_Fee) VALUES(2,  23000, 3000);
INSERT INTO tblfinance (StudentID, Tuition_Fee, Exams_Fee) VALUES (3,  20000, 3000);
INSERT INTO tblfinance (StudentID, Tuition_Fee, Exams_Fee) VALUES (29, 35000, 2000);
INSERT INTO tblfinance (StudentID, Tuition_Fee, Exams_Fee) VALUES (127, 28000, 3000);

-- e)ii)Extracting all students in Y1S1 with the tuition fee they have paid
SELECT 
    s.StudentName,
    s.StudentID,
    s.Year,
    FORMAT(f.Tuition_Fee, 0) AS Tuition_Fee
FROM tblstudent s
JOIN tblfinance f ON s.StudentID = f.StudentID
WHERE s.Year = 'Y1S1';

-- e)iii)All students with paid tuition fee >=30,000
SELECT 
    s.StudentName,
    s.StudentID,
    s.Year,
    FORMAT(f.Tuition_Fee, 0) AS Tuition_Fee
FROM tblstudent AS s
JOIN tblfinance AS f 
  ON s.StudentID = f.StudentID
WHERE f.Tuition_Fee >= 30000;

-- e)iv)
-- Adding new record 

INSERT INTO tblstudent (
  StudentName,
  StudentID,
  BirthDate,
  Year,
  MobileNo
) VALUES (
  'Dan',
  236, -- Assumption that Dan's StudentID is 236 coz must satisfy NOT NULL constraint
  STR_TO_DATE('20/4/2001', '%d/%m/%Y'),
  'Y1S2',
  '0723456123'
);

-- e)v)
-- Changing the student name with ID 26 to Nelson
UPDATE tblstudent
SET StudentName = 'Nelson'
WHERE StudentID = 26;

-- e)vi) Calculation of both highest and lowest tuition fees
SELECT
    FORMAT(MAX(Tuition_Fee), 0) AS `Highest Amount`,
    FORMAT(MIN(Tuition_Fee), 0) AS `Lowest Amount`
FROM tblfinance;





