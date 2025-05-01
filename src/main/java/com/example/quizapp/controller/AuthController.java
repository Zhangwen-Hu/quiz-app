package com.example.quizapp.controller;

import com.example.quizapp.entity.User;
import com.example.quizapp.service.QuizService;
import com.example.quizapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    
    private final UserService userService;
    private final QuizService quizService;
    
    @Autowired
    public AuthController(UserService userService, QuizService quizService) {
        this.userService = userService;
        this.quizService = quizService;
    }
    
    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid email or password");
        }
        return "login";
    }
    
    @PostMapping("/authenticate")
    public String authenticate(@RequestParam String email, 
                              @RequestParam String password,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        if (userService.validateUser(email, password)) {
            User user = userService.findByEmail(email);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("isAdmin", user.isAdmin());
            
            // Check if the user has an active quiz
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            
            // If user has an active quiz, redirect directly to it
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
            
            // If user is admin, redirect to admin dashboard
            if (user.isAdmin()) {
                return "redirect:/admin";
            }
            
            return "redirect:/";
        } else {
            redirectAttributes.addAttribute("error", "true");
            return "redirect:/login";
        }
    }
    
    @GetMapping("/register")
    public String registerPage(Model model, HttpSession session) {
        // Check if user has an active quiz before showing register page
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            
            // If user has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("user", new User());
        return "register";
    }
    
    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, 
                              RedirectAttributes redirectAttributes) {
        
        // Check if email already exists
        if (userService.findByEmail(user.getEmail()) != null) {
            redirectAttributes.addFlashAttribute("error", "Email already registered");
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/register";
        }
        
        // Set default values
        user.setActive(true);
        user.setAdmin(false);
        
        userService.save(user);
        redirectAttributes.addFlashAttribute("success", "Registration successful. Please log in.");
        
        return "redirect:/login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        // Check if user has an active quiz before logout
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            
            // If user has an active quiz, show warning and don't logout
            if (hasActiveQuiz) {
                redirectAttributes.addFlashAttribute("warning", "Please finish your active quiz before logging out.");
                return "redirect:/quiz/active";
            }
        }
        
        session.invalidate();
        return "redirect:/login";
    }
} 