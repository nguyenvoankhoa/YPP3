## Data Exploration and Cleansing
## Update the fresh_segments.interest_metrics table by modifying the month_year column to be a date data type with the start of the month
```sql
ALTER TABLE interest_metrics MODIFY COLUMN month_year varchar(10);
UPDATE interest_metrics 
SET month_year = STR_TO_DATE(CONCAT(month_year, '-01'), '%m-%Y-%d');
ALTER TABLE interest_metrics MODIFY COLUMN month_year date;

```
## What is count of records in the fresh_segments.interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?
```sql
SELECT month_year, COUNT(*) 
FROM interest_metrics 
GROUP BY month_year 
ORDER BY month_year IS NULL, month_year;

```
## What do you think we should do with these null values in the fresh_segments.interest_metrics
```sql
DELETE FROM interest_metrics 
WHERE
    interest_id IS NULL

```
## How many interest_id values exist in the fresh_segments.interest_metrics table but not in the fresh_segments.interest_map table? What about the other way around?
```sql
SELECT 
    COUNT(DISTINCT id) AS map_id,
    SUM(CASE
        WHEN me.interest_id IS NULL THEN 1
        ELSE 0
    END) AS not_int_metric
FROM
    interest_map AS ma
        LEFT OUTER JOIN
    interest_metrics AS me ON ma.id = me.interest_id 
UNION SELECT 
    COUNT(DISTINCT interest_id) AS metric_id,
    SUM(CASE
        WHEN ma.id IS NULL THEN 1
        ELSE 0
    END) AS not_int_map
FROM
    interest_map AS ma
        RIGHT OUTER JOIN
    interest_metrics AS me ON ma.id = me.interest_id
```
## Summarise the id values in the fresh_segments.interest_map by its total record count in this table
```sql
SELECT 
    COUNT(*)
FROM
    interest_map

```
## What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your joined output and include all columns from fresh_segments.interest_metrics and all columns from fresh_segments.interest_map except from the id column.
```sql
SELECT 
    *
FROM
    interest_map AS ma
        JOIN
    interest_metrics AS me ON ma.id = me.interest_id
WHERE
    ma.id = 21246

```
## Are there any records in your joined table where the month_year value is before the created_at value from the fresh_segments.interest_map table? Do you think these values are valid and why?
```sql
SELECT 
    id, interest_name, created_at, month_year
FROM
    interest_map AS ma
        JOIN
    interest_metrics AS me ON ma.id = me.interest_id
WHERE
    month_year < created_at
```
## Interest Analysis
## Which interests have been present in all month_year dates in our dataset?
```sql
SELECT 
    interest_id
FROM
    (SELECT 
        interest_id, COUNT(DISTINCT month_year) AS total_present
    FROM
        interest_metrics
    WHERE
        month_year IS NOT NULL
    GROUP BY interest_id) AS cte
WHERE
    total_present = 14
```
## Using this same total_months measure - calculate the cumulative percentage of all records starting at 14 months - which total_months value passes the 90% cumulative percentage value?
```sql
with cte as (
 select interest_id, count(distinct month_year) as total_month from interest_metrics where month_year is not null group by interest_id
), cte_2 as (
select total_month, sum(interest_id) as interest_count from cte group by total_month
), cte_3 as (
select *, 100 * sum(interest_count) over (order by total_month desc) / (select sum(interest_count) from cte_2) as cummulative_pct from cte_2 group by total_month
)
select * from cte_3 where cummulative_pct >= 90
```
## If we were to remove all interest_id values which are lower than the total_months value we found in the previous question - how many total data points would we be removing?
```sql
with cte as
(
select interest_id, count(distinct month_year) as month_count
from 
interest_metrics
group by interest_id
having count(distinct month_year) <6 
)
select count(interest_id) from interest_metrics where interest_id in (select interest_id from cte)

```
## Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed interest example for your arguments - think about what it means to have less months present from a segment perspective.
```sql
WITH few_interest AS (
    SELECT 
        interest_id, 
        COUNT(DISTINCT month_year) AS month_count
    FROM 
        interest_metrics
    GROUP BY 
        interest_id
    HAVING 
        COUNT(DISTINCT month_year) < 6 
),
not_interests AS (
    SELECT 
        COUNT(*) AS remove_interest, 
        month_year 
    FROM 
        interest_metrics 
    WHERE 
        interest_id IN (SELECT interest_id FROM few_interest) 
    GROUP BY 
        month_year
),
current_interests AS (
    SELECT 
        COUNT(*) AS current_interest, 
        month_year 
    FROM 
        interest_metrics 
    WHERE 
        interest_id NOT IN (SELECT interest_id FROM few_interest) 
    GROUP BY 
        month_year
)
SELECT 
    remove_interest, 
    current_interest, 
    not_interests.month_year, 
    100 * remove_interest / current_interest AS remove_pct 
FROM 
    not_interests 
JOIN 
    current_interests 
ON 
    not_interests.month_year = current_interests.month_year;

```
## After removing these interests - how many unique interests are there for each month?
```sql
with few_interest as
(
select interest_id, count(distinct month_year) as month_count
from 
interest_metrics
group by interest_id
having count(distinct month_year) <6 
)
select count(distinct interest_id) as current_interest , month_year from interest_metrics where interest_id not in (select interest_id from few_interest) group by month_year

```
## Segment Analysis
## Using our filtered dataset by removing the interests with less than 6 months worth of data, which are the top 10 and bottom 10 interests which have the largest composition values in any month_year? Only use the maximum composition value for each interest but you must keep the corresponding month_year
```sql
create view filter_table as
with filtered as (select interest_id , count(distinct month_year) as month_count from interest_metrics group by interest_id having month_count >= 6)
select * from interest_metrics where interest_id in (select interest_id from filtered);
select interest_id , month_year, max(composition) as top_compo from filter_table group by month_year , interest_id order by top_compo desc limit 10
```
## Which 5 interests had the lowest average ranking value?
```sql
select interest_id, avg(ranking) as rank_val from filter_table group by interest_id order by rank_val limit 5

```
## Which 5 interests had the largest standard deviation in their percentile_ranking value?
```sql
select interest_id, stddev(percentile_ranking) as std from filter_table group by interest_id order by std desc limit 5
```
## For the 5 interests found in the previous question - what was minimum and maximum percentile_ranking values for each interest and its corresponding year_month value? Can you describe what is happening for these 5 interests?
```sql
with cte as (select interest_id, stddev(percentile_ranking) as std from filter_table group by interest_id order by std desc limit 5)
select max(percentile_ranking), min(percentile_ranking), month_year from filter_table where interest_id in (select interest_id from cte) group by month_year

```
## How would you describe our customers in this segment based off their composition and ranking values? What sort of products or services should we show to these customers and what should we avoid?
```sql
select * from filter_table
```
## Index Analysis
## What is the top 10 interests by the average composition for each month?
```sql
select interest_id, avg(composition) as avg_compo from interest_metrics group by interest_id order by avg_compo desc limit 10;

```
## For all of these top 10 interests - which interest appears the most often?
```sql
select interest_id, count(interest_id) from interest_metrics where interest_id in (select interest_id from cte) group by interest_id order by count(interest_id) desc limit 1

```
## What is the average of the average composition for the top 10 interests for each month?
```sql
with cte as (select interest_id, month_year, avg(composition) as avg_compo from interest_metrics group by interest_id, month_year order by avg_compo desc limit 10)
select avg(avg_compo) from cte
```
## What is the 3 month rolling average of the max average composition value from September 2018 to August 2019 and include the previous top ranking interests in the same output shown below.
```sql
create view index_table as 
 select *, round(composition/index_value,2) as avg_composition
 from interest_metrics 
 
with cte as (select month_year, round(max(avg_composition),2) as max_avg_comp from index_table group by month_year)
select ma.interest_name, i.month_year, interest_id, max_avg_comp as max_index_composition,
round(avg(max_avg_comp)over(order by i.month_year rows between 2 preceding and current row),2) as '3_month_moving_avg'
from index_table i join cte on cte.month_year = i.month_year
 join interest_map ma
 on i.interest_id=ma.id
 where avg_composition =max_avg_comp 
```
