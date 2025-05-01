<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div class="card mb-4">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h4>${quiz.name} - Results</h4>
        <span class="badge bg-primary">Category: ${quiz.category.name}</span>
    </div>
    <div class="card-body">
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="quiz-info">
                    <c:set var="formatter" value='<%=java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm:ss")%>' />
                    <p>
                        <strong>Started:</strong> 
                        <c:choose>
                            <c:when test="${quiz.timeStart != null}">
                                ${quiz.timeStart.format(formatter)}
                            </c:when>
                            <c:otherwise>
                                N/A
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p>
                        <strong>Finished:</strong> 
                        <c:choose>
                            <c:when test="${quiz.timeEnd != null}">
                                ${quiz.timeEnd.format(formatter)}
                            </c:when>
                            <c:otherwise>
                                N/A
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Your Score</h5>
                        <h1 class="display-4">${quiz.correctCount} / ${quiz.totalCount}</h1>
                        <p class="card-text">
                            <c:set var="percentage" value="${(quiz.correctCount / quiz.totalCount) * 100}" />
                            <fmt:formatNumber value="${percentage}" maxFractionDigits="0" />%
                        </p>
                        
                        <!-- Pass/Fail Indicator -->
                        <div class="mt-2 mb-3">
                            <c:choose>
                                <c:when test="${quiz.correctCount >= 2}">
                                    <div class="alert alert-success">
                                        <strong>PASS</strong>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-danger">
                                        <strong>FAIL</strong>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <c:choose>
                            <c:when test="${percentage >= 80}">
                                <div class="alert alert-success">Excellent job!</div>
                            </c:when>
                            <c:when test="${percentage >= 60}">
                                <div class="alert alert-primary">Good work!</div>
                            </c:when>
                            <c:when test="${percentage >= 40}">
                                <div class="alert alert-warning">Not bad, keep practicing!</div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-danger">You need more practice!</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        
        <h5 class="mb-3">Question Details</h5>
        
        <c:forEach var="qq" items="${quiz.quizQuestions}" varStatus="status">
            <c:set var="isCorrect" value="false" />
            <c:forEach var="choice" items="${qq.question.choices}">
                <c:if test="${choice.choiceId == qq.userChoiceId && choice.correct}">
                    <c:set var="isCorrect" value="true" />
                </c:if>
            </c:forEach>
            
            <div class="card mb-3 ${isCorrect ? 'border-success' : 'border-danger'}">
                <div class="card-header d-flex justify-content-between ${isCorrect ? 'bg-success text-white' : 'bg-danger text-white'}">
                    <h6 class="mb-0">Question ${status.index + 1}</h6>
                    <span>${isCorrect ? 'Correct' : 'Incorrect'}</span>
                </div>
                <div class="card-body">
                    <h6 class="card-title">${qq.question.description}</h6>
                    
                    <div class="list-group mt-3">
                        <c:forEach var="choice" items="${qq.question.choices}">
                            <div class="list-group-item 
                                 ${choice.choiceId == qq.userChoiceId ? (choice.correct ? 'list-group-item-success' : 'list-group-item-danger') : ''} 
                                 ${choice.correct && choice.choiceId != qq.userChoiceId ? 'list-group-item-success' : ''}">
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <c:if test="${choice.choiceId == qq.userChoiceId}">
                                            <i class="bi bi-check-circle-fill me-2 ${choice.correct ? 'text-success' : 'text-danger'}"></i>
                                        </c:if>
                                        ${choice.description}
                                    </div>
                                    <c:if test="${choice.correct}">
                                        <span class="badge bg-success">Correct Answer</span>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <div class="d-flex justify-content-between mt-4">
            <a href="<c:url value='/' />" class="btn btn-primary">
                <i class="bi bi-list-ul"></i> View My Quizzes
            </a>
            <a href="<c:url value='/' />" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Start New Quiz
            </a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />