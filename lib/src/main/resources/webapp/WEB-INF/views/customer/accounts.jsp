<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Accounts | Core Banking</title>
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

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">My Bank Accounts</h3>
            <p class="text-muted small mb-0">Overview of your active Savings and Current accounts</p>
        </div>
        <a href="${pageContext.request.contextPath}/account/transfer" class="btn btn-success">
            <i class="bi bi-arrow-left-right me-1"></i> Transfer Funds
        </a>
    </div>

    <div class="row g-4">
        <c:forEach var="acc" items="${accounts}">
            <div class="col-md-6">
                <div class="card shadow-sm border-0 h-100">
                    <div class="card-header bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
                        <span class="badge ${acc.accountType eq 'SAVINGS' ? 'bg-primary' : 'bg-dark'} px-3 py-2">
                            ${acc.accountType} ACCOUNT
                        </span>
                        <span class="badge ${acc.accountStatus eq 'ACTIVE' ? 'bg-success' : 'bg-warning text-dark'}">
                            ${acc.accountStatus}
                        </span>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-3">
                            <small class="text-muted text-uppercase fw-bold">Account Number</small>
                            <h4 class="fw-bold text-primary font-monospace mt-1">${acc.accountNumber}</h4>
                        </div>
                        <div class="mb-4">
                            <small class="text-muted text-uppercase fw-bold">Available Balance</small>
                            <h2 class="fw-bold text-dark mt-1">₹${acc.balance}</h2>
                        </div>
                        <div class="row g-2 border-top pt-3 text-muted small">
                            <div class="col-6">
                                <strong>Min. Balance:</strong> ₹${acc.minimumBalance}
                            </div>
                            <div class="col-6">
                                <strong>Date Opened:</strong> ${acc.dateOpened}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty accounts}">
            <div class="col-12">
                <div class="card shadow-sm border-0 text-center py-5">
                    <div class="text-muted mb-3"><i class="bi bi-wallet2 display-3"></i></div>
                    <h5 class="fw-bold">No Active Accounts Found</h5>
                    <p class="text-muted">You do not have any open accounts yet. Please visit your branch to open an account.</p>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>