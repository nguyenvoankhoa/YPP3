CREATE TABLE Role (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50)
);

CREATE TABLE Category (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
);

CREATE TABLE User (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE,
  password VARCHAR(255),
  name NVARCHAR(255),
  phone VARCHAR(15),
  email VARCHAR(255) UNIQUE,
  status BOOLEAN,
  age INT,
  assest_id VARCHAR(255),
  account_balance DOUBLE,
  role INT,
  FOREIGN KEY (role) REFERENCES Role(id)
);

CREATE TABLE Course (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name NVARCHAR(255),
  category INT,
  price DECIMAL(10,2),
  description TEXT,
  status INT,
  createdAt TIMESTAMP,
  createBy INT,
  FOREIGN KEY (category) REFERENCES Category(id),
  FOREIGN KEY (createBy) REFERENCES User(id)
);

CREATE TABLE Tag (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
);

CREATE TABLE CourseTag (
  course_id INT,
  tag_id INT,
  PRIMARY KEY (course_id, tag_id),
  FOREIGN KEY (course_id) REFERENCES Course(id),
  FOREIGN KEY (tag_id) REFERENCES Tag(id)
);

CREATE TABLE Section (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  course_id INT,
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Lesson (
  id INT PRIMARY KEY AUTO_INCREMENT,
  section_id INT,
  title VARCHAR(255),
  transcript TEXT,
  summary TEXT,
  assest_id VARCHAR(255),
  FOREIGN KEY (section_id) REFERENCES Section(id)
);

CREATE TABLE Resource (
  id INT PRIMARY KEY AUTO_INCREMENT,
  assest_id VARCHAR(255),
  uploadAt TIMESTAMP,
  lesson_id INT,
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id)
);

CREATE TABLE Discussion (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  lesson_id INT,
  parent_discussion_id INT,
  content TEXT,
  createdAt TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES User(id),
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
  FOREIGN KEY (parent_discussion_id) REFERENCES Discussion(id)
);

CREATE TABLE Review (
  mentee_id INT,
  course_id INT,
  rate INT,
  comment TEXT,
  reviewAt TIMESTAMP,
  PRIMARY KEY (mentee_id, course_id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE MenteeSaveCourse (
  course_id INT,
  mentee_id INT,
  PRIMARY KEY (course_id, mentee_id),
  FOREIGN KEY (course_id) REFERENCES Course(id),
  FOREIGN KEY (mentee_id) REFERENCES User(id)
);

CREATE TABLE ImageBanner (
  id INT PRIMARY KEY AUTO_INCREMENT,
  course_id INT,
  assest_id VARCHAR(255),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Progress (
  id INT PRIMARY KEY AUTO_INCREMENT,
  lesson_id INT,
  mentee_id INT,
  course_id INT,
  timeClosed TIMESTAMP,
  status BOOLEAN,
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE PaymentMethod (
  id INT PRIMARY KEY AUTO_INCREMENT,
  method VARCHAR(255)
);

CREATE TABLE UserPaymentInfo (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  nameOnCard VARCHAR(255),
  cardNumber VARCHAR(20),
  expiryDate DATETIME,
  payment_type_id INT,
  FOREIGN KEY (user_id) REFERENCES User(id),
  FOREIGN KEY (payment_type_id) REFERENCES PaymentMethod(id)
);

CREATE TABLE CourseOrder (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mentee_id INT,
  payment_info_id INT,
  totalAmount DECIMAL(10,2),
  status INT,
  createdAt TIMESTAMP,
  updatedAt TIMESTAMP,
  discount INT,
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (payment_info_id) REFERENCES UserPaymentInfo(id)
);

CREATE TABLE OrderDetail (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  amount DECIMAL(10,2),
  course_id INT,
  FOREIGN KEY (order_id) REFERENCES CourseOrder(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE Quiz (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  summary TEXT,
  attemptsAllowed INT,
  passingGrade INT,
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
  assest_id VARCHAR(255),
  isCorrect BOOLEAN,
  FOREIGN KEY (question_id) REFERENCES Question(id)
);

CREATE TABLE QuizResult (
  mentee_id INT,
  quiz_id INT,
  date TIMESTAMP,
  mark DOUBLE,
  result BOOLEAN,
  PRIMARY KEY (mentee_id, quiz_id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (quiz_id) REFERENCES Quiz(id)
);

CREATE TABLE MenteeQuestion (
  mentee_id INT,
  question_id INT,
  earnedMarks DOUBLE,
  PRIMARY KEY (mentee_id, question_id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (question_id) REFERENCES Question(id)
);

CREATE TABLE LearningPath (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title TEXT,
  description TEXT,
  mentor_id INT,
  createdAt TIMESTAMP,
  updatedAt TIMESTAMP,
  FOREIGN KEY (mentor_id) REFERENCES User(id)
);

CREATE TABLE CourseLearningPath (
  learning_path_id INT,
  course_id INT,
  PRIMARY KEY (learning_path_id, course_id),
  FOREIGN KEY (learning_path_id) REFERENCES LearningPath(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE LearningPathProgress (
  learning_path_id INT,
  mentee_id INT,
  progress FLOAT,
  PRIMARY KEY (learning_path_id, mentee_id),
  FOREIGN KEY (learning_path_id) REFERENCES LearningPath(id),
  FOREIGN KEY (mentee_id) REFERENCES User(id)
);

CREATE TABLE LessonProgress (
  mentee_id INT,
  lesson_id INT,
  status INT,
  PRIMARY KEY (mentee_id, lesson_id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (lesson_id) REFERENCES Lesson(id)
);

CREATE TABLE MenteeCourse (
  mentee_id INT,
  course_id INT,
  progress INT,
  enrollAt TIMESTAMP,
  PRIMARY KEY (mentee_id, course_id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

CREATE TABLE FavouriteCategory (
  mentee_id INT,
  category_id INT,
  lastVisit TIMESTAMP,
  PRIMARY KEY (mentee_id, category_id),
  FOREIGN KEY (mentee_id) REFERENCES User(id),
  FOREIGN KEY (category_id) REFERENCES Category(id)
);
