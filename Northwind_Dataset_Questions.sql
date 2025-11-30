-- 1. We need a complete list of our suppliers to update our contact records. Can you pull all the information from the suppliers' table?
SELECT 
    *
FROM
    suppliers;

-- 2. Our London sales team wants to run a local promotion. Could you get a list of all customers based in London?
SELECT 
    *
FROM
    customers;
SELECT 
    *
FROM
    customers
WHERE
    city = 'London';


-- 3. For our new 'Luxury Items' marketing campaign, I need to know our top 5 most expensive products.
SELECT 
    *
FROM
    products;

SELECT 
    *
FROM
    products
ORDER BY price DESC
LIMIT 5;


-- 4. HR is planning a professional development program for our younger employees. Can you provide a list of all employees born after 1965?
SELECT 
    *
FROM
    employees;

SELECT 
    employeeid,
    CONCAT(firstname, lastname) AS full_name,
    birthdate
FROM
    employees
WHERE
    YEAR(birthdate) > 1965;


-- 5. A customer is asking about our 'Chef' products but can't remember the full name. Can you search for all products that have 'Chef' in their title?
SELECT 
    *
FROM
    customers;
SELECT 
    *
FROM
    products;

SELECT 
    *
FROM
    products
WHERE
    productName LIKE '%chef%';


-- 6. We need a report that shows every order and which customer placed it. Can you combine the order information with the customer's name?
SELECT 
    *
FROM
    orders;
SELECT 
    *
FROM
    orderdetails;
SELECT 
    *
FROM
    customers;

SELECT 
    o.orderid, o.orderdate, o.shipperid, c.customername
FROM
    orders o
        JOIN
    customers c ON o.customerid = c.customerid;


-- 7. To organize our inventory, please create a list that shows each product and the name of the category it belongs to.
SELECT 
    *
FROM
    products;
SELECT 
    *
FROM
    categories;

SELECT 
    p.productid, p.productname, c.categoryname
FROM
    products p
        JOIN
    categories c ON p.categoryid = c.categoryid;


-- 8. We want to promote products sourced from the USA. Can you list all products provided by suppliers located in the USA?
SELECT 
    *
FROM
    products;
SELECT 
    *
FROM
    suppliers;

SELECT 
    p.productname, s.country
FROM
    products p
        JOIN
    suppliers s ON p.supplierid = s.supplierid
WHERE
    s.country = 'USA';


-- 9. A customer has a query about their order.
-- We need to know which employee was responsible for it. 
-- Can you create a list of orders with the corresponding employee's first and last name?
SELECT 
    *
FROM
    orders;
SELECT 
    *
FROM
    employees;

SELECT 
    o.orderid, e.firstname, e.lastname
FROM
    orders o
        JOIN
    employees e ON o.employeeid = e.employeeid;


SELECT 
    O.ORDERDATE,
    o.orderid,
    CONCAT(e.firstname, ' ', e.lastname) AS full_name_emp
FROM
    employees e
        JOIN
    orders o ON o.EmployeeID = e.employeeid
ORDER BY O.ORDERDATE DESC;


-- 10. To help with our international marketing strategy, I need a count of how many customers we have in each country, sorted from most to least.
SELECT 
    *
FROM
    customers;

SELECT 
    country, COUNT(customerid) AS count_of_customer
FROM
    customers
GROUP BY country
ORDER BY count_of_customer DESC;


-- 11. Let's analyze our pricing. What is the average product price within each product category?
SELECT 
    *
FROM
    products;
SELECT 
    *
FROM
    categories;

SELECT 
    c.categoryname, AVG(p.price) AS avg_price
FROM
    categories c
        JOIN
    products p ON c.categoryid = p.categoryid
GROUP BY categoryname
ORDER BY avg_price DESC;


-- 12. For our annual performance review, can you show the total number of orders handled by each employee?
show tables;
SELECT 
    *
FROM
    employees;
SELECT 
    *
FROM
    orders;
SELECT 
    CONCAT(e.firstname, e.lastname) AS full_name,
    COUNT(o.orderid) AS count_of_orders
FROM
    employees e
        JOIN
    orders o ON e.employeeid = o.employeeid
GROUP BY full_name
ORDER BY count_of_orders DESC; 


-- 13. We want to identify our key suppliers. Can you list the suppliers who provide us with more than three products?
SELECT 
    *
FROM
    suppliers;
SELECT 
    *
FROM
    products;

SELECT 
    s.suppliername, COUNT(p.productid) AS count_of_products
