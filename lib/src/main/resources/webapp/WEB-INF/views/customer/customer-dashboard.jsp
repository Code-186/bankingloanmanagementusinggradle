<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard | Core Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/customer/dashboard">
            <i class="bi bi-bank2 me-2"></i>${customer.bankName}
        </a>
        <div class="d-flex align-items-center text-white">
            <span class="me-3">
                Welcome, <strong>${customer.name}</strong> (${customer.userId}) | 
                Branch: <span class="badge bg-light text-dark">${customer.branchId}</span>
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">
                <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <c:if test="${customer.status eq 'REGISTERED'}">
        <div class="alert alert-warning shadow-sm mb-4">
            <i class="bi bi-exclamation-circle-fill me-2"></i>
            <strong>Account Pending Activation:</strong> You are currently self-registered. Please visit branch <strong>${customer.branchId}</strong> to deposit initial funds and activate your account.
        </div>
    </c:if>

    <div class="row mb-4">
        <div class="col">
            <h2 class="fw-bold text-dark">Digital Banking Portal</h2>
            <p class="text-muted">Manage your accounts, transfer funds, track loans, and manage payees in one place.</p>
        </div>
    </div>

    <div class="row g-4">
        <!-- 1. Accounts & Passbook -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body text-center p-4">
                    <div class="text-primary mb-3">
                        <i class="bi bi-wallet2 display-5"></i>
                    </div>
                    <h5 class="card-title fw-bold">My Accounts & Balance</h5>
                    <p class="card-text text-muted small">View active Savings and Current accounts, live balances, and account details.</p>
                    <a href="${pageContext.request.contextPath}/account/my-accounts" class="btn btn-outline-primary w-100">View Accounts</a>
                </div>
            </div>
        </div>

        <!-- 2. Transfer Funds -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body text-center p-4">
                    <div class="text-success mb-3">
                        <i class="bi bi-arrow-left-right display-5"></i>
                    </div>
                    <h5 class="card-title fw-bold">Fund Transfer</h5>
                    <p class="card-text text-muted small">Transfer funds to beneficiaries or another account using your secure 4-digit MPIN.</p>
                    <a href="${pageContext.request.contextPath}/account/transfer" class="btn btn-outline-success w-100">Transfer Money</a>
                </div>
            </div>
        </div>

        <!-- 3. Beneficiary Management -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body text-center p-4">
                    <div class="text-info mb-3">
                        <i class="bi bi-person-check-fill display-5"></i>
                    </div>
                    <h5 class="card-title fw-bold">Manage Beneficiaries</h5>
                    <p class="card-text text-muted small">Add new payees, search verified accounts, and manage your transfer list.</p>
                    <a href="${pageContext.request.contextPath}/beneficiary/list" class="btn btn-outline-info w-100">Beneficiary Desk</a>
                </div>
            </div>
        </div>

        <!-- 4. Apply for Loan -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body text-center p-4">
                    <div class="text-warning mb-3">
                        <i class="bi bi-cash-stack display-5"></i>
                    </div>
                    <h5 class="card-title fw-bold">Apply for a Loan</h5>
                    <p class="card-text text-muted small">Submit applications for Home Loans or Personal Loans with flexible tenures.</p>
                    <a href="${pageContext.request.contextPath}/loan/apply" class="btn btn-outline-warning w-100">Apply Loan</a>
                </div>
            </div>
        </div>

        <!-- 5. Loan Portfolio & EMI Repayment -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body text-center p-4">
                    <div class="text-danger mb-3">
                        <i class="bi bi-calendar2-check-fill display-5"></i>
                    </div>
                    <h5 class="card-title fw-bold">My Loans & EMI Desk</h5>
                    <p class="card-text text-muted small">Track application status, inspect scheduled monthly EMIs, and pay upcoming installments.</p>
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/loan/my-loans" class="btn btn-outline-secondary w-50 btn-sm">My Loans</a>
                        <a href="${pageContext.request.contextPath}/loan/emis" class="btn btn-outline-danger w-50 btn-sm">Pay EMIs</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 6. Profile & Security -->
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body text-center p-4">
                    <div class="text-dark mb-3">
                        <i class="bi bi-person-gear display-5"></i>
                    </div>
                    <h5 class="card-title fw-bold">Profile & Password</h5>
                    <p class="card-text text-muted small">Update phone, residential address, nominee information, or change password.</p>
                    <a href="${pageContext.request.contextPath}/customer/profile" class="btn btn-outline-dark w-100">Manage Profile</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>