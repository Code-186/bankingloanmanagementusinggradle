<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Beneficiary Desk | Core Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
        <a class="navbar-brand fw-bold text-white" href="#">
            <i class="bi bi-person-check-fill me-2"></i>Beneficiary Management Desk
        </a>
        <a href="${pageContext.request.contextPath}/${sessionScope.userRole eq 'EMPLOYEE' ? 'employee/dashboard' : 'customer/dashboard'}" class="btn btn-outline-light btn-sm">← Back</a>
    </div>
</nav>

<div class="container py-4">
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <div class="row g-4">
        <!-- Add Beneficiary Form -->
        <div class="col-lg-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom py-3">
                    <h5 class="mb-0 fw-bold text-primary"><i class="bi bi-person-plus-fill me-2"></i>Add Payee</h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/beneficiary/add" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Beneficiary Name *</label>
                            <input type="text" name="name" class="form-control" placeholder="Payee Full Name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">12-Digit Account Number *</label>
                            <input type="text" name="accountNumber" class="form-control font-monospace" pattern="\d{12}" placeholder="100000000102" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold">Bank Name *</label>
                            <input type="text" name="bankName" class="form-control" placeholder="e.g. State Bank of India" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 fw-bold">Save Beneficiary</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Payee Directory -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom py-3">
                    <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-people-fill me-2"></i>Registered Payees</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Payee ID</th>
                                    <th>Payee Name</th>
                                    <th>Account Number</th>
                                    <th>Bank</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ben" items="${beneficiaries}">
                                    <tr>
                                        <td class="fw-bold text-primary">${ben.beneficiaryId}</td>
                                        <td>${ben.beneficiaryName}</td>
                                        <td class="font-monospace">${ben.beneficiaryAccountNumber}</td>
                                        <td>${ben.bankName}</td>
                                        <td class="text-center">
                                            <form action="${pageContext.request.contextPath}/beneficiary/remove" method="post" class="d-inline" onsubmit="return confirm('Remove this beneficiary?');">
                                                <input type="hidden" name="beneficiaryId" value="${ben.beneficiaryId}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty beneficiaries}">
                                    <tr><td colspan="5" class="text-center text-muted py-4">No beneficiaries added yet.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>