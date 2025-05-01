package com.example.quizapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ErrorController implements org.springframework.boot.web.servlet.error.ErrorController {

    @GetMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        
        if (statusCode != null) {
            if (statusCode == 403) {
                model.addAttribute("errorMessage", "You don't have permission to access this resource");
                return "error-403";
            } else if (statusCode == 404) {
                return "redirect:/";
            } else if (statusCode == 500) {
                return "redirect:/";
            }
        }
        
        return "redirect:/";
    }

    @GetMapping("/access-denied")
    public String accessDenied(Model model) {
        model.addAttribute("errorMessage", "You don't have permission to access this resource");
        return "error-403";
    }
} 