

create database dooko;
show databases;
use dooko;
show tables;

-- FARMER
drop table if exists Farmer;
create table Farmer(
	FID int auto_increment primary key not null,
    FName varchar(255),
    EmailID varchar(100),
    Address varchar(255),
    Contact_No char(10),
    constraint f_Email check (EmailID regexp '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    constraint f_Contact_No check (length(Contact_No)=10)
);

-- CUSTOMER
drop table if exists Customer;
create table Customer(
	CID int auto_increment primary key not null,
    CName varchar(255),
    EmailID varchar(100),
    Address varchar(255),
    Contact_No char(10),
    constraint c_Email check (EmailID regexp '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    constraint c_Contact_No check (length(Contact_No)=10)
);

-- PRODUCT
drop table if exists Product;
create table Product(
	PID int auto_increment primary key not null,
    PName varchar(255),
    Descr varchar(255),
    Price decimal(10,2) default 0.00,
    Quantity int default 0,
    FID int,
    foreign key (FID) references Farmer(FID) on update cascade on delete cascade
);

-- Order
drop table if exists Orders;
create table Orders(
	OrderID int auto_increment primary key not null,
    OrderDate timestamp default current_timestamp,
    CID int,
    foreign key (CID) references Customer(CID) on update cascade on delete cascade
);

-- Order Detail
drop table if exists OrderDetail;
create table OrderDetail(
	OrderID int,
    PID int,
    Quantity int,
    foreign key(OrderID) references Orders(OrderID),
    foreign key(PID) references Product(PID)
);

-- Payment
drop table if exists payment;
create table payment(
	PaymentID int auto_increment primary key not null,
    PaymentDate timestamp default current_timestamp,
    Amount decimal(10,2) not null,
    OrderID int,
	foreign key(OrderID) references Orders(OrderID)
);

-- INSERT VALUES
insert into Farmer (FName, EmailID, Address, Contact_No)
values
    ('Kaushal Khatiwada', 'kk@abc.com', 'Kaushaltar', '1111111111'),
    ('Gopal Khadka', 'gkh@abc.com', 'Gaushala', '2222222222'),
    ('Rajendra Nepal', 'rn@abc.com', 'Rampur', '3333333333');
select * from Farmer;

insert into Customer(CName,EMailID,Address,Contact_No)
values 
	('Gaurav Bhattarai', 'gb@abc.com', 'Kritipur', '4444444444'),
    ('Abin Shrestha', 'as@abc.com', 'Gaushala', '5555555555'),
    ('Prakash lama', 'pl@abc.com', 'Balkhu', '6666666666');
select * from Customer;

insert into Product(PID,PName,Descr,Price,Quantity,FID)
values 
	(1,"Cauliflower","Fresh Cauli flower",100,20,1),
	(2,"Potato","Mustang Potato",200,30,1),
	(3,"Tomato","Red Tomato",200,5,2),
	(4,"Egg","Newly hatched Egg",20,100,2),
	(5,"Apple","Mustang Apple",70,50,3),
    (6,"Orange","Juicy Orange",30,40,3);
select * from Product;

insert into Orders(OrderID,CID)
value
	(1,1),
	(2,2),
	(3,3);
select * from Orders;

insert into OrderDetail(OrderID,PID,Quantity)
value
	(1,5,5),
    (1,3,5),
    (2,1,3),
    (2,2,10),
    (3,4,12),
    (3,6,20);
select * from OrderDetail;

delete from OrderDetail where Orderid=1;
truncate table OrderDetail;

-- STORE PROCEDURE
show procedure status;
drop procedure GetFarmerProducts;
-- Get Farmers Products
DELIMITER $$
CREATE PROCEDURE GetFarmerProducts(in farmer int)
BEGIN
    SELECT PID,PName,Descr,Price,Quantity
    FROM Product
    WHERE FID = farmer;   
END$$
DELIMITER ;

call GetFarmerProducts(1);

DELIMITER $$
CREATE PROCEDURE GetCustomerProducts(in customer int)
BEGIN
select C.CName,P.PName,Od.Quantity,O.OrderDate,P.Price,Od.Quantity*P.Price as Amount
	from OrderDetail Od
	inner join Orders O
	on Od.OrderID=O.OrderID
	inner join Customer C
	on O.CID=C.CID
	inner join Product P 
	on P.PID= Od.PID
	where O.CID = customer;
END$$
DELIMITER ;

call GetCustomerProducts(1);

-- TRIGGER
show triggers;
-- To reduce stock quantity after Oder Placement by customer
CREATE TRIGGER update_product_quantity
AFTER INSERT ON OrderDetail FOR EACH ROW
    UPDATE Product
    SET Quantity = Quantity - NEW.Quantity
    WHERE PID = NEW.PID;

-- View
Create view VW_FarmerTotalSales as
select F.FName, sum(P.Price * Od.Quantity) as Total
	from OrderDetail Od
	inner join Product P 
	on P.PID= Od.PID
    inner join Farmer F
    on F.FID = P.FID
    group by F.FName
    order by Total;

select * from VW_FarmerTotalSales;


create view FamerSaleByProduct as 
select F.FName, sum(P.Price * Od.Quantity) as Amount,P.PName
	from OrderDetail Od
	inner join Product P 
	on P.PID= Od.PID
    inner join Farmer F
    on F.FID = P.FID
    group by F.FName,P.PName;
    
select * from FamerSaleByProduct;







