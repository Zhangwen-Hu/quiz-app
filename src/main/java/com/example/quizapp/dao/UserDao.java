package com.example.quizapp.dao;

import com.example.quizapp.entity.User;

import java.util.List;

public interface UserDao {
    User findById(Integer id);
    User findByEmail(String email);
    List<User> findAll(int limit, int offset);
    Integer getTotalUserCount();
    void save(User user);
    void update(User user);
    boolean updateStatus(Integer userId, boolean isActive);
    Integer count();
} 