# SAMPLE_DATASET SQL Scripts

## Overview
This project contains SQL scripts to create a sample dataset for practicing SQL queries. The dataset consists of four tables:

1. `customers`
2. `orders`
3. `products`
4. `orderdetails`

Additionally, it includes various SQL queries to demonstrate different types of joins and data manipulations.

---

## Database and Table Creation

### 1. Create the Database
```sql
CREATE DATABASE SAMPLE_DATASET;
USE SAMPLE_DATASET;
```

### 2. Create and Populate Tables

#### `customers` Table
```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR (50),
    country VARCHAR (50)
);

INSERT INTO customers (customer_id, name, country)
VALUES
(1, 'Alice Smith', 'USA'),
(2, 'Bob Johnson', 'UK'),
(3, 'Charlie Lee', 'Canada'),
(4, 'Daisy Brown', 'USA');
```

#### `orders` Table
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DOUBLE
);

INSERT INTO orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2023-12-20', 250.00),
(102, 2, '2024-01-10', 300.00),
(103, 5, '2024-01-15', 150.00),
(104, 3, '2024-01-18', 400.00);
```

#### `products` Table
```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO products (product_id, product_name, price) VALUES
(1001, 'laptop', 800.00),
(1002, 'smartphone', 600.00),
(1003, 'headphones', 100.00);
```

#### `orderdetails` Table
```sql
CREATE TABLE orderdetails (
    orderid INT,
    productid INT,
    quantity INT
);

INSERT INTO orderdetails (orderid, productid, quantity) VALUES
(101, 1001, 1),
(101, 1002, 2),
(102, 1003, 4),
(104, 1002, 3);
```

---

## Practice Queries

### 1. Fetch all orders along with customer names and order amounts
```sql
SELECT o.order_id, c.name, o.amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;
```

### 2. Find details of orders and the corresponding products ordered
```sql
SELECT od.orderid, p.product_name, od.quantity
FROM orderdetails AS od
INNER JOIN products AS p
ON od.productid = p.product_id
INNER JOIN orders AS o
ON od.orderid = o.order_id;
```

### 3. Get all customers and their corresponding orders, if they have any
```sql
SELECT c.customer_id, c.name, o.order_id, o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
```

### 4. List all products along with the order quantity, if they are ordered
```sql
SELECT p.product_id, p.product_name, od.quantity
FROM products p
LEFT JOIN orderdetails od
ON p.product_id = od.productid;
```

### 5. Retrieve all orders and include customer details if available
```sql
SELECT o.order_id, o.amount, c.name
FROM orders AS o
RIGHT JOIN customers AS c
ON o.customer_id = c.customer_id;
```

### 6. List all customers and their orders. Include customers who haven't placed orders and orders without valid customers
```sql
SELECT c.customer_id, c.name, o.order_id, o.amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id

UNION

SELECT c.customer_id, c.name, o.order_id, o.amount
FROM orders AS o
RIGHT JOIN customers AS c
ON o.customer_id = c.customer_id;
```

### 7. Find pairs of customers from the same country
```sql
SELECT c.name AS customer1, c1.name AS customer2, c.country
FROM customers AS c
JOIN customers AS c1
ON c.country = c1.country AND c.customer_id <> c1.customer_id;
```

### 8. Retrieve order details, including customer name, product name, and total price (Quantity * Price)
```sql
SELECT o.order_id, c.name, p.product_name, (od.quantity * p.price) AS total_price
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN orderdetails AS od
ON o.order_id = od.orderid
INNER JOIN products AS p
ON od.productid = p.product_id;
```

---

## How to Use
1. Copy the table creation and data insertion scripts to your SQL environment to set up the database.
2. Use the provided queries to practice and understand SQL joins and operations.
3. Modify and extend the queries as needed for further exploration.

---

## License
This project is open for learning purposes and can be modified or distributed freely.

---

## Contact
For questions or suggestions, feel free to reach out!
