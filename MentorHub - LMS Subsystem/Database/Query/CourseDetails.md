## Course Details

```sql
WITH lesson_count AS (
    SELECT
        s.id,
        s.course_id,
        s.name,
        COUNT(l.id) AS lesson_per_section
    FROM
        section s
        JOIN lesson l ON s.id = l.section_id
    GROUP BY
        s.id,
        s.name,
		s.course_id
),
section_count AS (
    SELECT
        course_id,
        SUM(lesson_per_section) AS total_lesson,
        COUNT(lesson_per_section) AS total_section
    FROM
        lesson_count
    GROUP BY
        course_id
),
review_count AS (
    SELECT
        source_id,
        COUNT(source_id) AS total_review,
        AVG(rating_star) AS avg_star
    FROM
        Review
    GROUP BY
        source_id
)
SELECT
    c.name,
    c.price,
    u.name,
    u.asset_id,
    c.description,
    s.total_lesson,
    s.total_section,
    r.total_review,
    ROUND(r.avg_star, 1) AS avg_star
FROM
    Course c
    JOIN [user] u ON c.mentor_id = u.id
    JOIN section_count s ON c.id = s.course_id
    JOIN review_count r ON c.id = r.source_id
WHERE
    c.id = 1;
```

## Reviews

```sql
SELECT
    u.name, rating_star, content, review_at
FROM
    Review r
        JOIN
    [user] u ON r.user_id = u.id
WHERE
    r.source_id = 1;
```

## Related course

```sql
with cte as (SELECT
    id, category_id
FROM
    course
WHERE
    id = 1)
SELECT
    name AS course_name, price, mentor_id
FROM
    course
        JOIN
    cte ON cte.category_id = course.category_id
        AND course.id != cte.id
```
