package com.example.quizapp.dao;

import com.example.quizapp.entity.Question;

import java.util.List;

public interface QuestionDao {
    Question findById(Integer id);
    List<Question> findAll(int limit, int offset);
    List<Question> findByCategoryId(Integer categoryId);
    List<Question> findRandomQuestionsByCategory(Integer categoryId, int count);
    Integer getTotalQuestionCount();
    void save(Question question);
    void update(Question question);
    boolean updateStatus(Integer questionId, boolean isActive);
} 