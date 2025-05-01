<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />

<div class="row mb-4">
    <div class="col-md-12">
        <h2>Admin Dashboard</h2>
        <hr/>
    </div>
</div>

<div class="row">
    <div class="col-md-3">
        <div class="card mb-4">
            <div class="card-body text-center">
                <h1 class="display-4">${userCount}</h1>
                <h5>Total Users</h5>
                <a href="<c:url value='/admin/users' />" class="btn btn-primary mt-2">Manage Users</a>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card mb-4">
            <div class="card-body text-center">
                <h1 class="display-4">${questionCount}</h1>
                <h5>Total Questions</h5>
                <a href="<c:url value='/admin/questions' />" class="btn btn-primary mt-2">Manage Questions</a>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card mb-4">
            <div class="card-body text-center">
                <h1 class="display-4">${quizCount}</h1>
                <h5>Total Quizzes</h5>
                <a href="<c:url value='/admin/quizzes' />" class="btn btn-primary mt-2">View Quizzes</a>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card mb-4">
            <div class="card-body text-center">
                <h5>Most Popular Category</h5>
                <h3>${popularCategory != 'N/A' ? popularCategory : 'None'}</h3>
                <a href="<c:url value='/admin/categories' />" class="btn btn-primary mt-2">Manage Categories</a>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="card mb-4">
            <div class="card-header">
                <h5>Contact Messages</h5>
            </div>
            <div class="card-body text-center">
                <i class="bi bi-envelope-fill" style="font-size: 2rem;"></i>
                <h5 class="mt-3">Manage Contact Messages</h5>
                <p>View messages from users</p>
                <a href="<c:url value='/admin/contacts' />" class="btn btn-primary">View Messages</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" /> 