 create schema shopping;
 use shopping;
 create table Customer
(
CustomerID int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
CustFirstName  varchar(25),
CustMidName varchar(10),
CustLastName varchar(25)
)ENGINE=innodb;

Desc Customer;

create table SalesOrder
(
   OrderID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   OrderDate date, 
   CustomerID int,
   FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

Desc salesorder;

drop table product;

create table Product 
(
ProductID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
ProductName varchar(25),
UnitPrice decimal,
NumberInStock int
)engine=innodb;

desc product;

create table OrderLine 
(OrderLineID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
OrderID int, 
ProductID int,
QuantityOrdered varchar(15),
FOREIGN KEY (OrderID) REFERENCES SalesOrder(OrderID),
FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
)engine=innodb;

desc orderline;

INSERT INTO Customer (CustFirstName, CustLastName)
VALUES ('John', 'Doe'); 

INSERT INTO Customer (CustFirstName, CustMidName, CustLastName)
VALUES ('Bob', 'R.', 'Travis');

/*Multiple inserts*/

INSERT INTO Customer (CustFirstName, CustMidName, CustLastName) VALUES ('Ramesh', 'Sing', 'Saud'), ('Jagdish', Null, 'Bhatta');

select * from customer;

INSERT INTO Product (ProductName, UnitPrice, NumberInStock)
VALUES ('Strawberry', 4.523, 16);

select * from product;

alter table Product
modify UnitPrice decimal (5, 2);

UPDATE Product
SET UnitPrice =4.99 WHERE ProductID =1;

create table Customer2 as select * from Customer;

select * from customer2;
