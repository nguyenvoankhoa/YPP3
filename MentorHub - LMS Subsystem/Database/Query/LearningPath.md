## LearningPath

```sql
SELECT
    l.title,
    l.description,
    u.name,
    l.created_at
FROM
    learningpath l
    JOIN [user] u ON l.mentor_id = u.id;
```
