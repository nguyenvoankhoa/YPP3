-- Insert into Role table
INSERT INTO Role (name) VALUES ('mentee'), ('mentor'), ('admin');

-- Insert into User table
-- Insert sample data into User table
INSERT INTO User (name, asset_id, role_id, is_active, last_login) VALUES
-- 1 Admin
('AdminUser1', 'A001', 1, TRUE, '2024-06-24 10:30:00'),

-- 5 Mentors
('MentorUser1', 'M001', 2, TRUE, '2024-06-23 09:15:00'),
('MentorUser2', 'M002', 2, TRUE, '2024-06-22 08:20:00'),
('MentorUser3', 'M003', 2, FALSE, '2024-06-21 07:25:00'),
('MentorUser4', 'M004', 2, TRUE, '2024-06-20 06:30:00'),
('MentorUser5', 'M005', 2, FALSE, '2024-06-19 05:35:00'),

-- 10 Mentees
('MenteeUser1', 'N001', 3, TRUE, '2024-06-18 04:40:00'),
('MenteeUser2', 'N002', 3, FALSE, '2024-06-17 03:45:00'),
('MenteeUser3', 'N003', 3, TRUE, '2024-06-16 02:50:00'),
('MenteeUser4', 'N004', 3, FALSE, '2024-06-15 01:55:00'),
('MenteeUser5', 'N005', 3, TRUE, '2024-06-14 12:00:00'),
('MenteeUser6', 'N006', 3, FALSE, '2024-06-13 11:05:00'),
('MenteeUser7', 'N007', 3, TRUE, '2024-06-12 10:10:00'),
('MenteeUser8', 'N008', 3, FALSE, '2024-06-11 09:15:00'),
('MenteeUser9', 'N009', 3, TRUE, '2024-06-10 08:20:00'),
('MenteeUser10', 'N010', 3, FALSE, '2024-06-09 07:25:00');


-- Insert into Category table
INSERT INTO Category (id, name) VALUES
('CT1', 'Information Technology'),
('CT2', 'UI/UX Design'),
('CT3', 'Marketing'),
('CT4', 'Lifestyle'),
('CT5', 'Photography'),
('CT6', 'Video');

-- Insert into Tag table
INSERT INTO Tag (name) VALUES
('Beginner Level'),
('Intermediate Level'),
('Best-seller'),
('20% Off');

-- Insert into Course table
INSERT INTO Course (id, name, category_id, price, description, created_at, mentor_id, pass_condition) VALUES
('C1', 'Introduction to Python Programming', 'CT1', 49.99, 'Learn Python programming basics and fundamentals.', CURRENT_TIMESTAMP, 2, 70),
('C2', 'UI/UX Design Principles', 'CT2', 79.99, 'Explore principles of user interface and user experience design.', CURRENT_TIMESTAMP, 3, 80),
('C3', 'Digital Marketing Strategies', 'CT3', 59.99, 'Discover effective digital marketing strategies and techniques.', CURRENT_TIMESTAMP, 4, 75),
('C4', 'Healthy Lifestyle Habits', 'CT4', 29.99, 'Learn practical tips and habits for a healthy lifestyle.', CURRENT_TIMESTAMP, 6, 60),
('C5', 'Photography Masterclass', 'CT4', 89.99, 'Master the art of photography with professional techniques.', CURRENT_TIMESTAMP, 5, 85),
('C6', 'Video Production Essentials', 'CT5', 69.99, 'Essential skills and tools for producing high-quality videos.', CURRENT_TIMESTAMP, 2, 80),
('C7', 'Advanced Data Structures in C++', 'CT6', 99.99, 'Advanced data structures and algorithms in C++ programming language.', CURRENT_TIMESTAMP, 3, 85),
('C8', 'Introduction to Web Development', 'CT2', 49.99, 'Start your journey into web development with HTML, CSS, and JavaScript.', CURRENT_TIMESTAMP, 5, 70),
('C9', 'Effective Communication Skills', 'CT3', 39.99, 'Develop effective communication skills for personal and professional success.', CURRENT_TIMESTAMP, 6, 65),
('C10', 'Financial Planning and Budgeting', 'CT1', 79.99, 'Learn how to plan your finances and create effective budgets.', CURRENT_TIMESTAMP, 5, 75);

