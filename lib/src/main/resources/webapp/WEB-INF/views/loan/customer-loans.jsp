<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Loans | Core Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/customer/dashboard">
            <i class="bi bi-bank2 me-2"></i>Customer Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/customer/dashboard" class="btn btn-outline-light btn-sm">← Back</a>
    </div>
</nav>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">My Loan Applications</h3>
            <p class="text-muted small mb-0">Track application status and principal details</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/loan/emis" class="btn btn-danger btn-sm me-2">Pay EMIs</a>
            <a href="${pageContext.request.contextPath}/loan/apply" class="btn btn-warning btn-sm">Apply New Loan</a>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Loan ID</th>
                            <th>Loan Scheme</th>
                            <th>Principal (₹)</th>
                            <th>Interest Rate</th>
                            <th>Tenure</th>
                            <th>Application Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="loan" items="${loans}">
                            <tr>
                                <td class="fw-bold text-primary">${loan.loanId}</td>
                                <td><span class="badge bg-secondary">${loan.loanType}</span></td>
                                <td class="fw-bold text-success">₹${loan.loanAmount}</td>
                                <td>${loan.interestRate}% p.a.</td>
                                <td>${loan.tenureMonths} Months</td>
                                <td>
                                    <span class="badge ${loan.status eq 'APPROVED' ? 'bg-success' : (loan.status eq 'PENDING' ? 'bg-warning text-dark' : 'bg-danger')}">
                                        ${loan.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty loans}">
                            <tr><td colspan="6" class="text-center text-muted py-4">No loans applied yet.</td></tr>
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