FROM
    suppliers s
        JOIN
    products p ON s.supplierid = p.supplierid
GROUP BY s.suppliername
HAVING count_of_products > 3
ORDER BY count_of_products DESC;


-- 14. Finance team needs to know the total revenue for order 10250.
SELECT 
    *
FROM
    orders;
SELECT 
    *
FROM
    orderdetails;
SELECT 
    *
FROM
    products;

SELECT 
    od.orderid, SUM(od.quantity * p.price) AS total_revenue
FROM
    orderdetails od
        JOIN
    products p ON od.productid = p.productid
WHERE
    orderid = 10250;

-- 15. What are our most popular products? I need a list of the top 5 products based on the total quantity sold across all orders.
SELECT 
    *
FROM
    products;
SELECT 
    *
FROM
    orderdetails;

SELECT 
    p.productname, SUM(od.quantity) AS total_quantity_sold
FROM
    products p
        JOIN
    orderdetails od ON p.productid = od.productid
GROUP BY p.productname
ORDER BY total_quantity_sold DESC
LIMIT 5;

SELECT 
    p.productid,
    p.productname,
    SUM(od.quantity) AS total_quantity_sold
FROM
    products p
        JOIN
    orderdetails od ON p.productid = od.productid
GROUP BY p.productid , p.productname
ORDER BY SUM(od.quantity) DESC
LIMIT 5;

-- 16. To negotiate our shipping contracts, we need to know which shipping company we use the most. Can you count the number of orders handled by each shipper?
SELECT 
    *
FROM
    shippers;
SELECT 
    *
FROM
    orders;

SELECT 
    s.shippername, COUNT(o.orderid) AS total_orders
FROM
    shippers s
        JOIN
    orders o ON s.shipperid = o.shipperid
GROUP BY s.shippername
ORDER BY total_orders DESC;


-- 17. Who are our top-performing salespeople in terms of revenue? Please calculate the total sales amount for each employee.
SELECT 
    *
FROM
    employees;
SELECT 
    *
FROM
    orderdetails;
SELECT 
    *
FROM
    products;
SELECT 
    *
FROM
    orders;

SELECT 
    CONCAT(e.firstname, ' ', e.lastname) AS full_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM
    employees e
        JOIN
    orders o ON e.employeeid = o.employeeid
        JOIN
    orderdetails od ON o.orderid = od.orderid
        JOIN
    products p ON od.productid = p.productid
GROUP BY full_name
ORDER BY total_revenue DESC;



-- 18. We are running a promotion on our 'Chais' tea.
-- I need a list of all customers who have purchased this product before so we can send them a notification.

SELECT 
    *
FROM
    customers;
SELECT 
    *
FROM
    products;

SELECT 
    *
FROM
    orderdetails;
SELECT 
    *
FROM
    orders;


SELECT DISTINCT
    c.customerid, c.customername, c.contactname, p.productname
FROM
    products p
        JOIN
    orderdetails od ON p.productid = od.productid
        JOIN
    orders o ON o.orderid = od.orderid
        JOIN
    customers c ON c.customerid = o.customerid
WHERE
    p.productname = 'chais';





-- 19. Which product categories are the most profitable? I need a report showing the total revenue generated by each category.
SELECT 
    *
FROM
    categories;
SELECT 
    *
FROM
    orderdetails;
SELECT 
    *
FROM
    products;

SELECT 
    c.categoryname, SUM(od.quantity * p.price) AS total_revenue
FROM
    orderdetails od
        JOIN
    products p ON od.productid = p.productid
        JOIN
    categories c ON c.categoryid = p.categoryid
GROUP BY c.categoryname
ORDER BY total_revenue DESC;



-- 20. We want to start a loyalty program for our most frequent customers. 
-- Can you find all customers who have placed more than 5 orders?

SELECT 
    *
FROM
    customers;
SELECT 
    *
FROM
    orders;

SELECT 
    c.customername, COUNT(o.orderid) AS total_no_orders
FROM
    customers c
        JOIN
    orders o ON c.customerid = o.customerid
GROUP BY c.customerName
HAVING total_no_orders > 5
ORDER BY total_no_orders DESC
LIMIT 5;


SELECT 
    c.customerid,
    c.customername,
    COUNT(o.orderid) AS total_orders
FROM
    customers c
        JOIN
    orders o ON o.customerid = c.customerid
GROUP BY c.customerid , c.customername
HAVING COUNT(o.orderid) > 5
ORDER BY COUNT(o.orderid) DESC;

