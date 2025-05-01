package com.example.quizapp.service;

import com.example.quizapp.dao.*;
import com.example.quizapp.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class QuizServiceImpl implements QuizService {
    
    private final QuizDao quizDao;
    private final QuizQuestionDao quizQuestionDao;
    private final QuestionDao questionDao;
    private final ChoiceDao choiceDao;
    private final CategoryDao categoryDao;
    private final UserDao userDao;

    @Autowired
    public QuizServiceImpl(QuizDao quizDao, QuizQuestionDao quizQuestionDao, 
                          QuestionDao questionDao, ChoiceDao choiceDao, 
                          CategoryDao categoryDao, UserDao userDao) {
        this.quizDao = quizDao;
        this.quizQuestionDao = quizQuestionDao;
        this.questionDao = questionDao;
        this.choiceDao = choiceDao;
        this.categoryDao = categoryDao;
        this.userDao = userDao;
    }

    @Override
    public Quiz findById(Integer id) {
        return quizDao.findById(id);
    }

    @Override
    public Quiz findByIdWithDetails(Integer id) {
        Quiz quiz = quizDao.findById(id);
        if (quiz != null) {
            loadQuizDetails(quiz);
        }
        return quiz;
    }

    @Override
    public Quiz findActiveQuizByUserId(Integer userId) {
        return quizDao.findActiveQuizByUserId(userId);
    }

    @Override
    public Quiz findActiveQuizByUserIdWithDetails(Integer userId) {
        Quiz quiz = quizDao.findActiveQuizByUserId(userId);
        if (quiz != null) {
            loadQuizDetails(quiz);
        }
        return quiz;
    }

    @Override
    public List<Quiz> findByUserId(Integer userId, int limit) {
        return quizDao.findByUserId(userId, limit);
    }

    @Override
    public List<Quiz> findAll(int page, int size) {
        int offset = (page - 1) * size;
        return quizDao.findAll(size, offset);
    }

    @Override
    public List<Quiz> findByCriteria(Integer categoryId, Integer userId, int page, int size) {
        int offset = (page - 1) * size;
        return quizDao.findByCriteria(categoryId, userId, size, offset);
    }

    @Override
    public List<Quiz> findByCriteria(Integer categoryId, Integer userId, int page, int size, String sortBy, String sortDir) {
        int offset = (page - 1) * size;
        return quizDao.findByCriteria(categoryId, userId, size, offset, sortBy, sortDir);
    }

    @Override
    public Integer count() {
        return quizDao.count();
    }

    @Override
    public Integer countByCriteria(Integer categoryId, Integer userId) {
        return quizDao.countByCriteria(categoryId, userId);
    }

    @Override
    public void save(Quiz quiz) {
        // Set start time if not set
        if (quiz.getTimeStart() == null) {
            quiz.setTimeStart(LocalDateTime.now());
        }
        
        quizDao.save(quiz);
        
        // Save quiz questions if available
        if (quiz.getQuizQuestions() != null && !quiz.getQuizQuestions().isEmpty()) {
            for (QuizQuestion quizQuestion : quiz.getQuizQuestions()) {
                quizQuestion.setQuizId(quiz.getQuizId());
                quizQuestionDao.save(quizQuestion);
            }
        }
    }

    @Override
    public void update(Quiz quiz) {
        quizDao.update(quiz);
    }

    @Override
    public void saveQuizQuestion(QuizQuestion quizQuestion) {
        quizQuestionDao.save(quizQuestion);
    }

    @Override
    public void updateQuizQuestion(QuizQuestion quizQuestion) {
        quizQuestionDao.update(quizQuestion);
    }

    @Override
    public QuizQuestion findQuizQuestionById(Integer id) {
        QuizQuestion quizQuestion = quizQuestionDao.findById(id);
        if (quizQuestion != null) {
            loadQuizQuestionDetails(quizQuestion);
        }
        return quizQuestion;
    }

    @Override
    public List<QuizQuestion> findQuizQuestionsByQuizId(Integer quizId) {
        List<QuizQuestion> quizQuestions = quizQuestionDao.findByQuizId(quizId);
        quizQuestions.forEach(this::loadQuizQuestionDetails);
        return quizQuestions;
    }

    @Override
    public boolean updateQuizQuestionChoice(Integer qqId, Integer choiceId) {
        try {
            quizQuestionDao.updateUserChoice(qqId, choiceId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    private void loadQuizDetails(Quiz quiz) {
        // Load user
        User user = userDao.findById(quiz.getUserId());
        quiz.setUser(user);
        
        // Load category
        Category category = categoryDao.findById(quiz.getCategoryId());
        quiz.setCategory(category);
        
        // Load quiz questions
        List<QuizQuestion> quizQuestions = quizQuestionDao.findByQuizId(quiz.getQuizId());
        quizQuestions.forEach(this::loadQuizQuestionDetails);
        quiz.setQuizQuestions(quizQuestions);
        
        // Calculate score
        if (quiz.isFinished()) {
            int total = quizQuestions.size();
            int correct = 0;
            
            for (QuizQuestion qq : quizQuestions) {
                if (qq.getUserChoiceId() != null) {
                    Choice userChoice = choiceDao.findById(qq.getUserChoiceId());
                    if (userChoice != null && userChoice.isCorrect()) {
                        correct++;
                    }
                }
            }
            
            quiz.setTotalCount(total);
            quiz.setCorrectCount(correct);
        }
    }
    
    private void loadQuizQuestionDetails(QuizQuestion quizQuestion) {
        // Load question with choices
        Question question = questionDao.findById(quizQuestion.getQuestionId());
        if (question != null) {
            List<Choice> choices = choiceDao.findByQuestionId(question.getQuestionId());
            question.setChoices(choices);
            
            Category category = categoryDao.findById(question.getCategoryId());
            question.setCategory(category);
            
            quizQuestion.setQuestion(question);
        }
        
        // Load user choice if any
        if (quizQuestion.getUserChoiceId() != null) {
            Choice userChoice = choiceDao.findById(quizQuestion.getUserChoiceId());
            quizQuestion.setUserChoice(userChoice);
        }
    }
} 