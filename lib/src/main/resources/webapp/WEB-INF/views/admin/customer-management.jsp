<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Management | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-shield-lock-fill me-2"></i>Admin Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-sm">← Back</a>
    </div>
</nav>

<div class="container py-4">
    <div class="mb-4">
        <h3 class="fw-bold text-dark mb-0">Customer Master Directory</h3>
        <p class="text-muted small mb-0">System-wide customer registry across all participating banks</p>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Bank Name</th>
                            <th>Branch ID</th>
                            <th>Status</th>
                            <th>Nominee</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cust" items="${customers}">
                            <tr>
                                <td class="fw-bold text-primary">${cust.userId}</td>
                                <td>${cust.name}</td>
                                <td>${cust.email}</td>
                                <td>${cust.phoneNumber}</td>
                                <td>${cust.bankName}</td>
                                <td><span class="badge bg-secondary">${cust.branchId}</span></td>
                                <td>
                                    <span class="badge ${cust.status eq 'ACTIVE' ? 'bg-success' : (cust.status eq 'REGISTERED' ? 'bg-warning text-dark' : 'bg-danger')}">
                                        ${cust.status}
                                    </span>
                                </td>
                                <td>${empty cust.nomineeName ? '<span class=\"text-muted\">None</span>' : cust.nomineeName}</td>
                                <td class="text-center">
                                    <c:if test="${cust.status ne 'INACTIVE'}">
                                        <form action="${pageContext.request.contextPath}/admin/customer/delete" method="post" class="d-inline" onsubmit="return confirm('Deactivate this customer account?');">
                                            <input type="hidden" name="customerId" value="${cust.userId}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm"><i class="bi bi-person-x"></i> Deactivate</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${cust.status eq 'INACTIVE'}">
                                        <span class="text-muted small">Deactivated</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customers}">
                            <tr><td colspan="9" class="text-center text-muted py-4">No customers registered in the system.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>