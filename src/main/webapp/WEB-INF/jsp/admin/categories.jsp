<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Manage Categories</h2>
    <a href="<c:url value='/admin' />" class="btn btn-secondary">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</div>

<div class="row">
    <div class="col-md-4">
        <div class="card mb-4">
            <div class="card-header">
                <h5>Add New Category</h5>
            </div>
            <div class="card-body">
                <form:form action="/admin/categories/add" method="post" modelAttribute="newCategory">
                    <div class="mb-3">
                        <label for="name" class="form-label">Category Name</label>
                        <form:input path="name" type="text" class="form-control" id="name" required="true" />
                    </div>
                    <button type="submit" class="btn btn-primary">Add Category</button>
                </form:form>
            </div>
        </div>
    </div>
    
    <div class="col-md-8">
        <div class="card mb-4">
            <div class="card-header">
                <h5>Categories List</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categories}">
                                <tr>
                                    <td>${category.categoryId}</td>
                                    <td>${category.name}</td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-primary" 
                                                data-bs-toggle="modal" data-bs-target="#editCategoryModal${category.categoryId}">
                                            Edit
                                        </button>
                                        
                                        <!-- Edit Category Modal -->
                                        <div class="modal fade" id="editCategoryModal${category.categoryId}" tabindex="-1" 
                                             aria-labelledby="editCategoryModalLabel${category.categoryId}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="editCategoryModalLabel${category.categoryId}">
                                                            Edit Category
                                                        </h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <form action="<c:url value='/admin/categories/${category.categoryId}/update' />" method="post">
                                                        <div class="modal-body">
                                                            <div class="mb-3">
                                                                <label for="editName${category.categoryId}" class="form-label">Category Name</label>
                                                                <input type="text" class="form-control" id="editName${category.categoryId}" 
                                                                       name="name" value="${category.name}" required>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary">Save Changes</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" /> 