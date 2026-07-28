create DATABASE sales_management_1;

USE sales_management_1;

CREATE TABLE Offices (
    officeCode INT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    addressLine1 VARCHAR(100) NOT NULL,
    addressLine2 VARCHAR(100),
    state VARCHAR(50),
    postalCode VARCHAR(15),
    country VARCHAR(50) NOT NULL,
    territory VARCHAR(50)
);

insert into Offices(officeCode,city,phone,addressLine1,addressLine2,state,postalCode,country,territory) 
values
('1', 'Chennai', '+91-44-12345678', 'T Nagar', NULL, 'Tamil Nadu', 'India', '600017', 'APAC'),
('2', 'Bangalore', '+91-80-87654321', 'MG Road', NULL, 'Karnataka', 'India', '560001', 'APAC');

select * from Offices;


CREATE TABLE employee(
    employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    extension VARCHAR(50),
    email VARCHAR(100) UNIQUE, 
    officeCode INT NOT NULL,
    reportsTo INT,
    jobTitle VARCHAR(50),
    FOREIGN KEY (officeCode) REFERENCES Offices(officeCode),
    FOREIGN KEY (reportsTo) REFERENCES employee(employeeNumber)
);

insert into employee(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) 
values
(1002, 'Kumar', 'Arun', 'x101', 'arun.kumar@classic.com', '1', NULL, 'Sales Manager'),
(1056, 'Ravi', 'Suresh', 'x102', 'suresh.ravi@classic.com', '1', 1002, 'Sales Rep'),
(1076, 'Sharma', 'Neha', 'x103', 'neha.sharma@classic.com', '2', 1002, 'Sales Rep');

select * from employee;

select employeeNumber,lastName,firstName,jobTitle from employee
where officeCode in (
	select officeCode from Offices
    where state = 'Tamil Nadu'
    );



select 
    MIN(extension) AS min_extend,
    MAX(extension) AS max_extend
from employee;


CREATE TABLE ProductLines(
    productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000) DEFAULT NULL,
    htmlDescription MEDIUMTEXT,
    image BLOB
);

insert into ProductLines(productLine,textDescription,htmlDescription,image) 
values
('Classic Cars', 'Vintage and classic model cars', NULL, NULL),
('Motorcycles', 'Racing and sports bikes', NULL, NULL);

select * from ProductLines;


CREATE TABLE Products(
    productCode varchar(100) PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productScale VARCHAR(70),
    productVendor VARCHAR(70),
    productDescription TEXT,
    quantityInStock varchar(200),
    buyPrice DECIMAL(10, 2),
    MSRP DECIMAL(10, 2),
    productLine VARCHAR(50),
    FOREIGN KEY (productLine) REFERENCES ProductLines(productLine)
);

ALTER TABLE Products 
MODIFY quantityInStock INT;


INSERT INTO Products(
    productCode, productName, productScale, productVendor, 
    productDescription, quantityInStock, buyPrice, MSRP, productLine
) VALUES 
(
    'S10_1678', '1969 Harley Davidson', '1:10', 'Min Lin Diecast', 
    'Classic Harley Davidson bike model', 100, 4800.00, 6500.00, 'Motorcycles'
), 
(
    'S12_1099', '1968 Ford Mustang', '1:12', 'Autoart Studio', 
    'Classic Ford Mustang model', 50, 9500.00, 12000.00, 'Classic Cars'
);

select * from Products;

CREATE TABLE Customers(
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50) NOT NULL,
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
    FOREIGN KEY(salesRepEmployeeNumber) REFERENCES employee(employeeNumber)
);

insert into Customers(customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit) 
values
(2001, 'ABC Traders', 'Rao', 'Vikram', '+91-9876543210','Anna Nagar', NULL, 'Chennai', 'Tamil Nadu', '600040', 'India', 1056, 150000),
(2002, 'XYZ Electronics', 'Patel', 'Amit', '+91-9123456789', 'Indiranagar', NULL, 'Bangalore', 'Karnataka', '560038', 'India', 1076, 200000);

select * from Customers;

select customerNumber 
from Customers
where creditLimit > 10000;


SELECT salesRepEmployeeNumber
FROM Customers
WHERE customerNumber IN (
	SELECT customerNumber
    FROM Orders
    WHERE orderNumber = 30001
    );

CREATE TABLE Orders(
    orderNumber INT PRIMARY KEY,
    orderDate DATE NOT NULL,
    requiredDate DATE,
    shippedDate DATE,
    status VARCHAR(50),
    comments TEXT,
    customerNumber INT,
    FOREIGN KEY (customerNumber) REFERENCES Customers(customerNumber)
);

insert into Orders(orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber) 
values
(30001, '2026-01-10', '2026-01-15', '2026-01-13', 'Shipped', 'Delivered on time', 2001),
(30002, '2026-01-12', '2026-01-18', NULL, 'In Process', NULL, 2002);

select * from Orders;

SELECT COUNT(*) AS total_orders 
FROM orders;

select status 
from orders
where customerNumber = '2001';

SELECT orderDate, requiredDate, shippedDate,orderNumber,status
FROM orders
WHERE orderNumber in(
    SELECT orderNumber 
    FROM orders 
    WHERE status = 'Shipped' -- Example condition
);

CREATE TABLE OrderDetails(
    orderNumber INT,
    productCode VARCHAR(15),
    quantityOrdered INT NOT NULL,
    priceEach DECIMAL(10, 2) NOT NULL,
    orderLineNumber SMALLINT,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (orderNumber) REFERENCES Orders(orderNumber),
    FOREIGN KEY (productCode) REFERENCES Products(productCode)
);

insert into OrderDetails(orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber) 
values
(30001, 'S10_1678', 2, 6500, 1),
(30002, 'S12_1099', 1, 12000, 1);

select * from OrderDetails;

select avg(priceEach)
from OrderDetails;


select * from Offices;
select * from employee;
select * from ProductLines;
select * from Products;
select * from Customers;
select * from Orders;
select * from OrderDetails;



SELECT 
    Customers.customerNumber,
    Customers.customerName,
    COUNT(Orders.orderNumber) AS totalOrders
FROM Customers
JOIN Orders
ON Customers.customerNumber = Orders.customerNumber
GROUP BY Customers.customerNumber, Customers.customerName;


SELECT salesRepEmployeeNumber,
COUNT(customerNumber) AS totalCustomers
FROM Customers

