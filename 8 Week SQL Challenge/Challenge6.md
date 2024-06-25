## 2.  Digital Analysis
## How many users are there?
```sql
SELECT 
    COUNT(DISTINCT user_id)
FROM
    users;
```
## How many cookies does each user have on average?
```sql
SELECT 
    user_id, AVG(cookie_id)
FROM
    users
GROUP BY user_id;
```
## What is the unique number of visits by all users per month?
```sql
SELECT 
    MONTH(event_time) AS monthly, COUNT(DISTINCT visit_id)
FROM
    users
        JOIN
    events ON users.cookie_id = events.cookie_id
GROUP BY monthly;

-- What is the number of events for each event type?
SELECT 
    COUNT(events.event_type), event_name
FROM
    events
        JOIN
    event_identifier ON events.event_type = event_identifier.event_type
GROUP BY event_name;

```
## What is the number of events for each event type?
```sql
SELECT 
    COUNT(events.event_type), event_name
FROM
    events
        JOIN
    event_identifier ON events.event_type = event_identifier.event_type
GROUP BY event_name;

```
## What is the percentage of visits which have a purchase event?
```sql
SELECT 
    100 * COUNT(DISTINCT visit_id) / (SELECT 
            COUNT(DISTINCT visit_id)
        FROM
            events)
FROM
    events
        JOIN
    event_identifier ON events.event_type = event_identifier.event_type
WHERE
    event_name = 'Purchase';

```
## What is the percentage of visits which view the checkout page but do not have a purchase event?
```sql
SELECT 
    100 * (1 - SUM(purchase) / SUM(checkout)) AS pct
FROM
    (SELECT 
        visit_id,
            MAX(CASE
                WHEN page_id = 12 THEN 1
                ELSE 0
            END) AS checkout,
            MAX(CASE
                WHEN event_type = 3 THEN 1
                ELSE 0
            END) AS purchase
    FROM
        events
    GROUP BY visit_id) AS cte;

```
## What are the top 3 pages by number of views?
```sql
SELECT 
    page_name, COUNT(events.page_id) AS num_view
FROM
    events
        JOIN
    page_hierarchy ON events.page_id = page_hierarchy.page_id
GROUP BY page_name
ORDER BY num_view desc
LIMIT 3

```
## What is the number of views and cart adds for each product category?
```sql
SELECT 
    SUM(CASE
        WHEN event_type = 1 THEN 1
        ELSE 0
    END) AS page_view,
    SUM(CASE
        WHEN event_type = 2 THEN 1
        ELSE 0
    END) AS add_cart,
    product_category
FROM
    events
        JOIN
    page_hierarchy ON events.page_id = page_hierarchy.page_id
WHERE
    product_category IS NOT NULL
GROUP BY product_category;
```
## What are the top 3 products by purchases?
```sql
SELECT 
    product_id, product_category, COUNT(*) AS num_purchase
FROM
    events
        JOIN
    page_hierarchy ON events.page_id = page_hierarchy.page_id
WHERE
    event_type = 2
        AND events.visit_id IN (SELECT 
            visit_id
        FROM
            events
        WHERE
            event_type = 3)
GROUP BY product_id , product_category
ORDER BY num_purchase DESC
LIMIT 3

```

## 3. Product Funnel Analysis
## Which product had the most views, cart adds and purchases?
```sql
WITH product_id_info AS (
    SELECT 
        product_id, 
        product_category,
        SUM(CASE WHEN event_type = 1 THEN 1 ELSE 0 END) AS views,
        SUM(CASE WHEN event_type = 2 THEN 1 ELSE 0 END) AS add_to_cart,
        SUM(CASE WHEN event_type = 3 THEN 1 ELSE 0 END) AS view_purchase
    FROM 
        events 
    JOIN 
        page_hierarchy 
    ON 
        events.page_id = page_hierarchy.page_id 
    WHERE 
        product_id IS NOT NULL 
    GROUP BY 
        product_id, 
        product_category
),
product_abandon_info AS (
    SELECT 
        product_id, 
        product_category, 
        SUM(CASE WHEN event_type = 2 THEN 1 ELSE 0 END) AS abandon 
    FROM 
        events 
    JOIN 
        page_hierarchy 
    ON 
        events.page_id = page_hierarchy.page_id 
    WHERE 
        product_id IS NOT NULL 
        AND visit_id NOT IN (
            SELECT 
                visit_id 
            FROM 
                events 
            WHERE 
                event_type = 3
        )
    GROUP BY 
        product_id, 
        product_category
),
product_purchase_info AS (
    SELECT 
        product_id, 
        product_category, 
        SUM(CASE WHEN event_type = 2 THEN 1 ELSE 0 END) AS purchase 
    FROM 
        events 
    JOIN 
        page_hierarchy 
    ON 
        events.page_id = page_hierarchy.page_id 
    WHERE 
        product_id IS NOT NULL 
        AND visit_id IN (
            SELECT 
                visit_id 
            FROM 
                events 
            WHERE 
                event_type = 3
        )
    GROUP BY 
        product_id, 
        product_category
)
SELECT 
    pi.product_id,
    pi.product_category,
    pi.views,
    pi.add_to_cart,
    pi.view_purchase,
    pa.abandon,
    pp.purchase
FROM 
    product_id_info pi
LEFT JOIN 
    product_abandon_info pa 
ON 
    pi.product_id = pa.product_id
LEFT JOIN 
    product_purchase_info pp 
ON 
    pi.product_id = pp.product_id;

```
## Which product was most likely to be abandoned?
```sql
SELECT 
    *
FROM
    product_summary
ORDER BY views DESC
LIMIT 1;
```
## Which product had the highest view to purchase percentage?
```sql
SELECT 
    *
FROM
    product_summary
ORDER BY abandon DESC
LIMIT 1;

```
## What is the average conversion rate from view to cart add?
```sql
SELECT 
    AVG(views / add_to_cart) AS conversion_rate
FROM
    product_summary; 

```
## What is the average conversion rate from cart add to purchase?
```sql
SELECT 
    AVG(add_to_cart / purchase) AS conversion_rate
FROM
    product_summary;
```

## 4.  Campaigns Analysis
```sql
SELECT 
    visit_id,
    MIN(e.event_time) AS visit_start_time,
    event_type,
    SUM(CASE
        WHEN event_type = 1 THEN 1
        ELSE 0
    END) AS page_views,
    SUM(CASE
        WHEN event_type = 2 THEN 1
        ELSE 0
    END) AS cart_add,
    SUM(CASE
        WHEN event_type = 3 THEN 1
        ELSE 0
    END) AS purchase,
    SUM(CASE
        WHEN e.event_type = 4 THEN 1
        ELSE 0
    END) AS impression,
    SUM(CASE
        WHEN e.event_type = 5 THEN 1
        ELSE 0
    END) AS click,
    c.campaign_name
FROM
    events AS e
        JOIN
    campaign_identifier AS c ON e.event_time BETWEEN c.start_date AND c.end_date
GROUP BY cookie_id , visit_id , event_type , c.campaign_name
```
