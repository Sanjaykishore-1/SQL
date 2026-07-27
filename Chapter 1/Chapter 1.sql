create Database studentsid;

use studentsid

create table students(
Studentid int auto_increment primary key,
Firstname varchar(50),
Lastname  varchar(50),
Birthdate date,
gender varchar(10));

create table courses(
Courseid int auto_increment primary key,
courseName varchar(50),
credits int);

 create table enrollment(
 enrollmentId int auto_increment primary key,
 Studentid int,
 Courseid int,
 enrollmentDate date,
 foreign key(Studentid) references students(Studentid),
 foreign key(Courseid) references courses(Courseid));
 
 
 
