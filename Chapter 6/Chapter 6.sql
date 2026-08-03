create database College;

use College;

CREATE TABLE Dept (
    DeptNo INT PRIMARY KEY,
    DeptName VARCHAR(100) UNIQUE,
    NoOfTeachers INT,
    HeadOfDept VARCHAR(100),
    BlockName VARCHAR(100)
);

insert into Dept (DeptNo,DeptName,NoOfTeachers,HeadOfDept,BlockName)
values
(101, 'Computer Science', 18, 'Dr. Rajesh Kumar', 'Block A'),
(102, 'Mechanical Engineering', 22, 'Dr. Priya Sharma', 'Block B'),
(103, 'Electrical Engineering', 20, 'Dr. Arjun Mehta', 'Block C'),
(104, 'Civil Engineering', 16, 'Dr. Kavitha Reddy', 'Block D'),
(105, 'Electronics and Communication', 19, 'Dr. Suresh Nair', 'Block E'),
(106, 'Information Technology', 17, 'Dr. Anitha Menon', 'Block F');


CREATE TABLE Class (
    ClassNo INT PRIMARY KEY,
    BlockName VARCHAR(100),
    Floor VARCHAR(100),
    DeptName VARCHAR(100),
    DeptNo INT,
    ClassYear INT,
    NoOfBoys INT,
    NoOfGirls INT,
    Remarks VARCHAR(100),

    FOREIGN KEY (DeptNo) REFERENCES Dept(DeptNo),
    FOREIGN KEY (DeptName) REFERENCES Dept(DeptName)
);


INSERT INTO Class (ClassNo, BlockName, Floor, DeptName, DeptNo, ClassYear, NoOfBoys, NoOfGirls, Remarks) 
VALUES
(201, 'CS', '1st Floor', 'Computer Science', 101, 1, 28, 22, 'Regular'),
(202, 'ME B', '2nd Floor', 'Mechanical Engineering', 102, 2, 35, 12, 'Lab Class'),
(203, 'EE', '1st Floor', 'Electrical Engineering', 103, 3, 30, 18, 'Regular'),
(204, 'CE', '3rd Floor', 'Civil Engineering', 104, 4, 26, 20, 'Project Batch'),
(205, 'ECE', '2nd Floor', 'Electronics and Communication', 105, 2, 32, 16, 'Regular'),
(206, 'IT', '1st Floor', 'Information Technology', 106, 1, 24, 26, 'Smart Classroom');


CREATE TABLE Students (
    ClassNo INT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DeptName VARCHAR(100),
    StudyYear INT,
    ContactDetails VARCHAR(100),

    FOREIGN KEY (ClassNo) REFERENCES Class(ClassNo),
    FOREIGN KEY (DeptName) REFERENCES Dept(DeptName)
);


ALTER TABLE Class
ADD Total_Students INT 
GENERATED ALWAYS AS (NoOfBoys + NoOfGirls);

INSERT INTO Students 
(ClassNo, FirstName, LastName, DeptName, StudyYear, ContactDetails,Merit) 
VALUES
(201, 'Arun', 'Kumar', 'Computer Science', 1, '9876543210','Yes'),
(202, 'Priya', 'Sharma', 'Mechanical Engineering', 2, '9123456780','No'),
(203, 'Vignesh', 'Rajan', 'Electrical Engineering', 3, '9988776655','Yes'),
(204, 'Divya', 'Reddy', 'Civil Engineering', 4, '9345678901','Yes'),
(205, 'Karthik', 'Nair', 'Electronics and Communication', 2, '9567890123','No'),
(206, 'Ananya', 'Menon', 'Information Technology', 1, '9789012345','Yes');

ALTER TABLE Students
MODIFY ContactDetails INT;

select * from Dept;
select * from Class;
select * from Students;


##Task 1: Window Functions
#Using any database (either:

#perform the following:
#Frame 5 problem statements using window functions.

#	Use at least 4 different window functions from the list below:

## 	Rank the Students of every department with year wise and order them accordingly 

#	RANK()

Select *,
Rank() over (order by ClassYear)
From Class;

#	DENSE_RANK()

Select *,
dense_rank() over (order by ClassYear) as Year_order
From Class;

## 	Rank the Students of every department with class students capacity and strength 

Select *,
Sum(NoOfBoys and NoOfGirls) over (order by ClassYear) as Strength_order
From Class;

## 	Rank the class students average strength with partition by class year

Select *,
avg(Total_Students) over (partition by ClassYear) as Strength_Avg
From Class;

## 	Rank the Students of every year with count of merit and non merit

Select *,
count(Merit)over (partition by StudyYear) as Merit_students
From Students;

## Find the difference of class strength of students every year.

Select *,
lead(Total_Students) over (partition by ClassYear) as students_Next_year
From Class;



## Task 2 : Stored Procedures	
# Create 3 stored procedures.
# The procedures must include:

		#	One procedure without parameters
		#	One procedure with input parameters
        
        
# Show the class details
       
DELIMITER $$
CREATE PROCEDURE All_Class_Details()
BEGIN
    SELECT *
    FROM Class;
END $$
DELIMITER ;
   
CALL All_Class_Details();       
       
       
       

# Show the student details with input of ContactDetails.

DELIMITER $$

CREATE PROCEDURE Stut_Details(IN I_ContactDetails VARCHAR(100))
BEGIN
    SELECT 
        ClassNo,
        FirstName,
        LastName,
        DeptName,
        StudyYear,
        Merit
    FROM Students
    WHERE ContactDetails = I_ContactDetails;
END $$

DELIMITER ;

CALL Stut_Details('9789012345');




# Show the dept details with input of dept number
DELIMITER $$

CREATE PROCEDURE DEPT_Details(IN I_DeptNo INT)
BEGIN
    SELECT 
        DeptName,
        NoOfTeachers,
        HeadOfDept,
        BlockName
    FROM Dept
    WHERE DeptNo = I_DeptNo;
END $$

DELIMITER ;

CALL DEPT_Details(101);



