<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile | Core Banking</title>
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
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <div class="row g-4">
        <!-- Update Details -->
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom py-3">
                    <h5 class="mb-0 text-primary fw-bold"><i class="bi bi-person-lines-fill me-2"></i>Personal & Nominee Information</h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/customer/profile/update" method="post">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label text-muted">Customer ID</label>
                                <input type="text" class="form-control bg-light" value="${customer.userId}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label text-muted">Full Name</label>
                                <input type="text" class="form-control bg-light" value="${customer.name}" readonly>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label text-muted">Email</label>
                                <input type="email" class="form-control bg-light" value="${customer.email}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Phone Number *</label>
                                <input type="tel" name="phoneNumber" class="form-control" value="${customer.phoneNumber}" pattern="[6-9][0-9]{9}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Residential Address</label>
                            <textarea name="address" class="form-control" rows="2">${customer.address}</textarea>
                        </div>

                        <h6 class="text-secondary border-bottom pb-2 mt-4 mb-3">Nominee Details</h6>
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label">Nominee Name</label>
                                <input type="text" name="nomineeName" class="form-control" value="${customer.nomineeName}">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Relationship</label>
                                <input type="text" name="nomineeRelationship" class="form-control" value="${customer.nomineeRelationship}">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Nominee Phone</label>
                                <input type="tel" name="nomineePhoneNumber" class="form-control" value="${customer.nomineePhoneNumber}">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Change Password -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white border-bottom py-3">
                    <h5 class="mb-0 text-dark fw-bold"><i class="bi bi-key-fill me-2"></i>Change Password</h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/customer/profile/change-password" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Current Password *</label>
                            <input type="password" name="oldPassword" class="form-control" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold">New Password *</label>
                            <input type="password" name="newPassword" class="form-control" placeholder="Min 8 chars, 1 uppercase, 1 digit, 1 symbol" required>
                        </div>
                        <button type="submit" class="btn btn-dark w-100">Update Password</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>