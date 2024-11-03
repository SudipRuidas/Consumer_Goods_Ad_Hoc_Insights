-- 1

select market from dim_customer 
where customer="Atliq Exclusive" and region = "APAC"

-- 2

with cte1 as(
SELECT count(distinct(product_code)) as unique_products_2020 FROM fact_sales_monthly
where fiscal_year = "2020"
),

cte2 as(
SELECT count(distinct(product_code)) as unique_products_2021  FROM fact_sales_monthly
where fiscal_year = "2021"
)

select *, round(((unique_products_2021-unique_products_2020)*100/unique_products_2020),2) as percentage_chg 
from cte1,cte2;	

-- 3
select segment,
count(distinct product_code) as  Product_count
from dim_product
group by segment
order by Product_count desc;

-- 4
with cte1 as(
SELECT  segment, count(product_code)  as product_count_2020 
from dim_product as p
join fact_gross_price using (product_code)
where fiscal_year="2020"
group by segment
),

 cte2 as(
SELECT  segment, count(product_code)  as product_count_2021 from dim_product as p
join fact_gross_price using (product_code)
where fiscal_year="2021"
group by segment
)

select *, product_count_2021-product_count_2020 as difference 
from cte1 join cte2 using(segment) 
order by difference desc;

-- 5
SELECT m.product_code, concat(product," (",variant,")") AS product,manufacturing_cost
FROM fact_manufacturing_cost m
JOIN dim_product p ON m.product_code = p.product_code
WHERE manufacturing_cost= 
(SELECT min(manufacturing_cost) FROM fact_manufacturing_cost)
or 
manufacturing_cost = 
(SELECT max(manufacturing_cost) FROM fact_manufacturing_cost) 
ORDER BY manufacturing_cost DESC;

-- 6
select customer_code, customer, pre_invoice_discount_pct as average_discount_percentage
from fact_pre_invoice_deductions join dim_customer using(customer_code)
where pre_invoice_discount_pct>(select avg(pre_invoice_discount_pct)
from fact_pre_invoice_deductions) 
and
fiscal_year= "2021" and market = "india"
order by pre_invoice_discount_pct desc;

limit 5

-- 7
with cte1 as(
select date, monthname(date) as Month, product_code, customer_code, 
fiscal_year, gross_price, sold_quantity
from fact_gross_price  join fact_sales_monthly  
using(product_code, fiscal_year) 
join dim_customer using(customer_code)
where customer = "Atliq Exclusive"
)

select month, year(date) as Year, 
round(sum(sold_quantity*gross_price)/1000000,2) as Gross_sales_Amount FROM cte1
group by month,Year
order by Year;

-- 8

with cte1 as(
select date, quarter(date_add(date, interval 4 month)) as qrtr, 
sold_quantity
from fact_sales_monthly
where fiscal_year="2020"
)

select
CASE
    WHEN qrtr = 1 THEN "Q1"
    WHEN qrtr = 2 THEN "Q2"
    WHEN qrtr = 3 THEN "Q3"
    ELSE "Q4"
END AS Quarter,
round(sum(sold_quantity)/1000000,2) as total_sold_quantity
from cte1
group by Quarter
order by total_sold_quantity desc

-- 9

with cte1 as (
select c.channel,
round(sum((s.sold_quantity*g.gross_price)/1000000),2) as gross_sales_mln
from dim_customer c
join fact_sales_monthly s
on c.customer_code = s.customer_code
join fact_gross_price g
on s.product_code = g.product_code
where s.fiscal_year = 2021
group by c.channel
)
select 
*,
concat(round(gross_sales_mln*100/ (select sum(gross_sales_mln) from cte1),2)) as pct_contribution
from cte1
order by pct_contribution desc;

-- 10

with cte1 as(
select division, product_code, concat(product," (", variant,")") as product_name, 
sum(sold_quantity) as total_sold_quantity,
rank() over(partition by division order by sum(sold_quantity) desc ) as rank_order
from dim_product  join fact_sales_monthly
using(product_code)
where fiscal_year = "2021"
group by division, product_code, product_name
) 

select * from cte1
where rank_order<=3

 
