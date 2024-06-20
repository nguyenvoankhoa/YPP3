## A. Customer Nodes Exploration
## How many unique nodes are there on the Data Bank system?
```sql
select count(distinct(node_id)) as unique_node from customer_nodes

```
## What is the number of nodes per region?
```sql
select count(distinct node_id), r.region_id from customer_nodes as c join regions as r on c.region_id = r.region_id group by region_id

```
## How many customers are allocated to each region?
```sql
select count(customer_id), r.region_id from customer_nodes as c join regions as r on c.region_id = r.region_id group by region_id

```
## How many days on average are customers reallocated to a different node?
```sql
SELECT avg(TIMESTAMPDIFF(DAY, start_date, end_date)) AS date_diff FROM customer_nodes WHERE end_date != '9999-12-31'
```
## What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
```sql
```
## B. Customer Transactions
## What is the unique count and total amount for each transaction type?
```sql
select txn_type, count(*), sum(txn_amount) from customer_transactions group by txn_type
```
## What is the average total historical deposit counts and amounts for all customers?
```sql
select avg(count(distinct customer_id)), avg(txn_amount) from customer_transactions where txn_type = 'deposit'
```
## For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
```sql
select monthly, count(distinct customer_id) from
(
select customer_id, month(txn_date)  as monthly, 
sum(case when txn_type = 'deposit' then 0 else 1 end)  as deposit_count ,
sum(case when txn_type = 'purchase' then 0 else 1 end) as purchase_count,
sum(case when txn_type = 'withdrawal' then 0 else 1 end) as withdrawal_count
from customer_transactions group by customer_id, monthly
) 
as cte_table where deposit_count >1 and (purchase_count >=1 or withdrawal_count >=1) group by monthly
```
## What is the closing balance for each customer at the end of the month?
```sql
select customer_id, monthly , sum(deposit_count + purchase_count + withdrawal_count) from (
select customer_id, month(txn_date) as monthly, 
sum(case when txn_type = 'deposit' then txn_amount else 0 end)  as deposit_count,
sum(case when txn_type = 'purchase' then - txn_amount else 0 end) as purchase_count,
sum(case when txn_type = 'withdrawal' then - txn_amount else 0 end) as withdrawal_count
from customer_transactions group by customer_id, monthly) as cte_table group by customer_id, monthly order by customer_id
```
## What is the percentage of customers who increase their closing balance by more than 5%?
```sql
with cte as (select customer_id, month(txn_date) as monthly, 
sum(case when txn_type = 'purchase' or txn_type = 'withdrawal' then - txn_amount else txn_amount end) as transaction_balance
from customer_transactions group by customer_id, monthly order by customer_id, monthly),
cte_2 as (select customer_id, monthly, sum(transaction_balance) over (partition by customer_id order by customer_id 
rows BETWEEN UNBOUNDED PRECEDING AND current ROW) as balance, transaction_balance from cte),
cte_3 as (select distinct customer_id, first_value(balance) over (partition by customer_id order by customer_id) as start_balance,
last_value(balance) over (partition by customer_id order by customer_id) as end_balance from cte_2)
select customer_id, 100 * (end_balance - start_balance) / start_balance as growth_rate from cte_3 where 100 * (end_balance - start_balance) / start_balance >= 5
```
