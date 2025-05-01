package com.example.quizapp.dao;

import com.example.quizapp.entity.Choice;

import java.util.List;

public interface ChoiceDao {
    Choice findById(Integer id);
    List<Choice> findByQuestionId(Integer questionId);
    void save(Choice choice);
    void update(Choice choice);
    void deleteByQuestionId(Integer questionId);
} 