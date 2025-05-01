package com.example.quizapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Choice {
    private Integer choiceId;
    private Integer questionId;
    private String description;
    private boolean isCorrect;
} 