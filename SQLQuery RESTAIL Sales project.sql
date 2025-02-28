-- An SQL Retail Sales Analysis Report
CREATE DATABASE sql_sales_project;

-- Create a table 
DROP TABLE IF EXISTS Retail_Sales;
CREATE TABLE Retail_Sales (transactions_id INT PRIMARY KEY,
	sale_date DATE, sale_time TIME, customer_id INT, gender VARCHAR(15), age INT, category VARCHAR (15), quantiy INT, price_per_unit FLOAT, cogs FLOAT, total_sale FLOAT

);

SELECT * FROM retail_sales;

--Insert the data from the Csv file into the table created
BULK INSERT Retail_Sales
FROM "C:\Users\nutty\Downloads\Retail Sales..csv"
WITH 
(	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
    FIRSTROW = 2  -- skip the header row

);

SELECT TOP 10* 
FROM Retail_Sales
ORDER BY  transactions_id  ;

SELECT 
    COUNT(*) 
FROM Retail_Sales

--renamed the column "QUANTIY" TO "QUANTITY" to avoid conflict errors while cleaning data
EXEC sp_rename 'sql_sales_project.dbo.Retail_Sales.quantiy', 
'quantity', 'COLUMN';

SELECT *
FROM Retail_Sales;

--Clean the data for Null in the Transions_id, sale_date, sale_time, customer_id, gender,age, category, quantity, 
-- price_per_unit, cogs, total_sale

SELECT * FROM Retail_Sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
	OR
	customer_id IS NULL
    OR
    gender IS NULL
	OR
	age IS NULL	
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


-- there are 13 rows of  NULL values but we want to keep the age so we delete the rest since dont have 
-- informations about the values to replace we delete it 

SELECT * FROM Retail_Sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
	OR
	customer_id IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


--  after omiting the age, we have just 3 rows of values, so we proceed to delete since we dont have the information to replace

DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
	OR
	customer_id IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration

-- --How many Customers have we got?

SELECT COUNT (DISTINCT customer_id) as total_customer
FROM Retail_Sales;
 
SELECT DISTINCT category 
FROM Retail_Sales;

--Total number of sales
SELECT COUNT(*) as total_sale 
FROM Retail_Sales;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Find the total sales for each category
-- Q.2: Identify the top 2 Categoriess with the highest sales in each category.
-- Q.3: Calculate the average order value for each Gender.
-- Q.4: Find the number of transactions for each Category
-- Q.5: Find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.6: Identify the customers who have made purchases in multiple categories.
-- Q.7: Calculate the total sales for each quarter of the year.
-- Q.8: Find all transactions where the total_sale is greater than 1000.
-- Q.9: Find the top 5 products with the highest Total  sales.
-- Q.10:Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.11: Identify the customers who have made purchases on multiple days.
-- Q.12: Calculate the average sales per day for each month.
-- Q.13: Find the total sales for each hour of the day.
-- Q.14: Retrieve all columns for sales made on '2022-11-05
-- Q.15: Calculate the total sales (total_sale) for each  category.
-- Q.16: Find the average age of customers who purchased items from the 'Beauty' category.
-- Q.17: Calculate the average sale for each month. Find out best selling month in each year
-- Q.18: Find the top 5 customers based on the highest total sales 
-- Q.19: Find the number of unique customers who purchased items from each category.
-- Q.20: Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Find the total sales for each category.

-- The query retrieves the total sales for each category from the Retail_Sales table.
SELECT category, SUM(total_sale) as total_sales 
FROM Retail_Sales 
GROUP BY category;

-- Q.2: Identify the top 2 Categories with the highest sales in each category.

-- This query  retrieve the top  2 categories with the highest sales.
SELECT TOP 2 category, SUM(total_sale) as total_sales 
FROM Retail_Sales 
GROUP BY category 
ORDER BY total_sales DESC;


-- Q.3: Calculate the average order value for each Gender.

--This  query  calculates the average order value for each gender.
SELECT gender, AVG(total_sale) as average_order_value 
FROM Retail_Sales 
GROUP BY gender;


-- Q.4: Find the number of transactions for each category

--The query finds the number of transactions for each of the category.
SELECT category, COUNT(transactions_id) as num_transactions 
FROM Retail_Sales 
GROUP BY category;

-- Q.5: Find the total number of transactions (transaction_id) made by each gender in each category.

-- The query finds the total number of transactions made by each gender in each category.
SELECT category, gender, COUNT(transactions_id) as total_transactions 
FROM Retail_Sales 
GROUP BY category, gender;

-- Q.6: Identify the customers who have made purchases in multiple categories

--The query helps identify the customers who have made purchases in multiple categories.
SELECT customer_id, COUNT(DISTINCT category) as num_categories 
FROM Retail_Sales 
GROUP BY customer_id 
HAVING COUNT(DISTINCT category) > 1;


-- Q.7: Calculate the total sales for each quarter of the year.

		--this  query is designed to calculate the total sales for each quarter of the year.
		-- The Ccase statement Determines the quarter based on the month of the sale_date.
		 --    If the month is January, February, or March, it's Quarter 1.
		 --    If the month is April, May, or June, it's Quarter 2.
		 --    If the month is July, August, or September, it's Quarter 3.
		 --    Otherwise, it's Quarter 4 
