## 1. What is the total amount each customer spent at the restaurant? What is the total amount each customer spent at the restaurant?

`select sales.customer_id, sum(menu.price) from sales left join menu on sales.product_id = menu.product_id group by sales.customer_id`

## 2. How many days has each customer visited the restaurant?

`select sales.customer_id, count(distinct(sales.order_date)) from sales left join menu on sales.product_id = menu.product_id group by sales.customer_id`

## 3. What was the first item from the menu purchased by each customer?

`select customer_id, product_name from (SELECT customer_id, order_date, product_name, row_number() over (partition by customer_id order by sales.order_date) as order_number  FROM dannys_diner.sales join menu on sales.product_id = menu product_id) as table_select where table_select.order_number = 1`

## 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

`SELECT menu.product_name, count(sales.product_id) FROM sales join menu on sales.product_id = menu.product_id group by sales.product_id, menu.product_name order by count(product_id) desc limit 1`

## 5. Which item was the most popular for each customer?

`select customer_id, product_name, Count from (select customer_id, product_name, count(product_name) as Count, dense_rank() over (partition by customer_id order by count(product_name) desc) as ranking  from sales join menu on sales.product_id = menu.product_id group by product_name, customer_id, product_name) as sale_rank where sale_rank.ranking = 1;`

## 6. Which item was purchased first by the customer after they became a member?

`select customer_id, join_date, order_date, product_name from (select members.customer_id, members.join_date, sales.order_date, menu.product_name, rank() over (partition by members.customer_id order by order_date asc) as ranking from members  left join sales on members.customer_id = sales.customer_id and members.join_date < sales.order_date join menu on menu.product_id = sales.product_id) as first_order where first_order.ranking = 1`

## 7. Which item was purchased just before the customer became a member?

`select customer_id, join_date, order_date, product_name from (select members.customer_id, members.join_date, sales.order_date, menu.product_name, row_number() over (partition by members.customer_id order by order_date desc) as ranking from members  left join sales on members.customer_id = sales.customer_id and members.join_date > sales.order_date join menu on menu.product_id = sales.product_id) as first_order where first_order.ranking = 1`

## 8. What is the total items and amount spent for each member before they became a member?

`select members.customer_id, count(menu.product_id), sum(menu.price) from members left join sales on members.customer_id = sales.customer_id and members.join_date > sales.order_date join menu on menu.product_id = sales.product_id group by members.customer_id`

## 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

`select customer_id, sum(points) from (select customer_id, product_name, case when product_name = 'sushi' then price * 20 else price * 10 end as points  from sales join menu on menu.product_id = sales.product_id) as total_point group by customer_id`

## 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

`select customer_id, sum(points) from (select sales.customer_id, join_date, order_date, case when order_date between join_date and join_date + 6 then price *20 else price*10 end as points from sales join members on sales.customer_id = members.customer_id join menu on menu.product_id = sales.product_id where order_date >= join_date and order_date < '2021-01-31') as total_point group by customer_id`