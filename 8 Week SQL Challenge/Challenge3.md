## 1. How many customers has Foodie-Fi ever had?

```sql
SELECT
    COUNT(DISTINCT (customer_id)) AS cus_num
FROM
    subscriptions
```

## 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

```sql
SELECT
    COUNT(customer_id), MONTH(start_date) AS trial_month
FROM
    subscriptions
WHERE
    plan_id = 0
GROUP BY trial_month
ORDER BY trial_month

```

## 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

```sql
SELECT
    COUNT(customer_id), subscriptions.plan_id, plan_name
FROM
    subscriptions
        JOIN
    plans ON subscriptions.plan_id = plans.plan_id
WHERE
    YEAR(start_date) >= 2021
GROUP BY subscriptions.plan_id , plan_name
```

## 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

```sql
SELECT
    COUNT(DISTINCT customer_id),
    ROUND(100.0 * COUNT(sub.customer_id) / (SELECT
                    COUNT(DISTINCT customer_id)
                FROM
                    foodie_fi.subscriptions),
            1)
FROM
    subscriptions AS sub
WHERE
    plan_id = 4

```

## 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

```sql
SELECT
    COUNT(customer_id) AS customer_count,
    100 * COUNT(customer_id) / (
        SELECT
            COUNT(DISTINCT customer_id)
        FROM
            subscriptions
    ) AS percentage
FROM (
    SELECT
        customer_id,
        plan_id,
        LEAD(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_plan
    FROM
        subscriptions AS s
) AS cte_table
WHERE
    plan_id = 0
    AND next_plan = 4;

```

## 6. What is the number and percentage of customer plans after their initial free trial?

```sql
SELECT
    next_plan,
    100 * COUNT(next_plan) / (
        SELECT COUNT(DISTINCT customer_id)
        FROM subscriptions
    ) AS percentage
FROM (
    SELECT
        customer_id,
        plan_id,
        LEAD(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_plan
    FROM
        subscriptions
) AS cte_table
WHERE
    next_plan IS NOT NULL
    AND plan_id = 0
GROUP BY
    next_plan
ORDER BY
    next_plan;


```

## 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

```sql
WITH cte AS (
    SELECT
        customer_id,
        plan_id,
        LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_day
    FROM
        foodie_fi.subscriptions
    WHERE
        start_date <= '2020-12-31'
)
SELECT
    plan_id,
    COUNT(DISTINCT customer_id) AS customer_count,
    COUNT(DISTINCT customer_id) / (
        SELECT COUNT(DISTINCT customer_id)
        FROM subscriptions
    ) AS pct
FROM
    cte
WHERE
    next_day IS NULL
GROUP BY
    plan_id;

```

## 8. How many customers have upgraded to an annual plan in 2020?

```sql
SELECT
    COUNT(*)
FROM
    subscriptions
WHERE
    YEAR(start_date) = 2020 AND plan_id = 3

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
WITH annual_plan AS (
    SELECT customer_id, start_date
    FROM subscriptions
    WHERE plan_id = 3
),
trial_plan AS (
    SELECT customer_id, start_date
    FROM subscriptions
    WHERE plan_id = 0
),
bin AS (
    SELECT
        trial.customer_id,
        DATEDIFF(annual.start_date, trial.start_date) AS switch_to_annual_plan_days
    FROM trial_plan AS trial
    JOIN annual_plan AS annual
    ON trial.customer_id = annual.customer_id
)
SELECT
    CASE
        WHEN switch_to_annual_plan_days <= 30 THEN '0-30 days'
        WHEN switch_to_annual_plan_days <= 60 THEN '31-60 days'
        WHEN switch_to_annual_plan_days <= 90 THEN '61-90 days'
        WHEN switch_to_annual_plan_days <= 120 THEN '91-120 days'
        WHEN switch_to_annual_plan_days <= 150 THEN '121-150 days'
        WHEN switch_to_annual_plan_days <= 180 THEN '151-180 days'
        WHEN switch_to_annual_plan_days <= 210 THEN '181-210 days'
        WHEN switch_to_annual_plan_days <= 240 THEN '211-240 days'
        WHEN switch_to_annual_plan_days <= 270 THEN '241-270 days'
        WHEN switch_to_annual_plan_days <= 300 THEN '271-300 days'
        WHEN switch_to_annual_plan_days <= 330 THEN '301-330 days'
        WHEN switch_to_annual_plan_days <= 366 THEN '331-366 days'
        ELSE '>366 days'
    END AS switch_to_annual_plan_period,
    COUNT(customer_id) AS customers_cnt
FROM bin
WHERE switch_to_annual_plan_days IS NOT NULL
GROUP BY switch_to_annual_plan_period;

```

## 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

```sql
SELECT
    COUNT(*)
FROM (
    SELECT
        customer_id,
        subscriptions.plan_id,
        LEAD(plans.plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_plan
    FROM
        subscriptions
    JOIN
        plans
    ON
        subscriptions.plan_id = plans.plan_id
    WHERE
        YEAR(start_date) = 2020
) AS cte_table
WHERE
    plan_id = 2
    AND next_plan = 1;

```