-- Insert into CourseTag table
INSERT INTO CourseTag (course_id, tag_id) VALUES
('C1', 1),
('C2', 2),
('C3', 3),
('C4', 4),
('C5', 4),
('C6', 2),
('C7', 1),
('C8', 2),
('C9', 3),
('C10', 4);

-- Insert into Section table
INSERT INTO Section (course_id, name) VALUES
('C1', 'Introduction'),
('C1', 'Basic Concepts'),
('C1', 'Advanced Techniques'),
('C2', 'Introduction'),
('C2', 'Basic Concepts'),
('C2', 'Advanced Techniques');

-- Insert into Lesson table
INSERT INTO Lesson (section_id, title, transcript, summary, asset_id) VALUES
-- Lessons for Section 1 (Introduction)
(1, 'Welcome to the Course', 'In this lesson, you will be introduced to the course and its objectives.', 'Introduction to the course and its objectives.', 'A001'),
(1, 'Course Overview', 'This lesson provides an overview of what will be covered throughout the course.', 'Overview of the course content and structure.', 'A002'),

-- Lessons for Section 2 (Basic Concepts)
(2, 'Understanding Variables', 'Learn about variables, their types, and how to declare them in programming.', 'Introduction to variables in programming.', 'B001'),
(2, 'Control Structures', 'Explore control structures such as if-statements, loops, and switch statements.', 'Introduction to control structures in programming.', 'B002'),

-- Lessons for Section 3 (Advanced Techniques)
(3, 'Database Design Principles', 'Learn about database design principles, normalization, and entity-relationship modeling.', 'Advanced concepts in database design.', 'C001'),
(3, 'Web Security Best Practices', 'Explore best practices for securing web applications and preventing common vulnerabilities.', 'Advanced techniques for web security.', 'C002');

-- Insert into Resource table
INSERT INTO Resource (asset_id, lesson_id) VALUES
('A001-1', 1),
('A001-2', 1),
('B001-1', 2),
('B001-2', 2),
('C001-1', 3),
('C001-2', 3),
('C001-3', 3),
('A002-1', 1),
('B002-1', 2),
('C002-1', 3);

-- Insert into Discussion table
INSERT INTO Discussion (user_id, lesson_id, parent_discussion_id, content, created_at) VALUES
(11, 1, NULL, 'Discussion Content One', CURRENT_TIMESTAMP),
(12, 2, NULL, 'Discussion Content Two', CURRENT_TIMESTAMP),
(13, 3, NULL, 'Discussion Content Three', CURRENT_TIMESTAMP),
(14, 4, NULL, 'Discussion Content Four', CURRENT_TIMESTAMP),
(15, 5, NULL, 'Discussion Content Five', CURRENT_TIMESTAMP),
(16, 6, NULL, 'Discussion Content Six', CURRENT_TIMESTAMP),
(8, 4, NULL, 'Discussion Content Seven', CURRENT_TIMESTAMP),
(12, 2, NULL, 'Discussion Content Eight', CURRENT_TIMESTAMP),
(14, 3, NULL, 'Discussion Content Nine', CURRENT_TIMESTAMP),
(13, 5, NULL, 'Discussion Content Ten', CURRENT_TIMESTAMP);

-- Insert into Review table
INSERT INTO Review (mentee_id, source_id, rating_star, content, review_at, source_type) VALUES
(11, 'C1', 5, 'Excellent course, very informative and well-structured.', CURRENT_TIMESTAMP, 'Course'),
(12, 'C2', 4, 'Great insights on UI/UX design principles.', CURRENT_TIMESTAMP, 'Course'),
(13, 'C3', 3, 'Good content but could be more detailed.', CURRENT_TIMESTAMP, 'Course'),
(14, 'C4', 5, 'Practical tips for a healthy lifestyle, highly recommended!', CURRENT_TIMESTAMP, 'Course'),
(15, 'C5', 4, 'Learned a lot about photography techniques.', CURRENT_TIMESTAMP, 'Course'),
(7, 'C6', 5, 'Fantastic video production course!', CURRENT_TIMESTAMP, 'Course'),
(8, 'C7', 4, 'Advanced concepts explained clearly.', CURRENT_TIMESTAMP, 'Course'),
(9, 'C8', 3, 'Good introduction to web development.', CURRENT_TIMESTAMP, 'Course'),
(10, 'C9', 5, 'Effective communication skills explained well.', CURRENT_TIMESTAMP, 'Course'),
(15, 'C10', 4, 'Useful financial planning and budgeting tips.', CURRENT_TIMESTAMP, 'Course');

