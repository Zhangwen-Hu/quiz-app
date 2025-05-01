-- Insert admin user
INSERT INTO user (email, password, firstname, lastname, is_active, is_admin)
VALUES ('admin@example.com', 'admin123', 'Admin', 'User', TRUE, TRUE);

-- Insert regular users
INSERT INTO user (email, password, firstname, lastname, is_active, is_admin)
VALUES ('john.doe@example.com', 'password123', 'John', 'Doe', TRUE, FALSE);

INSERT INTO user (email, password, firstname, lastname, is_active, is_admin)
VALUES ('jane.smith@example.com', 'password456', 'Jane', 'Smith', TRUE, FALSE);

INSERT INTO user (email, password, firstname, lastname, is_active, is_admin)
VALUES ('michael.brown@example.com', 'password789', 'Michael', 'Brown', TRUE, FALSE);

INSERT INTO user (email, password, firstname, lastname, is_active, is_admin)
VALUES ('sarah.wilson@example.com', 'passwordabc', 'Sarah', 'Wilson', TRUE, FALSE);

INSERT INTO user (email, password, firstname, lastname, is_active, is_admin)
VALUES ('david.taylor@example.com', 'passworddef', 'David', 'Taylor', TRUE, FALSE);

INSERT INTO user (email, password, firstname, lastname, is_active, is_admin)
VALUES ('emily.johnson@example.com', 'passwordxyz', 'Emily', 'Johnson', TRUE, FALSE);

-- Insert categories
INSERT INTO category (name) VALUES ('Java');
INSERT INTO category (name) VALUES ('SQL');
INSERT INTO category (name) VALUES ('Spring Framework');
INSERT INTO category (name) VALUES ('JavaScript');

-- ====================== JAVA QUESTIONS (CATEGORY ID: 1) ======================

-- Question 1
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'What is a correct syntax to output "Hello World" in Java?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (1, 'System.out.println("Hello World");', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (1, 'echo("Hello World");', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (1, 'print("Hello World");', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (1, 'Console.WriteLine("Hello World");', FALSE);

-- Question 2
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'Java is a _____ language?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (2, 'Compiled', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (2, 'Interpreted', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (2, 'Both Compiled and Interpreted', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (2, 'None of the above', FALSE);

-- Question 3
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'Which of these keywords is used to define a class in Java?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (3, 'class', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (3, 'struct', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (3, 'interface', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (3, 'object', FALSE);

-- Question 4
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'What is the correct way to declare a variable that should store a decimal number in Java?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (4, 'int myNum = 5.5;', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (4, 'float myNum = 5.5;', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (4, 'double myNum = 5.5;', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (4, 'decimal myNum = 5.5;', FALSE);

-- Question 5
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'Which collection type allows duplicate elements?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (5, 'Set', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (5, 'List', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (5, 'Map', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (5, 'Queue', FALSE);

-- Question 6
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'What is the default value of a boolean variable in Java?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (6, 'true', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (6, 'false', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (6, 'null', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (6, 'undefined', FALSE);

-- Question 7
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'Which of the following is NOT a valid access modifier in Java?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (7, 'public', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (7, 'private', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (7, 'protected', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (7, 'friend', TRUE);

