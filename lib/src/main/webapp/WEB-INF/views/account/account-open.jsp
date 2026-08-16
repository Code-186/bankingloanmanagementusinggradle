<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Open Account | Staff Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light py-4">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-primary text-white p-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-wallet2 me-2"></i>Open New Bank Account</h5>
                    <a href="${pageContext.request.contextPath}/employee/dashboard" class="btn btn-outline-light btn-sm">← Back</a>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/account/open" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Customer ID *</label>
                            <input type="text" name="customerId" class="form-control form-control-lg" placeholder="e.g. CUST1001" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Account Scheme *</label>
                            <select name="accountType" class="form-select form-select-lg" required>
                                <option value="SAVINGS">Savings Account (Min Deposit ₹1,000 | 4.0% Interest)</option>
                                <option value="CURRENT">Current Account (Min Deposit ₹5,000 | Overdraft ₹25,000)</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Initial Opening Deposit (₹) *</label>
                            <input type="number" step="0.01" name="initialDeposit" class="form-control form-control-lg" placeholder="e.g. 2000.00" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Set 4-Digit MPIN *</label>
                            <input type="password" name="mpin" class="form-control form-control-lg" maxlength="4" pattern="\d{4}" placeholder="••••" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100 shadow-sm fw-bold">
                            <i class="bi bi-check2-circle me-1"></i> Create & Activate Account
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