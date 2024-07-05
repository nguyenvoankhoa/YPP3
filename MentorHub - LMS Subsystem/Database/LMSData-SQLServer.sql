
use LMS
go
INSERT INTO role (name) VALUES ('mentee'), ('mentor'), ('admin');

INSERT INTO [User] (name, asset_id, role_id, is_active, last_login) VALUES
-- 1 Admin
('John Doe', 1, 1, 1, '2024-06-24 10:30:00'),

-- 5 Mentors
('Jane Smith', 2, 2, 1, '2024-06-23 09:15:00'),
('Michael Johnson', 3, 2, 1, '2024-06-22 08:20:00'),
('Emily Brown', 4, 2, 0, '2024-06-21 07:25:00'),
('David Williams', 5, 2, 1, '2024-06-20 06:30:00'),
('Sarah Martinez', 6, 2, 0, '2024-06-19 05:35:00'),

-- 10 Mentees
('Alex Thompson', 7, 3, 1, '2024-06-18 04:40:00'),
('Jessica Garcia', 8, 3, 0, '2024-06-17 03:45:00'),
('Daniel Rodriguez', 9, 3, 1, '2024-06-16 02:50:00'),
('Olivia Hernandez', 10, 3, 0, '2024-06-15 01:55:00'),
('William Lopez', 11, 3, 1, '2024-06-14 12:00:00'),
('Sophia King', 12, 3, 0, '2024-06-13 11:05:00'),
('James Young', 13, 3, 1, '2024-06-12 10:10:00'),
('Ava Scott', 14, 3, 0, '2024-06-11 09:15:00'),
('Alexander Green', 15, 3, 1, '2024-06-10 08:20:00'),
('Ella Baker', 16, 3, 0, '2024-06-09 07:25:00');

INSERT INTO Category (name) VALUES
('Information Technology'),
('UI/UX Design'),
('Marketing'),
('Lifestyle'),
('Photography'),
('Video');

INSERT INTO tag(name) VALUES
('Python'),
('Data Science'),
('Selenium'),
('Web Development'),
('React'),
('React Router'),
('Redux'),
('NextJS'),
('React Native'),
('Jupyter Notebook'),
('Machine Learning'),
('Cloud Computing'),
('Cybersecurity'),
('Java'),
('Blockchain'),
('Cryptocurrency'),
('Artificial Intelligence'),
('Project Management'),
('UX Design'),
('Flutter'),
('DevOps');

INSERT INTO Course (name, category_id, price, description, created_at, mentor_id, pass_condition) VALUES
('Introduction to Python Programming', 1, 49.99, 'Learn Python programming basics and fundamentals.', CURRENT_TIMESTAMP, 2, 70),
('UI/UX Design Principles', 2, 79.99, 'Explore principles of user interface and user experience design.', CURRENT_TIMESTAMP, 3, 80),
('Digital Marketing Strategies', 3, 59.99, 'Discover effective digital marketing strategies and techniques.', CURRENT_TIMESTAMP, 4, 75),
('Healthy Lifestyle Habits', 4, 29.99, 'Learn practical tips and habits for a healthy lifestyle.', CURRENT_TIMESTAMP, 6, 60),
('Photography Masterclass', 4, 89.99, 'Master the art of photography with professional techniques.', CURRENT_TIMESTAMP, 5, 85),
('Video Production Essentials', 5, 69.99, 'Essential skills and tools for producing high-quality videos.', CURRENT_TIMESTAMP, 2, 80),
('Advanced Data Structures in C++', 6, 99.99, 'Advanced data structures and algorithms in C++ programming language.', CURRENT_TIMESTAMP, 3, 85),
('Introduction to Web Development', 2, 49.99, 'Start your journey into web development with HTML, CSS, and JavaScript.', CURRENT_TIMESTAMP, 5, 70),
('Effective Communication Skills', 3, 39.99, 'Develop effective communication skills for personal and professional success.', CURRENT_TIMESTAMP, 6, 65),
('Financial Planning and Budgeting', 1, 79.99, 'Learn how to plan your finances and create effective budgets.', CURRENT_TIMESTAMP, 5, 75),
('Data Science with R', 1, 59.99, 'An introductory course on data science using R programming language.', CURRENT_TIMESTAMP, 2, 75),
('Graphic Design Basics', 2, 49.99, 'Learn the basics of graphic design and essential tools.', CURRENT_TIMESTAMP, 3, 70),
('Social Media Marketing', 3, 39.99, 'Effective strategies for marketing on social media platforms.', CURRENT_TIMESTAMP, 4, 65),
('Personal Development and Wellness', 4, 29.99, 'Techniques for improving personal development and wellness.', CURRENT_TIMESTAMP, 5, 60),
('Advanced Photography Techniques', 5, 89.99, 'Advanced techniques for professional photography.', CURRENT_TIMESTAMP, 6, 85),
('Video Editing for Beginners', 6, 69.99, 'A beginner’s guide to video editing and essential tools.', CURRENT_TIMESTAMP, 2, 80),
('Machine Learning with Python', 1, 99.99, 'Advanced machine learning concepts and applications using Python.', CURRENT_TIMESTAMP, 3, 85),
('User Experience Research', 2, 79.99, 'Methods and tools for conducting user experience research.', CURRENT_TIMESTAMP, 4, 80),
('Content Marketing Strategies', 3, 59.99, 'Effective strategies for content marketing.', CURRENT_TIMESTAMP, 5, 75),
('Mindfulness and Meditation', 4, 29.99, 'Learn techniques for mindfulness and meditation.', CURRENT_TIMESTAMP, 6, 60),
('Portrait Photography', 5, 89.99, 'Master the art of portrait photography.', CURRENT_TIMESTAMP, 2, 85),
('Advanced Videography', 6, 99.99, 'Advanced techniques and tools for professional videography.', CURRENT_TIMESTAMP, 3, 90),
('Data Analysis with Excel', 1, 49.99, 'Learn how to analyze data effectively using Excel.', CURRENT_TIMESTAMP, 4, 70),
('Design Thinking', 2, 79.99, 'An introduction to design thinking principles and practices.', CURRENT_TIMESTAMP, 5, 80),
('SEO Best Practices', 3, 59.99, 'Learn the best practices for search engine optimization.', CURRENT_TIMESTAMP, 6, 75),
('Healthy Eating Habits', 4, 29.99, 'Develop healthy eating habits for a better lifestyle.', CURRENT_TIMESTAMP, 2, 65),
('Landscape Photography', 5, 89.99, 'Techniques for capturing stunning landscape photos.', CURRENT_TIMESTAMP, 3, 85),
('Film Production Basics', 6, 69.99, 'Learn the basics of film production and essential tools.', CURRENT_TIMESTAMP, 4, 80),
('Introduction to SQL', 1, 49.99, 'Learn SQL for database management and data analysis.', CURRENT_TIMESTAMP, 5, 70),
('Web Accessibility', 2, 79.99, 'Best practices for creating accessible web designs.', CURRENT_TIMESTAMP, 6, 80);

INSERT INTO sourcetag (source_id, source_type_id, tag_id) VALUES
(1, 3, 4),
(2, 3, 2),
(2, 3, 11),
(3, 3, 4),
(3, 3, 5),
(3, 3, 6),
(3, 3, 7),
(3, 3, 8),
(3, 3, 9),
(4, 3, 18),
(5, 3, 4),
(6, 3, 2),
(6, 3, 11),
(7, 3, 12),
(8, 3, 13),
(9, 3, 14),
(10, 3, 15),
(10, 3, 16),
(11, 3, 17),
(12, 3, 18),
(13, 3, 19),
(14, 3, 20),
(15, 3, 21),
(1, 2, 4),
(1, 2, 5),
(2, 2, 4),
(2, 2, 6),
(3, 2, 4),
(3, 2, 5),
(3, 2, 6),
(3, 2, 7),
(3, 2, 8),
(3, 2, 9),
(4, 2, 4),
(4, 2, 5),
(4, 2, 6),
(5, 2, 4),
(5, 2, 5),
(5, 2, 6),
(6, 2, 4),
(6, 2, 5),
(6, 2, 7), 
(7, 2, 11),
(8, 2, 19),
(8, 2, 20),
(9, 2, 3),
(10, 2, 4),
(11, 2, 5),
(12, 2, 6),
(13, 2, 4),
(13, 2, 5),
(14, 2, 19),
(15, 2, 6);


