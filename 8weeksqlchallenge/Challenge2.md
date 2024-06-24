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

## 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

```sql
SELECT
    pizza_id,
    AVG(TIMESTAMPDIFF(MINUTE,
        order_time,
        pickup_time))
FROM
    customer_orders
        INNER JOIN
    runner_orders_temp ON customer_orders.order_id = runner_orders_temp.order_id
WHERE
    distance > 0
GROUP BY pizza_id
```

## 4. What was the average distance travelled for each customer?

```sql
SELECT
    customer_id, AVG(distance)
FROM
    customer_orders
        INNER JOIN
    runner_orders_temp ON customer_orders.order_id = runner_orders_temp.order_id
WHERE
    distance > 0
GROUP BY customer_id
```

## 5. What was the difference between the longest and shortest delivery times for all orders?

```sql
SELECT
    MAX(duration) - MIN(duration) AS difference
FROM
    customer_orders
        INNER JOIN
    runner_orders_temp ON customer_orders.order_id = runner_orders_temp.order_id
WHERE
    distance > 0
```

## 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

```sql
SELECT
    runner_id,
    customer_id,
    pizza_id,
    customer_orders.order_id,
    ROUND((distance / duration * 60), 2) AS avg_speed
FROM
    customer_orders
        JOIN
    runner_orders_temp ON customer_orders.order_id = runner_orders_temp.order_id
WHERE
    distance > 0
```

## 7. What is the successful delivery percentage for each runner?

```sql
SELECT
    runner_id,
    100 * SUM(CASE
        WHEN distance = 0 THEN 0
        ELSE 1
    END) / COUNT(*)
FROM
    runner_orders
GROUP BY runner_id

```

## C. Ingredient Optimisation

## 1.What are the standard ingredients for each pizza?

```sql
WITH RECURSIVE split_values AS (
    SELECT
        pizza_id,
        CAST(SUBSTRING_INDEX(toppings, ', ', 1) AS UNSIGNED) AS topping,
        SUBSTRING(toppings, LENGTH(SUBSTRING_INDEX(toppings, ', ', 1)) + 3) AS rest
    FROM pizza_recipes
    UNION ALL
    SELECT
        pizza_id,
        CAST(SUBSTRING_INDEX(rest, ', ', 1) AS UNSIGNED),
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ', ', 1)) + 3)
    FROM split_values
    WHERE LENGTH(rest) > 0
)
SELECT
    pizza_id, topping
FROM
    split_values
```

## 2. What was the most commonly added extra?

```sql
-- with cte as (
-- select * from customer_orders_clean where extras is not null
-- ),
WITH RECURSIVE split_values AS (
    SELECT
        CAST(SUBSTRING_INDEX(extras, ', ', 1) AS UNSIGNED) AS extra,
        SUBSTRING(extras, LENGTH(SUBSTRING_INDEX(extras, ', ', 1)) + 3) AS rest
    FROM customer_orders_clean where extras is not null
    UNION ALL
    SELECT
        CAST(SUBSTRING_INDEX(rest, ', ', 1) AS UNSIGNED),
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ', ', 1)) + 3)
    FROM split_values
    WHERE LENGTH(rest) > 0
)
SELECT
    count(extra), extra
FROM
    split_values
    group by extra
    order by count(extra) desc limit 1
```

## 3. What was the most common exclusion?

```sql
-- with cte as (
-- select * from customer_orders_clean where extras is not null
-- ),
WITH RECURSIVE split_values AS (
    SELECT
        CAST(SUBSTRING_INDEX(exclusions, ', ', 1) AS UNSIGNED) AS exclusions,
        SUBSTRING(extras, LENGTH(SUBSTRING_INDEX(exclusions, ', ', 1)) + 3) AS rest
    FROM customer_orders_clean where exclusions is not null
    UNION ALL
    SELECT
        CAST(SUBSTRING_INDEX(rest, ', ', 1) AS UNSIGNED),
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ', ', 1)) + 3)
    FROM split_values
    WHERE LENGTH(rest) > 0
)
SELECT
    count(exclusions), exclusions
FROM
    split_values
    group by exclusions
    order by count(exclusions) desc limit 1
```

## 4. Generate an order item for each record in the customers_orders table in the format of one of the following:

Meat Lovers
Meat Lovers - Exclude Beef
Meat Lovers - Extra Bacon
Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

