-- DATA EXPLORATION 

SELECT * FROM amazon.amazon_explo1;

-- TOTAL amount of sales  made by amazon
SELECT  SUM(TotalAmount) 
FROM amazon_explo1;

-- How many orders
SELECT COUNT(*) AS TotalOrders
 FROM amazon_explo1;
-- most  selling product
SELECT ProductName , SUM(Quantity) AS TotalQuantity
FROM amazon_explo1
GROUP BY ProductName
ORDER BY TotalQuantity DESC
LIMIT 1;
-- total amount made by each country 
SELECT Country, SUM(TotalAmount) AS TotalSales
FROM amazon_explo1
GROUP BY Country;



-- Find the total shipping cost by state, sorted from highest to lowest

SELECT State, SUM(ShippingCost) AS total_shipping_cost,COUNT(*) AS order_count
FROM amazon_explo1
GROUP BY State
ORDER BY total_shipping_cost DESC;

-- Retrieve all orders where the total amount is greater than $1000
SELECT * 
FROM  amazon.amazon_explo1
WHERE TotalAmount > 1000;

-- Unique product categories and payment method available in the dataset
SELECT DISTINCT Category 
FROM   amazon.amazon_explo;
SELECT DISTINCT PaymentMethod
FROM amazon_explo;

-- count the total number of orders in the dataset
SELECT COUNT(*) AS total_orders 
FROM amazon_explo1 ;

-- display ordervthat have been delivered
SELECT * 
FROM  amazon_explo1
WHERE OrderStatus = 'Delivered';

-- List all orders from customers in Texas (TX)
SELECT * 
FROM amazon_explo
WHERE State = 'TX';
-- List the top 10 most expensive orders by total amount
SELECT * 
FROM  amazon_explo1
ORDER BY TotalAmount DESC 
LIMIT 10;
 
 -- Retrieve orders where quantity is greater than 4 
SELECT * 
FROM amazon_explo1
WHERE Quantity > 4;

-- Find customers who have spent more than $5,000 in total
SELECT CustomerID, CustomerName, 
SUM(TotalAmount) AS total_spent,
COUNT(*) AS order_count
FROM amazon_explo1
GROUP BY CustomerID, CustomerName
HAVING SUM(TotalAmount) > 5000
ORDER BY total_spent DESC;

-- Find the month with the highest number of orders in 2023
SELECT 
    MONTH(OrderDate) AS month,
    COUNT(*) AS order_count
FROM   amazon_explo1
WHERE YEAR(OrderDate) = 2023
GROUP BY MONTH(OrderDate)
ORDER BY order_count DESC
LIMIT 1;

-- Find the average order value for each country
SELECT Country, 
AVG(TotalAmount) AS avg_order_value,
COUNT(*) AS order_count
FROM amazon_explo1
GROUP BY Country
ORDER BY avg_order_value DESC;

-- Count how many orders each customer has placed, showing only customers with more than 5 orders
SELECT CustomerID, CustomerName, COUNT(*) AS order_count
FROM amazon_explo1
GROUP BY CustomerID, CustomerName
HAVING COUNT(*) > 5
ORDER BY order_count DESC;

-- Compare the total revenue between 2023 and 2024
SELECT YEAR(OrderDate) AS year,
SUM(TotalAmount) AS total_revenue,COUNT(*) AS order_count
FROM amazon_explo1
WHERE YEAR(OrderDate) IN (2023, 2024)
GROUP BY YEAR(OrderDate)
ORDER BY year;

-- Find customers who have spent more than $5,000 in total

SELECT CustomerID, CustomerName, 
SUM(TotalAmount) AS total_spent,COUNT(*) AS order_count
FROM amazon_explo1
GROUP BY CustomerID, CustomerName
HAVING SUM(TotalAmount) > 5000
ORDER BY total_spent DESC;

-- Find the total shipping cost by state, sorted from highest to lowest
SELECT State, SUM(ShippingCost) AS total_shipping_cost,COUNT(*) AS order_count
FROM amazon_explo1
GROUP BY State
ORDER BY total_shipping_cost DESC;

-- Find customers who have spent more than $5,000 in total

SELECT CustomerID, CustomerName, 
SUM(TotalAmount) AS total_spent,COUNT(*) AS order_count
FROM amazon_explo1
GROUP BY CustomerID, CustomerName
HAVING SUM(TotalAmount) > 5000
ORDER BY total_spent DESC;



SELECT 
    YEAR(OrderDate) AS year,
    QUARTER(OrderDate) AS quarter,
    COUNT(*) AS order_count,
    SUM(TotalAmount) AS revenue,
    ROUND(AVG(TotalAmount), 2) AS avg_order_value
FROM amazon_explo
GROUP BY YEAR(OrderDate), QUARTER(OrderDate)
ORDER BY year, quarter;

-- Find the correlation between discount percentage and order quantity
SELECT ROUND(AVG(Discount), 4) AS avg_discount,ROUND(AVG(Quantity), 2) AS avg_quantity,COUNT(*) AS sample_size,
    ROUND(
	(SUM((Discount - (SELECT AVG(Discount) FROM amazon_explo )) * (Quantity - (SELECT AVG(Quantity) FROM amazon_explo )))) /
	(SQRT(SUM(POW(Discount - (SELECT AVG(Discount) FROM amazon_explo), 2))) *SQRT(SUM(POW(Quantity - (SELECT AVG(Quantity) FROM amazon_explo   ), 2)))),
    4) AS correlation_coefficient
FROM amazon_explo1 ;


--  find what percentage of customers generate 80% of revenue
WITH customer_revenue AS (
    SELECT 
        CustomerID,
        CustomerName,
        SUM(TotalAmount) AS total_revenue
    FROM amazon_explo1
    GROUP BY CustomerID, CustomerName
),
ranked_customers AS (
    SELECT 
        CustomerID,
        CustomerName,
        total_revenue,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
        (SELECT SUM(total_revenue) FROM customer_revenue) AS total_revenue_all,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS customer_rank
    FROM customer_revenue
)
SELECT 
    customer_rank,
    CustomerID,
    CustomerName,
    total_revenue,
    cumulative_revenue,
    ROUND(cumulative_revenue * 100.0 / total_revenue_all, 2) AS cumulative_percent
FROM ranked_customers
WHERE cumulative_revenue <= (SELECT SUM(total_revenue) * 0.8 FROM customer_revenue);


-- Product Performance
SELECT ProductName,Category,Brand,
COUNT(*) AS times_ordered,SUM(Quantity) AS total_units_sold,SUM(TotalAmount) AS total_revenue,
AVG(TotalAmount) AS avg_order_value,AVG(Discount) AS avg_discount,COUNT(DISTINCT CustomerID) AS unique_customers
FROM  amazon_explo1
WHERE OrderStatus = 'Delivered'
GROUP BY ProductName, Category, Brand
ORDER BY total_revenue DESC
LIMIT 20;

-- Products that have been sold in at least 10 different state
SELECT ProductName,COUNT(DISTINCT State) AS states_count,SUM(Quantity) AS total_quantity_sold,SUM(TotalAmount) AS total_revenue
FROM amazon_explo1
GROUP BY ProductName
HAVING COUNT(DISTINCT State) >= 10
ORDER BY states_count DESC, total_revenue DESC;




