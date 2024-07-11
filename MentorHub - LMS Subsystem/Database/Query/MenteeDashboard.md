## Total course

```sql
SELECT
    COUNT(*) AS total_course
FROM
    menteecourse
WHERE
    mentee_id = 11;
```

## Completed Course

```sql
SELECT
    COUNT(*) AS complete_course
FROM
    menteecourse
WHERE
    mentee_id = 11
    AND cert_id IS NOT NULL;
```

## Total Quiz

```sql
SELECT
    COUNT(*) AS total_quiz
FROM
    quizresult
WHERE
    mentee_id = 11;
```

## Pass Quizz

```sql
SELECT count(*) as pass_quiz FROM quizresult where  mentee_id = 11 and result = 1;
```

## Course Progress

```sql
SELECT
    me.course_id,
    me.progress,
    c.name,
    CASE
        WHEN me.progress = 0 THEN 'Pending'
        WHEN me.progress < 100 THEN 'Processing'
        ELSE 'Completed'
    END AS tag
FROM
    menteecourse me
    JOIN course c ON me.course_id = c.id
WHERE
    me.mentee_id = 11;
```

## Course Statistics

```sql
SELECT
    status,
    ROUND((COUNT(*) * 100.0 / total_courses), 2) AS percentage
FROM
    (
        SELECT
            CASE
                WHEN progress = 0 THEN 'Pending'
                WHEN progress < 100 THEN 'Processing'
                ELSE 'Completed'
            END AS status,
            COUNT(*) OVER() AS total_courses
        FROM
            menteecourse me
            JOIN course c ON me.course_id = c.id
        WHERE
            mentee_id = 11
    ) subquery
GROUP BY
    status, total_courses;

```

## Average Hour Activity

```sql
SELECT
    SUM(DATEPART(HOUR, online_time) + (DATEPART(MINUTE, online_time) / 60.0)) AS total_online_time,
    MONTH(online_date) AS monthly
FROM
    UserOnline
WHERE
    user_id = 7
GROUP BY MONTH(online_date)
```

## Todo List

```sql
SELECT
    s.name AS section_name,
    q.name AS quiz_name
FROM
    menteecourse mc
    JOIN section s ON mc.course_id = s.course_id
    JOIN quiz q ON s.id = q.section_id
WHERE
    mc.mentee_id = 11
    AND q.id NOT IN (
        SELECT
            quiz_id
        FROM
            quizresult
        WHERE
            mentee_id = 11
            AND result = 1
    );
```
