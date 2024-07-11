## Revenue

```sql
SELECT sum(price) as total_revenue FROM menteecourse me join course c on me.course_id = c.id;
```

## Total mentees

```sql
SELECT COUNT(*) as total_mentee FROM [user] where role_id = 3;
```

## Total mentors

```sql
SELECT COUNT(*) as total_mentor FROM [user] where role_id = 2;
```

## Total courses

```sql
SELECT COUNT(*) as total_course FROM Course
```

## Total sales

```sql
SELECT
    SUM(price) AS monthly_sale
FROM
    course c
    JOIN menteecourse mc ON c.id = mc.course_id
WHERE
    MONTH(mc.enroll_at) = MONTH(CURRENT_TIMESTAMP);
```

## Sale this week

```sql
SELECT
    SUM(c.price) AS weekly_sale
FROM
    course c
    JOIN menteecourse mc ON c.id = mc.course_id
WHERE
    DATEPART(YEAR, mc.enroll_at) = DATEPART(YEAR, GETDATE()) and DATEPART(WEEK, mc.enroll_at) = DATEPART(WEEK, GETDATE())
```

## Active mentees

```sql
WITH cte AS (
    SELECT
        DATEPART(DAY, online_date) AS onl_date,
        DATEPART(HOUR, online_time) + (DATEPART(MINUTE, online_time) / 60.0) AS onl_time
    FROM
        UserOnline
)
SELECT
    onl_date,
    SUM(onl_time) AS total_time
FROM
    cte
GROUP BY
    onl_date;

```

## Category activities

```sql
WITH day_sell AS (
    SELECT
        COUNT(*) AS total_sells,
        category_id
    FROM
        course
    WHERE
        DATEDIFF(day, CURRENT_TIMESTAMP, created_at) < 15
    GROUP BY
        category_id
),
day_buy AS (
    SELECT
        COUNT(course_id) AS total_buy,
        category_id
    FROM
        course c
        JOIN menteecourse m ON c.id = m.course_id
    GROUP BY
        category_id
)
SELECT
    sell.total_sells,
    buy.total_buy,
    category.name
FROM
    day_sell AS sell
    JOIN day_buy AS buy ON sell.category_id = buy.category_id
    JOIN category ON sell.category_id = category.id;

```

## Top course

```sql
WITH cte as (SELECT mc.course_id, COUNT(mc.course_id) as enroll_nums FROM MenteeCourse mc
JOIN Course c on mc.course_id = c.id
GROUP BY mc.course_id),
enrollments as (
SELECT course_id, enroll_nums * 1.0 / (SELECT MAX(enroll_nums) from cte) as enroll_nums from cte),
completion as (
SELECT
    mc.course_id,
    SUM(CASE WHEN mc.cert_id IS NOT NULL THEN 1 ELSE 0 END)* 1.0 / COUNT(*) AS complete
FROM
    MenteeCourse mc
JOIN
    Course c ON mc.course_id = c.id
GROUP BY
    mc.course_id
),
rating as(
SELECT source_id, avg(rating_star) * 1.0 / 5 as avg_rating FROM Review
where source_type_id = (SELECT setting_value FROM GetSettingValue('SourceType', 'course'))
group by source_id
),
total as( SELECT e.course_id, enroll_nums * (SELECT setting_value FROM GetSettingValue('Criteria', 'Enrollments')) as e_weight,
complete * (SELECT setting_value FROM GetSettingValue('Criteria', 'Completion Rate')) as c_weight,
avg_rating *(SELECT setting_value FROM GetSettingValue('Criteria', 'Average Learner Rating')) as a_weight FROM enrollments e join completion c on e.course_id = c.course_id join rating r on e.course_id = r.source_id)
select course_id, c.name, c.price ,e_weight + c_weight + a_weight as points from total t join Course c on t.course_id = c.id order by points desc

```

## Top mentor

```sql
WITH rating AS (
    SELECT
        AVG(rating_star) AS average_star,
        mentor_id
    FROM
        Review r
        JOIN course c ON r.source_id = c.id
    GROUP BY
        mentor_id
)
SELECT
    rating.average_star,
    c.mentor_id,
    COUNT(c.mentor_id) AS enroll_per_mentor
FROM
    course c
    JOIN menteecourse m ON c.id = m.course_id
    JOIN rating ON c.mentor_id = rating.mentor_id
GROUP BY
    c.mentor_id, rating.average_star;

```

## New mentees

```sql
SELECT gender, count(*) as enroll_num,  create_at
FROM [User]
WHERE DATEDIFF(DAY, create_at, CURRENT_TIMESTAMP) < (SELECT setting_value FROM GetSettingValue('Criteria', 'New Mentee')) AND role_id = 3
GROUP BY gender, create_at
```
