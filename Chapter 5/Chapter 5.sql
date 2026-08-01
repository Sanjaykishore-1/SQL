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

INSERT INTO Students 
(ClassNo, FirstName, LastName, DeptName, StudyYear, ContactDetails) 
VALUES
(201, 'Arun', 'Kumar', 'Computer Science', 1, '9876543210'),
(202, 'Priya', 'Sharma', 'Mechanical Engineering', 2, '9123456780'),
(203, 'Vignesh', 'Rajan', 'Electrical Engineering', 3, '9988776655'),
(204, 'Divya', 'Reddy', 'Civil Engineering', 4, '9345678901'),
(205, 'Karthik', 'Nair', 'Electronics and Communication', 2, '9567890123'),
(206, 'Ananya', 'Menon', 'Information Technology', 1, '9789012345');


select * from Dept;
select * from Class;
select * from Students;


-- inner join 

SELECT 
    Dept.DeptName,
    Class.Floor
FROM Dept
INNER JOIN Class
    ON Dept.DeptNo = Class.DeptNo;
    
-- Left join
    
SELECT 
    Dept.DeptName,
    Class.Floor
FROM Dept
LEFT JOIN Class
    ON Dept.DeptNo = Class.DeptNo;
    

-- Right join 
    
SELECT 
    Dept.DeptName,
    Class.Floor
FROM Dept
RIGHT JOIN Class
    ON Dept.DeptNo = Class.DeptNo; 
    
    
-- Full Join
    
SELECT 
    Dept.DeptName,
    Class.Floor
FROM Dept
LEFT JOIN Class
    ON Dept.DeptNo = Class.DeptNo

UNION

SELECT 
    Dept.DeptName,
    Class.Floor
FROM Dept
RIGHT JOIN Class
    ON Dept.DeptNo = Class.DeptNo;
    

-- Inner Join
    
SELECT 
    d.DeptName,
    c.ClassNo,
    c.Floor,
    c.ClassYear
FROM Dept d
INNER JOIN Class c
    ON d.DeptNo = c.DeptNo;
    

-- Cross Join

select
	Dept.DeptName,
    Class.Remarks
from Dept
cross join Class;

