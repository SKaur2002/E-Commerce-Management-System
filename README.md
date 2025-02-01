## E-Commerce-SalesAnalysis-System

# Overview

This repository contains SQL scripts for creating and managing an e-commerce database. It includes database schema definitions, data insertion, and various queries for data retrieval and analysis. Additionally, it features stored procedures and views to enhance database functionality.

# Database Structure

The database is named SQL_projects and contains the following tables:

Users - Stores user details such as name, email, phone number, and registration date.

Categories - Defines different product categories.

Products - Stores product details, including name, category, price, and stock quantity.

Orders - Contains order details, including user ID, order date, total amount, and status.

# Schema Creation

CREATE TABLE statements define the database schema.

AUTO_INCREMENT is used for primary keys.

FOREIGN KEY constraints ensure referential integrity.

CHECK constraints validate price and stock quantity.

# Data Insertion

Sample data for Users, Categories, Products, and Orders is included.

# SQL Queries

The project includes various queries for retrieving useful insights:

Fetching all users, products, and orders.

Filtering users based on email and order date.

Retrieving top products by price.

Counting total registered users and calculating revenue.

Finding the most expensive product in each category.

Analyzing orders placed per month.

# Views

product_summary - Displays product details with category names.

Order_Details - Lists all delivered orders.

# Stored Procedure

GetProductsBelowStockQuantity(stock_limit) - Retrieves products with stock lower than a given limit.

# Usage

Open MySQL Workbench or any SQL environment.

Execute the scripts in sequence:

Create database and tables.

Insert sample data.

Run queries, views, and stored procedures.

# Contributions

Feel free to contribute by adding more queries, optimizing performance, or extending the database schema.

# License

This project is open-source and available under the MIT License.
