SELECT 
    mentee_id, rating_star, content, review_at
FROM
    lms.review
WHERE
    source_id = 'C1';