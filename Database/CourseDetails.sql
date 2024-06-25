WITH lesson_count as (
SELECT 
    s.id, s.course_id, s.name, COUNT(l.id) AS lesson_per_section
FROM
    section s
        JOIN
    lesson l ON s.id = l.section_id
GROUP BY s.id , s.name
),
section_count as (
SELECT 
    course_id,
    SUM(lesson_per_section) AS total_lesson,
    COUNT(lesson_per_section) AS total_section
FROM
    lesson_count
GROUP BY course_id
),
review_count as (
SELECT 
    source_id,
    COUNT(source_id) AS total_review,
    AVG(rating_star) AS avg_star
FROM
    lms.review
GROUP BY source_id
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
    round(r.avg_star, 1) as avg_star
FROM
    lms.course c
        JOIN
    user u ON c.mentor_id = u.id
        JOIN
    section_count s ON c.id = s.course_id
        JOIN 
    review_count r on c.id = r.source_id    
WHERE c.id = 'C1'    
