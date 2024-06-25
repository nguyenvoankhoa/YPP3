SELECT 
    course_id,
    COUNT(mentee_id) AS num_enrolled,
    course.name AS course_name,
    course.price,
    category.name AS category
FROM
    menteecourse
        JOIN
    course ON menteecourse.course_id = course.id
        JOIN
    category ON course.category_id = category.id
GROUP BY course_id
ORDER BY num_enrolled DESC
LIMIT 4 