-- Insert into MenteeSaveCourse table
INSERT INTO MenteeSaveCourse (course_id, mentee_id) VALUES
('C1', 7),
('C2', 8),
('C3', 13),
('C4', 14),
('C5', 15),
('C6', 16),
('C7', 7),
('C8', 8),
('C9', 9),
('C10', 10);

-- Insert into ImageBanner table
INSERT INTO ImageBanner (course_id, asset_id) VALUES
('C1', 'IMG001'),
('C2', 'IMG002'),
('C3', 'IMG003'),
('C4', 'IMG004'),
('C5', 'IMG005'),
('C6', 'IMG006'),
('C7', 'IMG007'),
('C8', 'IMG008'),
('C9', 'IMG009'),
('C10', 'IMG010');

-- Insert into PaymentType table
INSERT INTO PaymentMethod (method) VALUES
('Credit Card'),
('Debit Card'),
('PayPal'),
('Bank Transfer'),
('Cryptocurrency');

INSERT INTO Voucher (code, discount) VALUES
('WELCOME10', 10.0),
('SUMMER20', 20.0),
('FALL15', 15.0),
('WINTER25', 25.0),
('SPRING30', 30.0),
('HOLIDAY50', 50.0),
('NEWYEAR5', 5.0),
('BLACKFRIDAY40', 40.0),
('CYBERMONDAY35', 35.0),
('FLASHSALE45', 45.0);

-- Insert into UserPaymentInfo table
INSERT INTO UserPaymentInfo (user_id, name_on_card, card_number, expiry_date, payment_method_id) VALUES
(11, 'John Doe', '4111111111111111', '2025-12-31 00:00:00', 1),
(12, 'Jane Smith', '4222222222222222', '2024-11-30 00:00:00', 2),
(13, 'Michael Johnson', '4333333333333333', '2026-10-31 00:00:00', 3),
(14, 'Emily Brown', '4444444444444444', '2023-09-30 00:00:00', 4),
(15, 'David Wilson', '4555555555555555', '2027-08-31 00:00:00', 5),
(16, 'Sarah Lee', '4666666666666666', '2025-07-31 00:00:00', 4),
(7, 'Chris Martin', '4777777777777777', '2023-06-30 00:00:00', 2),
(8, 'Jessica Taylor', '4888888888888888', '2024-05-31 00:00:00', 1),
(9, 'Brian Harris', '4999999999999999', '2026-04-30 00:00:00', 3),
(10, 'Laura Clark', '4000000000000000', '2027-03-31 00:00:00', 2);

-- Insert into OrderTable
INSERT INTO `Order` (mentee_id, user_payment_id, status, voucher_id) VALUES
(11, 1, 1, 1),
(12, 2, 2, 2),
(13, 3, 1, 3),
(14, 4, 2, 4),
(15, 5, 1, 5),
(16, 6, 2, 2),
(7, 7, 1, 4),
(8, 8, 2, 5),
(9, 9, 1, 1),
(10, 10, 2, 3);

-- Insert into OrderDetail
INSERT INTO OrderDetail (order_id, price, source_id, source_type) VALUES
(1, 49.99, 'C1', 'Course'),
(2, 79.99, 'C2', 'Course'),
(3, 59.99, 'C3', 'Course'),
(4, 29.99, 'C4', 'Course'),
(5, 89.99, 'C5', 'Course'),
(6, 99.99, 'C6', 'Course'),
(7, 69.99, 'C7', 'Course'),
(8, 39.99, 'C8', 'Course'),
(9, 19.99, 'C9', 'Course'),
(10, 29.99, 'C10', 'Course');

