<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div class="card mb-4 border-0 shadow-lg">
    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
        <h4 class="mb-0 fw-bold text-primary">${quiz.name}</h4>
        <span class="badge text-bg-primary rounded-pill px-3 py-2 fw-medium">
            <i class="bi bi-tag-fill me-1"></i>
            ${quiz.category.name}
        </span>
    </div>
    <div class="card-body p-4">
        <div class="alert alert-info mb-4 bg-info bg-opacity-10 border-0">
            <div class="d-flex align-items-center">
                <i class="bi bi-info-circle-fill me-3 fs-3 text-info"></i>
                <p class="mb-0">Answer all questions and click "Submit Quiz" when you're done. Your progress is automatically saved.</p>
            </div>
        </div>

        <form action="<c:url value='/quiz/submit-all-answers' />" method="post">
            <c:forEach var="qq" items="${quiz.quizQuestions}" varStatus="status">
                <div class="card mb-4 border-0 shadow-sm question-card position-relative ${qq.userChoiceId != null ? 'answered' : 'unanswered'}">
                    <div class="question-status ${qq.userChoiceId != null ? 'answered-badge' : 'unanswered-badge'}">
                        ${qq.userChoiceId != null ? 'Answered' : 'Unanswered'}
                    </div>
                    <div class="card-header d-flex justify-content-between align-items-center ${qq.userChoiceId != null ? 'bg-success bg-opacity-25' : ''}">
                        <h5 class="mb-0">
                            <span class="badge rounded-pill bg-dark me-2">${status.index + 1}</span>
                            Question ${status.index + 1} of ${quiz.quizQuestions.size()}
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <h5 class="card-title mb-4 fw-bold">${qq.question.description}</h5>
                        
                        <div class="list-group">
                            <c:forEach var="choice" items="${qq.question.choices}">
                                <label class="list-group-item list-group-item-action d-flex align-items-center p-3 ${qq.userChoiceId == choice.choiceId ? 'question-choice answered-choice' : ''} ${qq.userChoiceId == null ? 'question-choice' : ''}">
                                    <div class="d-flex align-items-center w-100">
                                        <div class="form-check">
                                            <input class="form-check-input me-3" type="radio" name="choiceIds_${qq.qqId}" 
                                                id="choice_${choice.choiceId}"
                                                value="${choice.choiceId}" 
                                                ${qq.userChoiceId == choice.choiceId ? 'checked' : ''}>
                                        </div>
                                        <label class="form-check-label w-100" for="choice_${choice.choiceId}">
                                            ${choice.description}
                                        </label>
                                    </div>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <div class="d-flex justify-content-between mt-5">
                <a href="<c:url value='/' />" class="btn btn-outline-secondary px-4">
                    <i class="bi bi-house-door me-2"></i> Return Home
                </a>
                <div>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-circle me-2"></i> Submit Quiz
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" /> 

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Get all radio inputs for quiz choices
    const choiceInputs = document.querySelectorAll('input[type="radio"][name^="choiceIds_"]');
    
    // Add change event listener to each radio input
    choiceInputs.forEach(input => {
        input.addEventListener('change', function() {
            // Get the question card element (parent of the input)
            const questionCard = this.closest('.question-card');
            
            // Update the question card status
            questionCard.classList.remove('unanswered');
            questionCard.classList.add('answered');
            
            // Update the status badge
            const statusBadge = questionCard.querySelector('.question-status');
            statusBadge.textContent = 'Answered';
            statusBadge.classList.remove('unanswered-badge');
            statusBadge.classList.add('answered-badge');
            
            // Update the selected choice
            const allChoices = questionCard.querySelectorAll('.list-group-item');
            allChoices.forEach(choice => {
                choice.classList.remove('answered-choice');
            });
            
            const selectedChoice = this.closest('.list-group-item');
            selectedChoice.classList.add('question-choice', 'answered-choice');
            
            // Update the card header
            const cardHeader = questionCard.querySelector('.card-header');
            cardHeader.classList.add('bg-success', 'bg-opacity-25');
        });
    });
});
</script> 