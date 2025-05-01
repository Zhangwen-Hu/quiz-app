package com.example.quizapp.controller;

import com.example.quizapp.entity.Category;
import com.example.quizapp.entity.Choice;
import com.example.quizapp.entity.Question;
import com.example.quizapp.entity.Quiz;
import com.example.quizapp.entity.User;
import com.example.quizapp.service.CategoryService;
import com.example.quizapp.service.QuestionService;
import com.example.quizapp.service.QuizService;
import com.example.quizapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    private final UserService userService;
    private final CategoryService categoryService;
    private final QuestionService questionService;
    private final QuizService quizService;
    
    @Autowired
    public AdminController(UserService userService, CategoryService categoryService, 
                         QuestionService questionService, QuizService quizService) {
        this.userService = userService;
        this.categoryService = categoryService;
        this.questionService = questionService;
        this.quizService = quizService;
    }
    
    @GetMapping("")
    public String adminDashboard(Model model, HttpSession session) {
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("userCount", userService.count());
        model.addAttribute("questionCount", questionService.getTotalQuestionCount());
        model.addAttribute("quizCount", quizService.count());
        model.addAttribute("popularCategory", categoryService.findMostPopularCategory());
        return "admin/dashboard";
    }
    
    // User Management
    @GetMapping("/users")
    public String listUsers(@RequestParam(defaultValue = "1") int page,
                          @RequestParam(defaultValue = "5") int size,
                          Model model,
                          HttpSession session) {
        
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("users", userService.findAll(page, size));
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        
        int totalUsers = userService.getTotalUserCount();
        int totalPages = (int) Math.ceil((double) totalUsers / size);
        model.addAttribute("totalPages", totalPages);
        
        return "admin/users";
    }
    
    @PostMapping("/users/{userId}/toggle-status")
    public String toggleUserStatus(@PathVariable Integer userId, @RequestParam boolean isActive) {
        userService.updateStatus(userId, isActive);
        return "redirect:/admin/users";
    }
    
    // Category Management
    @GetMapping("/categories")
    public String listCategories(Model model, HttpSession session) {
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("newCategory", new Category());
        return "admin/categories";
    }
    
    @PostMapping("/categories/add")
    public String addCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        try {
            categoryService.save(category);
            redirectAttributes.addFlashAttribute("success", "Category added successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding category: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }
    
    @PostMapping("/categories/{categoryId}/update")
    public String updateCategory(@PathVariable Integer categoryId, 
                               @RequestParam String name,
                               RedirectAttributes redirectAttributes) {
        try {
            Category category = categoryService.findById(categoryId);
            if (category != null) {
                category.setName(name);
                categoryService.update(category);
                redirectAttributes.addFlashAttribute("success", "Category updated successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Category not found");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating category: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }
    
    // Question Management
    @GetMapping("/questions")
    public String listQuestions(@RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "5") int size,
                              Model model,
                              HttpSession session) {
        
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("questions", questionService.findAllWithChoices(page, size));
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        
        int totalQuestions = questionService.getTotalQuestionCount();
        int totalPages = (int) Math.ceil((double) totalQuestions / size);
        model.addAttribute("totalPages", totalPages);
        
        return "admin/questions";
    }
    
    @GetMapping("/questions/add")
    public String addQuestionForm(Model model, HttpSession session) {
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        model.addAttribute("question", new Question());
        model.addAttribute("categories", categoryService.findAll());
        
        // Add empty choices (always initialize with 4 choices)
        List<Choice> choices = new ArrayList<>();
        for (int i = 0; i < 4; i++) {
            choices.add(new Choice());
        }
        model.addAttribute("choices", choices);
        
        return "admin/question-form";
    }
    
    @PostMapping("/questions/add")
    public String addQuestion(@ModelAttribute Question question,
                            @RequestParam("choiceDesc") List<String> choiceDescriptions,
                            @RequestParam(value = "isCorrect", required = false) Integer correctChoiceIndex,
                            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                            @RequestParam(value = "isActive", required = true) String isActive,
                            RedirectAttributes redirectAttributes) {
        
        try {
            // Validate that a correct answer is selected
            if (correctChoiceIndex == null) {
                redirectAttributes.addFlashAttribute("error", "You must select a correct answer");
                return "redirect:/admin/questions/add";
            }
            
            // Set choices to the question
            List<Choice> choices = new ArrayList<>();
            for (int i = 0; i < choiceDescriptions.size(); i++) {
                if (choiceDescriptions.get(i) != null && !choiceDescriptions.get(i).trim().isEmpty()) {
                    Choice choice = new Choice();
                    choice.setDescription(choiceDescriptions.get(i));
                    choice.setCorrect(i == correctChoiceIndex);
                    choices.add(choice);
                }
            }
            
            // Validate we have exactly 4 choices
            if (choices.size() != 4) {
                redirectAttributes.addFlashAttribute("error", "Exactly four choices are required");
                return "redirect:/admin/questions/add";
            }
            
            // Validate that the correctChoiceIndex corresponds to a non-empty choice
            boolean correctChoiceExists = false;
            for (int i = 0; i < choiceDescriptions.size(); i++) {
                if (i == correctChoiceIndex && 
                    choiceDescriptions.get(i) != null && 
                    !choiceDescriptions.get(i).trim().isEmpty()) {
                    correctChoiceExists = true;
                    break;
                }
            }
            
            if (!correctChoiceExists) {
                redirectAttributes.addFlashAttribute("error", "The correct answer cannot be empty");
                return "redirect:/admin/questions/add";
            }
            
            question.setChoices(choices);
            question.setActive(Boolean.parseBoolean(isActive));
            
            // Save question and choices
            questionService.save(question);
            
            redirectAttributes.addFlashAttribute("success", "Question added successfully");
            return "redirect:/admin/questions?page=" + page;
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding question: " + e.getMessage());
            return "redirect:/admin/questions/add";
        }
    }
    
    @GetMapping("/questions/{questionId}/edit")
    public String editQuestionForm(@PathVariable Integer questionId, Model model, HttpSession session) {
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        Question question = questionService.findByIdWithChoices(questionId);
        if (question == null) {
            return "redirect:/admin/questions";
        }
        
        model.addAttribute("question", question);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("choices", question.getChoices());
        
        return "admin/question-form";
    }
    
    @PostMapping("/questions/{questionId}/edit")
    public String updateQuestion(@PathVariable Integer questionId,
                               @ModelAttribute Question question,
                               @RequestParam("choiceDesc") List<String> choiceDescriptions,
                               @RequestParam(value = "isCorrect", required = false) Integer correctChoiceIndex,
                               @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                               @RequestParam(value = "isActive", required = true) String isActive,
                               RedirectAttributes redirectAttributes) {
        
        try {
            // Validate that a correct answer is selected
            if (correctChoiceIndex == null) {
                redirectAttributes.addFlashAttribute("error", "You must select a correct answer");
                return "redirect:/admin/questions/" + questionId + "/edit";
            }
            
            // Set updated choices to the question
            List<Choice> choices = new ArrayList<>();
            for (int i = 0; i < choiceDescriptions.size(); i++) {
                if (choiceDescriptions.get(i) != null && !choiceDescriptions.get(i).trim().isEmpty()) {
                    Choice choice = new Choice();
                    choice.setDescription(choiceDescriptions.get(i));
                    choice.setCorrect(i == correctChoiceIndex);
                    choices.add(choice);
                }
            }
            
            // Validate we have exactly 4 choices
            if (choices.size() != 4) {
                redirectAttributes.addFlashAttribute("error", "Exactly four choices are required");
                return "redirect:/admin/questions/" + questionId + "/edit";
            }
            
            // Validate that the correctChoiceIndex corresponds to a non-empty choice
            boolean correctChoiceExists = false;
            for (int i = 0; i < choiceDescriptions.size(); i++) {
                if (i == correctChoiceIndex && 
                    choiceDescriptions.get(i) != null && 
                    !choiceDescriptions.get(i).trim().isEmpty()) {
                    correctChoiceExists = true;
                    break;
                }
            }
            
            if (!correctChoiceExists) {
                redirectAttributes.addFlashAttribute("error", "The correct answer cannot be empty");
                return "redirect:/admin/questions/" + questionId + "/edit";
            }
            
            question.setQuestionId(questionId);
            question.setChoices(choices);
            
            // Set the active status explicitly based on the isActive parameter
            question.setActive(Boolean.parseBoolean(isActive));
            
            // Update question and choices
            questionService.update(question);
            
            redirectAttributes.addFlashAttribute("success", "Question updated successfully");
            return "redirect:/admin/questions?page=" + page;
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating question: " + e.getMessage());
            return "redirect:/admin/questions/" + questionId + "/edit";
        }
    }
    
    @PostMapping("/questions/{questionId}/toggle-status")
    public String toggleQuestionStatus(@PathVariable Integer questionId, 
                                      @RequestParam boolean isActive,
                                      @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
        questionService.updateStatus(questionId, isActive);
        return "redirect:/admin/questions?page=" + page;
    }
    
    // Quiz Management
    @GetMapping("/quizzes")
    public String listQuizzes(@RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "5") int size,
                            @RequestParam(required = false) Integer categoryId,
                            @RequestParam(required = false) Integer userId,
                            @RequestParam(required = false, defaultValue = "time_start") String sortBy,
                            @RequestParam(required = false, defaultValue = "desc") String sortDir,
                            Model model,
                            HttpSession session) {
        
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        // Get all categories for the filter dropdown
        model.addAttribute("categories", categoryService.findAll());
        
        // Get all users for the filter dropdown
        model.addAttribute("usersList", userService.findAll(1, 1000));
        
        // Apply filters and get filtered quizzes with sorting
        model.addAttribute("quizzes", quizService.findByCriteria(categoryId, userId, page, size, sortBy, sortDir));
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("selectedCategory", categoryId);
        model.addAttribute("selectedUser", userId);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" : "asc");
        
        // Count total filtered quizzes for pagination
        int totalQuizzes = quizService.countByCriteria(categoryId, userId);
        int totalPages = (int) Math.ceil((double) totalQuizzes / size);
        model.addAttribute("totalPages", totalPages);
        
        return "admin/quizzes";
    }
    
    @GetMapping("/quizzes/{quizId}")
    public String viewQuiz(@PathVariable Integer quizId, 
                         @RequestParam(required = false) Integer returnPage,
                         @RequestParam(required = false) Integer categoryId,
                         @RequestParam(required = false) Integer userId,
                         @RequestParam(required = false, defaultValue = "time_start") String sortBy,
                         @RequestParam(required = false, defaultValue = "desc") String sortDir,
                         Model model, 
                         HttpSession session) {
        // Check if admin has an active quiz
        User user = (User) session.getAttribute("user");
        if (user != null) {
            boolean hasActiveQuiz = quizService.findActiveQuizByUserId(user.getUserId()) != null;
            model.addAttribute("hasActiveQuiz", hasActiveQuiz);
            
            // If admin has an active quiz, redirect to the active quiz page
            if (hasActiveQuiz) {
                return "redirect:/quiz/active";
            }
        }
        
        Quiz quiz = quizService.findByIdWithDetails(quizId);
        if (quiz == null) {
            return "redirect:/admin/quizzes";
        }
        
        model.addAttribute("quiz", quiz);
        // Add the return parameters to the model for the back button
        model.addAttribute("returnPage", returnPage);
        model.addAttribute("returnCategoryId", categoryId);
        model.addAttribute("returnUserId", userId);
        model.addAttribute("returnSortBy", sortBy);
        model.addAttribute("returnSortDir", sortDir);
        
        return "admin/quiz-details";
    }
} 