INSERT INTO section (course_id, name) VALUES
-- Course 1: Introduction to Python Programming
(1, 'Introduction'),
(1, 'Basic Concepts'),
(1, 'Advanced Techniques'),

-- Course 2: UI/UX Design Principles
(2, 'Introduction to UI/UX'),
(2, 'Design Basics'),
(2, 'Advanced UI/UX Techniques'),

-- Course 3: Digital Marketing Strategies
(3, 'Introduction to Digital Marketing'),
(3, 'Marketing Fundamentals'),
(3, 'Advanced Marketing Strategies'),

-- Course 4: Healthy Lifestyle Habits
(4, 'Introduction to Healthy Lifestyle'),
(4, 'Healthy Eating'),
(4, 'Exercise and Fitness'),

-- Course 5: Photography Masterclass
(5, 'Introduction to Photography'),
(5, 'Photography Techniques'),
(5, 'Advanced Photography'),

-- Course 6: Video Production Essentials
(6, 'Introduction to Video Production'),
(6, 'Video Editing Basics'),
(6, 'Advanced Video Production'),

-- Course 7: Advanced Data Structures in C++
(7, 'Introduction to Data Structures'),
(7, 'Intermediate Data Structures'),
(7, 'Advanced Data Structures'),

-- Course 8: Introduction to Web Development
(8, 'Introduction to Web Development'),
(8, 'HTML and CSS Basics'),
(8, 'JavaScript Fundamentals'),

-- Course 9: Effective Communication Skills
(9, 'Introduction to Communication Skills'),
(9, 'Verbal Communication'),
(9, 'Non-verbal Communication'),

-- Course 10: Financial Planning and Budgeting
(10, 'Introduction to Financial Planning'),
(10, 'Budgeting Basics'),
(10, 'Advanced Financial Strategies'),

-- Course 11: Data Science with R
(11, 'Introduction to Data Science'),
(11, 'R Programming Basics'),
(11, 'Advanced Data Science Techniques'),

-- Course 12: Graphic Design Basics
(12, 'Introduction to Graphic Design'),
(12, 'Design Tools'),
(12, 'Advanced Graphic Design'),

-- Course 13: Social Media Marketing
(13, 'Introduction to Social Media Marketing'),
(13, 'Marketing Strategies'),
(13, 'Advanced Social Media Techniques'),

-- Course 14: Personal Development and Wellness
(14, 'Introduction to Personal Development'),
(14, 'Wellness Techniques'),
(14, 'Advanced Personal Development'),

-- Course 15: Advanced Photography Techniques
(15, 'Introduction to Advanced Photography'),
(15, 'Photography Tools'),
(15, 'Professional Photography Techniques'),

-- Course 16: Video Editing for Beginners
(16, 'Introduction to Video Editing'),
(16, 'Editing Tools'),
(16, 'Advanced Editing Techniques'),

-- Course 17: Machine Learning with Python
(17, 'Introduction to Machine Learning'),
(17, 'Python for Machine Learning'),
(17, 'Advanced Machine Learning'),

-- Course 18: User Experience Research
(18, 'Introduction to User Experience'),
(18, 'Research Methods'),
(18, 'Advanced UX Techniques'),

-- Course 19: Content Marketing Strategies
(19, 'Introduction to Content Marketing'),
(19, 'Content Creation'),
(19, 'Advanced Marketing Strategies'),

-- Course 20: Mindfulness and Meditation
(20, 'Introduction to Mindfulness'),
(20, 'Meditation Techniques'),
(20, 'Advanced Mindfulness'),

-- Course 21: Portrait Photography
(21, 'Introduction to Portrait Photography'),
(21, 'Photography Techniques'),
(21, 'Advanced Portrait Photography'),

-- Course 22: Advanced Videography
(22, 'Introduction to Videography'),
(22, 'Videography Tools'),
(22, 'Professional Videography Techniques'),

-- Course 23: Data Analysis with Excel
(23, 'Introduction to Data Analysis'),
(23, 'Excel Tools'),
(23, 'Advanced Data Analysis'),

-- Course 24: Design Thinking
(24, 'Introduction to Design Thinking'),
(24, 'Design Thinking Methods'),
(24, 'Advanced Design Thinking'),

-- Course 25: SEO Best Practices
(25, 'Introduction to SEO'),
(25, 'SEO Tools'),
(25, 'Advanced SEO Techniques'),

-- Course 26: Healthy Eating Habits
(26, 'Introduction to Healthy Eating'),
(26, 'Nutrition Basics'),
(26, 'Advanced Healthy Eating'),

-- Course 27: Landscape Photography
(27, 'Introduction to Landscape Photography'),
(27, 'Photography Techniques'),
(27, 'Advanced Landscape Photography'),

-- Course 28: Film Production Basics
(28, 'Introduction to Film Production'),
(28, 'Film Production Tools'),
(28, 'Advanced Film Production'),

-- Course 29: Introduction to SQL
(29, 'Introduction to SQL'),
(29, 'SQL Basics'),
(29, 'Advanced SQL Techniques'),

-- Course 30: Web Accessibility
(30, 'Introduction to Web Accessibility'),
(30, 'Accessibility Tools'),
(30, 'Advanced Accessibility Techniques');

INSERT INTO Lesson (section_id, title, transcript, summary, asset_id) VALUES
-- Lessons for Section 1 (Introduction)
(1, 'Welcome to the Course', 'In this lesson, you will be introduced to the course and its objectives.', 'Introduction to the course and its objectives.', 1),
(1, 'Course Overview', 'This lesson provides an overview of what will be covered throughout the course.', 'Overview of the course content and structure.', 2),

-- Lessons for Section 2 (Basic Concepts)
(2, 'Understanding Variables', 'Learn about variables, their types, and how to declare them in programming.', 'Introduction to variables in programming.', 3),
(2, 'Control Structures', 'Explore control structures such as if-statements, loops, and switch statements.', 'Introduction to control structures in programming.', 4),

-- Lessons for Section 3 (Advanced Techniques)
(3, 'Database Design Principles', 'Learn about database design principles, normalization, and entity-relationship modeling.', 'Advanced concepts in database design.', 5),
(3, 'Web Security Best Practices', 'Explore best practices for securing web applications and preventing common vulnerabilities.', 'Advanced techniques for web security.', 6),

-- Lessons for Section 4 (Introduction to UI/UX)
(4, 'What is UI/UX?', 'Introduction to the concepts of UI/UX design.', 'Understanding UI/UX design basics.', 7),
(4, 'History of UI/UX', 'An overview of the history and evolution of UI/UX design.', 'History and evolution of UI/UX design.', 8),

-- Lessons for Section 5 (Design Basics)
(5, 'Design Elements', 'Learn about the basic elements of design.', 'Introduction to design elements.', 9),
(5, 'Color Theory', 'Understanding color theory and its application in design.', 'Basics of color theory in design.', 10),

-- Lessons for Section 6 (Advanced UI/UX Techniques)
(6, 'Prototyping', 'Learn about the process of creating prototypes.', 'Advanced techniques in prototyping.', 11),
(6, 'User Testing', 'Methods and importance of user testing in UI/UX design.', 'Advanced techniques in user testing.', 12),

