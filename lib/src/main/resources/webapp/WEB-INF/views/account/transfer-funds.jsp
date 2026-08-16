<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fund Transfer | Core Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light py-5">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-success text-white p-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-arrow-left-right me-2"></i>Fund Transfer</h5>
                    <a href="${pageContext.request.contextPath}/customer/dashboard" class="btn btn-outline-light btn-sm">← Back</a>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/account/transfer" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">From Account *</label>
                            <select name="fromAccount" class="form-select form-select-lg" required>
                                <option value="" disabled selected>-- Select Source Account --</option>
                                <c:forEach var="acc" items="${accounts}">
                                    <option value="${acc.accountNumber}">${acc.accountNumber} (${acc.accountType}) - Bal: ₹${acc.balance}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Recipient 12-Digit Account Number *</label>
                            <input type="text" name="toAccount" class="form-control form-control-lg font-monospace" pattern="\d{12}" placeholder="100000000102" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Transfer Amount (₹) *</label>
                            <input type="number" step="0.01" name="amount" class="form-control form-control-lg" placeholder="0.00" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Authorize with 4-Digit MPIN *</label>
                            <input type="password" name="mpin" class="form-control form-control-lg" maxlength="4" pattern="\d{4}" placeholder="••••" required>
                        </div>

                        <button type="submit" class="btn btn-success btn-lg w-100 shadow-sm fw-bold">
                            Confirm & Transfer Funds
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