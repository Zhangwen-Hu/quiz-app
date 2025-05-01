package com.example.quizapp.service;

import com.example.quizapp.entity.Quiz;
import com.example.quizapp.entity.QuizQuestion;

import java.util.List;

public interface QuizService {
    Quiz findById(Integer id);
    Quiz findByIdWithDetails(Integer id);
    Quiz findActiveQuizByUserId(Integer userId);
    Quiz findActiveQuizByUserIdWithDetails(Integer userId);
    List<Quiz> findByUserId(Integer userId, int limit);
    List<Quiz> findAll(int page, int size);
    List<Quiz> findByCriteria(Integer categoryId, Integer userId, int page, int size);
    List<Quiz> findByCriteria(Integer categoryId, Integer userId, int page, int size, String sortBy, String sortDir);
    Integer count();
    Integer countByCriteria(Integer categoryId, Integer userId);
    void save(Quiz quiz);
    void update(Quiz quiz);
    void saveQuizQuestion(QuizQuestion quizQuestion);
    void updateQuizQuestion(QuizQuestion quizQuestion);
    QuizQuestion findQuizQuestionById(Integer id);
    List<QuizQuestion> findQuizQuestionsByQuizId(Integer quizId);
    boolean updateQuizQuestionChoice(Integer qqId, Integer choiceId);
} 