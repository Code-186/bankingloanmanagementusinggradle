<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Apply Loan | Core Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light py-5">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-warning text-dark p-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-cash-stack me-2"></i>Apply for a Loan</h5>
                    <a href="${pageContext.request.contextPath}/customer/dashboard" class="btn btn-outline-dark btn-sm">← Back</a>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/loan/apply" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Loan Scheme *</label>
                            <select name="loanType" class="form-select form-select-lg" required>
                                <option value="HOME_LOAN">Home Loan (8.50% p.a. Fixed Interest)</option>
                                <option value="PERSONAL_LOAN">Personal Loan (12.00% p.a. Fixed Interest)</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Principal Amount (₹) *</label>
                            <input type="number" step="0.01" name="amount" class="form-control form-control-lg" placeholder="500000.00" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Tenure (In Months) *</label>
                            <select name="tenureMonths" class="form-select form-select-lg" required>
                                <option value="12">12 Months (1 Year)</option>
                                <option value="24">24 Months (2 Years)</option>
                                <option value="36">36 Months (3 Years)</option>
                                <option value="60">60 Months (5 Years)</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-warning btn-lg w-100 fw-bold shadow-sm">
                            Submit Application
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>