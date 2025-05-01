<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div class="card mb-4">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h4>${quiz.name}</h4>
        <span class="badge bg-primary">Category: ${quiz.category.name}</span>
    </div>
    <div class="card-body">
        <div class="alert alert-info">
            <i class="bi bi-info-circle-fill me-2"></i>
            Navigate through questions using the Previous and Next buttons. Your answers are saved when you move between questions.
        </div>

        <!-- Current Question -->
        <form action="<c:url value='/quiz/save-answer' />" method="post">
            <input type="hidden" name="qqId" value="${currentQuestion.qqId}">
            <input type="hidden" name="questionNumber" value="${questionNumber}">
            
            <div class="card mb-4 question-card position-relative ${currentQuestion.userChoiceId != null ? 'answered' : 'unanswered'}">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Question ${questionNumber} of ${totalQuestions}</h5>
                </div>
                <div class="card-body">
                    <h5 class="card-title">${currentQuestion.question.description}</h5>
                    
                    <div class="list-group">
                        <c:forEach var="choice" items="${currentQuestion.question.choices}">
                            <label class="list-group-item list-group-item-action ${currentQuestion.userChoiceId == choice.choiceId ? 'question-choice answered-choice' : ''} ${currentQuestion.userChoiceId == null ? 'question-choice' : ''}">
                                <div class="d-flex align-items-center">
                                    <input class="form-check-input me-3" type="radio" name="choiceId" 
                                           value="${choice.choiceId}" 
                                           ${currentQuestion.userChoiceId == choice.choiceId ? 'checked' : ''}>
                                    ${choice.description}
                                </div>
                            </label>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div class="d-flex justify-content-between mt-4">
                <div class="w-25 text-start">
                    <c:if test="${questionNumber > 1}">
                        <button type="submit" name="action" value="prev" class="btn btn-outline-secondary me-2">
                            <i class="bi bi-arrow-left"></i> Previous
                        </button>
                    </c:if>
                </div>
                
                <div class="w-50 text-center">
                    <button type="submit" name="action" value="submit" class="btn btn-primary me-2">
                        <i class="bi bi-check-circle"></i> Submit Quiz
                    </button>
                </div>
                
                <div class="w-25 text-end">
                    <c:if test="${questionNumber < totalQuestions}">
                        <button type="submit" name="action" value="next" class="btn btn-outline-secondary">
                            Next <i class="bi bi-arrow-right"></i>
                        </button>
                    </c:if>
                </div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />

<style>
.question-card {
    position: relative;
    margin-bottom: 1.5rem;
    border: 1px solid #dee2e6;
    border-radius: 0.25rem;
}

.unanswered .card-header {
    background-color: #f8d7da;
    color: #721c24;
    border-color: #f5c6cb;
}

.answered .card-header {
    background-color: #d4edda;
    color: #155724;
    border-color: #c3e6cb;
}

.question-choice:hover {
    background-color: #f8f9fa;
    cursor: pointer;
}

.answered-choice {
    background-color: #d4edda !important;
    border-color: #c3e6cb;
    color: #155724;
}
</style> 