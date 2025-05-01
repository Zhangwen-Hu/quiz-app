<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="header.jsp" />

<div class="row justify-content-center my-5">
    <div class="col-lg-8">
        <div class="card border-0 shadow-lg">
            <div class="card-header bg-white py-3">
                <h4 class="text-center mb-0 fw-bold text-primary">Get In Touch</h4>
            </div>
            <div class="card-body p-4">
                <div class="text-center mb-4">
                    <i class="bi bi-envelope-paper-fill fs-1 text-primary"></i>
                    <p class="lead mt-3">We'd love to hear from you! Fill out the form below to send us a message.</p>
                </div>
                
                <form:form action="/contact" method="post" modelAttribute="contact" cssClass="row g-3">
                    <div class="col-md-12 mb-3">
                        <label for="email" class="form-label fw-medium">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="bi bi-envelope-fill text-muted"></i>
                            </span>
                            <form:input path="email" type="email" class="form-control border-start-0" id="email" placeholder="Enter your email" required="true" />
                        </div>
                    </div>
                    <div class="col-md-12 mb-3">
                        <label for="subject" class="form-label fw-medium">Subject</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="bi bi-chat-left-text-fill text-muted"></i>
                            </span>
                            <form:input path="subject" type="text" class="form-control border-start-0" id="subject" placeholder="What is this about?" required="true" />
                        </div>
                    </div>
                    <div class="col-md-12 mb-4">
                        <label for="message" class="form-label fw-medium">Message</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="bi bi-pencil-fill text-muted"></i>
                            </span>
                            <form:textarea path="message" class="form-control border-start-0" id="message" rows="6" placeholder="Tell us what you need help with..." required="true" />
                        </div>
                    </div>
                    <div class="col-12 text-center">
                        <button type="submit" class="btn btn-primary px-5 py-2">
                            <i class="bi bi-send-fill me-2"></i>Send Message
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" /> 