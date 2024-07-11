CREATE database LMS
GO

USE LMS
GO

CREATE TABLE Role (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(50)
);

CREATE TABLE Jobtitle (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE Location (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE [User] (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255),
  asset_id INT,
  location_id INT,
  jobtitle_id INT,
  role_id INT,
  create_at DATETIME,
  age INT,
  gender VARCHAR(10),
  status BIT,
  FOREIGN KEY (role_id) REFERENCES Role(id),
  FOREIGN KEY (jobtitle_id) REFERENCES Jobtitle(id),
  FOREIGN KEY (location_id) REFERENCES Location(id)
);

CREATE TABLE SourceImage (
  id INT PRIMARY KEY IDENTITY(1,1),
  source_id INT,
  asset_id INT,
  source_type_id INT
);

CREATE TABLE Category (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255)
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
  start_at DATETIME,
  end_at DATETIME,
  FOREIGN KEY (thumbnail_id) REFERENCES SourceImage(id)
);

CREATE TABLE Tag (
  id INT PRIMARY KEY IDENTITY(1,1),
  tag_name VARCHAR(255)
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
    source_id INT,
    user_id INT,
    source_type_id INT,
    rating_star INT,
    content VARCHAR(255),
	review_at TIME,
    FOREIGN KEY (user_id) REFERENCES [User](id)
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
  source_type_id INT,
  FOREIGN KEY (order_id) REFERENCES [Order](id)
);

CREATE TABLE CartItem (
  id INT PRIMARY KEY,
  user_id INT,
  source_id INT,
  source_type_id INT,
  FOREIGN KEY (user_id) REFERENCES [User](id)
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
  id INT PRIMARY KEY,
  setting_type VARCHAR(255),
  setting_name VARCHAR(255),
  setting_value INT
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

CREATE TABLE Program (
  id INT PRIMARY KEY,
  user_id INT,
  program_name VARCHAR(255),
  description VARCHAR(255),
  price FLOAT,
  category_id INT,
  asset_id INT,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (category_id) REFERENCES Category(id)
);

CREATE TABLE ProgramUser (
  program_id INT,
  user_id INT,
  progress_percent FLOAT,
  status VARCHAR(50),
  start_at DATE,
  PRIMARY KEY (program_id, user_id),
  FOREIGN KEY (program_id) REFERENCES Program(id),
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE ProgramSource (
  program_id INT,
  source_id INT,
  source_type_id INT,
  source_order INT,
  PRIMARY KEY (program_id, source_id, source_type_id),
  FOREIGN KEY (program_id) REFERENCES Program(id)
);

CREATE TABLE ProgramMentor (
  program_id INT,
  user_id INT,
  PRIMARY KEY (program_id, user_id),
  FOREIGN KEY (program_id) REFERENCES Program(id),
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE Challenge (
  id INT PRIMARY KEY,
  user_id INT,
  category_id INT,
  challenge_name VARCHAR(255),
  description VARCHAR(255),
  location VARCHAR(255),
  phase VARCHAR(255),
  start_date DATETIME,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (category_id) REFERENCES Category(id)
);

CREATE TABLE ChallengeUser (
  challenge_id INT,
  user_id INT,
  score FLOAT,
  status VARCHAR(255),
  date_submission DATETIME,
  FOREIGN KEY (challenge_id) REFERENCES Challenge(id),
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE FollowUser (
  id INT PRIMARY KEY,
  follower_id INT,
  followee_id INT,
  datefollow DATETIME,
  FOREIGN KEY (follower_id) REFERENCES [User](id),
  FOREIGN KEY (followee_id) REFERENCES [User](id)
);

CREATE TABLE SourceTemplate (
  id INT PRIMARY KEY,
  template_id INT,
  source_id INT,
  sourcetype_id INT,
  FOREIGN KEY (sourcetype_id) REFERENCES Setting(id)
);

CREATE TABLE CredentialIssued (
  id INT PRIMARY KEY,
  sourcetemplate_id INT,
  user_id INT,
  credentialcode VARCHAR(50),
  certified_at DATETIME,
  FOREIGN KEY (sourcetemplate_id) REFERENCES SourceTemplate(id),
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE Company (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  img VARCHAR(255)
);

CREATE TABLE WorkingType (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE Experience (
  id INT PRIMARY KEY,
  jobtitle_id INT,
  company_id INT,
  type_id INT,
  user_id INT,
  isworking BIT,
  FOREIGN KEY (company_id) REFERENCES Company(id),
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (jobtitle_id) REFERENCES Jobtitle(id),
  FOREIGN KEY (type_id) REFERENCES WorkingType(id)
);

CREATE TABLE University (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  img VARCHAR(255)
);

CREATE TABLE Education (
  id INT PRIMARY KEY,
  degree VARCHAR(255),
  university_id INT,
  user_id INT,
  FOREIGN KEY (university_id) REFERENCES University(id),
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE Skill (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE UserSkill (
  id INT PRIMARY KEY,
  user_id INT,
  skill_id INT,
  FOREIGN KEY (user_id) REFERENCES [User](id),
  FOREIGN KEY (skill_id) REFERENCES Skill(id)
);

CREATE TABLE Event (
  id INT PRIMARY KEY,
  title VARCHAR(255),
  user_id INT,
  views INT,
  create_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE EventUser (
  id INT PRIMARY KEY,
  event_id INT,
  user_id INT,
  FOREIGN KEY (event_id) REFERENCES Event(id),
  FOREIGN KEY (user_id) REFERENCES [User](id)
);

CREATE TABLE MentorReview (
  id INT PRIMARY KEY,
  sender_id INT,
  receiver_id INT,
  rating_star INT,
  content VARCHAR(255),
  FOREIGN KEY (sender_id) REFERENCES [User](id),
  FOREIGN KEY (receiver_id) REFERENCES [User](id)
);

