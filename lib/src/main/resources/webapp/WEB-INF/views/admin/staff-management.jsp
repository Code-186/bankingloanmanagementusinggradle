<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Management | Admin</title>
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Bank Employee Directory</h3>
            <p class="text-muted small mb-0">Manage and onboard official bank employees</p>
        </div>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerEmployeeModal">
            <i class="bi bi-person-plus-fill me-1"></i> Onboard New Employee
        </button>
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
                            <th>Employee ID</th>
                            <th>Full Name</th>
                            <th>Official Email</th>
                            <th>Phone</th>
                            <th>Designation</th>
                            <th>Salary (₹)</th>
                            <th>Branch ID</th>
                            <th>Status</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="emp" items="${employees}">
                            <tr>
                                <td class="fw-bold text-primary">${emp.userId}</td>
                                <td>${emp.name}</td>
                                <td>${emp.email}</td>
                                <td>${emp.phoneNumber}</td>
                                <td><span class="badge bg-info text-dark">${emp.designation}</span></td>
                                <td>₹${emp.salary}</td>
                                <td><span class="badge bg-secondary">${emp.branchId}</span></td>
                                <td>
                                    <span class="badge ${emp.status eq 'ACTIVE' ? 'bg-success' : 'bg-danger'}">${emp.status}</span>
                                </td>
                                <td class="text-center">
                                    <c:if test="${emp.status eq 'ACTIVE'}">
                                        <form action="${pageContext.request.contextPath}/admin/employee/delete" method="post" class="d-inline" onsubmit="return confirm('Deactivate this employee account?');">
                                            <input type="hidden" name="employeeId" value="${emp.userId}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm"><i class="bi bi-person-x"></i> Deactivate</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${emp.status ne 'ACTIVE'}">
                                        <span class="text-muted small">Inactive</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty employees}">
                            <tr><td colspan="9" class="text-center text-muted py-4">No employees registered yet.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Onboard Employee -->
<div class="modal fade" id="registerEmployeeModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/employee/register" method="post">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title"><i class="bi bi-person-plus-fill me-2"></i>Onboard Employee</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Full Name *</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Official Bank Email *</label>
                            <input type="email" name="email" class="form-control" placeholder="user@officialdomain" required>
                        </div>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Phone Number *</label>
                            <input type="tel" name="phone" class="form-control" pattern="[6-9][0-9]{9}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Date of Birth *</label>
                            <input type="date" name="dob" class="form-control" required>
                        </div>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Designation *</label>
                            <input type="text" name="designation" class="form-control" placeholder="e.g. Branch Officer / Teller" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Monthly Salary (₹) *</label>
                            <input type="number" step="0.01" name="salary" class="form-control" placeholder="50000.00" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password *</label>
                        <input type="password" name="password" class="form-control" placeholder="Min 8 chars with uppercase, digit & symbol" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Residential Address</label>
                        <textarea name="address" class="form-control" rows="2"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Create Employee Account</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>