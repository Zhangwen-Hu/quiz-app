package com.example.quizapp.controller;

import com.example.quizapp.entity.User;
import com.example.quizapp.service.CategoryService;
import com.example.quizapp.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {
    
    private final CategoryService categoryService;
    private final QuizService quizService;
    
    @Autowired
    public HomeController(CategoryService categoryService, QuizService quizService) {
        this.categoryService = categoryService;
        this.quizService = quizService;
    }
    
    @GetMapping("/")
    public String home(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "10") int size,
                       Model model, 
                       HttpSession session) {
        // Add categories for select box
        model.addAttribute("categories", categoryService.findAll());
        
        // Add quiz history if user is logged in
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("quizHistory", quizService.findByCriteria(null, user.getUserId(), page, size));
            model.addAttribute("currentPage", page);
            model.addAttribute("pageSize", size);
            
            // Add total quiz count for pagination display
            int totalQuizCount = quizService.countByCriteria(null, user.getUserId());
            model.addAttribute("quizHistoryCount", totalQuizCount);
            
            int totalPages = (int) Math.ceil((double) totalQuizCount / size);
            model.addAttribute("totalPages", totalPages);
            
            // Check if user has an active quiz
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If user has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        return "index";
    }
} 