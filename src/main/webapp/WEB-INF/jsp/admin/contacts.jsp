<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Contact Messages</h2>
    <a href="<c:url value='/admin' />" class="btn btn-secondary">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5>Messages List</h5>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty contacts}">
                <div class="alert alert-info">No contact messages found.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Subject</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="contact" items="${contacts}">
                                <tr>
                                    <td>${contact.contactId}</td>
                                    <td>${contact.email}</td>
                                    <td>${contact.subject}</td>
                                    <td>
                                        <c:set var="formatter" value='<%=java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm")%>' />
                                        <c:choose>
                                            <c:when test="${contact.time != null}">
                                                ${contact.time.format(formatter)}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-primary" 
                                                data-bs-toggle="modal" data-bs-target="#viewModal${contact.contactId}">
                                            <i class="bi bi-eye"></i> View
                                        </button>
                                        
                                        <!-- Message View Modal -->
                                        <div class="modal fade" id="viewModal${contact.contactId}" tabindex="-1" 
                                             aria-labelledby="viewModalLabel${contact.contactId}" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="viewModalLabel${contact.contactId}">
                                                            Message Details
                                                        </h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="mb-3">
                                                            <label class="form-label">ID</label>
                                                            <input type="text" class="form-control" value="${contact.contactId}" readonly>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Email</label>
                                                            <input type="text" class="form-control" value="${contact.email}" readonly>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Subject</label>
                                                            <input type="text" class="form-control" value="${contact.subject}" readonly>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Date</label>
                                                            <input type="text" class="form-control" 
                                                                   value="<c:choose><c:when test="${contact.time != null}">${contact.time.format(formatter)}</c:when><c:otherwise>N/A</c:otherwise></c:choose>" readonly>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Message</label>
                                                            <textarea class="form-control" rows="5" readonly>${contact.message}</textarea>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Contacts pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/contacts?page=${currentPage - 1}' />">Previous</a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/admin/contacts?page=${i}' />">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/contacts?page=${currentPage + 1}' />">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../footer.jsp" /> 