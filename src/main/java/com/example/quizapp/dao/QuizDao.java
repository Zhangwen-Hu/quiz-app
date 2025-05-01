package com.example.quizapp.dao;

import com.example.quizapp.entity.Quiz;

import java.util.List;

public interface QuizDao {
    Quiz findById(Integer id);
    Quiz findActiveQuizByUserId(Integer userId);
    List<Quiz> findByUserId(Integer userId, int limit);
    List<Quiz> findAll(int limit, int offset);
    List<Quiz> findByCriteria(Integer categoryId, Integer userId, int limit, int offset);
    List<Quiz> findByCriteria(Integer categoryId, Integer userId, int limit, int offset, String sortBy, String sortDir);
    Integer count();
    Integer countByCriteria(Integer categoryId, Integer userId);
    void save(Quiz quiz);
    void update(Quiz quiz);
} 