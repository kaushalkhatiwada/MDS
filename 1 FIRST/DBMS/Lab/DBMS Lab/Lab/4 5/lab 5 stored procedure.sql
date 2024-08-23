use classicmodels;
-- stored procedure

DELIMITER $$
drop procedure GetCustomers;
CREATE PROCEDURE GetCustomers()
BEGIN
    SELECT 
        customerName, 
        city, 
        state, 
        postalCode, 
        country
    FROM
        customers
    ORDER BY customerName;    
END$$
DELIMITER ;

call GetCustomers(); -- executing the procedure

DELIMITER $$
drop procedure Getallproducts; 
CREATE PROCEDURE Getallproducts()
BEGIN
    SELECT *
    FROM products;    
END$$

call Getallproducts();

-- stored procedure with IN parameter
DELIMITER // -- using // as delimiter
drop procedure getofficebycountry;
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
BEGIN
    SELECT * 
    FROM offices
    WHERE country = countryName;
END //
DELIMITER ;

call getofficebycountry(); -- will return error as no of arguments are not matching
call getofficebycountry('USA');

-- stored procedure with OUT parameter
DELIMITER $$
DROP procedure GetOrderCountByStatus; 
CREATE PROCEDURE GetOrderCountByStatus (OUT total INT)
BEGIN
    SELECT COUNT(orderNumber)
    INTO total
    FROM orders
    WHERE status = 'shipped';
END $$
DELIMITER ;

CALL GetOrderCountByStatus(@total);
SELECT @total;

-- stored procedure with both IN and OUT parameters
DELIMITER $$
drop procedure  GetOrderCountByStatusargument;
CREATE PROCEDURE GetOrderCountByStatusargument (IN  orderStatus VARCHAR(25), OUT total INT)
BEGIN
    SELECT COUNT(orderNumber)
    INTO total
    FROM orders
    WHERE status = orderStatus;
END$$
DELIMITER ;

CALL GetOrderCountByStatusargument('Shipped', @total);
SELECT @total;

desc orders;
select orderNumber, comments, status from orders where status='shipped';

delimiter $$
drop procedure getsomeorders;
CREATE PROCEDURE getsomeorders()
BEGIN
    select orderNumber, comments, status from orders where status='Disputed';
END $$
delimiter ; 

call getsomeorders();

-- *list of  input parameter*

delimiter //
drop procedure Searchproducts;
CREATE  PROCEDURE Searchproducts(IN Pcodes VARCHAR(100))
BEGIN
    SELECT * FROM products
    WHERE FIND_IN_SET(productCode, Pcodes ); -- position of string in comma separated list of strings
END //
delimiter ;

call Searchproducts('S32_1374,S24_2360,S32_4485');





