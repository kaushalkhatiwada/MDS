
create database Kaushal_13_Company;
show databases;
use Kaushal_13_Company;
show tables;

-- Office Table
insert into Office(Onumber,Oname,Country)
values 	(1,"C8I","Nepal"),
		(2,"Cypher Technology","Nepal"),
        (3,"Visec Technology","India"),
        (4,"Dell Technology","USA"),
        (5,"Info Developer","Nepal"),
        (6,"Kaushal_Office_13","Nepal"),
        (7,"Classy Print","Nepal");

 -- Employee Table
insert into Employee (SSN, Ename, Gender, Bdate, Address, Salary, Ono, Years_of_experience)
values 	(1,"Santosh Parajuli","M","1996-05-01","Kirtipur",55000,1,7),	
		(2,"Raju Shrestha","M","1995-01-01","Kalimati",50000,2,5),
		(3,"Bipin Maharjan","M","1994-08-12","Kirtipur",40000,5,2),
        (4,"Rishi Pradhananga","M","1990-10-21","Anamnagar",60000,4,8),
        (5,"Dipen Khatri","M","1993-02-07","Pepsicola",58000,3,10),
        (6,"Gopal Shrama","M","200-01-01","Lagankhel",25000,1,1),
        (7,"Tina  Lama","F","2002-07-12","Balkhu",36000,2,2),
        (8,"Shyam Tamang","M","1998-12-12","Kalanki",48000,3,3),
        (9,"Prakash Karki","M","1988-03-03","Baneshwor",57000,4,4),
        (13,"Kaushal Khatiwada","M","1996-10-28","Kaushaltar",30000,6,6);
        
 -- Project Table
 insert into Project (Pnumber, Pname, Proj_location, Onumber)
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
        (4,"Gopal Khatri",3,5,"Son"),
        (5,"Maya Khatiwada",50,13,"Mother");

-- 2        
create table PF(
	PFID int primary key,
    SSN int,
    PFCategoryName varchar(255),
    Amount decimal(10, 2),
    Start_date date,
    Remarks varchar(255),
    foreign key (SSN) references Employee(SSN)
);

-- 3 
alter table Employee
add Matrial_status varchar(50);

update Employee 
set Matrial_status ="Married" where ssn in (1,3,5);
update Employee 
set Matrial_status="Divorced" where ssn in (4,6,8);
update Employee 
set Matrial_status="Single" where ssn in (2,7,9,13);

-- 4
insert into PF(PFID,SSN,PFCategoryName,Amount,Start_date,Remarks)
	values 	(1,1,"SSF",5500,"2017-05-01","Regular Contributor"),
			(2,2,"SSF",5000,"2019-03-01","Irregular Contributor"),
            (3,3,"SSF",4000,"2022-02-01","Regular Contributor"),
            (4,4,"SSF",6000,"2016-08-01","Irregular Contributor"),
            (5,5,"SSF",5800,"2014-12-01","Regular Contributor"),
            (6,6,"CIT",2500,"2023-07-01","Irregular Contributor"),
            (7,7,"CIT",3600,"2022-06-01","Regular Contributor"),
            (8,8,"CIT",4800,"2021-05-01","Irregular Contributor"),
            (9,9,"CIT",5700,"2020-11-01",NULL),
            (13,13,"CIT",3000,"2018-02-01",NULL);
            
-- 5
select * from Office;
select * from Employee;
select * from Project;
select * from Works_On;
select * from Dependents;
select * from PF;

-- 6
select * from Employee
where salary>30000
order by Ename desc;

-- 7
select * from Project
order by Pname;

-- 8
select * from Employee
where salary>30000 and Years_of_experience<3;

-- 9
select Ename,Address,Salary from Employee
where salary>30000 or Years_of_experience<3;

-- 10
select * from Dependents;

-- 11
select Dname,Dage from Dependents
where Dage between 5 and 60;

-- 12
select * from Office
where Oname like "%Nt%";

-- 13
select * from Office
where Onumber in (1,2,3);

-- 14
select * from PF
where Remarks is null;

-- 15
select PFCategoryName,Amount,Start_date,Remarks from PF
where Remarks is not null;

-- 16
select * from PF
limit 5;

-- 17
select PFCategoryName from PF
where Amount != 3000;

-- 18
select * from Employee
join Works_On on Employee.SSN=Works_On.ESSN
where Works_On.Pno=2;
