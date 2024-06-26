DROP DATABASE IF EXISTS LMS;
CREATE DATABASE LMS;
USE LMS;

CREATE TABLE Role (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50)
);

CREATE TABLE Category (
  id varchar(10) primary key,
  name VARCHAR(255)
);

CREATE TABLE User (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  asset_id VARCHAR(255),
  role_id INT,
  is_active boolean,
  last_login timestamp,
  FOREIGN KEY (role_id) REFERENCES Role(id)
);

CREATE TABLE Course (
  id VARCHAR(255) PRIMARY KEY,
  name NVARCHAR(255),
  category_id varchar(10),
  price DECIMAL(10, 2),
  description TEXT,
  created_at TIMESTAMP,
  mentor_id INT,
  pass_condition INT,
  FOREIGN KEY (category_id) REFERENCES Category(id),
  FOREIGN KEY (mentor_id) REFERENCES User(id)
);

CREATE TABLE Tag (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
);

CREATE TABLE CourseTag (
  course_id VARCHAR(255),
  tag_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(id),
  FOREIGN KEY (tag_id) REFERENCES Tag(id)
);

CREATE TABLE Section (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  course_id VARCHAR(255),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Lesson (
  id INT PRIMARY KEY AUTO_INCREMENT,
  section_id INT,
  title VARCHAR(255),
  transcript TEXT,
  summary TEXT,
  asset_id VARCHAR(255),
  FOREIGN KEY (section_id) REFERENCES Section(id)
);

CREATE TABLE Resource (
  id INT PRIMARY KEY AUTO_INCREMENT,
  asset_id VARCHAR(255),
  upload_at TIMESTAMP,
  lesson_id INT,
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id)
);

CREATE TABLE Discussion (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  lesson_id INT,
  parent_discussion_id INT,
  content TEXT,
  created_at TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES User(id),
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
  FOREIGN KEY (parent_discussion_id) REFERENCES Discussion(id)
);

CREATE TABLE Review (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mentee_id INT,
  source_id VARCHAR(255),
  rating_star INT,
  content TEXT,
  review_at TIMESTAMP,
  source_type VARCHAR(255),
  FOREIGN KEY (mentee_id) REFERENCES User(id)
);

CREATE TABLE MenteeSaveCourse (
  course_id VARCHAR(255),
  mentee_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(id),
  FOREIGN KEY (mentee_id) REFERENCES User(id)
);

CREATE TABLE ImageBanner (
  id INT PRIMARY KEY AUTO_INCREMENT,
  course_id VARCHAR(255),
  asset_id VARCHAR(255),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Progress (
  id INT PRIMARY KEY AUTO_INCREMENT,
  lesson_id INT,
  mentee_id INT,
  course_id VARCHAR(255),
  time_closed TIMESTAMP,
  status BOOLEAN,
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Voucher (
  id INT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(255),
  discount DOUBLE
);



CREATE TABLE PaymentMethod (
  id INT PRIMARY KEY AUTO_INCREMENT,
  method VARCHAR(255)
);

CREATE TABLE UserPaymentInfo (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  name_on_card VARCHAR(255),
  card_number VARCHAR(20),
  expiry_date DATETIME,
  payment_method_id INT,
  FOREIGN KEY (user_id) REFERENCES User(id),
  FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(id)
);


CREATE TABLE `Order` (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mentee_id INT,
  user_payment_id INT,
  status INT,
  created_at TIMESTAMP,
  voucher_id INT,
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (user_payment_id) REFERENCES UserPaymentInfo(id),
  FOREIGN KEY (voucher_id) REFERENCES Voucher(id)
);

CREATE TABLE OrderDetail (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  price DECIMAL(10, 2),
  source_id VARCHAR(255),
  source_type VARCHAR(255),
  FOREIGN KEY (order_id) REFERENCES `Order`(id)
);

CREATE TABLE Quiz (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  summary TEXT,
  attempts_allowed INT,
  passing_grade INT,
  duration TIME,
  section_id INT,
  FOREIGN KEY (section_id) REFERENCES Section(id)
);

CREATE TABLE QuestionType (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type VARCHAR(255)
);

CREATE TABLE Question (
  id INT PRIMARY KEY AUTO_INCREMENT,
  question_type_id INT,
  quiz_id INT,
  title TEXT,
  randomize BOOLEAN,
  points DOUBLE,
  explanation TEXT,
  FOREIGN KEY (question_type_id) REFERENCES QuestionType(id),
  FOREIGN KEY (quiz_id) REFERENCES Quiz(id)
);

CREATE TABLE Answer (
  id INT PRIMARY KEY AUTO_INCREMENT,
  question_id INT,
  content TEXT,
  asset_id VARCHAR(255),
  is_correct BOOLEAN,
  FOREIGN KEY (question_id) REFERENCES Question(id)
);

CREATE TABLE QuizResult (
  mentee_id INT,
  quiz_id INT,
  date TIMESTAMP,
  mark DOUBLE,
  result BOOLEAN,
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (quiz_id) REFERENCES Quiz(id)
);

CREATE TABLE MenteeQuestion (
  mentee_id INT,
  question_id INT,
  earned_marks DOUBLE,
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (question_id) REFERENCES Question(id)
);

CREATE TABLE LearningPath (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title TEXT,
  description TEXT,
  mentor_id INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (mentor_id) REFERENCES User(id)
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
  FOREIGN KEY (mentee_id) REFERENCES User(id)
);

CREATE TABLE MenteeCourse (
  mentee_id INT,
  course_id VARCHAR(255),
  progress INT,
  enroll_at TIMESTAMP,
  cert_id INT,
  issued_on DATE,
  expiry_at DATE,
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE `Online` (
   user_id INT,
   online_date DATE,
   online_time TIME
);
CREATE TABLE FavouriteCategory(
   mentee_id INT,
   category_id varchar(10), 
   FOREIGN KEY (category_id) REFERENCES Category(id),
   FOREIGN KEY (mentee_id) REFERENCES User(id)
)