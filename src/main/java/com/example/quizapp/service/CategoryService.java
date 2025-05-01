package com.example.quizapp.service;

import com.example.quizapp.entity.Category;

import java.util.List;

public interface CategoryService {
    Category findById(Integer id);
    List<Category> findAll();
    void save(Category category);
    void update(Category category);
    String findMostPopularCategory();
} 