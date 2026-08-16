<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | ${admin.bankName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-shield-lock-fill me-2"></i>${admin.bankName} - Admin Console
        </a>
        <div class="d-flex align-items-center text-white">
            <span class="me-3">Admin: <strong>${admin.name}</strong> (${admin.userId}) | Branch: <span class="badge bg-secondary">${admin.branchId}</span></span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row mb-4">
        <div class="col">
            <h2 class="fw-bold text-dark">System Administration</h2>
            <p class="text-muted">Manage staff personnel, customer directory, loan reviews, and reports.</p>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-primary mb-3"><i class="bi bi-people-fill display-5"></i></div>
                <h5 class="fw-bold">Staff Management</h5>
                <p class="text-muted small">Onboard employees, view staff roster, and toggle account statuses.</p>
                <a href="${pageContext.request.contextPath}/admin/view/employees" class="btn btn-outline-primary w-100 mt-auto">Manage Staff</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-success mb-3"><i class="bi bi-person-lines-fill display-5"></i></div>
                <h5 class="fw-bold">Customer Directory</h5>
                <p class="text-muted small">Inspect registered customers across all branches and deactivate accounts.</p>
                <a href="${pageContext.request.contextPath}/admin/view/customers" class="btn btn-outline-success w-100 mt-auto">View Customers</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-warning mb-3"><i class="bi bi-cash-coin display-5"></i></div>
                <h5 class="fw-bold">Loan Processing</h5>
                <p class="text-muted small">Review pending credit applications and approve to generate monthly EMIs.</p>
                <a href="${pageContext.request.contextPath}/loan/admin/pending" class="btn btn-outline-warning w-100 mt-auto">Review Loans</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm border-0 text-center p-4">
                <div class="text-info mb-3"><i class="bi bi-bar-chart-line-fill display-5"></i></div>
                <h5 class="fw-bold">Reports & Audits</h5>
                <p class="text-muted small">Audit bank distributions, active staff counts, and loan portfolios.</p>
                <a href="${pageContext.request.contextPath}/admin/reports" class="btn btn-outline-info w-100 mt-auto">Open Reports</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>