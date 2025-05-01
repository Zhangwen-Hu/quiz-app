<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

<div class="row justify-content-center my-5">
    <div class="col-md-5">
        <div class="card border-0 shadow-lg">
            <div class="card-header bg-white py-3">
                <h4 class="text-center mb-0 fw-bold text-primary">Welcome Back</h4>
            </div>
            <div class="card-body p-4">
                <div class="text-center mb-4">
                    <i class="bi bi-person-circle fs-1 text-primary"></i>
                </div>
                <form action="<c:url value='/authenticate' />" method="post">
                    <div class="mb-3">
                        <label for="email" class="form-label fw-medium">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="bi bi-envelope-fill text-muted"></i>
                            </span>
                            <input type="email" class="form-control border-start-0" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label for="password" class="form-label fw-medium">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="bi bi-key-fill text-muted"></i>
                            </span>
                            <input type="password" class="form-control border-start-0" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary py-2">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Login
                        </button>
                    </div>
                </form>
                <div class="mt-4 text-center">
                    <p class="mb-0">Don't have an account? <a href="<c:url value='/register' />" class="fw-medium text-decoration-none">Register here</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
