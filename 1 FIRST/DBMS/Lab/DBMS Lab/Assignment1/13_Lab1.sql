
-- create database 
create database Kaushal_13_Company;

show databases;
use Kaushal_13_Company;

show tables;

-- create table
-- 1(B)
create table Office(
	Onumber int primary key,
    Oname varchar(255) not null,
    Country varchar(255)
);

-- 1(A) with foreign key
create table Employee(
	SSN int auto_increment primary key not null,
    Ename varchar(255) not null ,
    Gender char(1) check (Gender in ('M','F')),
    Bdate date,
    Address varchar(255),
    Salary decimal(10,2) default 0.00,
    Ono int,
    Years_of_experience int,
    foreign key (Ono) references Office(Onumber)
);

-- 1(C) with foreign key constraint
create table Project(
	Pnumber int primary key,
    Pname varchar(40) unique not null,
    Plocation varchar(40),
    Onumber int,
    constraint fk_pro foreign key(Onumber) references Office(Onumber)
);

-- 1(D) update cascade and delete cascade for foreign key
create table Works_on(
	ESSN int,
    Pno int,
    foreign key (ESSN) references Employee(SSN) 
    on update cascade 
    on delete cascade,
    foreign key (Pno) references Project(Pnumber) 
    on update cascade 
    on delete cascade
);


-- 1(E) 
create table Dependents(
	Did int primary key,
    Dname varchar(255),
    Dage int,
    SSN int,
    Drelation char(50),
    foreign key (SSN) references Employee(SSN) 
    on delete set null 
    on update set null,
    constraint age_constraint check (Dage<16) 
);

-- 2 Alter table
alter table Dependents
modify Drelation varchar(50);
    
-- 3 Insert
-- Office Table
insert into Office(Onumber,Oname,Country)
values 	(1,"C8I","Nepal"),
		(2,"Cypher Technology","Nepal"),
        (3,"Visec Technology","India"),
        (4,"Dell Technology","USA"),
        (5,"Info Developer","Nepal"),
        (6,"Kaushal_Office_13","Nepal");
        
insert into Office(Onumber,Oname,Country)
values 	(13,"Kaushal_Ncell_13","Nepal");

 -- Employee Table
insert into Employee (SSN, Ename, Gender, Bdate, Address, Salary, Ono, Years_of_experience)
values 	(1,"Santosh Parajuli","M","1996-05-01","Kirtipur",55000,1,7),	
		(2,"Raju Shrestha","M","1995-01-01","Kalimati",50000,2,5),
		(3,"Bipin Maharjan","M","1994-08-12","Kirtipur",40000,5,2),
        (4,"Rishi Pradhananga","M","1990-10-21","Anamnagar",60000,4,8),
        (5,"Dipen Khatri","M","1993-02-07","Pepsicola",58000,3,10),
        (13,"Kaushal Khatiwada","M","1996-10-28","Kaushaltar",30000,6,6);
 
 -- Project Table
 insert into Project (Pnumber, Pname, Plocation, Onumber)
 values	(1,"SaaS Product Deployment","Satdobato",1),
		(2,"HCI Deployment","Kupondole",2),
        (3,"Sever Protection","Bangalore",3),
        (4,"Dell R740 Resouce Upgradation","New York",4),
        (5,"Payment Feature Addition","Sanepa",5),
        (13,"Kaushal_ProjMDS","Kaushaltar",6);

-- Works_on Table
insert into Works_on(ESSN,Pno)
values	(1,1),
		(2,2),
        (3,5),
        (4,4),
        (5,3),
        (13,13);
        
-- Dependents Table
insert into Dependents (Did,Dname,Dage,SSN,Drelation)
values	(1,"Ram Khatiwada",15,13,"Brother"),
        (2,"Sharmila Parajuli",11,1,"Sister"),
        (3,"Ryan Shrestha",9,2,"Brother"),
        (4,"Gopal Khatri",3,5,"Son");
        
 -- Age check constraint [<16]
insert into dependents (Did,Dname,Dage,SSN,Drelation)
values	(5,"Maya Khatiwada",50,13,"Mother");

-- 4
update Office
set Oname="Kaushal_Ntc_13" 
where Oname="Kaushal_Ncell_13"; 
select * from Office;

-- 5 if Employee deleted from primary key table then foreign key (SSN) value from Depepndents table set to NULL
delete from Employee
where SSN=1;
select * from Dependents;

-- 6
alter table Project
rename column Plocation to Proj_location;

-- 7
select * from Office;
select * from Employee;
select * from Project;
select * from works_on;
select * from dependents;

-- 8
drop table Works_on;

-- 9
desc dependents;
alter table Dependents
drop constraint age_constraint;

		-- Verify Age check constraint deletion
insert into dependents (Did,Dname,Dage,SSN,Drelation)
values	(5,"Maya Khatiwada",50,13,"Mother");

-- 10
drop database Kaushal_13_Company;
show databases;

-----------------------------------------------






