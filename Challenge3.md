## 1. How many customers has Foodie-Fi ever had?
```sql
select count(distinct(customer_id)) as cus_num from subscriptions
```
## 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
```sql
select count(customer_id), month(start_date) as trial_month from subscriptions where plan_id =0 group by trial_month order by trial_month

```
## 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
```sql
select count(customer_id), subscriptions.plan_id, plan_name from subscriptions join plans on subscriptions.plan_id = plans.plan_id where year(start_date) >= 2021 
group by subscriptions.plan_id, plan_name
```
## 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
```sql
select COUNT(DISTINCT customer_id), ROUND(100.0 * COUNT(sub.customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions) ,1) from subscriptions as sub where plan_id = 4

```
## 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
```sql
count(customer_id), 100 * count(customer_id)/ (select count(distinct customer_id) from subscriptions) from (
select customer_id, plan_id, lead(plan_id) over (partition by customer_id order by start_date) as next_plan from subscriptions as s) as cte_table where plan_id =0 and next_plan = 4

```
## 6. What is the number and percentage of customer plans after their initial free trial?
```sql
select next_plan, 100 * count(next_plan)/ (select count(distinct customer_id) from subscriptions) from (
select customer_id, plan_id, lead(plan_id) over (partition by customer_id order by start_date) as next_plan from subscriptions 
) as cte_table where next_plan is not null and plan_id =0 group by next_plan order by next_plan

```
## 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
```sql
```
## 8. How many customers have upgraded to an annual plan in 2020?
```sql
select count(*) from subscriptions where year(start_date) = 2020 and plan_id = 3

```
## 9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
```sql
WITH annual_plan AS (
    SELECT customer_id, start_date 
    FROM subscriptions 
    WHERE 	plan_id = 3
),
start_plan AS (
    SELECT customer_id, start_date 
    FROM subscriptions 
    WHERE plan_id = 0
)
SELECT AVG(DATEDIFF(annual_plan.start_date, start_plan.start_date)) AS avg_date_diff
FROM annual_plan
JOIN start_plan ON annual_plan.customer_id = start_plan.customer_id;
```
## 10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
```sql
```
## 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
```sql
select count(*) from (
select customer_id, subscriptions.plan_id,  lead(plans.plan_id) over (partition by customer_id order by start_date) as next_plan from subscriptions 
join plans on subscriptions.plan_id = plans.plan_id where year(start_date) =2020
) as cte_table where plan_id = 2 and next_plan = 1
```
