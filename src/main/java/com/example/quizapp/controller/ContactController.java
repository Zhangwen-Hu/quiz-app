package com.example.quizapp.controller;

import com.example.quizapp.entity.Contact;
import com.example.quizapp.entity.User;
import com.example.quizapp.service.ContactService;
import com.example.quizapp.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;

@Controller
public class ContactController {
    
    private final ContactService contactService;
    private final QuizService quizService;
    
    @Autowired
    public ContactController(ContactService contactService, QuizService quizService) {
        this.contactService = contactService;
        this.quizService = quizService;
    }
    
    @GetMapping("/contact")
    public String contactPage(Model model, HttpSession session) {
        // Check if user has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If user has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("contact", new Contact());
        return "contact";
    }
    
    @PostMapping("/contact")
    public String submitContact(@ModelAttribute Contact contact, 
                               RedirectAttributes redirectAttributes) {
        
        // Set the current time
        contact.setTime(LocalDateTime.now());
        
        contactService.save(contact);
        redirectAttributes.addFlashAttribute("success", "Message sent successfully. We'll get back to you soon!");
        
        return "redirect:/contact";
    }
    
    @GetMapping("/admin/contacts")
    public String viewContacts(@RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "10") int size,
                              Model model,
                              HttpSession session) {
        
        // Check if admin user has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("contacts", contactService.findAll(page, size));
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        
        int totalContacts = contactService.count();
        int totalPages = (int) Math.ceil((double) totalContacts / size);
        model.addAttribute("totalPages", totalPages);
        
        return "admin/contacts";
    }
} 