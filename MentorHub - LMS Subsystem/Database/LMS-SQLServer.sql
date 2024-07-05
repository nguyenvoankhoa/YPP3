-- DROP DATABASE IF EXISTS LMS; -- SQL Server does not support IF EXISTS in DROP DATABASE

USE master;
GO
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
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255)
);

CREATE TABLE [User] (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  asset_id INT,
  role_id INT,
  is_active BIT,
  last_login DATETIME,
  FOREIGN KEY (role_id) REFERENCES Role(id)
);

CREATE TABLE SourceImage (
  id INT PRIMARY KEY IDENTITY(1,1),
  source_id INT,
  asset_id INT,
  source_type_id INT
);

CREATE TABLE Course (
  id INT PRIMARY KEY IDENTITY(1,1),
  name NVARCHAR(255),
  category_id INT,
  price DECIMAL(10, 2),
  description TEXT,
  created_at DATETIME,
  mentor_id INT,
  pass_condition INT,
  thumbnail_id INT,
  FOREIGN KEY (category_id) REFERENCES Category(id),
  FOREIGN KEY (mentor_id) REFERENCES [User](id),
  FOREIGN KEY (thumbnail_id) REFERENCES SourceImage(id)
);

CREATE TABLE Ads (
  source_id INT PRIMARY KEY IDENTITY(1,1),
  source_type INT,
  thumbnail_id INT,
  startAt DATETIME,
  endAt DATETIME,
  FOREIGN KEY (thumbnail_id) REFERENCES SourceImage(id)
);

CREATE TABLE Tag (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255)
);

CREATE TABLE SourceTag (
  source_id INT,
  source_type_id INT,
  tag_id INT,
  PRIMARY KEY (source_id, source_type_id, tag_id)
);

CREATE TABLE Section (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  course_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Lesson (
  id INT PRIMARY KEY IDENTITY(1,1),
  section_id INT,
  title VARCHAR(255),
  transcript TEXT,
  summary TEXT,
  asset_id INT,
  FOREIGN KEY (section_id) REFERENCES Section(id)
);

CREATE TABLE Resource (
  id INT PRIMARY KEY IDENTITY(1,1),
  asset_id INT,
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
  source_id INT,
  source_type INT,
  rating_star INT,
  content TEXT,
  review_at DATETIME,
  FOREIGN KEY (mentee_id) REFERENCES [User](id)
);

CREATE TABLE MenteeSaveCourse (
  course_id INT,
  mentee_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(id),
  FOREIGN KEY (mentee_id) REFERENCES [User](id)
);

CREATE TABLE Progress (
  id INT PRIMARY KEY IDENTITY(1,1),
  lesson_id INT,
  mentee_id INT,
  course_id INT,
  time_closed DATETIME,
  status BIT,
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
  FOREIGN KEY (mentee_id) REFERENCES [User](id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Voucher (
  id INT PRIMARY KEY IDENTITY(1,1),
  code VARCHAR(255),
  source_id INT,
  source_type_id INT,
  discount FLOAT,
  quantity INT,
  expire_date DATETIME
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
  user_id INT,
  user_payment_id INT,
  status INT,
  created_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (user_payment_id) REFERENCES UserPaymentInfo(id)
);

CREATE TABLE OrderDetail (
  id INT PRIMARY KEY IDENTITY(1,1),
  order_id INT,
  price DECIMAL(10, 2),
  source_id INT,
  source_type INT,
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
  asset_id INT,
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
  course_id INT,
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
  course_id INT,
  progress INT,
  enroll_at DATETIME,
  cert_id INT,
  issued_on DATE,
  expiry_at DATE,
  FOREIGN KEY (mentee_id) REFERENCES [User](id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE UserOnline (
  user_id INT,
  online_date DATE,
  online_time TIME,
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE FavouriteCategory (
  mentee_id INT,
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES Category(id),
  FOREIGN KEY (mentee_id) REFERENCES [User](id)
);

CREATE TABLE Setting (
  id INT PRIMARY KEY IDENTITY(1,1),
  type VARCHAR(255),
  name VARCHAR(255),
  value INT
);

CREATE TABLE EventType (
  id INT PRIMARY KEY IDENTITY(1,1),
  event_type_name VARCHAR(255)
);

CREATE TABLE EventLog (
  id INT PRIMARY KEY IDENTITY(1,1),
  user_id INT,
  source_id INT,
  source_type_id INT,
  event_type_id INT,
  event_time DATETIME,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (event_type_id) REFERENCES EventType(id)
);
