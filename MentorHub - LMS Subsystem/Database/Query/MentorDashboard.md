## Account Balance

```sql
SELECT
    SUM(price) AS revenue
FROM
    course c
    JOIN menteecourse mc ON c.id = mc.course_id AND mentor_id = 2;
```

## Total Course

```sql
SELECT
    COUNT(id) AS total_course
FROM
    course
WHERE
    mentor_id = 2;
```

## Total mentee

```sql
SELECT
    COUNT(DISTINCT mentee_id) AS total_student
FROM
    course c
    JOIN menteecourse mc ON c.id = mc.course_id AND c.mentor_id = 2;
```

## Active Student

```sql
SELECT COUNT(*)
   FROM UserOnline
WHERE DATEPART(DAY, online_date) = DATEPART(DAY, CURRENT_TIMESTAMP)
```

## New Enrollment

```sql
SELECT
    COUNT(*) AS new_enrollment
FROM
    course c
    JOIN menteecourse mc ON c.id = mc.course_id
WHERE
    DATEDIFF(DAY,CURRENT_TIMESTAMP, enroll_at) < 7
    AND mentor_id = 2;
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
select course_id, c.name, c.price ,e_weight + c_weight + a_weight as points from total t join Course c on t.course_id = c.id where c.mentor_id = 2 order by points desc
```

## Recent Review

```sql
SELECT top 5 rating_star,
        u.name FROM review r
JOIN course c
    ON source_id = c.id
        AND c.mentor_id = 2
JOIN [user] u
    ON r.mentee_id = u.id ORDER BY r.review_at
```
