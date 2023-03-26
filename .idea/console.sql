/*Create a new table named employeedetails which should contain data like:
bankAccount
address
phoneNumber
personalEmail*/
CREATE TABLE employeedetails (
    bankAccount VARCHAR(50),
    address VARCHAR(255),
    phoneNumber varchar(50),
    personalEmail varchar(50)

);

/*View all “Germany” customers and their orderdetails. If a customer has not made any orders
then he should not be included in the result*/
SELECT c.customerNumber, c.customerName, od.*
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
WHERE c.country = 'Germany';

/* List all employees and the their revenue amount (based on payments table)*/
SELECT e.employeeNumber, e.firstName, e.lastName, SUM(p.amount) as revenueAmount
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber;

/*Find the Customer who has the most orders. If more than 1 customer has the most orders then
all customers should be displayed*/
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber) AS total_orders
FROM customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber
HAVING COUNT(o.orderNumber) = (
    SELECT COUNT(orderNumber)
    FROM orders
    GROUP BY customerNumber
    ORDER BY COUNT(orderNumber) DESC
    LIMIT 1
);

/*List all products which have been ordered the last month. (since the database is a bit old we
assume we are now at 2005-01-01)*/
SELECT DISTINCT p.productName
FROM products p
INNER JOIN orderdetails od ON p.productCode = od.productCode
INNER JOIN orders o ON o.orderNumber = od.orderNumber
WHERE o.orderDate BETWEEN DATE_SUB('2005-01-01', INTERVAL 1 MONTH) AND '2005-01-01';