-- Lessons for Section 7 (Introduction to Digital Marketing)
(7, 'Digital Marketing Fundamentals', 'Introduction to the basics of digital marketing.', 'Understanding digital marketing basics.', 13),
(7, 'Marketing Channels', 'Overview of different digital marketing channels.', 'Introduction to digital marketing channels.', 14),

-- Lessons for Section 8 (Marketing Fundamentals)
(8, 'Content Marketing', 'Strategies for effective content marketing.', 'Introduction to content marketing strategies.', 15),
(8, 'SEO Basics', 'Understanding the basics of search engine optimization.', 'Basics of SEO in digital marketing.', 16),

-- Lessons for Section 9 (Advanced Marketing Strategies)
(9, 'Advanced SEO Techniques', 'Learn advanced techniques for search engine optimization.', 'Advanced SEO strategies.', 17),
(9, 'Social Media Advertising', 'Strategies for effective social media advertising.', 'Advanced techniques in social media advertising.', 18),

-- Lessons for Section 10 (Introduction to Healthy Lifestyle)
(10, 'Healthy Lifestyle Overview', 'Introduction to the principles of a healthy lifestyle.', 'Understanding healthy lifestyle basics.', 19),
(10, 'Benefits of a Healthy Lifestyle', 'Explore the benefits of maintaining a healthy lifestyle.', 'Benefits of a healthy lifestyle.', 20),

-- Lessons for Section 11 (Healthy Eating)
(11, 'Nutrition Basics', 'Understanding the basics of nutrition and healthy eating.', 'Basics of nutrition in healthy living.', 21),
(11, 'Meal Planning', 'Tips for planning balanced and nutritious meals.', 'Introduction to meal planning.', 22),

-- Lessons for Section 12 (Exercise and Fitness)
(12, 'Exercise Fundamentals', 'Basics of exercise and fitness.', 'Understanding exercise basics.', 23),
(12, 'Creating a Fitness Plan', 'Learn how to create an effective fitness plan.', 'Introduction to fitness planning.', 24),

-- Lessons for Section 13 (Introduction to Photography)
(13, 'Photography Basics', 'Introduction to the basics of photography.', 'Understanding photography basics.', 25),
(13, 'Camera Types', 'Overview of different types of cameras and their uses.', 'Basics of camera types in photography.', 26),

-- Lessons for Section 14 (Photography Techniques)
(14, 'Lighting Techniques', 'Learn about various lighting techniques in photography.', 'Introduction to lighting techniques.', 27),
(14, 'Composition and Framing', 'Understanding composition and framing in photography.', 'Basics of composition and framing.', 28),

-- Lessons for Section 15 (Advanced Photography)
(15, 'Advanced Lighting', 'Advanced techniques in lighting for photography.', 'Advanced lighting techniques.', 29),
(15, 'Post-Processing', 'Techniques for post-processing and editing photos.', 'Advanced post-processing techniques.', 30),

-- Lessons for Section 16 (Introduction to Video Production)
(16, 'Video Production Basics', 'Introduction to the basics of video production.', 'Understanding video production basics.', 31),
(16, 'Types of Video Equipment', 'Overview of different types of video equipment and their uses.', 'Basics of video equipment.', 32),

-- Lessons for Section 17 (Video Editing Basics)
(17, 'Editing Software', 'Learn about various video editing software options.', 'Introduction to video editing software.', 33),
(17, 'Basic Editing Techniques', 'Understanding basic video editing techniques.', 'Basics of video editing.', 34),

-- Lessons for Section 18 (Advanced Video Production)
(18, 'Advanced Shooting Techniques', 'Advanced techniques for shooting professional videos.', 'Advanced shooting techniques.', 35),
(18, 'Advanced Editing', 'Techniques for advanced video editing.', 'Advanced video editing techniques.', 36),

-- Lessons for Section 19 (Introduction to Data Structures)
(19, 'Data Structure Fundamentals', 'Introduction to the basics of data structures.', 'Understanding data structure basics.', 37),
(19, 'Types of Data Structures', 'Overview of different types of data structures.', 'Basics of data structure types.', 38),

-- Lessons for Section 20 (Intermediate Data Structures)
(20, 'Linked Lists', 'Learn about linked lists and their applications.', 'Introduction to linked lists.', 39),
(20, 'Stacks and Queues', 'Understanding stacks and queues in data structures.', 'Basics of stacks and queues.', 40),

-- Lessons for Section 21 (Advanced Data Structures)
(21, 'Trees and Graphs', 'Advanced concepts in trees and graphs.', 'Advanced techniques in trees and graphs.', 41),
(21, 'Hashing', 'Understanding the concept of hashing in data structures.', 'Advanced hashing techniques.', 42),

-- Lessons for Section 22 (Introduction to Web Development)
(22, 'Web Development Overview', 'Introduction to the basics of web development.', 'Understanding web development basics.', 43),
(22, 'HTML Basics', 'Learn about the basics of HTML for web development.', 'Basics of HTML in web development.', 44),

-- Lessons for Section 23 (HTML and CSS Basics)
(23, 'CSS Fundamentals', 'Introduction to the basics of CSS for web development.', 'Understanding CSS basics.', 45),
(23, 'Styling with CSS', 'Learn how to style web pages using CSS.', 'Basics of styling with CSS.', 46),

-- Lessons for Section 24 (JavaScript Fundamentals)
(24, 'JavaScript Basics', 'Introduction to the basics of JavaScript.', 'Understanding JavaScript basics.', 47),
(24, 'DOM Manipulation', 'Learn how to manipulate the DOM using JavaScript.', 'Basics of DOM manipulation.', 48),

-- Lessons for Section 25 (Introduction to Communication Skills)
(25, 'Communication Skills Overview', 'Introduction to the basics of effective communication.', 'Understanding communication skills basics.', 49),
(25, 'Types of Communication', 'Overview of different types of communication.', 'Basics of communication types.', 50),

-- Lessons for Section 26 (Verbal Communication)
(26, 'Public Speaking', 'Learn the basics of public speaking and presentation skills.', 'Introduction to public speaking.', 51),
(26, 'Interpersonal Communication', 'Understanding the basics of interpersonal communication.', 'Basics of interpersonal communication.', 52),

-- Lessons for Section 27 (Non-verbal Communication)
(27, 'Body Language', 'Learn about the importance of body language in communication.', 'Introduction to body language.', 53),
(27, 'Facial Expressions', 'Understanding the role of facial expressions in communication.', 'Basics of facial expressions.', 54),

-- Lessons for Section 28 (Introduction to Financial Planning)
(28, 'Financial Planning Basics', 'Introduction to the basics of financial planning.', 'Understanding financial planning basics.', 55),
(28, 'Budgeting', 'Learn how to create and manage a budget effectively.', 'Basics of budgeting.', 56),

-- Lessons for Section 29 (Budgeting Basics)
(29, 'Saving Strategies', 'Learn effective strategies for saving money.', 'Introduction to saving strategies.', 57),
(29, 'Debt Management', 'Understanding how to manage and reduce debt.', 'Basics of debt management.', 58),

-- Lessons for Section 30 (Advanced Financial Strategies)
(30, 'Investing', 'Advanced techniques for investing and growing wealth.', 'Advanced investing techniques.', 59),
(30, 'Retirement Planning', 'Understanding how to plan for a secure retirement.', 'Advanced retirement planning techniques.', 60),

-- Additional lessons for new sections
-- Course 11: Data Science with R
(11, 'Introduction to Data Science', 'Basics of data science using R.', 'Understanding data science basics.', 61),
(11, 'R Programming', 'Basics of R programming language.', 'Introduction to R programming.', 62),

