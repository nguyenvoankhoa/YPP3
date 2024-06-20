## High Level Sales Analysis
## 1. What was the total quantity sold for all products?
```sql
select sum(qty) as total_qty from sales
```
## 2. What is the total generated revenue for all products before discounts?
```sql
select sum(qty * price) as revenue from sales; 

```
## 3. What was the total discount amount for all products?
```sql
select sum(discount) as total_discount from sales

```
## Transaction Analysis
## 1. How many unique transactions were there?
```sql
select count(distinct txn_id) as unique_trans from sales

```
## 2. What is the average unique products purchased in each transaction?
```sql
select avg(total) from (select txn_id, sum(qty) as total from sales group by txn_id) as cte
```
## 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
```sql
with cte as (select txn_id , sum(price * qty) as revenue, ntile(4) over (order by sum(price * qty)) as ranking from sales group by txn_id)
select max(case when ranking = 1 then revenue else 0 end) as 25_th, 
max(case when ranking = 2 then revenue else 0 end) as 50_th,
max(case when ranking = 3 then revenue else 0 end) as 75_th
from cte

```
## 4. What is the average discount value per transaction?
```sql
select avg(total_discount) from ( select txn_id , sum(qty * price * discount / 100) as total_discount from sales group by txn_id) as cte

```
## 5. What is the percentage split of all transactions for members vs non-members?
```sql
select 100 *sum(case when member = 't' then 1 else 0 end) / count(*) as member_pct from sales
```
## 6. What is the average revenue for member transactions and non-member transactions?
```sql
select avg(revenue), member from (
select member, txn_id ,sum(price * qty) as revenue from sales group by member, txn_id
) as cte group by member

```
## Product Analysis
## 1. What are the top 3 products by total revenue before discount?
```sql
SELECT 
    prod_id, SUM(qty * price) AS revenue
FROM
    sales
GROUP BY prod_id
ORDER BY revenue DESC
LIMIT 3
```
## 2. What is the total quantity, revenue and discount for each segment?
```sql
SELECT 
    segment_name,
    SUM(qty) AS total_qty,
    SUM(qty * sales.price) AS revenue,
    SUM((qty * sales.price * discount) / 100) AS discount
FROM
    sales
        JOIN
    product_details ON sales.prod_id = product_details.product_id
GROUP BY segment_name
```
## 3. What is the top selling product for each segment?
```sql
select segment_name, prod_id, ranking from (
SELECT 
    segment_name,
    prod_id,
    rank() over (partition by segment_name order by sum(qty) desc) as ranking
FROM
    sales
        JOIN
    product_details ON sales.prod_id = product_details.product_id
GROUP BY segment_name, prod_id
) as cte where ranking = 1
```
## 4. What is the total quantity, revenue and discount for each category?
```sql
SELECT 
    category_name,
    SUM(qty) AS total_qty,
    SUM(qty * s.price) AS revenue,
    SUM((qty * s.price * discount) / 100) AS discount
FROM
    sales s
        JOIN
    product_details p ON s.prod_id = p.product_id
GROUP BY category_name
```
## 5. What is the top selling product for each category?
```sql
with cte as (SELECT 
    category_name,
    prod_id,
    RANK() OVER (partition by category_name order by SUM(qty) desc) AS ranking
FROM
    sales s
        JOIN
    product_details p ON s.prod_id = p.product_id
GROUP BY category_name, prod_id)
select category_name,
    prod_id from cte where ranking = 1
```
## 6. What is the percentage split of revenue by product for each segment?
```sql
with cte as (select product_name, segment_name, sum(qty*s.price) as revenue from sales s join product_details p on s.prod_id = p.product_id
group by product_name, segment_name)
select product_name, segment_name, 100*revenue / (select sum(revenue) from cte) as pct from cte
```
## 7. What is the percentage split of revenue by segment for each category?
```sql
with cte as (select segment_name, category_name, sum(qty*s.price) as revenue from sales s join product_details p on s.prod_id = p.product_id
group by segment_name, category_name)
select segment_name, category_name, 100*revenue / (select sum(revenue) from cte) as pct from cte
```
## 8. What is the percentage split of total revenue by category?
```sql
with cte as (select category_name, sum(qty*s.price) as rev from sales s join product_details p on s.prod_id = p.product_id group by category_name)
select category_name, 100* rev/ (select sum(rev) from cte) as pct from cte
```
## 9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
```sql
SELECT 
    prod_id,
    100 * COUNT(DISTINCT txn_id) / (SELECT 
            COUNT(DISTINCT txn_id)
        FROM
            sales) AS penetration
FROM
    sales
GROUP BY prod_id
```
## 10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
```sql
SELECT 
    s.prod_id,
    t1.prod_id,
    t2.prod_id,
    COUNT(*) AS combination_cnt
FROM
    sales s
        JOIN
    sales t1 ON t1.txn_id = s.txn_id
        AND s.prod_id < t1.prod_id
        JOIN
    sales t2 ON t2.txn_id = s.txn_id
        AND t1.prod_id < t2.prod_id
GROUP BY 1 , 2 , 3
ORDER BY 4 DESC
LIMIT 1;
```
