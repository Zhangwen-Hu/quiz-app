<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-danger">
                    <div class="card-header bg-danger text-white">
                        <h4><i class="fas fa-exclamation-triangle mr-2"></i> Access Denied (403)</h4>
                    </div>
                    <div class="card-body text-center">
                        <h5 class="card-title">You don't have permission to access this resource</h5>
                        <p class="card-text">${errorMessage != null ? errorMessage : "You are not authorized to view this page."}</p>
                        <a href="<c:url value='/' />" class="btn btn-primary mt-3">
                            <i class="fas fa-home mr-1"></i> Return to Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
    <script src="<c:url value='/js/jquery.min.js' />"></script>
</body>
</html> 