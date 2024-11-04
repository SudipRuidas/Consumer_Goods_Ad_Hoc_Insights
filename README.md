# Consumer Goods Ad-Hoc Insights

### Data-Driven Analysis for Strategic Decision Making

**Prepared by**: Sudip Ruidas

---

## Project Overview

This project delivers ad-hoc insights for AtliQ Hardware, a leading computer hardware producer in India. The objective was to uncover actionable, data-driven insights to assist in strategic decision-making.

---

## Problem Statement

AtliQ Hardware's management faced difficulties in obtaining timely, actionable insights to support quick, informed decision-making. This analysis was initiated alongside a hiring initiative to expand the data analytics team.

---

## Tools Used

The following tools were used to conduct the analysis:

- **SQL**: For querying data and generating the ad-hoc insights requested.
- **Excel**: For data preprocessing, analysis, and summary calculations.

---

## Data Overview

The dataset includes the following tables:
- **dim_customer**: Customer data.
- **dim_product**: Product data.
- **fact_gross_price**: Gross prices per product.
- **fact_manufacturing_cost**: Production costs per product.
- **fact_pre_invoice_deductions**: Pre-invoice deductions per product.
- **fact_sales_monthly**: Monthly sales data.


### Data Model
![Data Model](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Data_Model/data_model_image.png)

---

## Business Model

AtliQ Hardware operates across several platforms and business channels, including:
- **Channels**: Retailer, Distributor, and Direct.
- **Platforms**: Brick & Mortar, E-Commerce.

### Business Model Visual
![Business Model](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Business_Model/business_model_image.png)

---

## Ad-Hoc Requests and Insights

1. **Request**: Provide the list of markets in which customer "AtliQ Exclusive" operates its business in the APAC region.
- **Insight**: In the APAC region, AtliQ Exclusive has stores in 8 markets.
    
     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q1.PNG)

<br>
<br>

2. **Request**: What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields: `unique_products_2020`, `unique_products_2021`, and `percentage_chg`.
 - **Insight**: AtliQ's product count grew by 36.33% from 245 in FY 2020 to 334 in FY 2021, indicating product expansion and potential market growth.
     
     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/Q2.PNG)

<br>
<br>

3. **Request**: Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains 2 fields: `segment` and `product_count`.
- **Insight**: The majority of AtliQ's products are in the Notebook (129) and Accessories (116) segments, while other categories like Peripherals, Desktops, and Networking have fewer offerings.

     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q3.PNG)

<br>
<br>

4. **Request**: Which segment had the most increase in unique products in 2021 vs. 2020? The final output contains these fields: `segment`, `product_count_2020`, `product_count_2021`, and `difference`.
- **Insight**: The Accessories segment led the growth in 2021, with an addition of 34 unique products. Both Peripherals and Notebooks also increased by 16 products each.
     
     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q4.PNG)

<br>
<br>

5. **Request**: Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields: `product_code`, `product`, and `manufacturing_cost`.
- **Insight**: AtliQ's product lineup shows a wide cost variation, with the AQ HOME Allin1 Gen 2 (Plus 3) having the highest manufacturing cost at $240.54, while the AQ Master Wired x1 Ms (Standard 1) is the most affordable to produce at just $0.89.

     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q5.PNG)

<br>
<br>

6. **Request**: Generate a report with the top 5 customers who received an average high `pre_invoice_discount_pct` for the fiscal year 2021 in the Indian market. The final output contains these fields: `customer_code`, `customer`, and `average_discount_percentage`.
- **Insight**: In FY 2021, Flipkart received the highest average pre-invoice discount at 30.83% in the Indian market, followed closely by Viveks, Ezone, Croma, and Amazon, all with average discounts around 30%.
     
     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/Q6.PNG)

<br>
<br>

7. **Request**: Get the complete report of the Gross sales amount for the customer “AtliQ Exclusive” for each month. This analysis helps to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns: `Month`, `Year`, and `Gross sales Amount`.
- **Insight**: March 2020 saw a gross sales low of $0.38 million, likely due to COVID-19 disruptions, while sales rebounded to a peak of $20.46 million in November 2020.
    
     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q7.png)

<br>
<br>

8. **Request**: In which quarter of 2020 did the maximum `total_sold_quantity` occur? The final output contains these fields sorted by `total_sold_quantity`: `Quarter` and `total_sold_quantity`.
- **Insight**: The analysis shows COVID-19's impact on sales, with Q3 (2020-2021) averaging a low 2.08 units sold, while Q1 averaged 7.01 units, indicating stronger sales and a recovery trend in following quarters.
    
     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q8.PNG)

<br>
<br>

9. **Request**: Which channel helped to bring more gross sales in the fiscal year 2021, and what was the percentage contribution? The final output contains these fields: `channel`, `gross_sales_mln`, and `percentage`.
- **Insight**: In FY 2021, the Retailer channel led with $1219.08 million in gross sales, accounting for 73.23% of total sales, followed by Direct and Distributor channels with 15.47% and 11.30%, respectively.
     
     ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q9.PNG)

<br>
<br>

10. **Request**: Get the top 3 products in each division that have a high `total_sold_quantity` in FY 2021. The final output contains these fields: `division` and `product_code`.
- **Insight**: In FY 2021, AQ Pen Drive 2 IN 1 (Premium) topped the N & S division with 701,373 units sold. AQ Gamers Ms (Standard 2) led the P & A division, and AQ Digit (Standard Blue) was the highest seller in the PC division.
    
  ![Output](https://raw.githubusercontent.com/SudipRuidas/Consumer_Goods_Ad_Hoc_Insights/refs/heads/master/Images/Outputs/q10.PNG)