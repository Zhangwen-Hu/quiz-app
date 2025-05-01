package com.example.quizapp.service;

import com.example.quizapp.dao.CategoryDao;
import com.example.quizapp.dao.ChoiceDao;
import com.example.quizapp.dao.QuestionDao;
import com.example.quizapp.entity.Category;
import com.example.quizapp.entity.Choice;
import com.example.quizapp.entity.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {
    
    private final QuestionDao questionDao;
    private final ChoiceDao choiceDao;
    private final CategoryDao categoryDao;

    @Autowired
    public QuestionServiceImpl(QuestionDao questionDao, ChoiceDao choiceDao, CategoryDao categoryDao) {
        this.questionDao = questionDao;
        this.choiceDao = choiceDao;
        this.categoryDao = categoryDao;
    }

    @Override
    public Question findById(Integer id) {
        return questionDao.findById(id);
    }

    @Override
    public Question findByIdWithChoices(Integer id) {
        Question question = questionDao.findById(id);
        if (question != null) {
            loadChoicesAndCategory(question);
        }
        return question;
    }

    @Override
    public List<Question> findAll(int page, int size) {
        int offset = (page - 1) * size;
        return questionDao.findAll(size, offset);
    }

    @Override
    public List<Question> findAllWithChoices(int page, int size) {
        List<Question> questions = findAll(page, size);
        questions.forEach(this::loadChoicesAndCategory);
        return questions;
    }

    @Override
    public List<Question> findByCategoryId(Integer categoryId) {
        return questionDao.findByCategoryId(categoryId);
    }

    @Override
    public List<Question> findByCategoryIdWithChoices(Integer categoryId) {
        List<Question> questions = findByCategoryId(categoryId);
        questions.forEach(this::loadChoicesAndCategory);
        return questions;
    }

    @Override
    public List<Question> findRandomQuestionsByCategoryWithChoices(Integer categoryId, int count) {
        List<Question> questions = questionDao.findRandomQuestionsByCategory(categoryId, count);
        questions.forEach(this::loadChoicesAndCategory);
        return questions;
    }

    @Override
    public Integer getTotalQuestionCount() {
        return questionDao.getTotalQuestionCount();
    }

    @Override
    public void save(Question question) {
        // Save the question first
        questionDao.save(question);
        
        // Then save the choices
        if (question.getChoices() != null) {
            for (Choice choice : question.getChoices()) {
                choice.setQuestionId(question.getQuestionId());
                choiceDao.save(choice);
            }
        }
    }

    @Override
    public void update(Question question) {
        // Update the question
        questionDao.update(question);
        
        // Delete existing choices and add new ones
        if (question.getChoices() != null) {
            choiceDao.deleteByQuestionId(question.getQuestionId());
            for (Choice choice : question.getChoices()) {
                choice.setQuestionId(question.getQuestionId());
                choiceDao.save(choice);
            }
        }
    }

    @Override
    public boolean updateStatus(Integer questionId, boolean isActive) {
        return questionDao.updateStatus(questionId, isActive);
    }
    
    private void loadChoicesAndCategory(Question question) {
        // Load choices
        List<Choice> choices = choiceDao.findByQuestionId(question.getQuestionId());
        question.setChoices(choices);
        
        // Load category
        Category category = categoryDao.findById(question.getCategoryId());
        question.setCategory(category);
    }
} 