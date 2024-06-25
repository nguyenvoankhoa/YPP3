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
SELECT
    AVG(total)
FROM
    (SELECT
        txn_id, SUM(qty) AS total
    FROM
        sales
    GROUP BY txn_id) AS cte
```

## 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?

```sql
WITH cte AS (
    SELECT
        txn_id,
        SUM(price * qty) AS revenue,
        NTILE(4) OVER (ORDER BY SUM(price * qty)) AS ranking
    FROM
        sales
    GROUP BY
        txn_id
)
SELECT
    MAX(CASE WHEN ranking = 1 THEN revenue ELSE 0 END) AS 25_th,
    MAX(CASE WHEN ranking = 2 THEN revenue ELSE 0 END) AS 50_th,
    MAX(CASE WHEN ranking = 3 THEN revenue ELSE 0 END) AS 75_th
FROM
    cte;


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
SELECT
    AVG(revenue), member
FROM
    (SELECT
        member, txn_id, SUM(price * qty) AS revenue
    FROM
        sales
    GROUP BY member , txn_id) AS cte
GROUP BY member

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
SELECT
    category_name, prod_id
FROM
    cte
WHERE
    ranking = 1
```

## 6. What is the percentage split of revenue by product for each segment?

```sql
WITH cte AS (SELECT
    product_name, segment_name, SUM(qty * s.price) AS revenue
FROM
    sales s
        JOIN
    product_details p ON s.prod_id = p.product_id
GROUP BY product_name , segment_name)
SELECT
    product_name,
    segment_name,
    100 * revenue / (SELECT
            SUM(revenue)
        FROM
            cte) AS pct
FROM
    cte
```

## 7. What is the percentage split of revenue by segment for each category?

```sql
with cte as (SELECT
    segment_name, category_name, SUM(qty * s.price) AS revenue
FROM
    sales s
        JOIN
    product_details p ON s.prod_id = p.product_id
GROUP BY segment_name , category_name)
SELECT
    segment_name,
    category_name,
    100 * revenue / (SELECT
            SUM(revenue)
        FROM
            cte) AS pct
FROM
    cte
```

## 8. What is the percentage split of total revenue by category?

```sql
WITH cte AS (SELECT
    category_name, SUM(qty * s.price) AS rev
FROM
    sales s
        JOIN
    product_details p ON s.prod_id = p.product_id
GROUP BY category_name)
SELECT
    category_name,
    100 * rev / (SELECT
            SUM(rev)
        FROM
            cte) AS pct
FROM
    cte
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