-- Question 8
INSERT INTO question (category_id, description, is_active)
VALUES (1, 'What is the purpose of the "final" keyword in Java?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (8, 'To prevent inheritance', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (8, 'To prevent method overriding', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (8, 'To make a variable constant', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (8, 'All of the above', TRUE);

-- ====================== SQL QUESTIONS (CATEGORY ID: 2) ======================

-- Question 9
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'Which SQL statement is used to extract data from a database?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (9, 'EXTRACT', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (9, 'SELECT', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (9, 'GET', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (9, 'OPEN', FALSE);

-- Question 10
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'Which SQL statement is used to update data in a database?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (10, 'SAVE', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (10, 'MODIFY', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (10, 'UPDATE', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (10, 'CHANGE', FALSE);

-- Question 11
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'Which SQL statement is used to delete data from a database?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (11, 'REMOVE', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (11, 'DELETE', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (11, 'DROP', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (11, 'CLEAR', FALSE);

-- Question 12
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'Which SQL keyword is used to sort the result set?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (12, 'SORT BY', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (12, 'ORDER BY', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (12, 'ARRANGE BY', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (12, 'GROUP BY', FALSE);

-- Question 13
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'Which of the following is NOT a valid SQL data type?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (13, 'CHAR', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (13, 'FLOAT', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (13, 'ARRAY', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (13, 'DATE', FALSE);

-- Question 14
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'What does SQL stand for?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (14, 'Structured Query Language', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (14, 'Standard Query Language', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (14, 'Simple Query Language', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (14, 'System Query Language', FALSE);

-- Question 15
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'Which SQL function returns the current date?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (15, 'DATE()', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (15, 'GETDATE()', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (15, 'NOW()', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (15, 'CURRENT_DATE()', TRUE);

-- Question 16
INSERT INTO question (category_id, description, is_active)
VALUES (2, 'Which SQL clause is used to filter group results?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (16, 'WHERE', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (16, 'HAVING', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (16, 'GROUP FILTER', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (16, 'FILTER BY', FALSE);

-- ====================== SPRING FRAMEWORK QUESTIONS (CATEGORY ID: 3) ======================

-- Question 17
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'Which of the following is a Spring Framework module?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (17, 'Spring Hibernate', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (17, 'Spring JDBC', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (17, 'Spring Express', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (17, 'Spring Node', FALSE);

-- Question 18
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'Which annotation is used to create a RESTful controller in Spring?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (18, '@Controller', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (18, '@Resource', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (18, '@RestController', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (18, '@Service', FALSE);

-- Question 19
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'Which of the following is NOT a Spring Framework stereotype annotation?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (19, '@Component', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (19, '@Controller', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (19, '@Repository', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (19, '@Model', TRUE);

-- Question 20
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'What does AOP stand for in Spring?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (20, 'Aspect Oriented Programming', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (20, 'Application Object Programming', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (20, 'Application Oriented Protocol', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (20, 'Array of Pointers', FALSE);

-- Question 21
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'Which annotation is used for dependency injection in Spring?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (21, '@Inject', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (21, '@DI', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (21, '@Autowired', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (21, '@Dependency', FALSE);

-- Question 22
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'What is the default scope of a Spring bean?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (22, 'Prototype', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (22, 'Singleton', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (22, 'Request', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (22, 'Session', FALSE);

-- Question 23
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'Which Spring annotation is used to handle HTTP GET requests?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (23, '@GetMapping', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (23, '@RequestGet', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (23, '@HttpGet', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (23, '@Get', FALSE);

-- Question 24
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'Which of the following is NOT a valid Spring Boot property file format?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (24, 'application.properties', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (24, 'application.yml', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (24, 'application.json', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (24, 'application-{profile}.properties', FALSE);

-- Question 25
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'Which Spring annotation is used to create a scheduled task?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (25, '@Timer', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (25, '@Schedule', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (25, '@Scheduled', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (25, '@Cron', FALSE);

-- Question 26
INSERT INTO question (category_id, description, is_active)
VALUES (3, 'What does IoC stand for in Spring?', TRUE);

INSERT INTO choice (question_id, description, is_correct)
VALUES (26, 'Inversion of Control', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (26, 'Integration of Components', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (26, 'Internal Object Container', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (26, 'Interface of Components', FALSE);

-- Insert JavaScript questions
INSERT INTO question (category_id, description, is_active)
VALUES (4, 'Inside which HTML element do we put the JavaScript?', TRUE);

-- Insert choices for the JavaScript question
INSERT INTO choice (question_id, description, is_correct)
VALUES (27, 'script', TRUE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (27, 'js', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (27, 'javascript', FALSE);
INSERT INTO choice (question_id, description, is_correct)
VALUES (27, 'scripting', FALSE);

-- Insert contact messages
INSERT INTO contact (subject, message, email, time)
VALUES ('Question about Java Quiz', 'Hello, I found a possible error in question 5 of the Java quiz. The correct answer should be List, not Set. Could you please check?', 'student@example.com', '2023-05-15 14:23:45');

INSERT INTO contact (subject, message, email, time)
VALUES ('Feedback on Quiz App', 'I really enjoy using your quiz application! It has helped me a lot with my Java studies. Would it be possible to add more questions about Spring Boot in the future?', 'java_learner@gmail.com', '2023-06-02 09:45:12');

INSERT INTO contact (subject, message, email, time)
VALUES ('Technical Issue', 'I encountered a problem while taking the SQL quiz. The quiz froze at question 7 and I had to restart. Could you please look into this issue?', 'developer@outlook.com', '2023-06-10 17:30:22');

INSERT INTO contact (subject, message, email, time)
VALUES ('New Category Suggestion', 'Have you considered adding a Docker or Kubernetes category? I think many developers would find that useful for their DevOps preparation.', 'devops_engineer@company.com', '2023-06-15 11:15:34');

INSERT INTO contact (subject, message, email, time)
VALUES ('Account Problem', 'I cannot reset my password. When I click on the "forgot password" link, I do not receive any email. Please help.', 'user123@example.com', '2023-06-20 13:40:55');

INSERT INTO contact (subject, message, email, time)
VALUES ('Feature Request', 'Could you implement a scoring history feature so I can track my progress over time? That would be very helpful for my exam preparation.', 'progress_tracker@gmail.com', '2023-07-05 08:22:17');

INSERT INTO contact (subject, message, email, time)
VALUES ('Content Suggestion', 'The Spring Framework questions are excellent! Could you add a category for Design Patterns? It would complement the existing content well.', 'architecture_student@university.edu', '2023-07-12 16:05:43');
