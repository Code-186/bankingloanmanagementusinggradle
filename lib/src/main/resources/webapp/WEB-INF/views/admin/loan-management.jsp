<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Loan Approvals | Admin</title>
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
        <h3 class="fw-bold text-dark mb-0">Loan Processing & Approvals</h3>
        <p class="text-muted small mb-0">Review pending loan applications and auto-generate EMI schedules upon approval</p>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-header bg-warning bg-opacity-10 border-0 py-3">
            <h5 class="mb-0 text-dark fw-bold"><i class="bi bi-clock-history me-2 text-warning"></i>Pending Loan Applications</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Loan ID</th>
                            <th>Customer ID</th>
                            <th>Loan Type</th>
                            <th>Principal (₹)</th>
                            <th>Interest Rate</th>
                            <th>Tenure</th>
                            <th>Status</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="loan" items="${loans}">
                            <tr>
                                <td class="fw-bold text-primary">${loan.loanId}</td>
                                <td><strong>${loan.customerId}</strong></td>
                                <td><span class="badge bg-secondary">${loan.loanType}</span></td>
                                <td class="fw-bold text-success">₹${loan.loanAmount}</td>
                                <td>${loan.interestRate}% p.a.</td>
                                <td>${loan.tenureMonths} Months</td>
                                <td><span class="badge bg-warning text-dark">${loan.status}</span></td>
                                <td class="text-center">
                                    <c:if test="${loan.status eq 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/loan/admin/approve/${loan.loanId}" method="post" class="d-inline" onsubmit="return confirm('Approve loan and generate EMI schedule?');">
                                            <button type="submit" class="btn btn-success btn-sm me-1"><i class="bi bi-check-lg"></i> Approve</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/loan/admin/reject/${loan.loanId}" method="post" class="d-inline" onsubmit="return confirm('Reject this loan application?');">
                                            <button type="submit" class="btn btn-danger btn-sm"><i class="bi bi-x-lg"></i> Reject</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${loan.status ne 'PENDING'}">
                                        <span class="text-muted small">${loan.status}</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty loans}">
                            <tr><td colspan="8" class="text-center text-muted py-4">No pending loan applications waiting for review.</td></tr>
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