<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header.jsp" />

<div class="jumbotron bg-light p-5 mb-4 rounded-3 shadow-sm">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-4 fw-bold text-primary">Welcome to Quiz App</h1>
                <p class="lead">Test your knowledge, challenge yourself, and learn something new with our engaging quizzes.</p>
                <hr class="my-4">
                <p class="mb-4">Choose a category below to start a new quiz and track your progress!</p>
                <a href="#start-quiz" class="btn btn-primary btn-lg px-4">
                    <i class="bi bi-play-circle me-2"></i>Start a Quiz
                </a>
            </div>
            <div class="col-lg-4 d-none d-lg-block text-center">
                <i class="bi bi-lightbulb-fill text-primary" style="font-size: 10rem; opacity: 0.8;"></i>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card mb-4 shadow-sm" id="start-quiz">
            <div class="card-header py-3">
                <h5 class="card-title mb-0 fw-bold"><i class="bi bi-play-circle me-2"></i>Start a New Quiz</h5>
            </div>
            <div class="card-body p-4">
                <form action="<c:url value='/quiz/start' />" method="get">
                    <div class="mb-4">
                        <label for="categoryId" class="form-label fw-medium">Select Category</label>
                        <select class="form-select py-2" id="categoryId" name="categoryId" required>
                            <option value="">-- Select a Category --</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categoryId}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-4">
                        <div class="alert alert-info bg-info bg-opacity-10 border-0">
                            <i class="bi bi-info-circle-fill me-2 text-info"></i>
                            Each quiz consists of 3 questions. If a category has fewer than 3 questions, you'll be asked to choose a different category.
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-lightning-charge me-2"></i>Start Quiz
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card mb-4 shadow-sm">
            <div class="card-header py-3">
                <h5 class="card-title mb-0 fw-bold"><i class="bi bi-journal-check me-2"></i>My Quizzes</h5>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty sessionScope.user}">
                    <c:choose>
                        <c:when test="${empty quizHistory}">
                            <div class="text-center py-4">
                                <i class="bi bi-clipboard text-muted" style="font-size: 3rem;"></i>
                                <p class="text-muted mt-3">You haven't taken any quizzes yet.</p>
                                <a href="#start-quiz" class="btn btn-sm btn-outline-primary mt-2">Take your first quiz</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Quiz Name</th>
                                            <th>Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="quiz" items="${quizHistory}">
                                            <tr>
                                                <td class="fw-medium">${quiz.name}</td>
                                                <td>
                                                    <c:set var="formatter" value='<%=java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy")%>' />
                                                    <c:choose>
                                                        <c:when test="${quiz.timeStart != null}">
                                                            <i class="bi bi-calendar-event me-1 text-muted"></i>${quiz.timeStart.format(formatter)}
                                                        </c:when>
                                                        <c:otherwise>
                                                            N/A
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${quiz.finished}">
                                                            <a href="<c:url value='/quiz/result/${quiz.quizId}' />" class="btn btn-sm btn-outline-primary rounded-pill">
                                                                <i class="bi bi-eye me-1"></i>View
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="<c:url value='/quiz/active' />" class="btn btn-sm btn-outline-warning rounded-pill">
                                                                <i class="bi bi-arrow-right me-1"></i>Continue
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${quizHistoryCount > quizHistory.size()}">
                                <div class="mt-3 text-center">
                                    <c:if test="${totalPages > 1}">
                                        <nav aria-label="Quiz history pagination">
                                            <ul class="pagination pagination-sm justify-content-center">
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="<c:url value='/?page=${currentPage - 1}' />">
                                                        <i class="bi bi-chevron-left"></i>
                                                    </a>
                                                </li>
                                                
                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                        <a class="page-link" href="<c:url value='/?page=${i}' />">${i}</a>
                                                    </li>
                                                </c:forEach>
                                                
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="<c:url value='/?page=${currentPage + 1}' />">
                                                        <i class="bi bi-chevron-right"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </c:if>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <div class="text-center py-4">
                        <i class="bi bi-lock text-muted" style="font-size: 3rem;"></i>
                        <p class="text-muted mt-3">Please login to view your quiz history.</p>
                        <a href="<c:url value='/login' />" class="btn btn-sm btn-outline-primary mt-2">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Login
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" /> 