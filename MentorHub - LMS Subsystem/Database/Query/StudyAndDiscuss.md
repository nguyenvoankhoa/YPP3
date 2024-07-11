## Section

```sql
SELECT
    s.name AS section_name,
    l.id,
    l.title
FROM
    section s
    JOIN lesson l ON s.id = l.section_id
WHERE
    s.id = 1;
```

## Lesson

```sql
SELECT
    l.id,
    l.title,
    l.transcript,
    l.summary,
    l.asset_id,
    u.name,
    d.content
FROM
    Lesson l
    JOIN discussion d ON l.id = d.lesson_id
    JOIN [user] u ON u.id = d.user_id
WHERE
    l.id = 2;
```
