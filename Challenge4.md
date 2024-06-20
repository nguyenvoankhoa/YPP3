## A. Customer Nodes Exploration
## How many unique nodes are there on the Data Bank system?
```sql
SELECT 
    COUNT(DISTINCT (node_id)) AS unique_node
FROM
    customer_nodes
```
## What is the number of nodes per region?
```sql
SELECT 
    COUNT(DISTINCT node_id), r.region_id
FROM
    customer_nodes AS c
        JOIN
    regions AS r ON c.region_id = r.region_id
GROUP BY region_id
```
## How many customers are allocated to each region?
```sql
SELECT 
    COUNT(customer_id), r.region_id
FROM
    customer_nodes AS c
        JOIN
    regions AS r ON c.region_id = r.region_id
GROUP BY region_id
```
## How many days on average are customers reallocated to a different node?
```sql
SELECT avg(TIMESTAMPDIFF(DAY, start_date, end_date)) AS date_diff FROM customer_nodes WHERE end_date != '9999-12-31'
```
## What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
```sql

with cte as (
SELECT 
    DATEDIFF(end_date, start_date) AS reallocation, region_id,
    ntile(20) over (order by datediff(end_date, start_date)) as ranking
FROM
    customer_nodes
WHERE
    end_date != '9999-12-31'
)
SELECT 
    MAX(CASE
        WHEN ranking = 10 THEN reallocation
        ELSE 0
    END) AS median,
    MAX(CASE
        WHEN ranking = 16 THEN reallocation
        ELSE 0
    END) AS 80_th,
    MAX(CASE
        WHEN ranking = 19 THEN reallocation
        ELSE 0
    END) AS 95_th,
    region_id
FROM
    cte
GROUP BY region_id
```
## B. Customer Transactions
## What is the unique count and total amount for each transaction type?
```sql
SELECT 
    txn_type, COUNT(*), SUM(txn_amount)
FROM
    customer_transactions
GROUP BY txn_type
```
## What is the average total historical deposit counts and amounts for all customers?
```sql
SELECT 
    AVG(COUNT(DISTINCT customer_id)), AVG(txn_amount)
FROM
    customer_transactions
WHERE
    txn_type = 'deposit'
```
## For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
```sql
SELECT 
    monthly, COUNT(DISTINCT customer_id)
FROM
    (SELECT 
        customer_id,
            MONTH(txn_date) AS monthly,
            SUM(CASE
                WHEN txn_type = 'deposit' THEN 0
                ELSE 1
            END) AS deposit_count,
            SUM(CASE
                WHEN txn_type = 'purchase' THEN 0
                ELSE 1
            END) AS purchase_count,
            SUM(CASE
                WHEN txn_type = 'withdrawal' THEN 0
                ELSE 1
            END) AS withdrawal_count
    FROM
        customer_transactions
    GROUP BY customer_id , monthly) AS cte_table
WHERE
    deposit_count > 1
        AND (purchase_count >= 1
        OR withdrawal_count >= 1)
GROUP BY monthly
```
## What is the closing balance for each customer at the end of the month?
```sql
SELECT 
    customer_id,
    monthly,
    SUM(deposit_count + purchase_count + withdrawal_count)
FROM
    (SELECT 
        customer_id,
            MONTH(txn_date) AS monthly,
            SUM(CASE
                WHEN txn_type = 'deposit' THEN txn_amount
                ELSE 0
            END) AS deposit_count,
            SUM(CASE
                WHEN txn_type = 'purchase' THEN - txn_amount
                ELSE 0
            END) AS purchase_count,
            SUM(CASE
                WHEN txn_type = 'withdrawal' THEN - txn_amount
                ELSE 0
            END) AS withdrawal_count
    FROM
        customer_transactions
    GROUP BY customer_id , monthly) AS cte_table
GROUP BY customer_id , monthly
ORDER BY customer_id
```
## What is the percentage of customers who increase their closing balance by more than 5%?
```sql
WITH cte AS (
    SELECT 
        customer_id, 
        MONTH(txn_date) AS monthly,
        SUM(
            CASE 
                WHEN txn_type = 'purchase' OR txn_type = 'withdrawal' THEN -txn_amount 
                ELSE txn_amount 
            END
        ) AS transaction_balance
    FROM 
        customer_transactions 
    GROUP BY 
        customer_id, 
        monthly 
    ORDER BY 
        customer_id, 
        monthly
),
cte_2 AS (
    SELECT 
        customer_id, 
        monthly, 
        SUM(transaction_balance) OVER (PARTITION BY customer_id ORDER BY customer_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS balance, 
        transaction_balance 
    FROM 
        cte
),
cte_3 AS (
    SELECT 
        DISTINCT customer_id, 
        FIRST_VALUE(balance) OVER (PARTITION BY customer_id ORDER BY customer_id) AS start_balance,
        LAST_VALUE(balance) OVER (PARTITION BY customer_id ORDER BY customer_id) AS end_balance 
    FROM 
        cte_2
)
SELECT 
    customer_id, 
    100 * (end_balance - start_balance) / start_balance AS growth_rate 
FROM 
    cte_3 
WHERE 
    100 * (end_balance - start_balance) / start_balance >= 5;

```
