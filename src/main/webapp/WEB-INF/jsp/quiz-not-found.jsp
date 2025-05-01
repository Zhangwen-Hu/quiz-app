<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

<div class="card mb-4">
    <div class="card-header bg-warning">
        <h4>Quiz Not Found</h4>
    </div>
    <div class="card-body">
        <div class="alert alert-warning">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <c:choose>
                <c:when test="${not empty error}">
                    ${error}
                </c:when>
                <c:otherwise>
                    The quiz you are looking for does not exist or you do not have access to it.
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="mt-4">
            <a href="<c:url value='/' />" class="btn btn-primary">
                <i class="bi bi-house-fill"></i> Go to Home
            </a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" /> 