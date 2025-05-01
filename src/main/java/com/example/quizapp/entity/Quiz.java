package com.example.quizapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Quiz {
    private Integer quizId;
    private Integer userId;
    private Integer categoryId;
    private String name;
    private LocalDateTime timeStart;
    private LocalDateTime timeEnd;
    
    // Transient properties (not in DB)
    private User user;
    private Category category;
    private List<QuizQuestion> quizQuestions;
    private boolean finished;
    private int correctCount;
    private int totalCount;
    
    // Additional display properties for admin pages
    private String userName;
    private String categoryName;
} 