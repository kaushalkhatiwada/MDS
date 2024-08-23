
show databases;
create database kaushal_13_school;
use kaushal_13_school;

show tables;
drop table teacher;
drop table student;

-- 1
create table Teacher(
	ID int primary key,
    TNAME varchar(20)
);

create table Student(
	ID int primary key,
    SNAME varchar(20)
);

-- 2 
insert into Teacher
values	(1,"Karma"),
		(2,"Shyam"),
		(3,"Rajesh"),
		(4,"Gopal"),
		(5,"Robert");    
select * from Teacher;

insert into Student
values	(1,"Karma"),
		(2,"Ram"),
		(3,"Rajesh"),
		(4,"Nabin"),
		(5,"Robert");
    
select * from Student;

-- 3
select TNAME as ALL_NAMES from Teacher 
union
select SNAME from Student;

-- 4
select TNAME as COMMON_NAME from Teacher 
intersect
select SNAME from Student;

-- 5
select distinct TNAME from Teacher 
inner join Student
on TNAME=SNAME;

-- 6
select Tname
from Teacher
where TNAME in (select SNAME from Student);

-- 7
select T.TNAME as TEACHER_ONLY from Teacher T
left join Student S
on T.TNAME = S.SNAME
where S.ID is null;

-- 8
use kaushal_13_company;
select count(distinct Oname) as No_Of_Offices from Office;

-- 9
select count(distinct Ename) as No_Of_Employees from Employee;

-- 10
select sum(Salary) as TotalSalary_for_Employees from Employee;

-- 11
select avg(Salary) as AverageSalary_Of_Employees from Employee;

-- 12
select max(Amount) as Maximum_PFAmount from PF;

-- 13
select min(Amount) as Minimum_PFAmount from PF;