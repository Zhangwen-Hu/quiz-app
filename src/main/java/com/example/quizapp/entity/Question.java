package com.example.quizapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Question {
    private Integer questionId;
    private Integer categoryId;
    private String description;
    private boolean active;
    
    // Transient properties (not in DB)
    private List<Choice> choices;
    private Category category;
} 