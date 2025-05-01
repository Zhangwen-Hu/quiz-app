package com.example.quizapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuizQuestion {
    private Integer qqId;
    private Integer quizId;
    private Integer questionId;
    private Integer userChoiceId;
    
    // Transient properties (not in DB)
    private Question question;
    private Choice userChoice;
} 