-- Course 12: Graphic Design Basics
(12, 'Design Basics', 'Introduction to graphic design.', 'Understanding graphic design basics.', 63),
(12, 'Design Tools', 'Overview of essential design tools.', 'Basics of design tools.', 64),

-- Course 13: Social Media Marketing
(13, 'Marketing Basics', 'Introduction to social media marketing.', 'Understanding marketing basics.', 65),
(13, 'Marketing Tools', 'Overview of social media marketing tools.', 'Basics of marketing tools.', 66),

-- Course 14: Personal Development and Wellness
(14, 'Personal Development', 'Introduction to personal development.', 'Understanding personal development basics.', 67),
(14, 'Wellness Techniques', 'Overview of wellness techniques.', 'Basics of wellness techniques.', 68),

-- Course 15: Advanced Photography Techniques
(15, 'Photography Techniques', 'Advanced techniques in photography.', 'Understanding advanced photography techniques.', 69),
(15, 'Editing Techniques', 'Advanced techniques in photo editing.', 'Basics of editing techniques.', 70),

-- Course 16: Video Editing for Beginners
(16, 'Editing Basics', 'Introduction to video editing.', 'Understanding editing basics.', 71),
(16, 'Editing Tools', 'Overview of video editing tools.', 'Basics of editing tools.', 72),

-- Course 17: Machine Learning with Python
(17, 'Machine Learning Basics', 'Introduction to machine learning.', 'Understanding machine learning basics.', 73),
(17, 'Python for Machine Learning', 'Basics of using Python for machine learning.', 'Basics of Python in machine learning.', 74),

-- Course 18: User Experience Research
(18, 'UX Research', 'Introduction to user experience research.', 'Understanding UX research basics.', 75),
(18, 'Research Methods', 'Overview of research methods in UX.', 'Basics of research methods.', 76),

-- Course 19: Content Marketing Strategies
(19, 'Content Marketing', 'Introduction to content marketing.', 'Understanding content marketing basics.', 77),
(19, 'Marketing Strategies', 'Overview of content marketing strategies.', 'Basics of marketing strategies.', 78),

-- Course 20: Mindfulness and Meditation
(20, 'Mindfulness Basics', 'Introduction to mindfulness.', 'Understanding mindfulness basics.', 79),
(20, 'Meditation Techniques', 'Overview of meditation techniques.', 'Basics of meditation techniques.', 80),

-- Course 21: Portrait Photography
(21, 'Portrait Techniques', 'Introduction to portrait photography.', 'Understanding portrait photography basics.', 81),
(21, 'Lighting for Portraits', 'Overview of lighting techniques for portraits.', 'Basics of lighting for portraits.', 82),

-- Course 22: Advanced Videography
(22, 'Videography Basics', 'Introduction to advanced videography.', 'Understanding advanced videography basics.', 83),
(22, 'Videography Techniques', 'Overview of advanced videography techniques.', 'Basics of videography techniques.', 84),

-- Course 23: Data Analysis with Excel
(23, 'Excel Basics', 'Introduction to data analysis with Excel.', 'Understanding Excel basics.', 85),
(23, 'Advanced Excel Techniques', 'Overview of advanced Excel techniques for data analysis.', 'Basics of advanced Excel techniques.', 86),

-- Course 24: Design Thinking
(24, 'Design Thinking Basics', 'Introduction to design thinking.', 'Understanding design thinking basics.', 87),
(24, 'Design Thinking Methods', 'Overview of design thinking methods.', 'Basics of design thinking methods.', 88),

-- Course 25: SEO Best Practices
(25, 'SEO Basics', 'Introduction to SEO.', 'Understanding SEO basics.', 89),
(25, 'Advanced SEO', 'Overview of advanced SEO techniques.', 'Basics of advanced SEO techniques.', 90),

-- Course 26: Healthy Eating Habits
(26, 'Healthy Eating Basics', 'Introduction to healthy eating habits.', 'Understanding healthy eating habits basics.', 91),
(26, 'Nutrition for Health', 'Overview of nutrition for health.', 'Basics of nutrition for health.', 92),

-- Course 27: Landscape Photography
(27, 'Landscape Techniques', 'Introduction to landscape photography.', 'Understanding landscape photography basics.', 93),
(27, 'Editing Landscapes', 'Overview of editing techniques for landscape photography.', 'Basics of editing landscapes.', 94),

-- Course 28: Film Production Basics
(28, 'Film Production Basics', 'Introduction to film production.', 'Understanding film production basics.', 95),
(28, 'Production Tools', 'Overview of film production tools.', 'Basics of production tools.', 96),

-- Course 29: Introduction to SQL
(29, 'SQL Basics', 'Introduction to SQL.', 'Understanding SQL basics.', 97),
(29, 'Advanced SQL', 'Overview of advanced SQL techniques.', 'Basics of advanced SQL techniques.', 98),

-- Course 30: Web Accessibility
(30, 'Accessibility Basics', 'Introduction to web accessibility.', 'Understanding web accessibility basics.', 99),
(30, 'Advanced Accessibility', 'Overview of advanced web accessibility techniques.', 'Basics of advanced web accessibility.', 100);

INSERT INTO Resource (asset_id, lesson_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 3),
(8, 1),
(9, 2),
(10, 3),
(11, 4),
(12, 4),
(13, 5),
(14, 5),
(15, 6),
(16, 6),
(17, 7),
(18, 7),
(19, 8),
(20, 8),
(21, 9),
(22, 9),
(23, 10),
(24, 10),
(25, 11),
(26, 11),
(27, 12),
(28, 12),
(29, 13),
(30, 13),
(31, 14),
(32, 14),
(33, 15),
(34, 15),
(35, 16),
(36, 16),
(37, 17),
(38, 17),
(39, 18),
(40, 18),
(41, 19),
(42, 19),
(43, 20),
(44, 20),
(45, 21),
(46, 21),
(47, 22),
(48, 22),
(49, 23),
(50, 23),
(51, 24),
(52, 24),
(53, 25),
(54, 25),
(55, 26),
(56, 26),
(57, 27),
(58, 27),
(59, 28),
(60, 28),
(61, 29),
(62, 29),
(63, 30),
(64, 30),
(65, 31),
(66, 31),
(67, 32),
(68, 32),
(69, 33),
(70, 33),
(71, 34),
(72, 34),
(73, 35),
(74, 35),
(75, 36),
(76, 36),
(77, 37),
(78, 37),
(79, 38),
(80, 38),
(81, 39),
(82, 39),
(83, 40),
(84, 40),
(85, 41),
(86, 41),
(87, 42),
(88, 42),
(89, 43),
(90, 43),
(91, 44),
(92, 44),
(93, 45),
(94, 45),
(95, 46),
(96, 46),
(97, 47),
(98, 47),
(99, 48),
(100, 48),
(101, 49),
(102, 49),
(103, 50),
(104, 50),
(105, 51),
(106, 51),
(107, 52),
(108, 52),
(109, 53),
(110, 53),
(111, 54),
(112, 54),
(113, 55),
(114, 55),
(115, 56),
(116, 56),
(117, 57),
(118, 57),
(119, 58),
(120, 58),
(121, 59),
(122, 59),
(123, 60),
(124, 60),
(125, 61),
(126, 61),
(127, 62),
(128, 62),
(129, 63),
(130, 63),
(131, 64),
(132, 64),
(133, 65),
(134, 65),
(135, 66),
(136, 66),
(137, 67),
(138, 67),
(139, 68),
(140, 68),
(141, 69),
(142, 69),
(143, 70),
(144, 70),
(145, 71),
(146, 71),
(147, 72),
(148, 72),
(149, 73),
(150, 73),
(151, 74),
(152, 74),
(153, 75),
(154, 75),
(155, 76),
(156, 76),
(157, 77),
(158, 77),
(159, 78),
(160, 78),
(161, 79),
(162, 79),
(163, 80),
(164, 80),
(165, 81),
(166, 81),
(167, 82),
(168, 82),
(169, 83),
(170, 83),
(171, 84),
(172, 84),
(173, 85),
(174, 85),
(175, 86),
(176, 86),
(177, 87),
(178, 87),
(179, 88),
(180, 88),
(181, 89),
(182, 89),
(183, 90),
(184, 90),
(185, 91),
(186, 91),
(187, 92),
(188, 92),
(189, 93),
(190, 93),
(191, 94),
(192, 94),
(193, 95),
(194, 95),
(195, 96),
(196, 96),
(197, 97),
(198, 97),
(199, 98),
(200, 98),
(201, 99),
(202, 99),
(203, 100),
(204, 100);

