<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports Hub | Admin</title>
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
        <h3 class="fw-bold text-dark">Banking & Financial Reports</h3>
        <p class="text-muted small">System summaries and audit views</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 p-3">
                <div class="card-body">
                    <h5 class="card-title text-primary"><i class="bi bi-building me-2"></i>Staff Directory</h5>
                    <p class="card-text text-muted small">Audit employee allocations and salary structures across branches.</p>
                    <a href="${pageContext.request.contextPath}/admin/view/employees" class="btn btn-outline-primary btn-sm">View Staff</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 p-3">
                <div class="card-body">
                    <h5 class="card-title text-success"><i class="bi bi-cash-stack me-2"></i>Loan Portfolio</h5>
                    <p class="card-text text-muted small">Audit all loan applications across schemes and approval statuses.</p>
                    <a href="${pageContext.request.contextPath}/loan/admin/pending" class="btn btn-outline-success btn-sm">Review Loans</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 p-3">
                <div class="card-body">
                    <h5 class="card-title text-dark"><i class="bi bi-people me-2"></i>Customer Roster</h5>
                    <p class="card-text text-muted small">Review customer profiles across branches.</p>
                    <a href="${pageContext.request.contextPath}/admin/view/customers" class="btn btn-outline-dark btn-sm">View Customers</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>