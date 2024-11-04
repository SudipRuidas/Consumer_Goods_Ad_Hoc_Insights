1. Provide the list of markets in which customer "Atliq Exclusive" operates its
business in the APAC region.

SELECT market 
FROM dim_customer 
WHERE customer="Atliq Exclusive" AND region = "APAC"


2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
unique_products_2020
unique_products_2021
percentage_chg

WITH cte1 AS(
SELECT count(DISTINCT(product_code)) AS unique_products_2020 
FROM fact_sales_monthly
WHERE fiscal_year = "2020"
),

cte2 AS(
SELECT count(DISTINCT(product_code)) AS unique_products_2021  
FROM fact_sales_monthly
where fiscal_year = "2021"
)

SELECT *, round(((unique_products_2021-unique_products_2020)*100/unique_products_2020),2) AS percentage_chg 
FROM cte1,cte2;	


3. Provide a report with all the unique product counts for each segment and
sort them in descending order of product counts. The final output contains
2 fields,
segment
product_count

SELECT segment,
count(DISTINCT product_code) AS  Product_count
FROM dim_product
GROUP BY segment
ORDER BY Product_count DESC;


4. Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment
product_count_2020
product_count_2021
difference

WITH cte1 AS(
SELECT  segment, count(product_code)  AS product_count_2020 
FROM dim_product AS p
JOIN fact_gross_price USING (product_code)
WHERE fiscal_year="2020"
GROUP BY segment
),

 cte2 AS(
SELECT  segment, count(product_code) AS product_count_2021 
FROM dim_product AS p
JOIN fact_gross_price USING (product_code)
WHERE fiscal_year="2021"
GROUP BY segment
)

SELECT *, product_count_2021-product_count_2020 AS difference 
FROM cte1 JOIN cte2 USING(segment) 
ORDER BY difference DESC;


5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost

SELECT m.product_code, concat(product," (",variant,")") AS product,manufacturing_cost
FROM fact_manufacturing_cost m
JOIN dim_product p ON m.product_code = p.product_code
WHERE manufacturing_cost= 
(SELECT min(manufacturing_cost) FROM fact_manufacturing_cost)
or 
manufacturing_cost = 
(SELECT max(manufacturing_cost) FROM fact_manufacturing_cost) 
ORDER BY manufacturing_cost DESC;


6. Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the
Indian market. The final output contains these fields,
customer_code
customer
average_discount_percentage

SELECT customer_code, customer, pre_invoice_discount_pct AS average_discount_percentage
FROM fact_pre_invoice_deductions JOIN dim_customer USING(customer_code)
WHERE pre_invoice_discount_pct>(SELECT AVG(pre_invoice_discount_pct)
FROM fact_pre_invoice_deductions) 
AND
fiscal_year= "2021" AND market = "india"
ORDER BY pre_invoice_discount_pct DESC;
LIMIT 5


7. Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount

WITH cte1 AS(
SELECT date, monthname(date) AS Month, product_code, customer_code, 
fiscal_year, gross_price, sold_quantity
FROM fact_gross_price  JOIN fact_sales_monthly  
USING(product_code, fiscal_year) 
JOIN dim_customer USING(customer_code)
WHERE customer = "Atliq Exclusive"
)

SELECT month, year(date) AS Year, 
round(sum(sold_quantity*gross_price)/1000000,2) AS Gross_sales_Amount 
FROM cte1
GROUP BY month,Year
ORDER BY Year;


8. In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
Quarter
total_sold_quantity

WITH cte1 AS(
SELECT date, quarter(date_add(date, interval 4 month)) AS qrtr, 
sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year="2020"
)

SELECT
CASE
    WHEN qrtr = 1 THEN "Q1"
    WHEN qrtr = 2 THEN "Q2"
    WHEN qrtr = 3 THEN "Q3"
    ELSE "Q4"
END AS Quarter,
round(sum(sold_quantity)/1000000,2) AS total_sold_quantity
FROM cte1
GROUP BY Quarter
ORDER BY total_sold_quantity DESC;


9. Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel
gross_sales_mln
percentage

WITH channel_gs AS(
SELECT channel, sum(gross_price*sold_quantity) AS gross_sales 
FROM fact_gross_price
JOIN fact_sales_monthly USING(product_code, fiscal_year)
JOIN dim_customer USING(customer_code)
WHERE fiscal_year = 2021
GROUP BY channel)

SELECT channel, 
round(gross_sales/1000000,2) AS gross_sales_mln, 
round((gross_sales/(SELECT sum(gross_sales) from channel_gs))*100,2) AS percentage
FROM channel_gs
ORDER BY percentage DESC; 


10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_order

WITH cte1 as(
SELECT division, product_code, concat(product," (", variant,")") AS product_name, 
sum(sold_quantity) as total_sold_quantity,
RANK() OVER(PARTITION BY division ORDER BY sum(sold_quantity) DESC ) AS rank_order
FROM dim_product  JOIN fact_sales_monthly
USING(product_code)
WHERE fiscal_year = "2021"
GROUP BY division, product_code, product_name
) 

SELECT * FROM cte1
WHERE rank_order<=3

 