INSERT INTO discussion (user_id, lesson_id, parent_discussion_id, content, created_at) VALUES
(2, 1, NULL, 'I found the introduction to Python programming quite engaging. Looking forward to diving deeper into variables and control structures!', CURRENT_TIMESTAMP),
(3, 2, NULL, 'The UI/UX design principles course is really insightful. Anyone else excited about learning prototyping techniques?', CURRENT_TIMESTAMP),
(4, 3, NULL, 'Digital marketing strategies are evolving rapidly. Let''s discuss effective SEO tactics and social media engagement strategies.', CURRENT_TIMESTAMP),
(5, 4, NULL, 'Healthy lifestyle habits have made a big difference in my daily routine. What are your favorite tips for staying healthy?', CURRENT_TIMESTAMP),
(6, 5, NULL, 'Photography masterclass has helped me capture some amazing shots. What are your thoughts on advanced techniques like lighting and composition?', CURRENT_TIMESTAMP),
(7, 6, NULL, 'Video production essentials course is great for beginners. Who else is learning the basics of video editing and production?', CURRENT_TIMESTAMP),
(8, 4, NULL, 'I''m curious about advanced data structures in C++. Any tips on mastering complex algorithms?', CURRENT_TIMESTAMP),
(9, 2, NULL, 'UI/UX design is more than just aesthetics. How do you approach creating intuitive user interfaces?', CURRENT_TIMESTAMP),
(10, 3, NULL, 'Effective communication skills are crucial in every aspect of life. Share your experiences and tips for improving communication.', CURRENT_TIMESTAMP),
(11, 5, NULL, 'Advanced photography techniques are challenging but rewarding. What techniques have you found most useful?', CURRENT_TIMESTAMP),
(12, 6, NULL, 'Video editing for beginners has been a fun journey so far. What software do you recommend for beginners?', CURRENT_TIMESTAMP),
(13, 1, NULL, 'Python programming language is versatile. What projects are you working on to apply your Python skills?', CURRENT_TIMESTAMP),
(14, 3, NULL, 'Content marketing strategies are essential for digital success. Let''s discuss innovative content ideas and strategies.', CURRENT_TIMESTAMP),
(15, 4, NULL, 'Personal development and wellness tips have really helped me stay focused. How do you maintain a healthy work-life balance?', CURRENT_TIMESTAMP),
(16, 2, NULL, 'Learning about web accessibility has opened my eyes to creating inclusive designs. What are your thoughts on accessible web development?', CURRENT_TIMESTAMP);

INSERT INTO review (mentee_id, source_id, rating_star, content, review_at, source_type) VALUES
(7, 11, 4, 'Python course was informative, enjoyed learning!', CURRENT_TIMESTAMP, 1),
(8, 12, 3, 'UI/UX design principles were interesting but complex.', CURRENT_TIMESTAMP, 1),
(9, 13, 5, 'Digital marketing strategies were spot on, very practical.', CURRENT_TIMESTAMP, 1),
(10, 14, 4, 'Healthy lifestyle habits course was motivating and helpful.', CURRENT_TIMESTAMP, 1),
(11, 15, 5, 'Photography masterclass exceeded my expectations!', CURRENT_TIMESTAMP, 1),
(12, 16, 4, 'Video production essentials course was well-structured.', CURRENT_TIMESTAMP, 1),
(13, 17, 3, 'Data structures in C++ were challenging but rewarding.', CURRENT_TIMESTAMP, 1),
(14, 18, 5, 'Introduction to web development was a great starting point.', CURRENT_TIMESTAMP, 1),
(15, 19, 4, 'Effective communication skills course improved my interactions.', CURRENT_TIMESTAMP, 1),
(16, 20, 5, 'Financial planning and budgeting course was practical and useful.', CURRENT_TIMESTAMP, 1),
(11, 1, 5, 'Excellent course, very informative and well-structured.', CURRENT_TIMESTAMP, 1),
(12, 2, 4, 'Great insights on UI/UX design principles.', CURRENT_TIMESTAMP, 1),
(13, 3, 3, 'Good content but could be more detailed.', CURRENT_TIMESTAMP, 1),
(14, 4, 5, 'Practical tips for a healthy lifestyle, highly recommended!', CURRENT_TIMESTAMP, 1),
(15, 5, 4, 'Learned a lot about photography techniques.', CURRENT_TIMESTAMP, 1),
(7, 6, 5, 'Fantastic video production course!', CURRENT_TIMESTAMP, 1),
(8, 7, 4, 'Advanced concepts explained clearly.', CURRENT_TIMESTAMP, 1),
(9, 8, 3, 'Good introduction to web development.', CURRENT_TIMESTAMP, 1),
(10, 9, 5, 'Effective communication skills explained well.', CURRENT_TIMESTAMP, 1),
(15, 10, 4, 'Useful financial planning and budgeting tips.', CURRENT_TIMESTAMP, 1),
(7, 21, 4, 'Learning SQL was essential for my career development.', CURRENT_TIMESTAMP, 1),
(8, 22, 5, 'Web accessibility course taught me a lot about inclusivity.', CURRENT_TIMESTAMP, 1),
(9, 23, 3, 'Design thinking course was interesting but lacked practical examples.', CURRENT_TIMESTAMP, 1),
(10, 24, 4, 'SEO best practices course was informative and well-structured.', CURRENT_TIMESTAMP, 1),
(11, 25, 5, 'Healthy eating habits course changed my lifestyle positively.', CURRENT_TIMESTAMP, 1),
(12, 26, 4, 'Landscape photography course improved my photography skills.', CURRENT_TIMESTAMP, 1),
(13, 27, 3, 'Film production basics course covered essential concepts well.', CURRENT_TIMESTAMP, 1),
(14, 28, 5, 'Introduction to SQL course provided a solid foundation in databases.', CURRENT_TIMESTAMP, 1),
(15, 29, 4, 'User experience research course enhanced my design research skills.', CURRENT_TIMESTAMP, 1),
(16, 30, 5, 'Content marketing strategies course helped me refine my marketing skills.', CURRENT_TIMESTAMP, 1),
(7, 11, 4, 'Python course was informative, enjoyed learning!', CURRENT_TIMESTAMP, 1),
(8, 12, 3, 'UI/UX design principles were interesting but complex.', CURRENT_TIMESTAMP, 1),
(9, 13, 5, 'Digital marketing strategies were spot on, very practical.', CURRENT_TIMESTAMP, 1),
(10, 14, 4, 'Healthy lifestyle habits course was motivating and helpful.', CURRENT_TIMESTAMP, 1),
(11, 15, 5, 'Photography masterclass exceeded my expectations!', CURRENT_TIMESTAMP, 1),
(12, 16, 4, 'Video production essentials course was well-structured.', CURRENT_TIMESTAMP, 1),
(13, 17, 3, 'Data structures in C++ were challenging but rewarding.', CURRENT_TIMESTAMP, 1),
(14, 18, 5, 'Introduction to web development was a great starting point.', CURRENT_TIMESTAMP, 1),
(15, 19, 4, 'Effective communication skills course improved my interactions.', CURRENT_TIMESTAMP, 1),
(16, 20, 5, 'Financial planning and budgeting course was practical and useful.', CURRENT_TIMESTAMP, 1),
(11, 1, 5, 'Excellent course, very informative and well-structured.', CURRENT_TIMESTAMP, 1),
(12, 2, 4, 'Great insights on UI/UX design principles.', CURRENT_TIMESTAMP, 1),
(13, 3, 3, 'Good content but could be more detailed.', CURRENT_TIMESTAMP, 1),
(14, 4, 5, 'Practical tips for a healthy lifestyle, highly recommended!', CURRENT_TIMESTAMP, 1),
(15, 5, 4, 'Learned a lot about photography techniques.', CURRENT_TIMESTAMP, 1),
(7, 6, 5, 'Fantastic video production course!', CURRENT_TIMESTAMP, 1),
(8, 7, 4, 'Advanced concepts explained clearly.', CURRENT_TIMESTAMP, 1),
(9, 8, 3, 'Good introduction to web development.', CURRENT_TIMESTAMP, 1),
(10, 9, 5, 'Effective communication skills explained well.', CURRENT_TIMESTAMP, 1),
(15, 10, 4, 'Useful financial planning and budgeting tips.', CURRENT_TIMESTAMP, 1),
(7, 21, 4, 'Learning SQL was essential for my career development.', CURRENT_TIMESTAMP, 1),
(8, 22, 5, 'Web accessibility course taught me a lot about inclusivity.', CURRENT_TIMESTAMP, 1),
(9, 23, 3, 'Design thinking course was interesting but lacked practical examples.', CURRENT_TIMESTAMP, 1),
(10, 24, 4, 'SEO best practices course was informative and well-structured.', CURRENT_TIMESTAMP, 1),
(11, 25, 5, 'Healthy eating habits course changed my lifestyle positively.', CURRENT_TIMESTAMP, 1),
(12, 26, 4, 'Landscape photography course improved my photography skills.', CURRENT_TIMESTAMP, 1),
(13, 27, 3, 'Film production basics course covered essential concepts well.', CURRENT_TIMESTAMP, 1),
(14, 28, 5, 'Introduction to SQL course provided a solid foundation in databases.', CURRENT_TIMESTAMP, 1),
(15, 29, 4, 'User experience research course enhanced my design research skills.', CURRENT_TIMESTAMP, 1),
(16, 30, 5, 'Content marketing strategies course helped me refine my marketing skills.', CURRENT_TIMESTAMP, 1),
(7, 31, 4, 'Flutter course was insightful and practical.', CURRENT_TIMESTAMP, 1),
(8, 32, 3, 'DevOps principles were interesting but complex.', CURRENT_TIMESTAMP, 1),
(9, 33, 5, 'Blockchain technology was explained well.', CURRENT_TIMESTAMP, 1),
(10, 34, 4, 'Machine learning concepts were challenging and informative.', CURRENT_TIMESTAMP, 1),
(11, 35, 5, 'Cloud computing course provided valuable insights.', CURRENT_TIMESTAMP, 1),
(12, 36, 4, 'Cybersecurity practices were practical and useful.', CURRENT_TIMESTAMP, 1),
(13, 37, 3, 'Artificial intelligence course covered advanced topics.', CURRENT_TIMESTAMP, 1),
(14, 38, 5, 'Project management course was well-structured.', CURRENT_TIMESTAMP, 1),
(15, 39, 4, 'UX design course enhanced my design skills.', CURRENT_TIMESTAMP, 1),
(16, 40, 5, 'React course was excellent, learned a lot about frontend development.', CURRENT_TIMESTAMP, 1);

