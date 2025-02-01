create database SQL_projects;
use SQL_projects;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    address TEXT,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

INSERT INTO Users (first_name, last_name, email, phone_number, address) VALUES
('John', 'Doe', 'john.doe@gmail.com', '9876543210', '123 Main St, New York, NY'),
('Alice', 'Smith', 'alice.smith@yahoo.com', '9876543211', '456 Elm St, Los Angeles, CA'),
('Bob', 'Johnson', 'bob.johnson@hotmail.com', '9876543212', '789 Oak St, Chicago, IL'),
('Emily', 'Davis', 'emily.davis@gmail.com', '9876543213', '101 Pine St, Houston, TX'),
('Michael', 'Brown', 'michael.brown@outlook.com', '9876543214', '202 Maple St, San Francisco, CA'),
('Sophia', 'Wilson', 'sophia.wilson@gmail.com', '9876543215', '303 Birch St, Seattle, WA'),
('Daniel', 'Martinez', 'daniel.martinez@gmail.com', '9876543216', '404 Cedar St, Miami, FL'),
('Emma', 'Taylor', 'emma.taylor@gmail.com', '9876543217', '505 Willow St, Denver, CO'),
('James', 'Anderson', 'james.anderson@yahoo.com', '9876543218', '606 Aspen St, Dallas, TX'),
('Olivia', 'Hernandez', 'olivia.hernandez@gmail.com', '9876543219', '707 Palm St, Atlanta, GA');



INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Home & Kitchen'),
('Books'),
('Beauty & Health'),
('Sports & Fitness'),
('Toys & Games'),
('Automotive'),
('Jewelry'),
('Grocery');


INSERT INTO Products (product_name, category_id, price, stock_quantity) VALUES
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Blender', 3, 49.99, 40),
('Fiction Book', 4, 14.99, 75),
('Shampoo', 5, 9.99, 60),
('Basketball', 6, 29.99, 20),
('Toy Car', 7, 15.99, 90),
('Car Tire', 8, 79.99, 25),
('Gold Necklace', 9, 199.99, 15);


INSERT INTO Orders (user_id, order_date, total_amount, status) VALUES
(1, '2024-01-10 14:30:00', 719.98, 'Shipped'),
(2, '2024-02-15 09:45:00', 49.99, 'Pending'),
(3, '2024-03-20 18:00:00', 999.99, 'Delivered'),
(4, '2024-04-05 12:15:00', 19.99, 'Shipped'),
(5, '2024-05-12 16:20:00', 29.99, 'Pending'),
(6, '2024-06-25 08:50:00', 15.99, 'Delivered'),
(7, '2024-07-30 22:10:00', 79.99, 'Shipped'),
(8, '2024-08-18 10:05:00', 199.99, 'Pending'),
(9, '2024-09-07 14:45:00', 14.99, 'Delivered'),
(10, '2024-10-22 20:30:00', 9.99, 'Pending');


-- Retrieve all users' details from the Users table
Select * from users; 

-- Fetch the names and prices of all products from the Products table.
Select product_name,price from products;

-- List all orders along with the order date and total amount.
Select order_id,order_date,total_amount from orders;

-- Show all product categories available in the store.
Select * from categories order by category_id;

-- Find all users who ordered after January 1, 2024.
Select o.user_id,u.first_name,u.last_name,o.order_date 
from users u
join orders o on o.user_id=u.user_id
where order_date > 2024-09-15; 

-- Retrieve products that have a price between $50 and $200.
Select product_name,price from products where price between 50 and 200;

-- Find users whose email contains "@gmail.com".
Select * from users where email like "%@gmail.com";

-- List all products belonging to the "Electronics" category.
Select p.product_id,c.category_id,p.product_name,c.category_name
from products p
join categories c on c.category_id=p.category_id
where category_name ="Electronics";

-- Fetch all orders placed in December 2024.
Select * from orders where order_date between '2024-09-01' and '2024-09-31';

-- Retrieve the top 5 most expensive products.
Select * from products order by price desc limit 5;

-- Show the top 3 categories with the most products.
SELECT c.category_id, c.category_name, COUNT(p.product_id) AS product_count
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC
LIMIT 3;

-- List the latest 10 orders placed.
Select * from orders order by order_date desc;

-- Count the total number of users registered.
Select count(*) as users_registered from users where registration_date is not null;

-- Find the total revenue generated from all orders.
Select sum(total_amount) as Total_Revenue from orders;

-- Calculate the average price of all products in the store.
Select round(avg(price),3)  as Average_price from products;

-- Find the most expensive product in each category.
SELECT c.category_name, p.product_name, p.price
FROM Products p
JOIN Categories c ON c.category_id = p.category_id
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM Products p2
    WHERE p2.category_id = p.category_id
);

-- Show the number of orders placed per month.
Select month(order_date) as 'Month' , count(*) as Order_Placed  from orders group by month(order_date) order by month(order_date) asc;

-- Retrieve all orders along with the user's name who placed them.
Select o.order_id , u.user_id , u.first_name , u.last_name 
from orders o
join users u on o.user_id = u.user_id;

-- Fetch all products along with their category names.
Select p.product_id , c.category_id, p.product_name ,p.price 
from products p
join categories c on p.category_id=c.category_id;

-- Show all orders along with user details, including email and phone number.
Select o.order_id,u.first_name,u.last_name, u.email,u.phone_number ,o.total_amount
from users u
join orders o on o.user_id=u.user_id;

-- List all categories and the number of products in each.
Select c.category_name , count(p.product_id) as Total_Products 
from categories c 
join products p 
on p.category_id = c.category_id
group by category_name; 

-- List all orders where the total amount is above the average order total.
Select * from orders where total_amount > (Select avg(total_amount) from orders);

--  Find the users who have placed orders with a total amount greater than $500.
Select u.first_name ,u.last_name , u.address , o.total_amount
from users u
join orders o on o.user_id=u.user_id
where o.total_amount>500;

-- Create a view that shows the product_id, product_name, category_name, and price.
Create view product_summary as
Select p.product_id , p.product_name , c.category_name , p.price
from products p
join categories c
on c.category_id=p.category_id;

Select * from product_summary;

-- Create a view that displays all completed orders along with the total order amount.
Create view Order_Details as 
Select * from orders where status ="Delivered";

Select * from Order_Details;

-- Stored Procedure to Retrieve All Products Below a Given Stock Quantity
DELIMITER $$
CREATE PROCEDURE GetProductsBelowStockQuantity(IN stock_limit INT)
BEGIN
    SELECT product_name, stock_quantity
    FROM Products
    WHERE stock_quantity < stock_limit;
END$$

DELIMITER ;

call GetProductsBelowStockQuantity(30);




