-- DROP DATABASE IF EXISTS LMS; -- SQL Server does not support IF EXISTS in DROP DATABASE

use master
go
IF DB_ID('LMS') IS NOT NULL
   DROP DATABASE LMS;

CREATE DATABASE LMS;
GO

USE LMS;
GO

CREATE TABLE role (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(50)
);

CREATE TABLE category (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255)
);



CREATE TABLE [user] (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  asset_id int,
  role_id INT,
  is_active BIT,
  last_login DATETIME,
  FOREIGN KEY (role_id) REFERENCES role(id)
);
CREATE TABLE source_image (
  id INT PRIMARY KEY IDENTITY(1,1),
  source_id INT,
  asset_id int,
  source_type_id INT
);


CREATE TABLE course (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(255),
  category_id INT,
  price DECIMAL(10, 2),
  description TEXT,
  created_at DATETIME,
  mentor_id INT,
  pass_condition INT,
  thumbnail_id INT,
  FOREIGN KEY (category_id) REFERENCES category(id),
  FOREIGN KEY (mentor_id) REFERENCES [User](id),
  FOREIGN KEY (thumbnail_id) REFERENCES source_image(id)
);

CREATE TABLE ads(
  source_id INT PRIMARY KEY IDENTITY(1,1),
  source_type int,
  thumbnail_id INT,
  startAt DATETIME,
  endAt DATETIME 
  FOREIGN KEY (thumbnail_id) REFERENCES source_image(id)
)



CREATE TABLE tag (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255)
);

CREATE TABLE course_tag (
  course_id INT,
  tag_id INT,
  FOREIGN KEY (course_id) REFERENCES course(id),
  FOREIGN KEY (tag_id) REFERENCES tag(id)
);

CREATE TABLE section (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  course_id int,
  FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE lesson (
  id INT PRIMARY KEY IDENTITY(1,1),
  section_id INT,
  title VARCHAR(255),
  transcript TEXT,
  summary TEXT,
  asset_id int,
  FOREIGN KEY (section_id) REFERENCES section(id)
);

CREATE TABLE resource (
  id INT PRIMARY KEY IDENTITY(1,1),
  asset_id int,
  lesson_id INT,
  FOREIGN KEY (lesson_id) REFERENCES lesson(id)
);

CREATE TABLE discussion (
  id INT PRIMARY KEY IDENTITY(1,1),
  user_id INT,
  lesson_id INT,
  parent_discussion_id INT,
  content TEXT,
  created_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (lesson_id) REFERENCES lesson(id),
  FOREIGN KEY (parent_discussion_id) REFERENCES discussion(id)
);

CREATE TABLE review (
  id INT PRIMARY KEY IDENTITY(1,1),
  mentee_id INT,
  source_id INT,
  source_type int,
  rating_star INT,
  content TEXT,
  review_at DATETIME,
  
  FOREIGN KEY (mentee_id) REFERENCES [user](id)
);

CREATE TABLE mentee_save_course (
  course_id INT,
  mentee_id INT,
  FOREIGN KEY (course_id) REFERENCES course(id),
  FOREIGN KEY (mentee_id) REFERENCES [user](id)
);


CREATE TABLE progress (
  id INT PRIMARY KEY IDENTITY(1,1),
  lesson_id INT,
  mentee_id INT,
  course_id int,
  time_closed DATETIME,
  status BIT,
  FOREIGN KEY (lesson_id) REFERENCES lesson(id),
  FOREIGN KEY (mentee_id) REFERENCES [user](id),
  FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE voucher (
  id INT PRIMARY KEY IDENTITY(1,1),
  code VARCHAR(255),
  discount FLOAT,
);

CREATE TABLE payment_method (
  id INT PRIMARY KEY IDENTITY(1,1),
  method VARCHAR(255)
);

CREATE TABLE user_payment_info (
  id INT PRIMARY KEY IDENTITY(1,1),
  user_id INT,
  name_on_card VARCHAR(255),
  card_number VARCHAR(20),
  expiry_date DATETIME,
  payment_method_id INT,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_method(id)
);

CREATE TABLE [order] (
  id INT PRIMARY KEY IDENTITY(1,1),
  user_id INT,
  user_payment_id INT,
  status INT,
  created_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (user_payment_id) REFERENCES user_payment_info(id),
);

CREATE TABLE order_detail (
  id INT PRIMARY KEY IDENTITY(1,1),
  order_id INT,
  price DECIMAL(10, 2),
  source_id INT,
  source_type int,
  FOREIGN KEY (order_id) REFERENCES [order](id)
);

CREATE TABLE quiz (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  summary TEXT,
  attempts_allowed INT,
  passing_grade INT,
  duration TIME,
  section_id INT,
  FOREIGN KEY (section_id) REFERENCES section(id)
);

CREATE TABLE question_type (
  id INT PRIMARY KEY IDENTITY(1,1),
  type VARCHAR(255)
);

CREATE TABLE question (
  id INT PRIMARY KEY IDENTITY(1,1),
  question_type_id INT,
  quiz_id INT,
  title TEXT,
  randomize BIT,
  points FLOAT,
  explanation TEXT,
  FOREIGN KEY (question_type_id) REFERENCES question_type(id),
  FOREIGN KEY (quiz_id) REFERENCES quiz(id)
);

CREATE TABLE answer (
  id INT PRIMARY KEY IDENTITY(1,1),
  question_id INT,
  content TEXT,
  asset_id int,
  is_correct BIT,
  FOREIGN KEY (question_id) REFERENCES question(id)
);

CREATE TABLE quiz_result (
  mentee_id INT,
  quiz_id INT,
  date DATETIME,
  mark FLOAT,
  result BIT,
  FOREIGN KEY (mentee_id) REFERENCES [user](id),
  FOREIGN KEY (quiz_id) REFERENCES quiz(id)
);

CREATE TABLE mentee_question (
  mentee_id INT,
  question_id INT,
  earned_marks FLOAT,
  FOREIGN KEY (mentee_id) REFERENCES [user](id),
  FOREIGN KEY (question_id) REFERENCES question(id)
);

CREATE TABLE learning_path (
  id INT PRIMARY KEY IDENTITY(1,1),
  title TEXT,
  description TEXT,
  mentor_id INT,
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (mentor_id) REFERENCES [user](id)
);

CREATE TABLE course_learning_path (
  learning_path_id INT,
  course_id int,
  FOREIGN KEY (learning_path_id) REFERENCES learning_path(id),
  FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE learning_path_progress (
  learning_path_id INT,
  mentee_id INT,
  progress FLOAT,
  FOREIGN KEY (learning_path_id) REFERENCES learning_path(id),
  FOREIGN KEY (mentee_id) REFERENCES [user](id)
);

CREATE TABLE mentee_course (
  mentee_id INT,
  course_id int,
  progress INT,
  enroll_at DATETIME,
  cert_id INT,
  issued_on DATE,
  expiry_at DATE,
  FOREIGN KEY (mentee_id) REFERENCES [user](id),
  FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE user_online (
   user_id INT,
   online_date DATE,
   online_time TIME,
   FOREIGN KEY (user_id) REFERENCES [user](id)
);

CREATE TABLE favourite_category (
   mentee_id INT,
   category_id INT, 
   FOREIGN KEY (category_id) REFERENCES category(id),
   FOREIGN KEY (mentee_id) REFERENCES [user](id)
);

CREATE TABLE setting(
    id INT PRIMARY KEY IDENTITY(1,1),
    type VARCHAR(255),
    name VARCHAR(255),
    value INT
)