-- Insert into Quiz table
INSERT INTO Quiz (name, summary, attempts_allowed, passing_grade, duration, section_id) VALUES
('Introduction to IT', 'Basic concepts of Information Technology.', 3, 70, '00:30:00', 1),
('UI/UX Fundamentals', 'Understanding the basics of UI/UX design.', 2, 75, '00:45:00', 2),
('Marketing Basics', 'Core principles of marketing.', 3, 60, '01:00:00', 3),
('Healthy Lifestyle', 'Tips for maintaining a healthy lifestyle.', 5, 80, '00:20:00', 4),
('Photography Techniques', 'Fundamentals of photography.', 4, 70, '00:40:00', 5),
('Video Production', 'Basic video production skills.', 3, 65, '01:30:00', 6),
('Advanced IT Concepts', 'In-depth IT topics.', 2, 75, '01:00:00', 1),
('UI/UX Advanced', 'Advanced UI/UX design techniques.', 2, 80, '00:50:00', 2),
('Marketing Strategies', 'Effective marketing strategies.', 3, 70, '01:10:00', 3),
('Nutrition and Wellness', 'Nutritional advice for better health.', 5, 85, '00:25:00', 4);

-- Insert into QuestionType table
INSERT INTO QuestionType (type) VALUES
('Multiple Choice'),
('True/False');

-- Insert into Question table
INSERT INTO Question (question_type_id, quiz_id, title, randomize, points, explanation) VALUES
(1, 1, 'What is Information Technology?', TRUE, 5.0, 'Basic definition of Information Technology.'),
(2, 1, 'List three examples of IT devices.', FALSE, 10.0, 'Examples include computers, smartphones, and servers.'),
(1, 2, 'What does UI stand for?', TRUE, 5.0, 'UI stands for User Interface.'),
(2, 2, 'Describe the main difference between UI and UX.', FALSE, 10.0, 'UI is about the look and feel, UX is about user experience.'),
(1, 3, 'Define marketing.', TRUE, 5.0, 'Marketing is the process of promoting products or services.'),
(2, 3, 'Explain the 4 Ps of marketing.', FALSE, 10.0, 'Product, Price, Place, Promotion.'),
(1, 4, 'Why is a healthy lifestyle important?', TRUE, 5.0, 'A healthy lifestyle helps maintain physical and mental health.'),
(2, 4, 'Give two benefits of regular exercise.', FALSE, 10.0, 'Benefits include improved fitness and mood.'),
(1, 5, 'What is aperture in photography?', TRUE, 5.0, 'Aperture controls the amount of light entering the camera.'),
(2, 5, 'Explain the rule of thirds in photography.', FALSE, 10.0, 'It is a composition technique for balancing images.'),
(1, 6, 'What is video editing?', TRUE, 5.0, 'Video editing involves rearranging video shots to create a new work.'),
(2, 6, 'List two popular video editing software.', FALSE, 10.0, 'Examples are Adobe Premiere Pro and Final Cut Pro.'),
(1, 7, 'Define cloud computing.', TRUE, 5.0, 'Cloud computing is delivering computing services over the internet.'),
(2, 7, 'Give one advantage and one disadvantage of cloud computing.', FALSE, 10.0, 'Advantage: scalability, Disadvantage: security risks.'),
(1, 8, 'What is a wireframe in UI design?', TRUE, 5.0, 'A wireframe is a basic visual guide to suggest the structure of an interface.'),
(2, 8, 'Explain the concept of user personas.', FALSE, 10.0, 'User personas are fictional characters created to represent different user types.'),
(1, 9, 'What is a marketing funnel?', TRUE, 5.0, 'A marketing funnel is a model describing the customer journey.'),
(2, 9, 'Describe the stages of a marketing funnel.', FALSE, 10.0, 'Stages include awareness, interest, decision, and action.'),
(1, 10, 'Why is proper nutrition important?', TRUE, 5.0, 'Proper nutrition is essential for maintaining good health.'),
(2, 10, 'Name two essential nutrients and their functions.', FALSE, 10.0, 'Proteins for growth and repair, carbohydrates for energy.');

