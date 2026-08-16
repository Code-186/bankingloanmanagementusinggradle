<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assisted Onboarding | Staff Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light py-4">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-success text-white p-3 d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="mb-0"><i class="bi bi-person-plus-fill me-2"></i>Branch Assisted Customer Registration</h4>
                        <small class="opacity-75">Assigning to Branch: <strong>${branchId}</strong> (${bankName})</small>
                    </div>
                    <a href="${pageContext.request.contextPath}/employee/dashboard" class="btn btn-outline-light btn-sm">← Back</a>
                </div>

                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/employee/customer/register" method="post">
                        <div class="alert alert-secondary p-3 mb-4">
                            <div class="row">
                                <div class="col-md-6"><strong>Bank:</strong> ${bankName}</div>
                                <div class="col-md-6"><strong>Branch Code:</strong> <span class="badge bg-dark">${branchId}</span></div>
                            </div>
                        </div>

                        <h5 class="text-secondary border-bottom pb-2 mb-3">1. Personal Information</h5>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Full Name *</label>
                                <input type="text" name="name" class="form-control" placeholder="Customer full name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Date of Birth (18+) *</label>
                                <input type="date" name="dob" class="form-control" required>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Email Address *</label>
                                <input type="email" name="email" class="form-control" placeholder="customer@example.com" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phone Number *</label>
                                <input type="tel" name="phone" class="form-control" pattern="[6-9][0-9]{9}" placeholder="10-digit number" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Residential Address</label>
                            <textarea name="address" class="form-control" rows="2" placeholder="Full address"></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Temporary Portal Password *</label>
                            <input type="password" name="password" class="form-control" placeholder="Min 8 chars with uppercase, digit & symbol" required>
                        </div>

                        <h5 class="text-secondary border-bottom pb-2 mb-3">2. Nominee Details (Optional)</h5>
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <input type="text" name="nomineeName" class="form-control" placeholder="Nominee Full Name">
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="nomineeRelationship" class="form-control" placeholder="Relationship">
                            </div>
                            <div class="col-md-4">
                                <input type="tel" name="nomineePhone" class="form-control" pattern="[6-9][0-9]{9}" placeholder="Nominee Phone">
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg shadow-sm">Complete Customer Onboarding</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>