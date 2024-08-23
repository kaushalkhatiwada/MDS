use classmodels;

Select * from customers;

--  Order by contactLastname in ascending order
SELECT contactLastname,contactFirstname
FROM customers
ORDER BY contactLastname;

-- Order by contactLastname in descending order 
SELECT contactLastname,contactFirstname
FROM customers
ORDER BY contactLastname DESC;

-- Order multiple column 
SELECT contactLastname,contactFirstname
FROM customers
ORDER BY contactLastname DESC,contactFirstname ASC;

-- Order by total cost (quantityOrdered * EachPrice
SELECT orderNumber,orderlinenumber,quantityordered * priceeach
FROM orderdetails
ORDER BY quantityOrdered * priceEach DESC;

-- Order by order's status
SELECT orderNumber, status
FROM orders
ORDER BY 
    FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');
        
-- Select all SalesRep
SELECT lastname,firstname,jobtitle
FROM employees
WHERE jobtitle = "Sales Rep";

-- Select jobtitle "Sales Rep" and officecode=1
SELECT lastname,firstname,jobtitle
FROM employees
WHERE jobtitle = "Sales Rep" AND officeCode = 1;

-- Select jobtitle "Sales Rep" and officecode=1 nad orderby 
SELECT lastname,firstname,jobtitle
FROM employees
WHERE jobtitle = "Sales Rep" OR officeCode = 1
ORDER BY officecode,jobtitle;

-- where clause with between
SELECT firstname,lastname,officecode
FROM employees
WHERE officecode BETWEEN 1 AND 3
ORDER BY officecode;

-- where clause with LIKE (son in the lastname)
SELECT firstName, lastName
FROM employees
WHERE lastName LIKE '%son'
ORDER BY firstName;

-- where clause with IN
SELECT firstName, lastName, officeCode
FROM employees
WHERE officeCode IN (1 , 2, 3)
ORDER BY officeCode;

-- LAB 3
-- INNER JOIN with respect to productliine
SELECT productCode, productName, textDescription
FROM products t1
INNER JOIN productlines t2 
ON t1.productline = t2.productline;

-- LEFT JOIN
SELECT 
	customers.customerNumber, 
    customerName, 
    orderNumber, 
    status
FROM
    customers
LEFT JOIN orders ON 
    orders.customerNumber = customers.customerNumber;

-- RIGHT JOIN



