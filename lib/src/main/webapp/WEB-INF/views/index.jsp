<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Core Banking & Loan System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100 py-5">
<div class="container">
    <div class="text-center mb-5">
        <h1 class="display-5 fw-bold text-primary"><i class="bi bi-bank me-2"></i>Core Banking System</h1>
        <p class="lead text-muted">Select your portal access point</p>
    </div>

    <div class="row g-4 justify-content-center">
        <!-- Customer Portal -->
        <div class="col-md-4">
            <div class="card shadow-sm h-100 text-center p-4 border-0">
                <div class="text-primary mb-3"><i class="bi bi-person-circle display-4"></i></div>
                <h4 class="card-title text-primary fw-bold">Customer Portal</h4>
                <p class="text-muted small">Access accounts, transfer funds, manage payees, and apply for loans.</p>
                <div class="d-grid gap-2 mt-auto">
                    <a href="${pageContext.request.contextPath}/login?role=CUSTOMER" class="btn btn-primary">Customer Login</a>
                    <a href="${pageContext.request.contextPath}/register/customer" class="btn btn-outline-primary">Self-Registration</a>
                </div>
            </div>
        </div>

        <!-- Employee Desk -->
        <div class="col-md-4">
            <div class="card shadow-sm h-100 text-center p-4 border-0">
                <div class="text-success mb-3"><i class="bi bi-briefcase-fill display-4"></i></div>
                <h4 class="card-title text-success fw-bold">Employee Desk</h4>
                <p class="text-muted small">Onboard branch customers, open accounts, and process cash transactions.</p>
                <div class="d-grid gap-2 mt-auto">
                    <a href="${pageContext.request.contextPath}/login?role=EMPLOYEE" class="btn btn-success">Employee Login</a>
                </div>
            </div>
        </div>

        <!-- Admin Console -->
        <div class="col-md-4">
            <div class="card shadow-sm h-100 text-center p-4 border-0">
                <div class="text-dark mb-3"><i class="bi bi-shield-lock-fill display-4"></i></div>
                <h4 class="card-title text-dark fw-bold">Admin Portal</h4>
                <p class="text-muted small">Manage staff, bank branches, review loan applications, and audit reports.</p>
                <div class="d-grid gap-2 mt-auto">
                    <a href="${pageContext.request.contextPath}/login?role=ADMIN" class="btn btn-dark">Admin Login</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>