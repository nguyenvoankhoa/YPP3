## 2. Data Exploration
## What day of the week is used for each week_date value?
```sql
SELECT 
    DAYOFWEEK(week_date) AS day_of_week
FROM
    data_mart.clean_weekly_sales;
```
## What range of week numbers are missing from the dataset?
```sql
SELECT 
    year_num, SUM(year_num)
FROM
    clean_weekly_sales
GROUP BY year_num
```
## How many total transactions were there for each year in the dataset?
```sql
SELECT 
    year_num, SUM(transactions)
FROM
    clean_weekly_sales
GROUP BY year_num
```
## 3. Before & After Analysis
## What is the total sales for each region for each month?
```sql
SELECT 
    month_num,
    year_num,
    ROUND(100 * MAX(CASE
                WHEN platform = 'Shopify' THEN monthly_sale
                ELSE NULL
            END) / SUM(monthly_sale),
            2) AS shopify_sale,
    ROUND(100 * MAX(CASE
                WHEN platform = 'Retail' THEN monthly_sale
                ELSE NULL
            END) / SUM(monthly_sale),
            2) AS retail_sale
FROM
    (SELECT 
        SUM(sales) AS monthly_sale, month_num, platform, year_num
    FROM
        clean_weekly_sales
    GROUP BY month_num , platform , year_num) AS cte_table
GROUP BY month_num , year_num
```
## What is the total count of transactions for each platform
```sql
SELECT 
    year_num,
    100 * MAX(CASE
        WHEN demographic = 'Couples' THEN total
        ELSE NULL
    END) / SUM(total) AS couple_rate,
    100 * MAX(CASE
        WHEN demographic = 'Families' THEN total
        ELSE NULL
    END) / SUM(total) AS family_rate,
    100 * MAX(CASE
        WHEN demographic = 'unknown' THEN total
        ELSE NULL
    END) / SUM(total) AS unknown_rate
FROM
    (SELECT 
        demographic, year_num, SUM(sales) AS total
    FROM
        clean_weekly_sales
    GROUP BY year_num , demographic) AS cte
GROUP BY year_num
```
## What is the percentage of sales for Retail vs Shopify for each month?
```sql
WITH monthly_transactions AS (
  SELECT 
    calendar_year, 
    month_number, 
    platform, 
    SUM(sales) AS monthly_sales
  FROM clean_weekly_sales
  GROUP BY calendar_year, month_number, platform
)

SELECT 
  calendar_year, 
  month_number, 
  ROUND(100 * MAX 
    (CASE 
      WHEN platform = 'Retail' THEN monthly_sales ELSE NULL END) 
    / SUM(monthly_sales),2) AS retail_percentage,
  ROUND(100 * MAX 
    (CASE 
      WHEN platform = 'Shopify' THEN monthly_sales ELSE NULL END)
    / SUM(monthly_sales),2) AS shopify_percentage
FROM monthly_transactions
GROUP BY calendar_year, month_number
ORDER BY calendar_year, month_number;
```
## What is the percentage of sales by demographic for each year in the dataset?
```sql
WITH demographic_sales AS (
  SELECT 
    calendar_year, 
    demographic, 
    SUM(sales) AS yearly_sales
  FROM clean_weekly_sales
  GROUP BY calendar_year, demographic
)

SELECT 
  calendar_year, 
  ROUND(100 * MAX 
    (CASE 
      WHEN demographic = 'Couples' THEN yearly_sales ELSE NULL END)
    / SUM(yearly_sales),2) AS couples_percentage,
  ROUND(100 * MAX 
    (CASE 
      WHEN demographic = 'Families' THEN yearly_sales ELSE NULL END)
    / SUM(yearly_sales),2) AS families_percentage,
  ROUND(100 * MAX 
    (CASE 
      WHEN demographic = 'unknown' THEN yearly_sales ELSE NULL END)
    / SUM(yearly_sales),2) AS unknown_percentage
FROM demographic_sales
GROUP BY calendar_year;
```
## Which age_band and demographic values contribute the most to Retail sales?
```sql
SELECT 
    age_band, demographic, SUM(sales) AS total_sale
FROM
    clean_weekly_sales
GROUP BY age_band , demographic
ORDER BY total_sale DESC
```
## Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
```sql
SELECT 
    year_num, platform, AVG(avg_transaction)
FROM
    clean_weekly_sales
GROUP BY year_num , platform
```
