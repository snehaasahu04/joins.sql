CREATE DATABASE SAMPLE_DATASET;
USE SAMPLE_DATASET;
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
name VARCHAR (50),
country VARCHAR (50)
);
insert into customers (customer_id, name, country)
values
(1,	"Alice Smith", "USA"),
(2, "Bob Johnson", 'UK'),
(3, 'Charlie Lee', 'Canada'),
(4, 'Daisy Brown', 'USA');

SELECT * FROM customers;

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
amount DOUBLE
);
drop table orders;

INSERT INTO orders (order_id, customer_id, order_date, amount)
values
(101, 1, '2023-12-20', 250.00),
(102, 2, '2024-01-10', 300.00),
(103, 5, '2024-01-15', 150.00),
(104, 3, '2024-01-18', 400.00);

-- Create the Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert data into the Products table
INSERT INTO products (product_id, product_name, price) VALUES
(1001, 'laptop', 800.00),
(1002, 'smartphone', 600.00),
(1003, 'headphones', 100.00);


-- create the orderdetails table
create table orderdetails (
    orderid int,
    productid int,
    quantity int
);

-- insert data into the orderdetails table
insert into orderdetails (orderid, productid, quantity) values
(101, 1001, 1),
(101, 1002, 2),
(102, 1003, 4),
(104, 1002, 3);

-- questions 

-- 1. Fetch all orders along with customer names and order amounts.

select o.order_id, c.name, o.amount
from orders o
inner join customers c
on o.customer_id = c.customer_id;

-- 2. Find details of orders and the corresponding products ordered.

select od.orderid, p.product_name, od.quantity
from orderdetails as od
inner join products as p
on od.productid = p.product_id
inner join orders as o
on od.orderid = o.order_id;

-- 3. Get all customers and their corresponding orders, if they have any.

SELECT c.customer_id, c.name, o.order_id, o.amount 
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- 4. List all products along with the order quantity, if they are ordered.

SELECT p.product_id, p.product_name, od.quantity
FROM Products p
LEFT JOIN OrderDetails od
ON p.product_id = od.productid;

-- 5. Retrieve all orders and include customer details if available.

select o.order_id, o.amount, c.name
from orders as o
right join customers as c
on o.customer_id = c.customer_id;

-- 6. List all customers and their orders. Include customers who haven't placed orders and orders without valid customers.

select c.customer_id, c.name, o.order_id, o.amount
from customers as c
left join orders as o
on c.customer_id = o.customer_id

UNION

SELECT  c.customer_id, c.name, o.order_id, o.amount
from orders as o
right join customers as c
on o.customer_id = c.customer_id;

-- 7. Find pairs of customers from the same country.

select c.name as customer1, c1.name as customer2, c.country
from customers as c
join customers as c1
ON c.country = c1.country AND c.customer_id <> c1.customer_id;

-- 8. Retrieve order details, including customer name, product name, and total price (Quantity * Price).

select o.order_id, c.name, p.product_name, (od.quantity*p.price) as total_price
from customers as c
inner join orders as o
on c.customer_id = o.customer_id
inner join orderdetails as od
on o.order_id = od.orderid
inner join products as p
on od.productid = p.product_id;

