<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Core Banking Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="text-center mb-5">
        <h1 class="display-5 fw-bold text-primary">Core Banking & Loan System</h1>
        <p class="lead text-muted">Select your portal access point</p>
    </div>

    <div class="row g-4 justify-content-center">
        <!-- Customer Card -->
        <div class="col-md-4">
            <div class="card shadow-sm h-100 text-center p-4 border-0">
                <h4 class="card-title text-primary">Customer Portal</h4>
                <p class="text-muted">Access your accounts, transfer funds, apply for loans, and manage EMIs.</p>
                <div class="d-grid gap-2 mt-auto">
                    <a href="${pageContext.request.contextPath}/login?role=CUSTOMER" class="btn btn-primary">Customer Login</a>
                    <a href="${pageContext.request.contextPath}/register/customer" class="btn btn-outline-primary">Self Registration</a>
                </div>
            </div>
        </div>

        <!-- Employee Card -->
        <div class="col-md-4">
            <div class="card shadow-sm h-100 text-center p-4 border-0">
                <h4 class="card-title text-success">Employee Desk</h4>
                <p class="text-muted">Onboard branch customers, open accounts, handle deposits and teller withdrawals.</p>
                <div class="d-grid gap-2 mt-auto">
                    <a href="${pageContext.request.contextPath}/login?role=EMPLOYEE" class="btn btn-success">Employee Login</a>
                </div>
            </div>
        </div>

        <!-- Admin Card -->
        <div class="col-md-4">
            <div class="card shadow-sm h-100 text-center p-4 border-0">
                <h4 class="card-title text-dark">Admin Portal</h4>
                <p class="text-muted">Manage staff, bank branches, view reports, and approve loan applications.</p>
                <div class="d-grid gap-2 mt-auto">
                    <a href="${pageContext.request.contextPath}/login?role=ADMIN" class="btn btn-dark">Admin Login</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>