-- Insert into Answer table
INSERT INTO Answer (question_id, content, asset_id, is_correct) VALUES
(1, 'Information Technology is the use of computers to store, retrieve, transmit, and manipulate data.', NULL, TRUE),
(2, 'Computers, smartphones, servers', NULL, TRUE),
(2, 'Refrigerators, microwaves, toasters', NULL, FALSE),
(3, 'User Interface', NULL, TRUE),
(3, 'User Interaction', NULL, FALSE),
(4, 'UI is the look and feel, UX is the experience.', NULL, TRUE),
(4, 'UI is the experience, UX is the look and feel.', NULL, FALSE),
(5, 'Marketing is the process of promoting and selling products or services.', NULL, TRUE),
(5, 'Marketing is the process of producing goods.', NULL, FALSE),
(6, 'Product, Price, Place, Promotion', NULL, TRUE),
(6, 'Production, People, Planning, Promotion', NULL, FALSE),
(7, 'A healthy lifestyle helps maintain physical and mental health.', NULL, TRUE),
(7, 'A healthy lifestyle helps in earning more money.', NULL, FALSE),
(8, 'Improved fitness, enhanced mood', NULL, TRUE),
(8, 'Better financial status, increased sleep', NULL, FALSE),
(9, 'Aperture controls the amount of light entering the camera.', NULL, TRUE),
(9, 'Aperture adjusts the focus of the lens.', NULL, FALSE),
(10, 'Rule of thirds is a composition technique for balancing images.', NULL, TRUE),
(10, 'Rule of thirds is a lighting technique.', NULL, FALSE),
(11, 'Video editing involves rearranging video shots to create a new work.', NULL, TRUE),
(11, 'Video editing is about recording video.', NULL, FALSE),
(12, 'Adobe Premiere Pro, Final Cut Pro', NULL, TRUE),
(12, 'Microsoft Word, Excel', NULL, FALSE),
(13, 'Cloud computing is delivering computing services over the internet.', NULL, TRUE),
(13, 'Cloud computing is a type of physical storage device.', NULL, FALSE),
(14, 'Scalability, Security risks', NULL, TRUE),
(14, 'Cheap cost, No disadvantages', NULL, FALSE),
(15, 'A wireframe is a basic visual guide to suggest the structure of an interface.', NULL, TRUE),
(15, 'A wireframe is a final design of an interface.', NULL, FALSE),
(16, 'User personas are fictional characters created to represent different user types.', NULL, TRUE),
(16, 'User personas are real users interacting with the product.', NULL, FALSE),
(17, 'A marketing funnel is a model describing the customer journey.', NULL, TRUE),
(17, 'A marketing funnel is a tool for data analysis.', NULL, FALSE),
(18, 'Awareness, Interest, Decision, Action', NULL, TRUE),
(18, 'Awareness, Interest, Decision, Purchase', NULL, FALSE),
(19, 'Proper nutrition is essential for maintaining good health.', NULL, TRUE),
(19, 'Proper nutrition is only necessary for athletes.', NULL, FALSE),
(20, 'Proteins for growth and repair, Carbohydrates for energy', NULL, TRUE),
(20, 'Vitamins for energy, Carbohydrates for muscle building', NULL, FALSE);

-- Insert into QuizResult table
INSERT INTO QuizResult (mentee_id, quiz_id, date, mark, result) VALUES
(11, 1, CURRENT_TIMESTAMP, 90.0, TRUE),
(12, 2, CURRENT_TIMESTAMP, 80.0, TRUE),
(13, 3, CURRENT_TIMESTAMP, 70.0, TRUE),
(14, 4, CURRENT_TIMESTAMP, 60.0, FALSE),
(15, 5, CURRENT_TIMESTAMP, 50.0, FALSE),
(16, 6, CURRENT_TIMESTAMP, 90.0, TRUE),
(7, 7, CURRENT_TIMESTAMP, 80.0, TRUE),
(8, 8, CURRENT_TIMESTAMP, 70.0, TRUE),
(9, 9, CURRENT_TIMESTAMP, 60.0, FALSE),
(10, 10, CURRENT_TIMESTAMP, 50.0, FALSE);

