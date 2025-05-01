<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>${question.questionId != null ? 'Edit' : 'Add'} Question</h2>
    <a href="<c:url value='/admin/questions?page=${param.page != null ? param.page : 1}' />" class="btn btn-secondary">
        <i class="bi bi-arrow-left"></i> Back to Questions
    </a>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Question Form</h5>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${question.questionId != null}">
                <form action="<c:url value='/admin/questions/${question.questionId}/edit' />" method="post">
                    <input type="hidden" name="questionId" value="${question.questionId}">
                    <input type="hidden" name="page" value="${param.page != null ? param.page : 1}">
            </c:when>
            <c:otherwise>
                <form action="<c:url value='/admin/questions/add' />" method="post">
                    <input type="hidden" name="page" value="${param.page != null ? param.page : 1}">
            </c:otherwise>
        </c:choose>
        
            <div class="mb-3">
                <label for="categoryId" class="form-label">Category</label>
                <select class="form-select" id="categoryId" name="categoryId" required>
                    <option value="">-- Select a Category --</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}" ${question.categoryId == category.categoryId ? 'selected' : ''}>
                            ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="description" class="form-label">Question Text</label>
                <textarea class="form-control" id="description" name="description" rows="3" required>${question.description}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="isActive" class="form-label">Status</label>
                <select class="form-select" id="isActive" name="isActive">
                    <option value="true" ${question.active ? 'selected' : ''}>Active</option>
                    <option value="false" ${!question.active ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
            
            <h5 class="mt-4 mb-3">Choices</h5>
            <p class="text-muted">Each question must have exactly 4 choices with one correct answer.</p>
            
            <div id="choicesContainer">
                <c:forEach var="choice" items="${choices}" varStatus="status">
                    <div class="card mb-3 choice-card">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-2">
                                <h6 class="mb-0 me-2">Choice ${status.index + 1}</h6>
                                <div class="form-check ms-auto">
                                    <input class="form-check-input" type="radio" name="isCorrect" value="${status.index}" 
                                           id="isCorrect${status.index}" ${choice.correct ? 'checked' : ''}>
                                    <label class="form-check-label" for="isCorrect${status.index}">
                                        Correct Answer
                                    </label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="choiceDesc${status.index}" class="form-label">Choice Text</label>
                                <input type="text" class="form-control" id="choiceDesc${status.index}" 
                                       name="choiceDesc" value="${choice.description}" required>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty choices}">
                    <!-- Default empty choice cards for new questions -->
                    <c:forEach begin="0" end="3" varStatus="status">
                        <div class="card mb-3 choice-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-2">
                                    <h6 class="mb-0 me-2">Choice ${status.index + 1}</h6>
                                    <div class="form-check ms-auto">
                                        <input class="form-check-input" type="radio" name="isCorrect" value="${status.index}" id="isCorrect${status.index}" ${status.index == 0 ? 'checked' : ''}>
                                        <label class="form-check-label" for="isCorrect${status.index}">
                                            Correct Answer
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="choiceDesc${status.index}" class="form-label">Choice Text</label>
                                    <input type="text" class="form-control" id="choiceDesc${status.index}" name="choiceDesc">
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
            
            <div class="d-flex justify-content-end mt-4">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-save"></i> Save Question
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Form validation
    document.querySelector('form').addEventListener('submit', function(event) {
        // Get all radio buttons with name 'isCorrect'
        const correctAnswerRadios = document.querySelectorAll('input[name="isCorrect"]');
        let isCorrectAnswerSelected = false;
        let selectedRadioIndex = -1;
        
        // Check if any correct answer is selected
        correctAnswerRadios.forEach(function(radio) {
            if (radio.checked) {
                isCorrectAnswerSelected = true;
                selectedRadioIndex = parseInt(radio.value);
            }
        });
        
        // If no correct answer is selected, prevent form submission and show error
        if (!isCorrectAnswerSelected) {
            event.preventDefault();
            alert('Please select a correct answer');
            return;
        }
        
        // Check if the selected correct answer has content
        const choiceInputs = document.querySelectorAll('input[name="choiceDesc"]');
        
        if (selectedRadioIndex >= 0 && 
            (choiceInputs[selectedRadioIndex].value === null || 
             choiceInputs[selectedRadioIndex].value.trim() === '')) {
            event.preventDefault();
            alert('The correct answer cannot be empty');
            choiceInputs[selectedRadioIndex].focus();
            return;
        }
        
        // Count valid choices (non-empty)
        let validChoicesCount = 0;
        choiceInputs.forEach(function(input) {
            if (input.value && input.value.trim() !== '') {
                validChoicesCount++;
            }
        });
        
        // Check if we have exactly 4 valid choices
        if (validChoicesCount !== 4) {
            event.preventDefault();
            alert('Exactly four choices are required');
            return;
        }
    });
</script>

<jsp:include page="../footer.jsp" /> 