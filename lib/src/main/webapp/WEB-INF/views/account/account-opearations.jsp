<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teller Counter | Staff Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light py-5">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-dark text-white p-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-arrow-down-up me-2"></i>Teller Cash Counter</h5>
                    <a href="${pageContext.request.contextPath}/employee/dashboard" class="btn btn-outline-light btn-sm">← Back</a>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                    </c:if>

                    <!-- Nav Tabs for Deposit & Withdraw -->
                    <ul class="nav nav-pills nav-justified mb-4" id="tellerTab" role="tablist">
                        <li class="nav-item">
                            <button class="nav-link active fw-bold" id="deposit-tab" data-bs-toggle="pill" data-bs-target="#deposit-pane" type="button">
                                <i class="bi bi-box-arrow-in-down me-1"></i> Cash Deposit
                            </button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link fw-bold" id="withdraw-tab" data-bs-toggle="pill" data-bs-target="#withdraw-pane" type="button">
                                <i class="bi bi-box-arrow-up me-1"></i> Cash Withdrawal
                            </button>
                        </li>
                    </ul>

                    <div class="tab-content" id="tellerTabContent">
                        <!-- Deposit Form -->
                        <div class="tab-pane fade show active" id="deposit-pane">
                            <form action="${pageContext.request.contextPath}/account/deposit" method="post">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">12-Digit Account Number *</label>
                                    <input type="text" name="accountNumber" class="form-control form-control-lg font-monospace" pattern="\d{12}" placeholder="100000000101" required>
                                </div>
                                <div class="mb-4">
                                    <label class="form-label fw-bold">Deposit Amount (₹) *</label>
                                    <input type="number" step="0.01" name="amount" class="form-control form-control-lg" placeholder="0.00" required>
                                </div>
                                <button type="submit" class="btn btn-warning btn-lg w-100 fw-bold">Process Cash Deposit</button>
                            </form>
                        </div>

                        <!-- Withdraw Form -->
                        <div class="tab-pane fade" id="withdraw-pane">
                            <form action="${pageContext.request.contextPath}/account/withdraw" method="post">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">12-Digit Account Number *</label>
                                    <input type="text" name="accountNumber" class="form-control form-control-lg font-monospace" pattern="\d{12}" placeholder="100000000101" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Withdrawal Amount (₹) *</label>
                                    <input type="number" step="0.01" name="amount" class="form-control form-control-lg" placeholder="0.00" required>
                                </div>
                                <div class="mb-4">
                                    <label class="form-label fw-bold">Customer 4-Digit MPIN *</label>
                                    <input type="password" name="mpin" class="form-control form-control-lg" maxlength="4" pattern="\d{4}" placeholder="••••" required>
                                </div>
                                <button type="submit" class="btn btn-danger btn-lg w-100 fw-bold">Authorize & Withdraw</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>