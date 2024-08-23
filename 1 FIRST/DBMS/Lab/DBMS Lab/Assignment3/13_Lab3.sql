
show databases;
use kaushal_13_company;
show tables;

-- 1 Select the names of employees and their dependents without using JOIN.
select employee.Ename , dependents.Dname
from employee, dependents
where employee.ssn = dependents.ssn;

-- 2 Select the names of employees and their dependents without using INNER JOIN and order the result based on dependents name.
select employee.Ename , dependents.Dname
from employee, dependents
where employee.ssn = dependents.ssn
order by dependents.Dname;

-- 3 Use JOIN between Employee, Project and Works_on and retrieve the name of employees and the projects on which they work.
select employee.Ename, project.Pname
from employee
join works_on on employee.SSN = works_on.ESSN
join project on works_on.Pno = project.Pnumber;

-- 4 Use Inner join between Employee and PF table with the join condition, Employee.SSN=PF.SSN and Employee.Salary>PF.Amount
select *
from employee
inner join pf on employee.SSN = pf.SSN and employee.Salary>pf.Amount;

-- 5 Write a query to show the results of Left and Right Join between Office and Project.
select * 
from office
left join project on office.Onumber = project.Onumber;	-- classy print has no projects associated

select * 
from office
right join project on office.Onumber = project.Onumber;

-- 6 Write a query to show the results of Cross Join between Employee and PF tables.
select * 
from employee
cross join pf;

-- 7 Show results of using natural join between Employee and PF.
select * 
from employee
natural join pf;

-- 8 Find the number of employees and status in each status of “Married”, “Single”, “Divorced”. 
-- Use the COUNT function with the GROUP BY clause with status.
select employee.Matrial_status, count(Matrial_status) as Number_Of_Employee 
from employee
group by Matrial_status;

-- 9 Find the number of employees and status in each status of “Married” OR “Single”. 
-- Use the COUNT function with the GROUP BY clause with status and Having clause with status = “Married” OR “Single”
select employee.Matrial_status, count(Matrial_status) as Number_Of_Employee 
from employee
group by Matrial_status
having Matrial_status="Married" or Matrial_status="Single";

-- 10 Using sub query, select the name and location of projects whose Onumber is in the Onumber of the offices located in country Nepal and India. 

select Pname, Proj_location
from project
where Onumber in (
	select Onumber
    from office
    where country in ('Nepal', 'India')
);




