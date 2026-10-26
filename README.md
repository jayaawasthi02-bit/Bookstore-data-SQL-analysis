## Bookstore Sales & Inventory Analysis Using SQL

### Project Overview

This project focuses on analyzing bookstore data using Microsoft SQL Server (T-SQL) to understand book sales, customer purchasing behavior, revenue performance, and inventory levels.

Through a series of basic and advanced SQL queries, I explored how data can be transformed into meaningful business insights to support better decisions related to inventory management, customer retention, and sales performance.

#### Project Type: Data Analytics
#### Tool Used: Microsoft SQL Server
#### Domain: Retail / Bookstore Analytics

### Business Problems Solved

The project addresses key business questions across four major areas:

#### 1. Book & Product Analysis

Retrieved books by genre and publication year.

Identified the most expensive books and the top three most expensive books in the Fantasy genre.

Analyzed the number of books sold by genre and author.

Identified the most frequently ordered books and books with the highest total quantity purchased.

Examined total stock availability and books with the lowest stock levels.

#### 2. Customer Behavior Analysis

Identified customers who placed multiple orders.

Analyzed customer spending and purchasing frequency.

Explored customer locations by country and city.

Identified the highest-spending customer in each country.

#### 3. Sales & Revenue Analysis

Calculated total revenue generated from orders.

Analyzed monthly revenue, number of orders, and total quantity of books sold.

Retrieved orders exceeding a specified spending threshold.

Examined orders placed during November 2023.

#### 4. Inventory Management

Calculated remaining stock after accounting for ordered quantities.

Identified books at risk of running out of stock.

Categorized inventory into Out of Stock, Low Stock, and Sufficient Stock using conditional logic.

###  SQL Concepts & Techniques Used

This project helped me practice and apply the following SQL concepts:

1.Filtering & Sorting: WHERE, ORDER BY, TOP

2. Aggregation: COUNT(), SUM(), AVG(), MAX()

3. Grouping & Filtering Groups: GROUP BY, HAVING

4. Table Relationships: INNER JOIN, LEFT JOIN

5. Subqueries: Finding maximum book prices

6. Null Handling: COALESCE()

7. Conditional Logic: CASE expressions for inventory classification

8. Date Functions: DATENAME(), DATEPART()


### Key Analytical Insights
The queries were designed to uncover the following types of business insights:

##### Product Demand:
Comparing books sold across genres and authors can help identify product categories and authors that deserve closer attention.
##### Customer Loyalty:
Customers placing multiple orders can be identified for customer retention and loyalty initiatives.
##### Revenue Performance: 
Comparing revenue of different months like in the data 
Monthly revenue -January with the highest revenue
Order counts - with July having highest number of order placed.
##### Inventory Risk: 
Comparing stock levels with ordered quantities helps flag books that may require replenishment.
##### Customer Spending Patterns:
Identifying high-spending customers by country can support targeted promotions and personalized offers.
##### Pricing Opportunities: 
Comparing price of different book of different genre can help decide the preference of the customers. 
This data have Mystery genre with the highest number of book sold 504.

### Business Solutions & Recommendations

Based on the analyses this project enables, a bookstore could consider the following actions:

##### Inventory Management

Prioritize replenishment for out-of-stock and low-stock books, after validating actual inventory movements.

##### Product Strategy

Use genre- and author-level sales data to guide purchasing and product assortment decisions.

##### Customer Retention

Develop loyalty offers for repeat customers and personalized promotions for high-spending customers.

##### Sales Monitoring

Track monthly revenue, orders, and books sold to identify changes in business performance.

##### Pricing Strategy

Compare prices across genres and review the performance of higher-priced books before making pricing decisions.

##### Marketing Strategy

Use customer spending and location analysis to plan targeted campaigns.

These recommendations illustrate how SQL analysis can support data-driven decisions in a retail business.


### What I Learned

Through this project, I strengthened my ability to:

Translate business questions into SQL queries.

Retrieve and analyze data from multiple related tables.

Apply aggregations and joins to investigate sales and customer behavior.

Use CTEs and window functions to solve more advanced analytical problems.

Calculate inventory indicators and develop actionable business recommendations.

Approach business problems with a structured, data-driven mindset.


#### Skills: SQL | Microsoft SQL Server | Data Analysis | Business Insights | Inventory Analysis | Sales Analysis