INSERT INTO menteeSaveCourse (course_id, mentee_id) VALUES
(1, 7),
(2, 8),
(3, 13),
(4, 14),
(5, 15),
(6, 16),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO sourceimage (source_id, asset_id, source_type_id) VALUES
(1, 101, 1),
(2, 102, 1),
(3, 103, 1),
(4, 104, 1),
(5, 105, 1),
(6, 106, 1),
(7, 107, 1),
(8, 108, 1),
(9, 109, 1),
(10, 110, 1),
(11, 111, 1),
(12, 112, 1),
(13, 113, 1),
(14, 114, 1),
(15, 115, 1),
(16, 116, 1),
(17, 117, 1),
(18, 118, 1),
(19, 119, 1),
(20, 120, 1),
(21, 121, 1),
(22, 122, 1),
(23, 123, 1),
(24, 124, 1),
(25, 125, 1),
(26, 126, 1),
(27, 127, 1),
(28, 128, 1),
(29, 129, 1),
(30, 130, 1);

INSERT INTO paymentmethod (method) VALUES
('Credit Card'),
('Debit Card'),
('PayPal'),
('Bank Transfer'),
('Cryptocurrency');

INSERT INTO voucher (code, source_id, source_type_id, discount, quantity, expire_date) VALUES
('DISCOUNT10', 1, 3, 10.0, 100, '2024-12-31 23:59:59'),
('SAVE20', 2, 3, 20.0, 50, '2024-11-30 23:59:59'),
('OFFER30', 3, 3, 30.0, 25, '2024-10-31 23:59:59'),
('PROMO15', 4, 3, 15.0, 200, '2024-09-30 23:59:59'),
('DEAL25', 5, 2, 25.0, 75, '2024-08-31 23:59:59');

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

INSERT INTO [order] (user_id, user_payment_id, status, created_at) VALUES
(11, 1, 1, CURRENT_TIMESTAMP),
(12, 2, 2,CURRENT_TIMESTAMP),
(13, 3, 1, CURRENT_TIMESTAMP),
(14, 4, 2, CURRENT_TIMESTAMP),
(15, 5, 1, CURRENT_TIMESTAMP),
(16, 6, 2,CURRENT_TIMESTAMP),
(7, 7, 1,CURRENT_TIMESTAMP),
(8, 8, 2, CURRENT_TIMESTAMP),
(9, 9, 1, CURRENT_TIMESTAMP),
(10, 10, 2, CURRENT_TIMESTAMP);

INSERT INTO OrderDetail (order_id, price, source_id, source_type) VALUES
(1, 49.99, 1, 1),
(1, 29.99, 2, 1),
(1, 19.99, 3, 1),
(2, 79.99, 4, 1),
(2, 59.99, 5, 1),
(3, 29.99, 6, 1),
(4, 89.99, 7, 1),
(4, 99.99, 8, 1),
(5, 69.99, 9, 1),
(5, 39.99, 10, 1),
(6, 49.99, 11, 1),
(6, 79.99, 12, 1),
(7, 59.99, 13, 1),
(7, 29.99, 14, 1),
(8, 89.99, 15, 1),
(8, 69.99, 16, 1),
(9, 99.99, 17, 1),
(9, 49.99, 18, 1),
(10, 79.99, 19, 1),
(10, 39.99, 20, 1),
(1, 29.99, 21, 1),
(1, 89.99, 22, 1),
(2, 49.99, 23, 1),
(2, 69.99, 24, 1),
(3, 99.99, 25, 1),
(3, 59.99, 26, 1),
(4, 39.99, 27, 1),
(4, 29.99, 28, 1),
(5, 89.99, 29, 1),
(5, 79.99, 30, 1);

INSERT INTO quiz (name, summary, attempts_allowed, passing_grade, duration, section_id) VALUES
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

INSERT INTO QuestionType (type) VALUES
('Multiple Choice'),
('True/False');

