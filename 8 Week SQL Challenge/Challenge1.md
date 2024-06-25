## 1. What is the total amount each customer spent at the restaurant? What is the total amount each customer spent at the restaurant?
```sql
SELECT 
    sales.customer_id, SUM(menu.price)
FROM
    sales
        LEFT JOIN
    menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id
```

## 2. How many days has each customer visited the restaurant?
```sql
SELECT 
    sales.customer_id, 
    COUNT(DISTINCT sales.order_date) 
FROM 
    sales 
LEFT JOIN 
    menu 
ON 
    sales.product_id = menu.product_id 
GROUP BY 
    sales.customer_id;

```

## 3. What was the first item from the menu purchased by each customer?
```sql
SELECT 
    customer_id, 
    product_name 
FROM (
    SELECT 
        customer_id, 
        order_date, 
        product_name, 
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY sales.order_date
        ) AS order_number  
    FROM 
        dannys_diner.sales 
    JOIN 
        menu 
    ON 
        sales.product_id = menu.product_id
) AS table_select 
WHERE 
    table_select.order_number = 1;

```

## 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
```sql
SELECT 
    menu.product_name, COUNT(sales.product_id)
FROM
    sales
        JOIN
    menu ON sales.product_id = menu.product_id
GROUP BY sales.product_id , menu.product_name
ORDER BY COUNT(product_id) DESC
LIMIT 1

```

## 5. Which item was the most popular for each customer?
```sql
SELECT 
    customer_id, 
    product_name, 
    Count 
FROM (
    SELECT 
        customer_id, 
        product_name, 
        COUNT(product_name) AS Count, 
        DENSE_RANK() OVER (
            PARTITION BY customer_id 
            ORDER BY COUNT(product_name) DESC
        ) AS ranking  
    FROM 
        sales 
    JOIN 
        menu 
    ON 
        sales.product_id = menu.product_id 
    GROUP BY 
        product_name, 
        customer_id, 
        product_name
) AS sale_rank 
WHERE 
    sale_rank.ranking = 1;

```

## 6. Which item was purchased first by the customer after they became a member?
```sql
SELECT 
    customer_id, 
    join_date, 
    order_date, 
    product_name 
FROM (
    SELECT 
        members.customer_id, 
        members.join_date, 
        sales.order_date, 
        menu.product_name, 
        RANK() OVER (
            PARTITION BY members.customer_id 
            ORDER BY sales.order_date ASC
        ) AS ranking 
    FROM 
        members  
    LEFT JOIN 
        sales 
    ON 
        members.customer_id = sales.customer_id 
        AND members.join_date < sales.order_date 
    JOIN 
        menu 
    ON 
        menu.product_id = sales.product_id
) AS first_order
WHERE 
    first_order.ranking = 1;

```

## 7. Which item was purchased just before the customer became a member?

```sql
SELECT 
    customer_id, 
    join_date, 
    order_date, 
    product_name 
FROM (
    SELECT 
        members.customer_id, 
        members.join_date, 
        sales.order_date, 
        menu.product_name, 
        ROW_NUMBER() OVER (
            PARTITION BY members.customer_id 
            ORDER BY order_date DESC
        ) AS ranking 
    FROM 
        members  
    LEFT JOIN 
        sales 
    ON 
        members.customer_id = sales.customer_id 
        AND members.join_date > sales.order_date 
    JOIN 
        menu 
    ON 
        menu.product_id = sales.product_id
) AS first_order
WHERE 
    first_order.ranking = 1;

```

## 8. What is the total items and amount spent for each member before they became a member?

```sql
SELECT 
    members.customer_id, COUNT(menu.product_id), SUM(menu.price)
FROM
    members
        LEFT JOIN
    sales ON members.customer_id = sales.customer_id
        AND members.join_date > sales.order_date
        JOIN
    menu ON menu.product_id = sales.product_id
GROUP BY members.customer_id
```

## 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
```sql
SELECT 
    customer_id, SUM(points)
FROM
    (SELECT 
        customer_id,
            product_name,
            CASE
                WHEN product_name = 'sushi' THEN price * 20
                ELSE price * 10
            END AS points
    FROM
        sales
    JOIN menu ON menu.product_id = sales.product_id) AS total_point
GROUP BY customer_id
```

## 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
```sql
SELECT 
    customer_id, SUM(points)
FROM
    (SELECT 
        sales.customer_id,
            join_date,
            order_date,
            CASE
                WHEN order_date BETWEEN join_date AND join_date + 6 THEN price * 20
                ELSE price * 10
            END AS points
    FROM
        sales
    JOIN members ON sales.customer_id = members.customer_id
    JOIN menu ON menu.product_id = sales.product_id
    WHERE
        order_date >= join_date
            AND order_date < '2021-01-31') AS total_point
GROUP BY customer_id
```


