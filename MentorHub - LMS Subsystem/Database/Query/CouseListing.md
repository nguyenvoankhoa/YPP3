## Recommend Course

```sql
WITH latest_tags AS (
SELECT TOP 10 st.tag_id,
        COUNT(el.id) AS tag_count

    FROM EventLog el

JOIN SourceTag st

    ON el.source_id = st.source_id

        AND el.source_type_id = st.source_type_id

    WHERE el.user_id = 7

    GROUP BY  st.tag_id

ORDER BY  tag_count DESC
)
SELECT c.id, c.name, c.price, COUNT(r.source_id) AS review_count, AVG(r.rating_star) AS rating_star, COUNT(st.tag_id) AS tag_similar_count
FROM
	latest_tags lt
	JOIN SourceTag st
		ON lt.tag_id = st.tag_id
	JOIN Course c
		ON st.source_id = c.id
	LEFT
JOIN review r
    ON r.source_id = c.id
        AND r.source_type = (
		SELECT setting_value FROM GetSettingValue('SourceType', 'course')
	)
GROUP BY
 c.id,
 c.name,
 c.price
```

## Popular Course

```sql
SELECT
    c.id,
    c.name,
    c.price,
	COUNT(r.source_id) AS review_count,
    AVG(r.rating_star) AS rating_star,
    COUNT(el.user_id) AS view_count
FROM
    EventLog el
    JOIN Course c ON el.source_id = c.id AND el.source_type_id = (
       SELECT setting_value FROM GetSettingValue('SourceType', 'course')
    )
	LEFT JOIN review r ON r.source_id = c.id AND r.source_type_id = (
	   SELECT setting_value FROM GetSettingValue('SourceType', 'course')
	)
GROUP BY
    c.id,
    c.name,
    c.price
ORDER BY view_count DESC;
```

## Trending Course

```sql
WITH monthly_enrollments AS (
    SELECT
        course_id, FORMAT(enroll_at, 'yyyy-MM') AS month,
        COUNT(*) AS enrollments
    FROM
        MenteeCourse
    GROUP BY
        course_id, FORMAT(enroll_at, 'yyyy-MM')
)
SELECT
	course_id,
    month,
    enrollments,
    LAG(enrollments) OVER (ORDER BY month) AS previous_month_enrollments,
    CASE
        WHEN LAG(enrollments) OVER (ORDER BY month) IS NULL THEN 0
        ELSE (enrollments - LAG(enrollments) OVER (ORDER BY month)) * 100.0 / LAG(enrollments) OVER (ORDER BY month)
    END AS growth_rate
FROM
    monthly_enrollments
WHERE
	month = FORMAT(DATEADD(MONTH, 0, GETDATE()), 'yyyy-MM')
ORDER BY
    course_id, month;
```
