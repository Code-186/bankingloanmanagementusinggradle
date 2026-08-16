<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Desk | ${employee.bankName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/employee/dashboard">
            <i class="bi bi-bank2 me-2"></i>${employee.bankName} - Staff Desk
        </a>
        <div class="d-flex align-items-center text-white">
            <span class="me-3">
                Officer: <strong>${employee.name}</strong> (${employee.userId}) | 
                Branch: <span class="badge bg-dark">${employee.branchId}</span>
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-4">
            <i class="bi bi-check-circle-fill me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row mb-4">
        <div class="col">
            <h2 class="fw-bold text-dark">Branch Operations Desk</h2>
            <p class="text-muted">Handle customer onboarding, account creations, teller deposits/withdrawals, and payees.</p>
        </div>
    </div>

    <div class="row g-4">
        <!-- 1. Customer Onboarding -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-success mb-3"><i class="bi bi-person-plus-fill display-5"></i></div>
                <h5 class="fw-bold">Customer Onboarding</h5>
                <p class="text-muted small">Register a customer profile locked to branch <strong>${employee.branchId}</strong>.</p>
                <a href="${pageContext.request.contextPath}/employee/customer/register" class="btn btn-outline-success w-100 mt-auto">Register Customer</a>
            </div>
        </div>

        <!-- 2. Open Account -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-primary mb-3"><i class="bi bi-wallet2 display-5"></i></div>
                <h5 class="fw-bold">Open Bank Account</h5>
                <p class="text-muted small">Open a Savings or Current Account, set MPIN, and collect initial deposit.</p>
                <a href="${pageContext.request.contextPath}/account/open" class="btn btn-outline-primary w-100 mt-auto">Open Account</a>
            </div>
        </div>

        <!-- 3. Branch Directory -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-info mb-3"><i class="bi bi-people-fill display-5"></i></div>
                <h5 class="fw-bold">Branch Customers</h5>
                <p class="text-muted small">Inspect registered customers under this branch and view their accounts.</p>
                <a href="${pageContext.request.contextPath}/employee/customers" class="btn btn-outline-info w-100 mt-auto">View Customers</a>
            </div>
        </div>

        <!-- 4. Teller Operations (Unified) -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-warning mb-3"><i class="bi bi-arrow-down-up display-5"></i></div>
                <h5 class="fw-bold">Teller Desk</h5>
                <p class="text-muted small">Process customer cash deposits and MPIN-authenticated withdrawals.</p>
                <a href="${pageContext.request.contextPath}/account/operations" class="btn btn-outline-warning w-100 mt-auto">Deposit / Withdraw</a>
            </div>
        </div>

        <!-- 5. Beneficiary Desk -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-secondary mb-3"><i class="bi bi-person-check-fill display-5"></i></div>
                <h5 class="fw-bold">Beneficiary Operations</h5>
                <p class="text-muted small">Search, verify, and manage customer payee registrations.</p>
                <a href="${pageContext.request.contextPath}/beneficiary/list" class="btn btn-outline-secondary w-100 mt-auto">Beneficiary Desk</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>