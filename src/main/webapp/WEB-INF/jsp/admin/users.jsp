<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Manage Users</h2>
    <a href="<c:url value='/admin' />" class="btn btn-secondary">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Users List</h5>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty users}">
                <div class="alert alert-info">No users found. The system may be experiencing data loading issues.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Name</th>
                                <th>Status</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.userId}</td>
                                    <td>${user.email}</td>
                                    <td>${user.firstname} ${user.lastname}</td>
                                    <td>
                                        <span class="badge ${user.active ? 'bg-success' : 'bg-danger'}">
                                            ${user.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge ${user.admin ? 'bg-primary' : 'bg-secondary'}">
                                            ${user.admin ? 'Admin' : 'User'}
                                        </span>
                                    </td>
                                    <td>
                                        <form action="<c:url value='/admin/users/${user.userId}/toggle-status' />" method="post" style="display:inline;">
                                            <input type="hidden" name="isActive" value="${!user.active}">
                                            <button type="submit" class="btn btn-sm ${user.active ? 'btn-warning' : 'btn-success'}" 
                                                    ${user.userId == sessionScope.userId ? 'disabled' : ''}>
                                                ${user.active ? 'Suspend' : 'Activate'}
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
                    <nav aria-label="Users pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/users?page=${currentPage - 1}' />">Previous</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/admin/users?page=${i}' />">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/users?page=${currentPage + 1}' />">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../footer.jsp" /> 