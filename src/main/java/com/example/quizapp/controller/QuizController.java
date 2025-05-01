package com.example.quizapp.controller;

import com.example.quizapp.entity.Quiz;
import com.example.quizapp.entity.QuizQuestion;
import com.example.quizapp.service.CategoryService;
import com.example.quizapp.service.QuestionService;
import com.example.quizapp.service.QuizService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/quiz")
public class QuizController {
    
    private final QuizService quizService;
    private final CategoryService categoryService;
    private final QuestionService questionService;
    
    @Autowired
    public QuizController(QuizService quizService, CategoryService categoryService, QuestionService questionService) {
        this.quizService = quizService;
        this.categoryService = categoryService;
        this.questionService = questionService;
    }
    
    @GetMapping("/start")
    public String startQuiz(@RequestParam Integer categoryId,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        // Check if user already has an active quiz
        Quiz activeQuiz = quizService.findActiveQuizByUserId(userId);
        if (activeQuiz != null) {
            redirectAttributes.addFlashAttribute("warning", "You already have an active quiz. Please finish it first.");
            return "redirect:/quiz/active";
        }
        
        // Check if the category has at least 3 questions
        List<QuizQuestion> quizQuestions = questionService.findRandomQuestionsByCategoryWithChoices(categoryId, 3)
                .stream()
                .map(question -> {
                    QuizQuestion qq = new QuizQuestion();
                    qq.setQuestionId(question.getQuestionId());
                    qq.setQuestion(question);
                    return qq;
                })
                .collect(Collectors.toList());
        
        if (quizQuestions.size() < 3) {
            redirectAttributes.addFlashAttribute("error", "Not enough questions available for this category. Please select another category.");
            return "redirect:/";
        }
        
        // Create new quiz
        Quiz quiz = new Quiz();
        quiz.setUserId(userId);
        quiz.setCategoryId(categoryId);
        quiz.setName(categoryService.findById(categoryId).getName() + " Quiz");
        quiz.setTimeStart(LocalDateTime.now());
        
        quiz.setQuizQuestions(quizQuestions);
        
        // Save quiz
        quizService.save(quiz);
        
        // Redirect to the first question
        return "redirect:/quiz/question/1";
    }
    
    @GetMapping("/active")
    public String activeQuiz(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        Quiz activeQuiz = quizService.findActiveQuizByUserIdWithDetails(userId);
        if (activeQuiz == null) {
            model.addAttribute("error", "You don't have any active quiz");
            return "quiz-not-found";
        }
        
        // Redirect to the first question
        return "redirect:/quiz/question/1";
    }
    
    @GetMapping("/question/{questionNumber}")
    public String showQuestion(@PathVariable int questionNumber, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        Quiz activeQuiz = quizService.findActiveQuizByUserIdWithDetails(userId);
        if (activeQuiz == null) {
            model.addAttribute("error", "You don't have any active quiz");
            return "quiz-not-found";
        }
        
        // Validate question number
        int totalQuestions = activeQuiz.getQuizQuestions().size();
        if (questionNumber < 1 || questionNumber > totalQuestions) {
            return "redirect:/quiz/question/1";
        }
        
        // Get the current question (subtract 1 because list is 0-indexed)
        QuizQuestion currentQuestion = activeQuiz.getQuizQuestions().get(questionNumber - 1);
        
        model.addAttribute("quiz", activeQuiz);
        model.addAttribute("currentQuestion", currentQuestion);
        model.addAttribute("questionNumber", questionNumber);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("hasActiveQuiz", true);
        
        return "quiz-question";
    }
    
    @PostMapping("/save-answer")
    public String saveAnswer(@RequestParam Integer qqId,
                            @RequestParam(required = false) Integer choiceId,
                            @RequestParam int questionNumber,
                            @RequestParam(required = false) String action,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        // Get active quiz
        Quiz activeQuiz = quizService.findActiveQuizByUserIdWithDetails(userId);
        if (activeQuiz == null) {
            redirectAttributes.addFlashAttribute("error", "No active quiz found");
            return "redirect:/";
        }
        
        int totalQuestions = activeQuiz.getQuizQuestions().size();
        
        // Save the current answer if selected
        if (choiceId != null) {
            boolean updated = quizService.updateQuizQuestionChoice(qqId, choiceId);
            if (!updated) {
                redirectAttributes.addFlashAttribute("error", "Failed to save answer");
            }
        }
        
        // Handle action
        if ("submit".equals(action)) {
            // Submit the entire quiz
            activeQuiz.setTimeEnd(LocalDateTime.now());
            quizService.update(activeQuiz);
            return "redirect:/quiz/result/" + activeQuiz.getQuizId();
        } else if ("next".equals(action) && questionNumber < totalQuestions) {
            // Go to next question
            return "redirect:/quiz/question/" + (questionNumber + 1);
        } else if ("prev".equals(action) && questionNumber > 1) {
            // Go to previous question
            return "redirect:/quiz/question/" + (questionNumber - 1);
        }
        
        // Default: stay on the same question
        return "redirect:/quiz/question/" + questionNumber;
    }
    
