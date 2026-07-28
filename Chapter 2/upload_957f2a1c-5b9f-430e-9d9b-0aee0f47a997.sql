create database sales_management;

use sales_management;

create table ProductLines(
	productLine varchar(50) primary key,
	textDescription varchar(4000) default null,
	htmlDescription mediumtext ,
	image blob 
);

create table Products(
	productCode varchar(15) primary key,
	productName varchar(70),
	productScale varchar(70),
	productVendor varchar(70),
	productDescription text,
	quantityInStock int ,
	buyPrice decimal(10,2),
	MSRP decimal(10.2),
	foreign key(productLine) references ProductLines(ProductLine)
);

CREATE TABLE Customers (
    customerNumber INT primary key,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(20),
    addressLine1 VARCHAR(100),
    addressLine2 VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50),
    salesRepEmployeeNumber INT,
    creditLimit DECIMAL(10, 2),
);

create table Orders(
	orderNumber int primary key,
	productCode int,
	quantityOrdered int,
	priceEach int,
	orderLineNumber int
    foreign key(productCode) references Products(productCode)
    FOREIGN KEY(customerNumber) references Customers(customerNumber)
);

create table OrderDetails(
	orderNumber int primary key,
	orderDate Date,
	requiredDate Date,
	shippedDate Date,
	Status varchar(50),
	comments varchar(200),
	customerNumber int
    foreign key(productCode) references Products(productCode)
    foreign key(orderNumber) references Orders(orderNumber)
);

create table Payments(
	customerNumber int,
	checkNumber int,
	paymentDate date,
	amount int
    FOREIGN KEY(customerNumber) references Customers(customerNumber)
);

create table Employees(
	employeeNumber int primary key,
	lastName varchar(50),
	firstName varchar(50),
	extension varchar(50),
	email varchar(50),
	officeCode int,
	reportsTo varchar(50),
	jobTitle varchar(50)
    foreign key(officeCode) references Offices(officeCode)
);

CREATE TABLE Offices (
    officeCode INT PRIMARY KEY,
    city VARCHAR(50),
    phone VARCHAR(20),
    addressLine1 VARCHAR(100),
    addressLine2 VARCHAR(100),
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50),
    territory VARCHAR(50)
);













