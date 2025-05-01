package com.example.quizapp.service;

import com.example.quizapp.dao.UserDao;
import com.example.quizapp.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    
    private final UserDao userDao;

    @Autowired
    public UserServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public User findById(Integer id) {
        return userDao.findById(id);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public List<User> findAll(int page, int size) {
        int offset = (page - 1) * size;
        return userDao.findAll(size, offset);
    }

    @Override
    public Integer getTotalUserCount() {
        return userDao.getTotalUserCount();
    }

    @Override
    public void save(User user) {
        userDao.save(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public boolean updateStatus(Integer userId, boolean isActive) {
        return userDao.updateStatus(userId, isActive);
    }

    @Override
    public boolean validateUser(String email, String password) {
        User user = userDao.findByEmail(email);
        return user != null && user.getPassword().equals(password) && user.isActive();
    }

    @Override
    public Integer count() {
        return userDao.count();
    }
} 