SELECT 
  YEAR(sale_date) as sales_year, 
  CASE 
    WHEN MONTH(sale_date) IN (1, 2, 3) THEN 1
    WHEN MONTH(sale_date) IN (4, 5, 6) THEN 2
    WHEN MONTH(sale_date) IN (7, 8, 9) THEN 3
    ELSE 4
  END as sales_quarter, 
  SUM(total_sale) as total_sales 
FROM Retail_Sales 
GROUP BY YEAR(sale_date), 
  CASE 
    WHEN MONTH(sale_date) IN (1, 2, 3) THEN 1
    WHEN MONTH(sale_date) IN (4, 5, 6) THEN 2
    WHEN MONTH(sale_date) IN (7, 8, 9) THEN 3
    ELSE 4
  END
ORDER BY sales_year, sales_quarter;

-- Q.8: Find all transactions where the total_sale is greater than 1000.

-- This  query Will retrieve all transactions from the Retail_Sales table where the total_sale is greater than 1000.
SELECT * 
FROM Retail_Sales 
WHERE total_sale > 1000;

-- Q.9: Find the top 5 customers with the highest Total sales 

--This  queryto findS the top 5 customers with the highest total sales.
SELECT TOP 5 customer_id, SUM(total_sale) as total_sales 
FROM Retail_Sales 
GROUP BY customer_id 
ORDER BY total_sales DESC;

-- Q.10: Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

--This query retrieves all transactions from the Retail_Sales table 
-- from the clothing category with the quantity more than 3 in the month of november 2022

SELECT * 
FROM Retail_Sales 
WHERE category = 'Clothing' 
  AND quantity > 3 
  AND sale_date >= '2022-11-01' 
  AND sale_date <= '2022-11-30';

 -- Q.11: Identify the customers who have made purchases on multiple days.

 --This  query helps  identify the customers who have made purchases on multiple days.
SELECT customer_id, COUNT(DISTINCT sale_date) as num_days 
FROM Retail_Sales 
GROUP BY customer_id 
HAVING COUNT(DISTINCT sale_date) > 1;

-- Q.12: Calculate the average sales per day for each month.

-- this calculate sthe average sales per day for each month.
SELECT 
  YEAR(sale_date) as sales_year, 
  MONTH(sale_date) as sales_month, 
  AVG(DAILY_SALES) as average_daily_sales 
FROM 
  (SELECT sale_date, SUM(total_sale) as DAILY_SALES 
   FROM Retail_Sales 
   GROUP BY sale_date) AS DAILY_SALES_TABLE
GROUP BY YEAR(sale_date), MONTH(sale_date);


-- Q.13: Find the total sales for each hour of the day.

--The query  find the total sales for each hour of the day.
--DATEPART(hour, sale_time) extracts the hour from the sale_time column.
-- DATEPART is commonly used in SQL Server, while EXTRACT is used in PostgreSQL and Oracle
SELECT 
  DATEPART(hour, sale_time) as sales_hour, 
  SUM(total_sale) as total_sales 
FROM Retail_Sales 
GROUP BY DATEPART(hour, sale_time)
ORDER BY sales_hour;

-- Q.14: Retrieve all columns for sales made on '2022-11-05

--the query retrieves all columns (*) for sales made on a specific date, which is  '2022-11-05'
SELECT * 
FROM Retail_Sales 
WHERE sale_date = '2022-11-05';

-- Q.15: Calculate the total sales (total_sale) for each  category.
SELECT category, SUM(total_sale) as total_sales 
FROM Retail_Sales 
GROUP BY category;

-- Q.16: Find the average age of customers who purchased items from the 'Beauty' category.

--This query will  find the average age of customers who purchased items from the 'Beauty' category.
SELECT AVG(age) as average_age 
FROM Retail_Sales 
WHERE category = 'Beauty';

-- Q.17: Calculate the average sale for each month. Find out best selling month in each year

--This query will calculate the average sale for each month and find the best-selling month in each year.
SELECT YEAR(sale_date) as sales_year, 
       MONTH(sale_date) as sales_month, 
       AVG(total_sale) as average_sales 
FROM Retail_Sales 
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY sales_year, average_sales DESC;


-- Q.18: Find the top 5 customers based on the highest total sales 

--The query will help find the top 5 customers based on the highest total sales.
SELECT TOP 5 customer_id, SUM(total_sale) as total_sales 
FROM Retail_Sales 
GROUP BY customer_id 
ORDER BY total_sales DESC;

-- Q.19: Find the number of unique customers who purchased items from each category.

--what the qery does is find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) as unique_customers 
FROM Retail_Sales 
GROUP BY category;


-- Q.20: Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- The query categorizes each sale into a shift based on the hour of the day 
-- and count the number of orders for each shift.
--  We used case statement to define the shifts based on the hour of the day:
--	Morning:  12am - 12pm
--	Afternoon: 1pm - 5pm
--	Evening:   6pm - 11pm
SELECT 
  CASE 
    WHEN DATEPART(HOUR FROM sale_time) <= 12 THEN 'Morning'
    WHEN DATEPART(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS num_orders
FROM Retail_Sales
GROUP BY 
  CASE 
    WHEN DATEPART(HOUR FROM sale_time) <= 12 THEN 'Morning'
    WHEN DATEPART(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END
ORDER BY shift;