```sql
with cte as(SELECT
    co.order_id,
    co.customer_id,
    co.pizza_name,
    co.pizza_id,
    co.ord,
    IF(co.exclusions IS NOT NULL, (
        SELECT GROUP_CONCAT(t.topping_name separator ', ')
        FROM pizza_toppings t
        WHERE FIND_IN_SET(t.topping_id, REPLACE(co.exclusions, ' ', ''))
    ), '') AS exclusion_topping,
    IF(co.extras IS NOT NULL, (
        SELECT GROUP_CONCAT(t.topping_name separator ', ')
        FROM pizza_toppings t
        WHERE FIND_IN_SET(t.topping_id, REPLACE(co.extras, ' ', ''))
    ), '') AS extra_topping
FROM
    customer_orders_clean co)
SELECT
    ord,
    CONCAT(pizza_name,
            IF(exclusion_topping != '',
                CONCAT(' - Exclude ', exclusion_topping),
                ''),
            IF(exclusion_topping != '',
                CONCAT(' - Extra ', extra_topping),
                '')) AS order_detail
FROM
    cte

```

5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
   For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"

```sql
create view clean_order as
SELECT
    ord,
    order_id,
    customer_orders_clean.pizza_id,
    customer_id,
    pizza_name,
    topping,
    exclusions,
    extras,
    topping_name
FROM
    pizza_runner.customer_orders_clean
        JOIN
    pizza_recipe_clean rec ON customer_orders_clean.pizza_id = rec.pizza_id
        JOIN
    pizza_toppings top on rec.topping = top.topping_id
    order by ord
```

```sql
with cte as(
SELECT
    order_id,
    customer_id,
    pizza_name,
    pizza_id,
    ord,
    IF(exclusions IS NOT NULL,
        IF(topping LIKE exclusions,
            topping = 0,
            topping_name),
        topping_name) AS exclusion_topping,
    IF(extras IS NOT NULL,
        IF(topping LIKE extras,
            CONCAT('2x', topping_name),
            topping_name),
        topping_name) AS extra_topping
FROM
    pizza_runner.clean_order),
cte_2 as (
SELECT
    *,
    CASE
        WHEN exclusion_topping = '0' THEN ''
        ELSE extra_topping
    END AS final_topping
FROM
    cte)

SELECT
    ord,
    CONCAT(pizza_name,
            ' : ',
            GROUP_CONCAT(final_topping
                SEPARATOR ', ')) as topping
FROM
    cte_2
GROUP BY ord , pizza_name
```

7. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

```sql
SELECT
    topping, COUNT(topping) AS quantity
FROM
    pizza_runner.customer_orders ord
        JOIN
    pizza_recipe_clean cle ON ord.pizza_id = cle.pizza_id
        JOIN
    runner_orders run ON ord.order_id = run.order_id
WHERE
    pickup_time != 'null'
GROUP BY topping
ORDER BY quantity DESC
```

## D. Pricing and Ratings

## 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

```sql
SELECT sum(
       (CASE
            WHEN pizza_id = 1 THEN 10
            ELSE 12
        END)) as revenue
FROM pizza_runner.customer_orders;
```

## 2. What if there was an additional $1 charge for any pizza extras? Add cheese is $1 extra

```sql
SELECT
    SUM(revenue) + SUM(total_revenue) + SUM(total_extras) AS total
FROM (
    SELECT
        (CASE
            WHEN pizza_id = 1 THEN 10
            ELSE 12
        END) AS revenue,
        (CASE
            WHEN LENGTH(exclusions) = 1 THEN 1
            WHEN LENGTH(exclusions) > 1 THEN 2
            ELSE 0
        END) AS total_revenue,
        (CASE
            WHEN LENGTH(extras) = 1 THEN 1
            WHEN LENGTH(extras) > 1 THEN 2
            ELSE 0
        END) AS total_extras
    FROM
        pizza_runner.customer_orders_temp
) AS cte_table;
```

## 3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

```sql
CREATE TABLE Rating (
    rating_id INT,
    order_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5)
);
```

## 4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?

```sql
SELECT
    customer_id,
    customer_orders.order_id,
    runner_id,
    rating,
    order_time,
    pickup_time,
    TIMESTAMPDIFF(MINUTE,
        order_time,
        pickup_time) AS time_diff,
    duration,
    (distance * 60 / duration) AS avg_speed
FROM
    pizza_runner.customer_orders
        JOIN
    runner_orders_temp ON customer_orders.order_id = runner_orders_temp.order_id
        JOIN
    rating ON customer_orders.order_id = rating.order_id;
```

## 5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

```sql
SELECT
    SUM(revenue - fee) AS profit
FROM
    (SELECT
        distance * 0.3 AS fee,
            (CASE
                WHEN pizza_id = 1 THEN 10
                ELSE 12
            END) AS revenue
    FROM
        pizza_runner.customer_orders
    JOIN runner_orders_temp ON customer_orders.order_id = runner_orders_temp.order_id
    WHERE
        distance > 0) AS cte_table
```
