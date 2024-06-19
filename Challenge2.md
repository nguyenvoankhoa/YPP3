## A. Pizza Metrics 
## 1. How many pizzas were ordered?
```sql
SELECT 
    COUNT(*) AS pizza_order
FROM
    customer_orders
```

## 2. How many unique customer orders were made?
```sql
SELECT 
    COUNT(DISTINCT order_id) AS unique_customer_orders
FROM
    customer_orders
```

## 3. How many successful orders were delivered by each runner?
```sql
SELECT 
    runner_id, COUNT(runner_id) AS successful_orders
FROM
    runner_orders
WHERE
    distance != 0
GROUP BY runner_id
```

## 4. How many of each type of pizza was delivered?
```sql
SELECT 
    pizza_id, COUNT(pizza_id) AS orders
FROM
    pizza_runner.customer_orders
GROUP BY pizza_id;
```

## 5. How many Vegetarian and Meatlovers were ordered by each customer?
```sql
SELECT 
    customer_id,
    COUNT(customer_orders.pizza_id) AS orders,
    pizza_name AS orders
FROM
    pizza_runner.customer_orders
        JOIN
    pizza_names ON customer_orders.pizza_id = pizza_names.pizza_id
GROUP BY customer_orders.pizza_id , pizza_name , customer_id;

```

## 6. What was the maximum number of pizzas delivered in a single order?
```sql
SELECT 
    customer_orders.order_id,
    COUNT(customer_orders.order_id) AS orders
FROM
    customer_orders
        JOIN
    runner_orders ON customer_orders.order_id = runner_orders.order_id
WHERE
    distance != 0
GROUP BY customer_orders.order_id
```

## 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

```sql
SELECT 
    c.customer_id,
    SUM(CASE
        WHEN c.exclusions <> '' OR c.extras <> '' THEN 1
        ELSE 0
    END) AS al_one_change,
    SUM(CASE
        WHEN c.exclusions = '' AND c.extras = '' THEN 1
        ELSE 0
    END) AS no_change
FROM
    customer_orders_temp AS c
        JOIN
    runner_orders_temp AS r ON c.order_id = r.order_id
WHERE
    r.distance != 0
GROUP BY customer_id

```

## 8. How many pizzas were delivered that had both exclusions and extras?
```sql
SELECT 
    SUM(CASE
        WHEN
            exclusions IS NOT NULL
                AND extras IS NOT NULL
        THEN
            1
        ELSE 0
    END) AS result
FROM
    customer_orders AS c
        JOIN
    runner_orders AS r ON c.order_id = r.order_id
WHERE
    r.distance >= 1 AND c.exclusions <> ' '
        AND c.extras <> ' '
```

## 9. What was the total volume of pizzas ordered for each hour of the day?
```sql
SELECT 
    COUNT(order_id), HOUR(order_time) AS date_hour
FROM
    pizza_runner.customer_orders
GROUP BY date_hour
ORDER BY date_hour;
```

## 10. What was the volume of orders for each day of the week?
```sql
SELECT 
    COUNT(order_id) AS order_count,
    ELT(DAYOFWEEK(order_time + INTERVAL 1 DAY),
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday') AS date_order
FROM
    pizza_runner.customer_orders
GROUP BY date_order
ORDER BY order_count DESC
```

## B. Runner and Customer Experience
## 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
```sql
SELECT 
    WEEK(registration_date, 1) AS week,
    COUNT(runner_id) AS register_num
FROM
    pizza_runner.runners
GROUP BY week
```

## 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
```sql
SELECT 
    runner_id, AVG(avg_time)
FROM
    (SELECT 
        runner_id,
            AVG(TIMESTAMPDIFF(MINUTE, order_time, pickup_time)) AS avg_time
    FROM
        runner_orders
    JOIN customer_orders ON runner_orders.order_id = customer_orders.order_id
    WHERE
        distance > 0
    GROUP BY runner_id , customer_orders.order_id) AS cte_order
GROUP BY runner_i
```

## 3. How many successful orders were delivered by each runner?
```sql
SELECT 
    runner_id, COUNT(runner_id) AS successful_orders
FROM
    runner_orders
WHERE
    distance != 0
GROUP BY runner_id
```

## 4. How many of each type of pizza was delivered?
```sql
SELECT 
    pizza_id, COUNT(pizza_id) AS orders
FROM
    pizza_runner.customer_orders
GROUP BY pizza_id;
```

## 5. How many Vegetarian and Meatlovers were ordered by each customer?
```sql
SELECT 
    customer_id,
    COUNT(customer_orders.pizza_id) AS orders,
    pizza_name AS orders
FROM
    pizza_runner.customer_orders
        JOIN
    pizza_names ON customer_orders.pizza_id = pizza_names.pizza_id
GROUP BY customer_orders.pizza_id , pizza_name , customer_id;

```

## 6. What was the maximum number of pizzas delivered in a single order?
```sql
SELECT 
    customer_orders.order_id,
    COUNT(customer_orders.order_id) AS orders
FROM
    customer_orders
        JOIN
    runner_orders ON customer_orders.order_id = runner_orders.order_id
WHERE
    distance != 0
GROUP BY customer_orders.order_id
```

## 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

```sql
SELECT 
    c.customer_id,
    SUM(CASE
        WHEN c.exclusions <> '' OR c.extras <> '' THEN 1
        ELSE 0
    END) AS al_one_change,
    SUM(CASE
        WHEN c.exclusions = '' AND c.extras = '' THEN 1
        ELSE 0
    END) AS no_change
FROM
    customer_orders_temp AS c
        JOIN
    runner_orders_temp AS r ON c.order_id = r.order_id
WHERE
    r.distance != 0
GROUP BY customer_id

```

## 8. How many pizzas were delivered that had both exclusions and extras?
```sql
SELECT 
    SUM(CASE
        WHEN
            exclusions IS NOT NULL
                AND extras IS NOT NULL
        THEN
            1
        ELSE 0
    END) AS result
FROM
    customer_orders AS c
        JOIN
    runner_orders AS r ON c.order_id = r.order_id
WHERE
    r.distance >= 1 AND c.exclusions <> ' '
        AND c.extras <> ' '
```

## 9. What was the total volume of pizzas ordered for each hour of the day?
```sql
SELECT 
    COUNT(order_id), HOUR(order_time) AS date_hour
FROM
    pizza_runner.customer_orders
GROUP BY date_hour
ORDER BY date_hour;
```

## 10. What was the volume of orders for each day of the week?
```sql
SELECT 
    COUNT(order_id) AS order_count,
    ELT(DAYOFWEEK(order_time + INTERVAL 1 DAY),
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday') AS date_order
FROM
    pizza_runner.customer_orders
GROUP BY date_order
ORDER BY order_count DESC
```
