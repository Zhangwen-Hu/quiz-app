<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Manage Questions</h2>
    <div>
        <a href="<c:url value='/admin/questions/add?page=${currentPage}' />" class="btn btn-success me-2">
            <i class="bi bi-plus-circle"></i> Add New Question
        </a>
        <a href="<c:url value='/admin' />" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Questions List</h5>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty questions}">
                <div class="alert alert-info">No questions found. <a href="<c:url value='/admin/questions/add' />" class="alert-link">Add a new question</a>.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Category</th>
                                <th>Question</th>
                                <th>Choices</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="question" items="${questions}">
                                <tr>
                                    <td>${question.questionId}</td>
                                    <td>${question.category.name}</td>
                                    <td>${question.description}</td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-info" 
                                                data-bs-toggle="modal" data-bs-target="#choicesModal${question.questionId}">
                                            View Choices
                                        </button>
                                        
                                        <!-- Choices Modal -->
                                        <div class="modal fade" id="choicesModal${question.questionId}" tabindex="-1" 
                                             aria-labelledby="choicesModalLabel${question.questionId}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="choicesModalLabel${question.questionId}">
                                                            Choices for Question #${question.questionId}
                                                        </h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p><strong>Question:</strong> ${question.description}</p>
                                                        <hr>
                                                        <h6>Choices:</h6>
                                                        <ul class="list-group">
                                                            <c:choose>
                                                                <c:when test="${empty question.choices}">
                                                                    <li class="list-group-item text-muted">No choices found for this question.</li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:forEach var="choice" items="${question.choices}">
                                                                        <li class="list-group-item ${choice.correct ? 'list-group-item-success' : ''}">
                                                                            ${choice.description}
                                                                            <c:if test="${choice.correct}">
                                                                                <span class="badge bg-success float-end">Correct</span>
                                                                            </c:if>
                                                                        </li>
                                                                    </c:forEach>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </ul>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge ${question.active ? 'bg-success' : 'bg-danger'}">
                                            ${question.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="<c:url value='/admin/questions/${question.questionId}/edit?page=${currentPage}' />" class="btn btn-sm btn-primary">
                                            Edit
                                        </a>
                                        <form action="<c:url value='/admin/questions/${question.questionId}/toggle-status' />" method="post" style="display:inline;">
                                            <input type="hidden" name="isActive" value="${!question.active}">
                                            <input type="hidden" name="page" value="${currentPage}">
                                            <button type="submit" class="btn btn-sm ${question.active ? 'btn-warning' : 'btn-success'}">
                                                ${question.active ? 'Suspend' : 'Activate'}
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Questions pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/questions?page=${currentPage - 1}' />">Previous</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/admin/questions?page=${i}' />">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/questions?page=${currentPage + 1}' />">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../footer.jsp" /> 