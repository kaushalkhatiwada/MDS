use kaushal_13_Company;

show procedure status;
drop procedure GetEmployee;
drop procedure GetPF;
drop procedure GetNumberOfPF;

-- 1
DELIMITER $$
CREATE PROCEDURE GetEmployee()
BEGIN
    SELECT Ename, Bdate, Address
    FROM Employee;   
END$$
DELIMITER ;
 -- 2
call GetEmployee(); 

-- 3
desc pf;
DELIMITER $$
CREATE PROCEDURE GetPF(in amt decimal(10,2))
BEGIN
    SELECT PFCategoryName, Amount, Start_date
    FROM PF
    WHERE Amount > amt;   
END$$
DELIMITER ;

call GetPF(1000.00);
call GetPF(3000.00);

-- 4 
DELIMITER $$
CREATE PROCEDURE GetNumberOfPF(in amt decimal(10,2),OUT total INT)
BEGIN
    SELECT COUNT(Amount)
    FROM PF
    WHERE Amount = amt;   
END$$
DELIMITER ;

-- 5
call GetNumberOfPF(3000.00,@total);
---------------------------------- TRIGGER 
show triggers;
drop trigger new_employee_create;
-- 6
DELIMITER $$
create trigger new_employee_create 
before insert on employee for each row
begin
	if new.salary<0 then set new.salary = 0;
	end if;
end; $$
DELIMITER ;

select * from employee;
insert into Employee (SSN, Ename, Gender, Bdate, Address, Salary, Ono, Years_of_experience)
values 	(10,"Suresh timalsina","M","1992-03-22","Koteshwor",-55000,1,11);

delete from employee where SSN=10;

-- 7
-- Create a table to store the deleted items
create table deleted_pf (
    PFID int,
    SSN int,
    Start_date date,
    Amount decimal(10,2),
    deletion_date timestamp,
    Remarks varchar(255)
);

DELIMITER $$
create trigger after_PF_delete
after delete on PF for each row
begin
    insert into deleted_pf values (old.pfid, old.ssn,old.start_date,old.amount,now(),"It is deleted");
end; $$
DELIMITER ;

delete from pf where pfid = 6;


-- show triggers;
-- drop trigger after_PF_delete;
-- select * from pf;
-- drop table deleted_pf;
select * from deleted_pf;


