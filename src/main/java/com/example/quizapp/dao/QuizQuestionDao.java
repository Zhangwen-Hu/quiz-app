package com.example.quizapp.dao;

import com.example.quizapp.entity.QuizQuestion;

import java.util.List;

public interface QuizQuestionDao {
    QuizQuestion findById(Integer id);
    List<QuizQuestion> findByQuizId(Integer quizId);
    void save(QuizQuestion quizQuestion);
    void update(QuizQuestion quizQuestion);
    void updateUserChoice(Integer qqId, Integer userChoiceId);
} 