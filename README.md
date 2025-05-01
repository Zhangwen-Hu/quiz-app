# Quiz Application

A web-based quiz platform built with Spring Boot that allows users to take quizzes on various categories and track their performance.

## Screenshots

<img width="1512" alt="1" src="https://github.com/user-attachments/assets/cced164f-deb5-4232-8ca3-6d48897361b9" />
<img width="1512" alt="2" src="https://github.com/user-attachments/assets/2fa15e69-3f25-4498-83ca-ba51e1459df1" />
<img width="1512" alt="3" src="https://github.com/user-attachments/assets/25b66f31-e450-42ab-b5f3-dfb68c1515e0" />
<img width="1512" alt="4" src="https://github.com/user-attachments/assets/5efa17cc-5c7a-4de0-bbd8-ac3e736a9859" />
<img width="1512" alt="5" src="https://github.com/user-attachments/assets/a4396b58-409b-4a17-8f9b-1c273c724093" />
<img width="1512" alt="6" src="https://github.com/user-attachments/assets/714d043f-ea42-4956-9ae3-ce19fd1c88b1" />

## Features

### User Features
- User registration and authentication
- Browse available quiz categories
- Take quizzes with multiple-choice questions
- View quiz results and performance statistics
- Track quiz history

### Admin Features
- Dashboard with system statistics
- User management (activate/deactivate users)
- Category management
- Question management (add, edit, delete)
- Quiz management and monitoring
- Performance analytics

## Technology Stack

- **Backend**: Java 8, Spring Boot 2.6.7
- **Database**: MySQL
- **Frontend**: JSP, Bootstrap, JavaScript
- **Build Tool**: Maven

## Setup & Installation

### Prerequisites
- Java 8 or higher
- MySQL
- Maven

### Configuration
1. Clone the repository:
   ```
   git clone https://github.com/Zhangwen-Hu/quiz-app.git
   cd quiz-app
   ```

2. Configure the database in `src/main/resources/application.properties`:
   ```
   spring.datasource.url=jdbc:mysql://localhost:3306/quiz_app?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

3. Build the application:
   ```
   mvn clean install
   ```

4. Run the application:
   ```
   mvn spring-boot:run
   ```
   
5. Access the application at `http://localhost:8080`

## Database Schema

The application uses the following main entities:
- Users (user accounts and authentication)
- Categories (quiz categories)
- Questions (quiz questions with multiple choices)
- Quizzes (quiz instances taken by users)
- Quiz Questions (questions within a specific quiz)

## Usage

### User Flow
1. Register for an account or log in
2. Browse available quiz categories
3. Start a new quiz
4. Answer questions and submit answers
5. View quiz results and performance

### Admin Flow
1. Log in with admin credentials
2. Access the admin dashboard
3. Manage users, categories, questions, and quizzes
4. Monitor system performance

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 
