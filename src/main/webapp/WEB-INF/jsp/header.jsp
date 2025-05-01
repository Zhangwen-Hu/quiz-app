<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #f72585;
            --success-color: #4cc9f0;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        body {
            padding-top: 60px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fb;
        }
        
        .main-content {
            flex: 1;
        }
        
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        
        .nav-link {
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .footer {
            padding: 20px 0;
            margin-top: auto;
            background-color: var(--light-color);
            border-top: 1px solid #e7e7e7;
        }
        
        /* Card styling */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.3s ease;
        }
        
        .card:hover {
            /* Removed: transform: translateY(-5px); */
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            font-weight: 600;
            border-radius: 10px 10px 0 0 !important;
        }
        
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.5rem 1.5rem;
            transition: background-color 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            /* Removed: transform: translateY(-2px); */
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
        }
        
        /* Quiz question styling */
        .question-card {
            transition: background-color 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease;
            border-radius: 12px;
            overflow: hidden;
        }
        
        .question-card.answered {
            border-left: 5px solid var(--success-color) !important;
            box-shadow: 0 0.5rem 1rem rgba(76, 201, 240, 0.15) !important;
        }
        
        .question-card.unanswered {
            border-left: 5px solid #6c757d !important;
            opacity: 0.9;
        }
        
        .question-status {
            position: absolute;
            top: 12px;
            right: 12px;
            font-size: 0.75rem;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
        
        .answered-badge {
            background-color: var(--success-color);
            color: white;
        }
        
        .unanswered-badge {
            background-color: #6c757d;
            color: white;
        }
        
        .question-choice.answered-choice {
            background-color: rgba(76, 201, 240, 0.1) !important;
            border-color: var(--success-color) !important;
        }
        
        /* Form styling */
        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            font-size: 1rem;
        }
        
        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.25);
            border-color: var(--primary-color);
        }
        
        /* List group styling */
        .list-group-item {
            border-radius: 8px !important;
            margin-bottom: 0.5rem;
            border: 1px solid rgba(0,0,0,0.1);
            padding: 1rem;
            transition: background-color 0.2s ease, border-color 0.2s ease;
        }
        
        .list-group-item:hover {
            background-color: rgba(67, 97, 238, 0.05);
            /* Ensure no transform is applied on hover */
        }
        
        /* Table styling */
        .table {
            border-collapse: separate;
            border-spacing: 0 5px;
        }
        
        .table tr {
            border-radius: 8px;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.05);
        }
        
        .table th {
            border-top: none;
            font-weight: 600;
        }
        
        .table td {
            vertical-align: middle;
        }
        
        /* Alerts styling */
        .alert {
            border-radius: 8px;
            border: none;
        }
        
        /* Pagination styling */
        .pagination .page-link {
            border-radius: 8px;
            margin: 0 3px;
            color: var(--primary-color);
        }
        
        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        /* Jumbotron styling */
        .jumbotron {
            border-radius: 16px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color: var(--primary-color);">
    <div class="container">
        <span class="navbar-brand"><i class="bi bi-lightning-charge-fill me-2"></i>Quiz App</span>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${not empty sessionScope.user}">
                    <c:choose>
                        <c:when test="${hasActiveQuiz}">
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/quiz/active' />">
                                    <i class="bi bi-pencil-square me-1"></i> Taking Quiz
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/' />">
                                    <i class="bi bi-house-door me-1"></i> Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/contact' />">
                                    <i class="bi bi-envelope me-1"></i> Contact
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/contact' />">
                            <i class="bi bi-envelope me-1"></i> Contact
                        </a>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/login' />">
                                <i class="bi bi-box-arrow-in-right me-1"></i> Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/register' />">
                                <i class="bi bi-person-plus me-1"></i> Register
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${sessionScope.isAdmin && !hasActiveQuiz}">
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/admin' />">
                                    <i class="bi bi-shield-lock me-1"></i> Admin Dashboard
                                </a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <span class="nav-link">
                                <i class="bi bi-person-circle me-1"></i> Welcome, ${sessionScope.user.firstname}!
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/logout' />">
                                <i class="bi bi-box-arrow-right me-1"></i> Logout
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="main-content">
    <div class="container py-4">
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty warning}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle-fill me-2"></i> ${warning}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
    </div>
</div>
</body>
</html> 