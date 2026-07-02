CREATE DATABASE ecommerce_project;
USE ecommerce_project;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE
);
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Fashion'),
('Books'),
('Home Appliances'),
('Sports');
INSERT INTO products (product_name, category_id, price, stock_quantity)
VALUES
('Dell Inspiron Laptop', 1, 65000.00, 25),
('Samsung Galaxy S24', 1, 72000.00, 18),
('Sony Headphones', 1, 8500.00, 40),
('Apple Smart Watch', 1, 32000.00, 20),
('Nike Running Shoes', 2, 5500.00, 35),
('Adidas Hoodie', 2, 2800.00, 50),
('Levi''s Jeans', 2, 3500.00, 30),
('Python Programming', 3, 950.00, 60),
('SQL for Beginners', 3, 800.00, 55),
('Data Science Handbook', 3, 1200.00, 40);
INSERT INTO products (product_name, category_id, price, stock_quantity)
VALUES
('LG Refrigerator', 4, 42000.00, 12),
('Samsung Washing Machine', 4, 31000.00, 15),
('Philips Air Fryer', 4, 8500.00, 25),
('Prestige Pressure Cooker', 4, 2200.00, 60),
('Football', 5, 900.00, 80),
('Cricket Bat', 5, 2500.00, 45),
('Badminton Racket', 5, 1800.00, 55),
('Yoga Mat', 5, 700.00, 100),
('Dumbbell Set', 5, 3500.00, 30),
('Table Tennis Kit', 5, 1600.00, 25);
INSERT INTO customers
(first_name, last_name, email, phone, city, state, join_date)
VALUES
('Rahul','Sharma','rahul.sharma@gmail.com','9876543210','Chennai','Tamil Nadu','2025-01-15'),
('Priya','Reddy','priya.reddy@gmail.com','9876543211','Hyderabad','Telangana','2025-02-10'),
('Arjun','Patel','arjun.patel@gmail.com','9876543212','Ahmedabad','Gujarat','2025-03-05'),
('Sneha','Nair','sneha.nair@gmail.com','9876543213','Kochi','Kerala','2025-03-22'),
('Kiran','Kumar','kiran.kumar@gmail.com','9876543214','Bangalore','Karnataka','2025-04-08'),
('Aisha','Khan','aisha.khan@gmail.com','9876543215','Mumbai','Maharashtra','2025-04-25'),
('Rohan','Singh','rohan.singh@gmail.com','9876543216','Delhi','Delhi','2025-05-02'),
('Meera','Joshi','meera.joshi@gmail.com','9876543217','Pune','Maharashtra','2025-05-18'),
('Vikram','Das','vikram.das@gmail.com','9876543218','Kolkata','West Bengal','2025-06-01'),
('Ananya','Iyer','ananya.iyer@gmail.com','9876543219','Chennai','Tamil Nadu','2025-06-15');
INSERT INTO orders (customer_id, order_date, order_status)
VALUES
(1, '2025-06-01', 'Delivered'),
(2, '2025-06-03', 'Delivered'),
(3, '2025-06-05', 'Shipped'),
(4, '2025-06-08', 'Pending'),
(5, '2025-06-10', 'Delivered'),
(6, '2025-06-12', 'Cancelled'),
(7, '2025-06-15', 'Delivered'),
(8, '2025-06-18', 'Shipped'),
(9, '2025-06-20', 'Pending'),
(10,'2025-06-22', 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, total_price)
VALUES
(1, 1, 1, 65000.00),
(1, 3, 2, 17000.00),
(2, 2, 1, 72000.00),
(3, 5, 2, 11000.00),
(3, 6, 1, 2800.00),
(4, 4, 1, 32000.00),
(5, 7, 3, 10500.00),
(6, 10, 2, 2400.00),
(7, 11, 1, 42000.00),
(7, 12, 1, 31000.00),
(8, 15, 2, 5000.00),
(9, 18, 1, 700.00),
(10, 20, 1, 1600.00);
SELECT * FROM customers;
SELECT * FROM products;
SELECT *
FROM customers
WHERE city = 'Chennai';
SELECT *
FROM products
ORDER BY price DESC;
SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id;
SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_status,
    oi.total_price
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id;
CREATE VIEW customer_order_summary AS
SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_status,
    oi.total_price
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id;
SELECT * FROM customer_order_summary;
CREATE INDEX idx_customer
ON orders(customer_id);
SELECT *
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);
SELECT AVG(price) AS average_price
FROM products;
SELECT SUM(total_price) AS total_sales
FROM order_items;
SELECT c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
SELECT c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;