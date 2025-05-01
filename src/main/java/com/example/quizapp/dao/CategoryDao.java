package com.example.quizapp.dao;

import com.example.quizapp.entity.Category;

import java.util.List;

public interface CategoryDao {
    Category findById(Integer id);
    List<Category> findAll();
    void save(Category category);
    void update(Category category);
    String findMostPopularCategory();
} 