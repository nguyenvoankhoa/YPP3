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
```
## 2. What is the total quantity, revenue and discount for each segment?
```sql
```
## 3. What is the top selling product for each segment?
```sql
```
## 4. What is the total quantity, revenue and discount for each category?
```sql
```
## 5. What is the top selling product for each category?
```sql
```
## 6. What is the percentage split of revenue by product for each segment?
```sql
```
## 7. What is the percentage split of revenue by segment for each category?
```sql
```
## 8. What is the percentage split of total revenue by category?
```sql
```
## 9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
```sql
```
## 10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
```sql
```
