<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Loan EMIs | Core Banking</title>
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

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Monthly EMI Schedule</h3>
            <p class="text-muted small mb-0">Scheduled installments and inline payments</p>
        </div>
        <a href="${pageContext.request.contextPath}/loan/my-loans" class="btn btn-outline-secondary btn-sm">View My Loans</a>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>EMI ID</th>
                            <th>Loan ID</th>
                            <th>Installment (₹)</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="emi" items="${emis}">
                            <tr>
                                <td class="fw-bold text-primary">${emi.emiId}</td>
                                <td><span class="badge bg-secondary">${emi.loanId}</span></td>
                                <td class="fw-bold">₹${emi.emiAmount}</td>
                                <td>${emi.dueDate}</td>
                                <td>
                                    <span class="badge ${emi.status eq 'PAID' ? 'bg-success' : 'bg-danger'}">${emi.status}</span>
                                </td>
                                <td class="text-center">
                                    <c:if test="${emi.status eq 'UNPAID'}">
                                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#payModal_${emi.emiId}">
                                            <i class="bi bi-credit-card me-1"></i> Pay Now
                                        </button>

                                        <!-- Pay EMI Modal -->
                                        <div class="modal fade" id="payModal_${emi.emiId}" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content text-start">
                                                    <form action="${pageContext.request.contextPath}/loan/pay-emi" method="post">
                                                        <input type="hidden" name="emiId" value="${emi.emiId}">
                                                        <div class="modal-header bg-primary text-white">
                                                            <h5 class="modal-title">Pay EMI (${emi.emiId})</h5>
                                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body p-4">
                                                            <p>Amount to Pay: <strong class="text-success fs-5">₹${emi.emiAmount}</strong></p>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Select Debit Account *</label>
                                                                <select name="accountNumber" class="form-select" required>
                                                                    <c:forEach var="acc" items="${accounts}">
                                                                        <option value="${acc.accountNumber}">${acc.accountNumber} (${acc.accountType}) - Bal: ₹${acc.balance}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Enter 4-Digit MPIN *</label>
                                                                <input type="password" name="mpin" class="form-control" maxlength="4" pattern="\d{4}" placeholder="••••" required>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-success">Authorize Payment</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${emi.status eq 'PAID'}">
                                        <span class="text-success small fw-bold"><i class="bi bi-check-circle-fill me-1"></i>Settled</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty emis}">
                            <tr><td colspan="6" class="text-center text-muted py-4">No active EMIs found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>