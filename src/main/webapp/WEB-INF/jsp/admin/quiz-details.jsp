<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Quiz Details</h2>
    <a href="<c:url value='/admin/quizzes?page=${returnPage}&categoryId=${returnCategoryId}&userId=${returnUserId}&sortBy=${returnSortBy}&sortDir=${returnSortDir}' />" class="btn btn-secondary">
        <i class="bi bi-arrow-left"></i> Back to Quizzes
    </a>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Quiz Information</h5>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <table class="table table-bordered">
                    <tr>
                        <th>Quiz ID</th>
                        <td>${quiz.quizId}</td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td>${quiz.name}</td>
                    </tr>
                    <tr>
                        <th>Category</th>
                        <td>${quiz.category.name}</td>
                    </tr>
                    <tr>
                        <th>User</th>
                        <td>${quiz.user.firstname} ${quiz.user.lastname} (${quiz.user.email})</td>
                    </tr>
                    <tr>
                        <th>Start Time</th>
                        <td>
                            <c:set var="formatter" value='<%=java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm:ss")%>' />
                            <c:choose>
                                <c:when test="${quiz.timeStart != null}">
                                    ${quiz.timeStart.format(formatter)}
                                </c:when>
                                <c:otherwise>
                                    N/A
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>End Time</th>
                        <td>
                            <c:choose>
                                <c:when test="${quiz.timeEnd != null}">
                                    ${quiz.timeEnd.format(formatter)}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-warning">In Progress</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td>
                            <c:choose>
                                <c:when test="${quiz.timeEnd != null}">
                                    <span class="badge bg-success">Completed</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-warning">In Progress</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div class="col-md-6">
                <c:if test="${quiz.finished}">
                    <div class="card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Quiz Results</h5>
                            <h1 class="display-4">${quiz.correctCount} / ${quiz.totalCount}</h1>
                            <p class="card-text">
                                <c:set var="percentage" value="${(quiz.correctCount / quiz.totalCount) * 100}" />
                                <fmt:formatNumber value="${percentage}" maxFractionDigits="0" />%
                            </p>
                            <div class="progress mb-3">
                                <div class="progress-bar bg-success" role="progressbar" style="width: ${percentage}%;" 
                                     aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100">
                                    <fmt:formatNumber value="${percentage}" maxFractionDigits="0" />%
                                </div>
                            </div>
                            
                            <!-- Pass/Fail Indicator -->
                            <div class="mb-3">
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
                                    <div class="alert alert-success">Excellent performance!</div>
                                </c:when>
                                <c:when test="${percentage >= 60}">
                                    <div class="alert alert-primary">Good performance!</div>
                                </c:when>
                                <c:when test="${percentage >= 40}">
                                    <div class="alert alert-warning">Average performance!</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-danger">Poor performance!</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Questions and Answers</h5>
    </div>
    <div class="card-body">
        <c:forEach var="qq" items="${quiz.quizQuestions}" varStatus="status">
            <div class="card mb-3">
                <div class="card-header">
                    <h6 class="mb-0">Question ${status.index + 1}</h6>
                </div>
                <div class="card-body">
                    <p class="card-text">${qq.question.description}</p>
                    
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
                                    <div>
                                        <c:if test="${choice.choiceId == qq.userChoiceId}">
                                            <span class="badge bg-primary">User's Answer</span>
                                        </c:if>
                                        <c:if test="${choice.correct}">
                                            <span class="badge bg-success ms-2">Correct Answer</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../footer.jsp" /> 