-- Insert into MenteeQuestion table
INSERT INTO MenteeQuestion (mentee_id, question_id, earned_marks) VALUES
(11, 1, 4.5),
(11, 2, 9.5),
(11, 3, 5.0),
(11, 4, 10.0),
(12, 1, 3.0),
(12, 2, 7.0),
(12, 3, 4.5),
(12, 4, 8.0),
(13, 5, 4.5),
(13, 6, 9.0),
(13, 7, 5.0),
(13, 8, 10.0),
(14, 5, 3.0),
(14, 6, 7.5),
(14, 7, 4.0),
(14, 8, 8.5),
(15, 9, 4.0),
(15, 10, 8.0),
(15, 11, 5.0),
(15, 12, 10.0);

-- Insert into LearningPath table
INSERT INTO LearningPath (title, description, mentor_id, created_at, updated_at) VALUES
('Introduction to Information Technology', 'Learn the basics of Information Technology.', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('UI/UX Design Fundamentals', 'Discover the principles of User Interface and User Experience design.', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Digital Marketing Essentials', 'Understand core concepts and strategies in digital marketing.', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Healthy Lifestyle Journey', 'Explore ways to lead a healthier lifestyle.', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Photography Techniques Masterclass', 'Master the fundamentals of photography.', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Video Production Basics', 'Learn essential skills for video production.', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Advanced Marketing Strategies', 'Explore advanced marketing techniques.', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('IT Security Fundamentals', 'Understand the basics of IT security.', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Creative UI/UX Approaches', 'Explore creative approaches in UI/UX design.', 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Fitness and Nutrition for Life', 'Discover the importance of fitness and nutrition.', 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert into CourseLearningPath table
INSERT INTO CourseLearningPath (learning_path_id, course_id) VALUES
(1, 'C1'),
(1, 'C2'),
(2, 'C2'),
(2, 'C3'),
(3, 'C3'),
(3, 'C4'),
(4, 'C4'),
(4, 'C5'),
(5, 'C5'),
(5, 'C6'),
(6, 'C1'),
(6, 'C6'),
(7, 'C3'),
(7, 'C7'),
(8, 'C2'),
(8, 'C7'),
(9, 'C4'),
(9, 'C8'),
(10, 'C5'),
(10, 'C8');

-- Insert into LearningPathProgress table
INSERT INTO LearningPathProgress (learning_path_id, mentee_id, progress) VALUES
(1, 11, 0.1),
(2, 12, 0.2),
(3, 13, 0.3),
(4, 14, 0.4),
(5, 15, 0.5),
(6, 16, 0.6),
(7, 7, 0.7),
(8, 8, 0.8),
(9, 9, 0.9),
(10, 10, 1.0);


-- Insert into MenteeCourse table
INSERT INTO MenteeCourse (mentee_id, course_id, progress, enroll_at, cert_id, issued_on, expiry_at) VALUES
(11, 'C1', 50, '2023-01-15 09:00:00', 1, '2023-02-28', '2024-02-28'),
(11, 'C2', 70, '2023-02-10 11:30:00', 2, '2023-03-15', '2024-03-15'),
(12, 'C3', 30, '2023-01-20 14:00:00', NULL, NULL, NULL),
(12, 'C4', 80, '2023-02-18 10:00:00', 3, '2023-03-30', '2024-03-30'),
(13, 'C5', 60, '2023-01-25 08:30:00', 4, '2023-03-01', '2024-03-01'),
(13, 'C6', 90, '2023-02-22 13:45:00', 5, '2023-04-10', '2024-04-10'),
(14, 'C7', 40, '2023-01-30 11:00:00', NULL, NULL, NULL),
(14, 'C8', 85, '2023-02-25 09:15:00', 6, '2023-04-15', '2024-04-15'),
(15, 'C1', 75, '2023-02-05 14:30:00', 7, '2023-03-15', '2024-03-15'),
(15, 'C2', 95, '2023-03-01 16:00:00', 8, '2023-04-20', '2024-04-20');
