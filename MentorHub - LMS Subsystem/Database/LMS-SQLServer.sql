-- DROP DATABASE IF EXISTS LMS; -- SQL Server does not support IF EXISTS in DROP DATABASE

IF DB_ID('LMS') IS NOT NULL
    DROP DATABASE LMS;

CREATE DATABASE LMS;
GO

USE LMS;
GO

CREATE TABLE Role (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(50)
);

CREATE TABLE Category (
  id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE [User] (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  asset_id VARCHAR(255),
  role_id INT,
  is_active BIT,
  last_login DATETIME,
  FOREIGN KEY (role_id) REFERENCES Role(id)
);

CREATE TABLE Course (
  id VARCHAR(255) PRIMARY KEY,
  name NVARCHAR(255),
  category_id VARCHAR(10),
  price DECIMAL(10, 2),
  description TEXT,
  created_at DATETIME,
  mentor_id INT,
  pass_condition INT,
  FOREIGN KEY (category_id) REFERENCES Category(id),
  FOREIGN KEY (mentor_id) REFERENCES [User](id)
);

CREATE TABLE Tag (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255)
);

CREATE TABLE CourseTag (
  course_id VARCHAR(255),
  tag_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(id),
  FOREIGN KEY (tag_id) REFERENCES Tag(id)
);

CREATE TABLE Section (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  course_id VARCHAR(255),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Lesson (
  id INT PRIMARY KEY IDENTITY(1,1),
  section_id INT,
  title VARCHAR(255),
  transcript TEXT,
  summary TEXT,
  asset_id VARCHAR(255),
  FOREIGN KEY (section_id) REFERENCES Section(id)
);

CREATE TABLE Resource (
  id INT PRIMARY KEY IDENTITY(1,1),
  asset_id VARCHAR(255),
  upload_at DATETIME,
  lesson_id INT,
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id)
);

CREATE TABLE Discussion (
  id INT PRIMARY KEY IDENTITY(1,1),
  user_id INT,
  lesson_id INT,
  parent_discussion_id INT,
  content TEXT,
  created_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
  FOREIGN KEY (parent_discussion_id) REFERENCES Discussion(id)
);

CREATE TABLE Review (
  id INT PRIMARY KEY IDENTITY(1,1),
  mentee_id INT,
  source_id VARCHAR(255),
  rating_star INT,
  content TEXT,
  review_at DATETIME,
  source_type VARCHAR(255),
  FOREIGN KEY (mentee_id) REFERENCES [User](id)
);

CREATE TABLE MenteeSaveCourse (
  course_id VARCHAR(255),
  mentee_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(id),
  FOREIGN KEY (mentee_id) REFERENCES [User](id)
);

CREATE TABLE ImageBanner (
  id INT PRIMARY KEY IDENTITY(1,1),
  course_id VARCHAR(255),
  asset_id VARCHAR(255),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Progress (
  id INT PRIMARY KEY IDENTITY(1,1),
  lesson_id INT,
  mentee_id INT,
  course_id VARCHAR(255),
  time_closed DATETIME,
  status BIT,
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
  FOREIGN KEY (mentee_id) REFERENCES [User](id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Voucher (
  id INT PRIMARY KEY IDENTITY(1,1),
  code VARCHAR(255),
  discount FLOAT
);

CREATE TABLE PaymentMethod (
  id INT PRIMARY KEY IDENTITY(1,1),
  method VARCHAR(255)
);

CREATE TABLE UserPaymentInfo (
  id INT PRIMARY KEY IDENTITY(1,1),
  user_id INT,
  name_on_card VARCHAR(255),
  card_number VARCHAR(20),
  expiry_date DATETIME,
  payment_method_id INT,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(id)
);

CREATE TABLE [Order] (
  id INT PRIMARY KEY IDENTITY(1,1),
  mentee_id INT,
  user_payment_id INT,
  status INT,
  created_at DATETIME,
  voucher_id INT,
  FOREIGN KEY (mentee_id) REFERENCES [User](id),
  FOREIGN KEY (user_payment_id) REFERENCES UserPaymentInfo(id),
  FOREIGN KEY (voucher_id) REFERENCES Voucher(id)
);

CREATE TABLE OrderDetail (
  id INT PRIMARY KEY IDENTITY(1,1),
  order_id INT,
  price DECIMAL(10, 2),
  source_id VARCHAR(255),
  source_type VARCHAR(255),
  FOREIGN KEY (order_id) REFERENCES [Order](id)
);

CREATE TABLE Quiz (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  summary TEXT,
  attempts_allowed INT,
  passing_grade INT,
  duration TIME,
  section_id INT,
  FOREIGN KEY (section_id) REFERENCES Section(id)
);

CREATE TABLE QuestionType (
  id INT PRIMARY KEY IDENTITY(1,1),
  type VARCHAR(255)
);

CREATE TABLE Question (
  id INT PRIMARY KEY IDENTITY(1,1),
  question_type_id INT,
  quiz_id INT,
  title TEXT,
  randomize BIT,
  points FLOAT,
  explanation TEXT,
  FOREIGN KEY (question_type_id) REFERENCES QuestionType(id),
  FOREIGN KEY (quiz_id) REFERENCES Quiz(id)
);

CREATE TABLE Answer (
  id INT PRIMARY KEY IDENTITY(1,1),
  question_id INT,
  content TEXT,
  asset_id VARCHAR(255),
  is_correct BIT,
  FOREIGN KEY (question_id) REFERENCES Question(id)
);

CREATE TABLE QuizResult (
  mentee_id INT,
  quiz_id INT,
  date DATETIME,
  mark FLOAT,
  result BIT,
  FOREIGN KEY (mentee_id) REFERENCES [User](id),
  FOREIGN KEY (quiz_id) REFERENCES Quiz(id)
);

CREATE TABLE MenteeQuestion (
  mentee_id INT,
  question_id INT,
  earned_marks FLOAT,
  FOREIGN KEY (mentee_id) REFERENCES [User](id),
  FOREIGN KEY (question_id) REFERENCES Question(id)
);

CREATE TABLE LearningPath (
  id INT PRIMARY KEY IDENTITY(1,1),
  title TEXT,
  description TEXT,
  mentor_id INT,
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (mentor_id) REFERENCES [User](id)
);

CREATE TABLE CourseLearningPath (
  learning_path_id INT,
  course_id VARCHAR(255),
  FOREIGN KEY (learning_path_id) REFERENCES LearningPath(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE LearningPathProgress (
  learning_path_id INT,
  mentee_id INT,
  progress FLOAT,
  FOREIGN KEY (learning_path_id) REFERENCES LearningPath(id),
  FOREIGN KEY (mentee_id) REFERENCES [User](id)
);

CREATE TABLE MenteeCourse (
  mentee_id INT,
  course_id VARCHAR(255),
  progress INT,
  enroll_at DATETIME,
  cert_id INT,
  issued_on DATE,
  expiry_at DATE,
  FOREIGN KEY (mentee_id) REFERENCES [User](id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE [Online] (
   user_id INT,
   online_date DATE,
   online_time TIME
);

CREATE TABLE FavouriteCategory (
   mentee_id INT,
   category_id VARCHAR(10), 
   FOREIGN KEY (category_id) REFERENCES Category(id),
   FOREIGN KEY (mentee_id) REFERENCES [User](id)
);

CREATE TABLE Setting(
    id INT PRIMARY KEY IDENTITY(1,1),
    category VARCHAR(20),
    variable VARCHAR(20),
    value INT
)