package com.example.quizapp.service;

import com.example.quizapp.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LoginService {
    private final UserService userService;

    @Autowired
    public LoginService(UserService userService) {this.userService = userService; }

    public Optional<User> validateLogin(String username, String password) {
        User user = userService.findByEmail(username);
        if (user != null && userService.validateUser(username, password)) {
            return Optional.of(user);
        }
        return Optional.empty();
    }
} 