    @PostMapping("/submit-answer")
    public String submitAnswer(@RequestParam Integer qqId,
                              @RequestParam Integer choiceId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        // Update quiz question with user's choice
        boolean updated = quizService.updateQuizQuestionChoice(qqId, choiceId);
        
        if (!updated) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit answer");
        }
        
        return "redirect:/quiz/active";
    }
    
    @PostMapping("/finish")
    public String finishQuiz(HttpSession session, RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        Quiz activeQuiz = quizService.findActiveQuizByUserId(userId);
        if (activeQuiz == null) {
            redirectAttributes.addFlashAttribute("error", "No active quiz found");
            return "redirect:/";
        }
        
        // Update end time
        activeQuiz.setTimeEnd(LocalDateTime.now());
        quizService.update(activeQuiz);
        
        return "redirect:/quiz/result/" + activeQuiz.getQuizId();
    }
    
    @GetMapping("/result/{quizId}")
    public String quizResult(@PathVariable Integer quizId, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        Quiz quiz = quizService.findByIdWithDetails(quizId);
        if (quiz == null) {
            model.addAttribute("error", "Quiz not found");
            return "quiz-not-found";
        }
        
        // Check if the user is trying to view another user's quiz results
        if (!quiz.getUserId().equals(userId)) {
            return "redirect:/access-denied";
        }
        
        // Check if user has an active quiz
        boolean hasActiveQuiz = quizService.findActiveQuizByUserId(userId) != null;
        model.addAttribute("hasActiveQuiz", hasActiveQuiz);
        
        if (!quiz.isFinished()) {
            return "redirect:/quiz/active";
        }
        
        model.addAttribute("quiz", quiz);
        return "quiz-result";
    }
    
    @GetMapping("/history")
    public String quizHistory(@RequestParam(defaultValue = "1") int page,
                             @RequestParam(defaultValue = "10") int size,
                             Model model,
                             HttpSession session) {
        // Redirect to home page which now contains quiz history
        return "redirect:/?page=" + page + "&size=" + size;
    }
    
    @PostMapping("/submit-all-answers")
    public String submitAllAnswers(HttpServletRequest request,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        // Get active quiz and its questions
        Quiz activeQuiz = quizService.findActiveQuizByUserIdWithDetails(userId);
        if (activeQuiz == null) {
            redirectAttributes.addFlashAttribute("error", "No active quiz found");
            return "redirect:/";
        }
        
        boolean allUpdated = true;
        int answeredCount = 0;
        
        // For each question, get the selected choice
        for (QuizQuestion qq : activeQuiz.getQuizQuestions()) {
            Integer qqId = qq.getQqId();
            String paramName = "choiceIds_" + qqId;
            String choiceIdStr = request.getParameter(paramName);
            
            if (choiceIdStr != null && !choiceIdStr.isEmpty()) {
                Integer choiceId = Integer.parseInt(choiceIdStr);
                boolean updated = quizService.updateQuizQuestionChoice(qqId, choiceId);
                if (updated) {
                    answeredCount++;
                } else {
                    allUpdated = false;
                }
            }
        }
        
        // Check if all questions were answered
        int totalQuestions = activeQuiz.getQuizQuestions().size();
        if (answeredCount < totalQuestions) {
            redirectAttributes.addFlashAttribute("warning", 
                "You've only answered " + answeredCount + " out of " + totalQuestions + " questions. Your quiz has been submitted with unanswered questions.");
        } else if (!allUpdated) {
            redirectAttributes.addFlashAttribute("warning", "Some answers could not be saved");
        } else {
            redirectAttributes.addFlashAttribute("success", "Quiz completed successfully!");
        }
        
        // Finish the quiz
        activeQuiz.setTimeEnd(LocalDateTime.now());
        quizService.update(activeQuiz);
        
        return "redirect:/quiz/result/" + activeQuiz.getQuizId();
    }
} 