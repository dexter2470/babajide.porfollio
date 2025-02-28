Retail Sales Analysis SQL Project

This project aims to demonstrate SQL skills and techniques used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis, and answering specific business questions through SQL queries.

Objectives

1. Set up a retail sales database and populate it with provided sales data.
2. Clean the data by identifying and removing records with missing or null values.
3. Perform exploratory data analysis to understand the dataset.
4. Use SQL to answer specific business questions and derive insights from the sales data.

Database Setup

CREATE DATABASE sql_sales_project;

CREATE TABLE Retail_Sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

The project starts by creating a database named sql_sales_project.db. A table named Retail_Sales is created to store the sales data, with columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold, and total sale amount.

Data Exploration and Cleaning
The project involves exploring the data to understand the distribution of sales, customer demographics, and product categories. Records with missing or null values are identified and removed from the dataset.

Data Analysis and Findings

The project involves developing SQL queries to answer specific business questions, such as:

- Retrieving all columns for sales made on a specific date
- Retrieving all transactions where the category is 'Clothing' and the quantity sold is more than 4 in a specific month
- Calculating the total sales for each category
- Finding the average age of customers who purchased items from the 'Beauty' category

Insights and Recommendations

The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance. The insights can be used to:

- Identify top-selling categories and products
- Understand customer demographics and behavior
- Optimize pricing and inventory strategies
- Develop targeted marketing campaigns

Conclusion

This project demonstrates the use of SQL for data analysis and provides insights into retail sales data. The findings can be used to inform business decisions and drive growth.
