<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${role} Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow border-0 p-4">
                <h3 class="text-center mb-4">${role} Login</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <input type="hidden" name="role" value="${role}">
                    
                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2">Sign In</button>
                </form>

                <c:if test="${role eq 'CUSTOMER'}">
                    <hr class="my-4">
                    <div class="text-center">
                        <span class="text-muted">Don't have an account?</span>
                        <a href="${pageContext.request.contextPath}/register/customer">Register here</a>
                    </div>
                </c:if>

                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/" class="text-muted small">← Back to Portal Selection</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>