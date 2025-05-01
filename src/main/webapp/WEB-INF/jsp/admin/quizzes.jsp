<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Quizzes</h2>
    <a href="<c:url value='/admin' />" class="btn btn-secondary">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Quizzes List</h5>
    </div>
    <div class="card-body">
        <!-- Filter Options -->
        <div class="row mb-4">
            <div class="col-12">
                <form action="<c:url value='/admin/quizzes' />" method="get" class="bg-light p-3 rounded">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label for="categoryId" class="form-label">Filter by Category</label>
                            <select id="categoryId" name="categoryId" class="form-select">
                                <option value="">All Categories</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}" ${category.categoryId == selectedCategory ? 'selected' : ''}>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="userId" class="form-label">Filter by User</label>
                            <select id="userId" name="userId" class="form-select">
                                <option value="">All Users</option>
                                <c:forEach var="userItem" items="${usersList}">
                                    <option value="${userItem.userId}" ${userItem.userId == selectedUser ? 'selected' : ''}>
                                        ${userItem.firstname} ${userItem.lastname} (${userItem.email})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary me-2">Apply Filters</button>
                            <a href="<c:url value='/admin/quizzes' />" class="btn btn-outline-secondary">Clear Filters</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${empty quizzes}">
                <div class="alert alert-info">No quizzes found.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>
                                    <a href="<c:url value='/admin/quizzes?page=${currentPage}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=user&sortDir=${sortBy == "user" ? reverseSortDir : "asc"}' />" class="text-dark">
                                        User <c:if test="${sortBy == 'user'}"><i class="bi bi-arrow-${sortDir == 'asc' ? 'up' : 'down'}"></i></c:if>
                                    </a>
                                </th>
                                <th>
                                    <a href="<c:url value='/admin/quizzes?page=${currentPage}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=category&sortDir=${sortBy == "category" ? reverseSortDir : "asc"}' />" class="text-dark">
                                        Category <c:if test="${sortBy == 'category'}"><i class="bi bi-arrow-${sortDir == 'asc' ? 'up' : 'down'}"></i></c:if>
                                    </a>
                                </th>
                                <th>
                                    <a href="<c:url value='/admin/quizzes?page=${currentPage}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=time_start&sortDir=${sortBy == "time_start" ? reverseSortDir : "desc"}' />" class="text-dark">
                                        Date <c:if test="${sortBy == 'time_start'}"><i class="bi bi-arrow-${sortDir == 'asc' ? 'up' : 'down'}"></i></c:if>
                                    </a>
                                </th>
                                <th>
                                    <a href="<c:url value='/admin/quizzes?page=${currentPage}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=status&sortDir=${sortBy == "status" ? reverseSortDir : "asc"}' />" class="text-dark">
                                        Status <c:if test="${sortBy == 'status'}"><i class="bi bi-arrow-${sortDir == 'asc' ? 'up' : 'down'}"></i></c:if>
                                    </a>
                                </th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="quiz" items="${quizzes}">
                                <tr>
                                    <td>${quiz.quizId}</td>
                                    <td>${quiz.userName}</td>
                                    <td>${quiz.categoryName}</td>
                                    <td>
                                        <c:set var="formatter" value='<%=java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm")%>' />
                                        <c:choose>
                                            <c:when test="${quiz.timeStart != null}">
                                                ${quiz.timeStart.format(formatter)}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
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
                                    <td>
                                        <a href="<c:url value='/admin/quizzes/${quiz.quizId}?returnPage=${currentPage}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=${sortBy}&sortDir=${sortDir}' />" class="btn btn-sm btn-primary">
                                            <i class="bi bi-eye"></i> View Details
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Quizzes pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/quizzes?page=${currentPage - 1}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=${sortBy}&sortDir=${sortDir}' />">Previous</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/admin/quizzes?page=${i}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=${sortBy}&sortDir=${sortDir}' />">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/quizzes?page=${currentPage + 1}&categoryId=${selectedCategory}&userId=${selectedUser}&sortBy=${sortBy}&sortDir=${sortDir}' />">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../footer.jsp" /> 