INSERT INTO Question (question_type_id, quiz_id, title, randomize, points, explanation) VALUES
(1, 1, 'What is Information Technology?', 1, 5.0, 'Basic definition of Information Technology.'),
(2, 1, 'List three examples of IT devices.', 0, 10.0, 'Examples include computers, smartphones, and servers.'),
(1, 2, 'What does UI stand for?', 1, 5.0, 'UI stands for User Interface.'),
(2, 2, 'Describe the main difference between UI and UX.', 0, 10.0, 'UI is about the look and feel, UX is about user experience.'),
(1, 3, 'Define marketing.', 1, 5.0, 'Marketing is the process of promoting products or services.'),
(2, 3, 'Explain the 4 Ps of marketing.', 0, 10.0, 'Product, Price, Place, Promotion.'),
(1, 4, 'Why is a healthy lifestyle important?', 1, 5.0, 'A healthy lifestyle helps maintain physical and mental health.'),
(2, 4, 'Give two benefits of regular exercise.', 0, 10.0, 'Benefits include improved fitness and mood.'),
(1, 5, 'What is aperture in photography?', 1, 5.0, 'Aperture controls the amount of light entering the camera.'),
(2, 5, 'Explain the rule of thirds in photography.', 0, 10.0, 'It is a composition technique for balancing images.'),
(1, 6, 'What is video editing?', 1, 5.0, 'Video editing involves rearranging video shots to create a new work.'),
(2, 6, 'List two popular video editing software.', 0, 10.0, 'Examples are Adobe Premiere Pro and Final Cut Pro.'),
(1, 7, 'Define cloud computing.', 1, 5.0, 'Cloud computing is delivering computing services over the internet.'),
(2, 7, 'Give one advantage and one disadvantage of cloud computing.', 0, 10.0, 'Advantage: scalability, Disadvantage: security risks.'),
(1, 8, 'What is a wireframe in UI design?', 1, 5.0, 'A wireframe is a basic visual guide to suggest the structure of an interface.'),
(2, 8, 'Explain the concept of user personas.', 0, 10.0, 'User personas are fictional characters created to represent different user types.'),
(1, 9, 'What is a marketing funnel?', 1, 5.0, 'A marketing funnel is a model describing the customer journey.'),
(2, 9, 'Describe the stages of a marketing funnel.', 0, 10.0, 'Stages include awareness, interest, decision, and action.'),
(1, 10, 'Why is proper nutrition important?', 1, 5.0, 'Proper nutrition is essential for maintaining good health.'),
(2, 10, 'Name two essential nutrients and their functions.', 0, 10.0, 'Proteins for growth and repair, carbohydrates for energy.');

INSERT INTO Answer (question_id, content, asset_id, is_correct) VALUES
(1, 'Information Technology is the use of computers to store, retrieve, transmit, and manipulate data.', NULL, 1),
(2, 'Computers, smartphones, servers', NULL, 1),
(2, 'Refrigerators, microwaves, toasters', NULL, 0),
(3, 'User Interface', NULL, 1),
(3, 'User Interaction', NULL, 0),
(4, 'UI is the look and feel, UX is the experience.', NULL, 1),
(4, 'UI is the experience, UX is the look and feel.', NULL, 0),
(5, 'Marketing is the process of promoting and selling products or services.', NULL, 1),
(5, 'Marketing is the process of producing goods.', NULL, 0),
(6, 'Product, Price, Place, Promotion', NULL, 1),
(6, 'Production, People, Planning, Promotion', NULL, 0),
(7, 'A healthy lifestyle helps maintain physical and mental health.', NULL, 1),
(7, 'A healthy lifestyle helps in earning more money.', NULL, 0),
(8, 'Improved fitness, enhanced mood', NULL, 1),
(8, 'Better financial status, increased sleep', NULL, 0),
(9, 'Aperture controls the amount of light entering the camera.', NULL, 1),
(9, 'Aperture adjusts the focus of the lens.', NULL, 0),
(10, 'Rule of thirds is a composition technique for balancing images.', NULL, 1),
(10, 'Rule of thirds is a lighting technique.', NULL, 0),
(11, 'Video editing involves rearranging video shots to create a new work.', NULL, 1),
(11, 'Video editing is about recording video.', NULL, 0),
(12, 'Adobe Premiere Pro, Final Cut Pro', NULL, 1),
(12, 'Microsoft Word, Excel', NULL, 0),
(13, 'Cloud computing is delivering computing services over the internet.', NULL, 1),
(13, 'Cloud computing is a type of physical storage device.', NULL, 0),
(14, 'Scalability, Security risks', NULL, 1),
(14, 'Cheap cost, No disadvantages', NULL, 0),
(15, 'A wireframe is a basic visual guide to suggest the structure of an interface.', NULL, 1),
(15, 'A wireframe is a final design of an interface.', NULL, 0),
(16, 'User personas are fictional characters created to represent different user types.', NULL, 1),
(16, 'User personas are real users interacting with the product.', NULL, 0),
(17, 'A marketing funnel is a model describing the customer journey.', NULL, 1),
(17, 'A marketing funnel is a tool for data analysis.', NULL, 0),
(18, 'Awareness, Interest, Decision, Action', NULL, 1),
(18, 'Awareness, Interest, Decision, Purchase', NULL, 0),
(19, 'Proper nutrition is essential for maintaining good health.', NULL, 1),
(19, 'Proper nutrition is only necessary for athletes.', NULL, 0),
(20, 'Proteins for growth and repair, Carbohydrates for energy', NULL, 1),
(20, 'Vitamins for energy, Carbohydrates for muscle building', NULL, 0);

INSERT INTO QuizResult (mentee_id, quiz_id, date, mark, result) VALUES
(11, 1, GETDATE(), 90.0, 1),
(12, 2, GETDATE(), 80.0, 1),
(13, 3, GETDATE(), 70.0, 1),
(14, 4, GETDATE(), 60.0, 0),
(15, 5, GETDATE(), 50.0, 0),
(16, 6, GETDATE(), 90.0, 1),
(7, 7, GETDATE(), 80.0, 1),
(8, 8, GETDATE(), 70.0, 1),
(9, 9, GETDATE(), 60.0, 0),
(10, 10, GETDATE(), 50.0, 0);

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

INSERT INTO LearningPath(title, description, mentor_id, created_at, updated_at) VALUES
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

INSERT INTO CourseLearningPath(learning_path_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3),
(3, 4),
(4, 4),
(4, 5),
(5, 5),
(5, 6),
(6, 1),
(6, 6),
(7, 3),
(7, 7),
(8, 2),
(8, 7),
(9, 4),
(9, 8),
(10, 5),
(10, 8);

INSERT INTO learningPathProgress (learning_path_id, mentee_id, progress) VALUES
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

