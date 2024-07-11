## Category

```sql
SELECT name FROM category;
```

## SourceImage

```sql
SELECT source_id, asset_id
FROM SourceImage
WHERE source_type_id = (SELECT value FROM Setting WHERE type = 'SourceType' AND name = 'course');
```

## Tag

```sql
SELECT name from Tag;
```
