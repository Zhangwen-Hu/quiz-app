package com.example.quizapp.service;

import com.example.quizapp.entity.Question;

import java.util.List;

public interface QuestionService {
    Question findById(Integer id);
    Question findByIdWithChoices(Integer id);
    List<Question> findAll(int page, int size);
    List<Question> findAllWithChoices(int page, int size);
    List<Question> findByCategoryId(Integer categoryId);
    List<Question> findByCategoryIdWithChoices(Integer categoryId);
    List<Question> findRandomQuestionsByCategoryWithChoices(Integer categoryId, int count);
    Integer getTotalQuestionCount();
    void save(Question question);
    void update(Question question);
    boolean updateStatus(Integer questionId, boolean isActive);
} 