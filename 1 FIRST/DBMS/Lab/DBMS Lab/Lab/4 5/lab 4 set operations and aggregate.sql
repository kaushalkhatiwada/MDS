use classicmodels;
SELECT 
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers;
    
CREATE TABLE A (ID INT, SALARY INT);
CREATE TABLE B (ID INT, SALARY INT);
insert into A values (1,100),(2,200);

insert into B values (1,100),(2,200),(3,300),(4,400);

table A union table B;

select salary from A 
union 
select salary from B;


table A intersect table B;

select salary from A 
intersect 
select salary from B;

/* simulating intersect using join*/
SELECT DISTINCT salary
FROM A
INNER JOIN B USING(salary);

SELECT DISTINCT salary
FROM A
WHERE salary IN (SELECT salary FROM B);


table A EXCEPT table B;
table B except table A;

select * from A 
except 
select * from B;

select * from B
except 
select * from A;

/* simulation of minus using join*/
SELECT salary
FROM A
LEFT JOIN B USING (salary)
WHERE B.salary IS NULL;

SELECT salary
FROM B
LEFT JOIN A USING (salary)
WHERE A.salary IS NULL;

/* aggregate functions*/
SELECT COUNT(*) AS Total
FROM products;

SELECT 
    productLine, 
    COUNT(*)
FROM
    products
GROUP BY productLine;

SELECT COUNT(productVendor) AS Total
FROM products;

SELECT COUNT(DISTINCT productVendor) AS Total
FROM products;

SELECT 
    productVendor, 
    COUNT(*)
FROM
    products
GROUP BY productVendor
ORDER BY COUNT(*) DESC;

SELECT 
    productVendor, 
    COUNT(*)
FROM
    products
GROUP BY productVendor
HAVING COUNT(*) >= 9
ORDER BY COUNT(*) DESC;


SELECT productCode,sum(priceEach * quantityOrdered) total
FROM orderdetails
GROUP by productCode;

SELECT AVG(buyPrice) average_buy_price
FROM products;

SELECT 
    AVG(buyprice) 'Average Classic Cars Price'
FROM
    products
WHERE
    productline = 'Classic Cars';

SELECT MAX(buyPrice) highest_price
FROM Products;

SELECT MIN(buyPrice) lowest_price
FROM Products
