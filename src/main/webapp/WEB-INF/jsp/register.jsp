<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="header.jsp" />

<div class="row justify-content-center my-5">
    <div class="col-md-6">
        <div class="card border-0 shadow-lg">
            <div class="card-header bg-white py-3">
                <h4 class="text-center mb-0 fw-bold text-primary">Create Account</h4>
            </div>
            <div class="card-body p-4">
                <div class="text-center mb-4">
                    <i class="bi bi-person-plus-fill fs-1 text-primary"></i>
                </div>
                <form:form action="/register" method="post" modelAttribute="user">
                    <div class="row mb-3">
                        <div class="col-md-6 mb-3 mb-md-0">
                            <label for="firstname" class="form-label fw-medium">First Name</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0">
                                    <i class="bi bi-person-fill text-muted"></i>
                                </span>
                                <form:input path="firstname" type="text" class="form-control border-start-0" id="firstname" placeholder="Enter first name" required="true" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="lastname" class="form-label fw-medium">Last Name</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0">
                                    <i class="bi bi-person-fill text-muted"></i>
                                </span>
                                <form:input path="lastname" type="text" class="form-control border-start-0" id="lastname" placeholder="Enter last name" required="true" />
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label fw-medium">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="bi bi-envelope-fill text-muted"></i>
                            </span>
                            <form:input path="email" type="email" class="form-control border-start-0" id="email" placeholder="Enter your email" required="true" />
                        </div>
                    </div>
                    <div class="mb-4">
                        <label for="password" class="form-label fw-medium">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="bi bi-key-fill text-muted"></i>
                            </span>
                            <form:input path="password" type="password" class="form-control border-start-0" id="password" placeholder="Choose a password" required="true" />
                        </div>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary py-2">
                            <i class="bi bi-person-check-fill me-2"></i>Create Account
                        </button>
                    </div>
                </form:form>
                <div class="mt-4 text-center">
                    <p class="mb-0">Already have an account? <a href="<c:url value='/login' />" class="fw-medium text-decoration-none">Login here</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" /> 