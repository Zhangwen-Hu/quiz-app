package com.example.quizapp.service;

import com.example.quizapp.entity.User;

import java.util.List;

public interface UserService {
    User findById(Integer id);
    User findByEmail(String email);
    List<User> findAll(int page, int size);
    Integer getTotalUserCount();
    void save(User user);
    void update(User user);
    boolean updateStatus(Integer userId, boolean isActive);
    boolean validateUser(String email, String password);
    Integer count();
} 