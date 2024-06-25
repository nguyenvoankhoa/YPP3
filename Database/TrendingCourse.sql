SELECT 
    course.name AS courseName,
    course.price,
    course.description,
    category.name AS category,
    course.created_at,
    rate.avg_rate,
    rate.total_rate
FROM
    course
        JOIN
    category ON course.category_id = category.id
        JOIN
    (SELECT 
        course_id
    FROM
        menteecourse
    GROUP BY course_id
    ORDER BY COUNT(course_id) DESC
    LIMIT 4) AS trending ON course.id = trending.course_id
        JOIN
    (SELECT 
        COUNT(review.rating_star) AS total_rate,
            SUM(review.rating_star) / COUNT(review.rating_star) AS avg_rate,
            course.id
    FROM
        review
    JOIN course ON review.source_id = course.id
    GROUP BY course.id) AS rate ON course.id = rate.id
ORDER BY rate.avg_rate DESC