INSERT INTO menteeCourse (mentee_id, course_id, progress, enroll_at, cert_id, issued_on, expiry_at) VALUES
(7, 1, 50, '2024-06-26 18:32:01', 1, '2023-02-28', '2024-02-28'),
(7, 2, 70, '2024-06-27 18:32:01', 2, '2023-03-15', '2024-03-15'),
(8, 3, 30, '2024-06-28 18:32:01', NULL, NULL, NULL),
(8, 4, 80, '2024-06-29 18:32:01', 3, '2023-03-30', '2024-03-30'),
(9, 5, 60, '2024-06-25 18:32:01', 4, '2023-03-01', '2024-03-01'),
(9, 6, 90, '2024-06-25 18:32:01', 5, '2023-04-10', '2024-04-10'),
(10, 7, 40, '2024-06-25 18:32:01', NULL, NULL, NULL),
(10, 8, 85, '2024-06-25 18:32:01', 6, '2023-04-15', '2024-04-15'),
(8, 1, 75, '2024-06-25 18:32:01', 7, '2023-03-15', '2024-03-15'),
(9, 2, 95, '2024-06-25 18:32:01', 8, '2023-04-20', '2024-04-20'),
(11, 3, 55, '2024-06-25 18:32:01', 9, '2023-05-01', '2024-05-01'),
(11, 4, 78, '2024-06-25 18:32:01', 10, '2023-05-10', '2024-05-10'),
(12, 5, 68, '2024-06-25 18:32:01', 11, '2023-06-01', '2024-06-01'),
(12, 6, 87, '2024-06-25 18:32:01', 12, '2023-06-15', '2024-06-15'),
(13, 7, 42, '2024-06-25 18:32:01', 13, '2023-07-01', '2024-07-01'),
(13, 8, 82, '2024-06-25 18:32:01', 14, '2023-07-10', '2024-07-10'),
(14, 1, 91, '2024-06-25 18:32:01', 15, '2023-08-01', '2024-08-01'),
(14, 2, 63, '2024-06-25 18:32:01', 16, '2023-08-15', '2024-08-15'),
(15, 3, 73, '2024-06-25 18:32:01', 17, '2023-09-01', '2024-09-01'),
(15, 4, 84, '2024-06-25 18:32:01', 18, '2023-09-10', '2024-09-10'),
(16, 5, 57, '2024-06-25 18:32:01', 19, '2023-10-01', '2024-10-01'),
(16, 6, 89, '2024-06-25 18:32:01', 20, '2023-10-15', '2024-10-15'),
(11, 7, 60, '2024-06-25 18:32:01', 21, '2023-11-01', '2024-11-01'),
(11, 8, 82, '2024-06-25 18:32:01', 22, '2023-11-10', '2024-11-10'),
(12, 1, 45, '2024-06-25 18:32:01', 23, '2023-12-01', '2024-12-01'),
(12, 2, 78, '2024-06-25 18:32:01', 24, '2023-12-15', '2024-12-15'),
(13, 3, 65, '2024-06-25 18:32:01', 25, '2024-01-01', '2025-01-01'),
(13, 4, 88, '2024-06-25 18:32:01', 26, '2024-01-10', '2025-01-10'),
(14, 5, 70, '2024-06-25 18:32:01', 27, '2024-02-01', '2025-02-01'),
(14, 6, 92, '2024-06-25 18:32:01', 28, '2024-02-15', '2025-02-15'),
(15, 7, 55, '2024-06-25 18:32:01', 29, '2024-03-01', '2025-03-01'),
(15, 8, 83, '2024-06-25 18:32:01', 30, '2024-03-10', '2025-03-10'),
(16, 1, 75, '2024-06-25 18:32:01', NULL, NULL, NULL),
(16, 2, 90, '2024-06-25 18:32:01', NULL, NULL, NULL),
(7, 3, 60, '2024-06-25 18:32:01', 31, '2024-04-01', '2025-04-01'),
(7, 4, 80, '2024-06-25 18:32:01', 32, '2024-04-10', '2025-04-10'),
(8, 5, 70, '2024-06-25 18:32:01', 33, '2024-05-01', '2025-05-01'),
(8, 6, 95, '2024-06-25 18:32:01', 34, '2024-05-15', '2025-05-15'),
(9, 7, 50, '2024-06-25 18:32:01', 35, '2024-06-01', '2025-06-01'),
(9, 8, 85, '2024-06-25 18:32:01', 36, '2024-06-10', '2025-06-10'),
(10, 1, 65, '2024-06-25 18:32:01', 37, '2024-07-01', '2025-07-01'),
(10, 2, 92, '2024-06-25 18:32:01', 38, '2024-07-15', '2025-07-15');

INSERT INTO [userOnline] (user_id, online_date, online_time) VALUES
(7, '2023-06-01', '01:00:00'),
(7, '2023-06-01', '00:30:00'), 
(7, '2023-06-01', '00:45:00'),  
(8, '2023-06-01', '01:00:00'),  
(8, '2023-06-01', '00:30:00'),  
(8, '2023-06-01', '00:45:00'), 
(11, '2023-06-01', '01:00:00'), 
(11, '2023-06-01', '00:30:00'),  
(11, '2023-06-01', '00:45:00'), 
(12, '2023-06-01', '01:15:00'),  
(12, '2023-06-01', '00:50:00'),  
(12, '2023-06-01', '01:30:00'),  
(13, '2023-06-01', '00:30:00'),  
(13, '2023-06-01', '01:00:00'),  
(13, '2023-06-01', '02:00:00'),  
(14, '2023-06-01', '00:45:00'), 
(14, '2023-06-01', '01:30:00'),  
(14, '2023-06-01', '01:00:00'),  
(15, '2023-06-01', '00:50:00'),  
(15, '2023-06-01', '01:15:00'),  
(15, '2023-06-01', '00:45:00');

INSERT INTO favouriteCategory (mentee_id, category_id) VALUES
(7, 1),
(7, 2),
(7, 3),
(8, 4),
(8, 2),
(9, 5),
(9, 6),
(12, 3),
(11, 2),
(11, 1),
(10, 6),
(14, 1),
(15, 1),
(12, 4),
(8, 3),
(13, 2),
(13, 1)

INSERT INTO setting (type, name, value) VALUES
('SourceType', 'course', 1),
('SourceType', 'challenge', 2),
('SourceType', 'program', 3),
('Role', 'Mentee', 1),
('Role', 'Mentor', 2),
('Role', 'Admin', 3);

INSERT INTO eventType (event_type_name) VALUES
('Page View'),
('Add to Cart'),
('Purchase'),
('Ad Impression'),
('Ad Click'),
('View Category');


INSERT INTO eventLog (user_id, source_id, source_type_id, event_type_id, event_time) VALUES
(1, 1, 1, 1, '2024-03-02 00:00:00'),
(1, 1, 1, 2, '2024-03-03 00:00:00'),
(1, 3, 1, 5, '2024-06-06 00:00:00'),
(1, 1, 1, 1, '2024-03-05 00:00:00'),
(1, 2, 1, 2, '2024-03-06 00:00:00'),
(2, 2, 1, 5, '2024-06-09 00:00:00'),
(1, 1, 1, 1, '2024-03-02 00:00:00'),
(1, 1, 1, 2, '2024-03-03 00:00:00'),
(1, 3, 1, 5, '2024-06-06 00:00:00'),
(1, 1, 1, 1, '2024-03-05 00:00:00'),
(1, 2, 1, 2, '2024-03-06 00:00:00'),
(2, 2, 1, 5, '2024-06-09 00:00:00'),
(2, 1, 1, 1, '2024-03-02 00:00:00'),
(2, 1, 1, 2, '2024-03-03 00:00:00'),
(2, 3, 1, 5, '2024-06-06 00:00:00'),
(2, 1, 1, 1, '2024-03-05 00:00:00'),
(2, 2, 1, 2, '2024-03-06 00:00:00'),
(3, 2, 1, 5, '2024-06-09 00:00:00'),
(3, 1, 1, 1, '2024-03-02 00:00:00'),
(3, 1, 1, 2, '2024-03-03 00:00:00'),
(3, 3, 1, 5, '2024-06-06 00:00:00'),
(3, 1, 1, 1, '2024-03-05 00:00:00'),
(3, 2, 1, 2, '2024-03-06 00:00:00'),
(4, 2, 1, 5, '2024-06-09 00:00:00'),
(4, 1, 1, 1, '2024-03-02 00:00:00'),
(4, 1, 1, 2, '2024-03-03 00:00:00'),
(4, 3, 1, 5, '2024-06-06 00:00:00'),
(4, 1, 1, 1, '2024-03-05 00:00:00'),
(4, 2, 1, 2, '2024-03-06 00:00:00');