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
        <div class="quiz-info mb-4">
            <p>
                <strong>Started:</strong> 
                <c:set var="formatter" value='<%=java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm:ss")%>' />
                <c:choose>
                    <c:when test="${quiz.timeStart != null}">
                        ${quiz.timeStart.format(formatter)}
                    </c:when>
                    <c:otherwise>
                        N/A
                    </c:otherwise>
                </c:choose>
            </p>
            <div class="progress mb-3">
                <c:set var="answeredCount" value="0" />
                <c:forEach var="qq" items="${quiz.quizQuestions}">
                    <c:if test="${qq.userChoiceId != null}">
                        <c:set var="answeredCount" value="${answeredCount + 1}" />
                    </c:if>
                </c:forEach>
                
                <c:set var="progressPercent" value="${(answeredCount / quiz.quizQuestions.size()) * 100}" />
                <div class="progress-bar" role="progressbar" style="width: ${progressPercent}%;" 
                     aria-valuenow="${progressPercent}" aria-valuemin="0" aria-valuemax="100">
                    ${answeredCount} / ${quiz.quizQuestions.size()}
                </div>
            </div>
        </div>
        
        <c:forEach var="qq" items="${quiz.quizQuestions}" varStatus="status">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between">
                    <h5>Question ${status.index + 1}</h5>
                    <c:if test="${qq.userChoiceId != null}">
                        <span class="badge bg-success">Answered</span>
                    </c:if>
                </div>
                <div class="card-body">
                    <h6 class="card-title">${qq.question.description}</h6>
                    
                    <form action="<c:url value='/quiz/submit-answer' />" method="post" class="mt-3">
                        <input type="hidden" name="qqId" value="${qq.qqId}">
                        
                        <div class="list-group">
                            <c:forEach var="choice" items="${qq.question.choices}">
                                <label class="list-group-item">
                                    <input type="radio" class="form-check-input me-2" name="choiceId" 
                                           value="${choice.choiceId}" ${choice.choiceId == qq.userChoiceId ? 'checked' : ''}>
                                    ${choice.description}
                                </label>
                            </c:forEach>
                        </div>
                        
                        <c:if test="${qq.userChoiceId == null}">
                            <button type="submit" class="btn btn-primary mt-3">Submit Answer</button>
                        </c:if>
                    </form>
                </div>
            </div>
        </c:forEach>
        
        <form action="<c:url value='/quiz/finish' />" method="post" class="d-grid gap-2">
            <button type="submit" class="btn btn-success">Finish Quiz</button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />
