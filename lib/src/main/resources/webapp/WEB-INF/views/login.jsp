<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${role} Login | Banking Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow border-0 p-4">
                <div class="text-center mb-3">
                    <h3 class="fw-bold mb-1">${role} Sign In</h3>
                    <p class="text-muted small">Enter your credentials to access your session</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="bi bi-exclamation-circle-fill me-1"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <input type="hidden" name="role" value="${role}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Email Address *</label>
                        <input type="email" name="email" class="form-control form-control-lg" placeholder="name@example.com" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Password *</label>
                        <input type="password" name="password" class="form-control form-control-lg" placeholder="••••••••" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold">Sign In</button>
                </form>

                <c:if test="${role eq 'CUSTOMER'}">
                    <hr class="my-3">
                    <div class="text-center small">
                        <span class="text-muted">New customer?</span>
                        <a href="${pageContext.request.contextPath}/register/customer" class="fw-bold">Register here</a>
                    </div>
                </c:if>

                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/" class="text-muted small">← Back to Portal Home</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>