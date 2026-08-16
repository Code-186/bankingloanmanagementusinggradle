<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Registration | Core Banking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light py-5">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">

            <c:choose>
                <%-- Success Feedback Card --%>
                <c:when test="${not empty customer}">
                    <div class="card shadow border-0 p-4 text-center">
                        <div class="mb-3 text-success">
                            <i class="bi bi-check-circle-fill display-2"></i>
                        </div>
                        <h3 class="fw-bold text-success">Registration Successful!</h3>
                        <p class="text-muted">Your customer profile has been saved.</p>

                        <div class="bg-light p-3 rounded text-start my-3 border">
                            <div class="row mb-2">
                                <div class="col-5 fw-bold text-secondary">Customer ID:</div>
                                <div class="col-7 text-primary fw-bold fs-5">${customer.userId}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5 fw-bold text-secondary">Full Name:</div>
                                <div class="col-7">${customer.name}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5 fw-bold text-secondary">Bank:</div>
                                <div class="col-7">${customer.bankName}</div>
                            </div>
                            <div class="row mb-2">
                                <div class="col-5 fw-bold text-secondary">Branch ID:</div>
                                <div class="col-7"><span class="badge bg-secondary">${customer.branchId}</span></div>
                            </div>
                            <div class="row">
                                <div class="col-5 fw-bold text-secondary">Status:</div>
                                <div class="col-7"><span class="badge bg-warning text-dark">${customer.status}</span></div>
                            </div>
                        </div>

                        <div class="alert alert-info text-start small">
                            <i class="bi bi-info-circle-fill me-1"></i>
                            <strong>Next Step:</strong> Visit your branch to open an active Savings or Current account.
                        </div>

                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/login?role=CUSTOMER" class="btn btn-primary btn-lg">Proceed to Login</a>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">Back to Home</a>
                        </div>
                    </div>
                </c:when>

                <%-- Registration Form --%>
                <c:otherwise>
                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-header bg-primary text-white p-3 text-center">
                            <h4 class="mb-1"><i class="bi bi-person-plus-fill me-2"></i>Customer Self-Registration</h4>
                            <p class="small mb-0 opacity-75">Initiate your bank onboarding digitally</p>
                        </div>
                        <div class="card-body p-4">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/register/customer" method="post">
                                <div class="mb-4 p-3 bg-light rounded border">
                                    <label class="form-label fw-bold text-primary"><i class="bi bi-bank2 me-1"></i>Select Bank Branch *</label>
                                    <select name="bankName" class="form-select form-select-lg" required>
                                        <option value="" disabled selected>-- Choose Bank --</option>
                                        <c:forEach var="bank" items="${banks}">
                                            <option value="${bank.key}">${bank.key} (Branch Code: ${bank.value})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <h5 class="text-secondary border-bottom pb-2 mb-3">1. Personal Information</h5>
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Full Name *</label>
                                        <input type="text" name="name" class="form-control" placeholder="Rahul Sharma" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Date of Birth (18+) *</label>
                                        <input type="date" name="dob" class="form-control" required>
                                    </div>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Email Address *</label>
                                        <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Mobile Number *</label>
                                        <input type="tel" name="phone" class="form-control" pattern="[6-9][0-9]{9}" placeholder="10-digit number" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Residential Address</label>
                                    <textarea name="address" class="form-control" rows="2" placeholder="Full street, city, pin"></textarea>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Create Password *</label>
                                    <input type="password" name="password" class="form-control" placeholder="Min 8 chars, 1 uppercase, 1 digit, 1 symbol" required>
                                </div>

                                <h5 class="text-secondary border-bottom pb-2 mb-3">2. Nominee Details (Optional)</h5>
                                <div class="row g-3 mb-4">
                                    <div class="col-md-4">
                                        <input type="text" name="nomineeName" class="form-control" placeholder="Nominee Name">
                                    </div>
                                    <div class="col-md-4">
                                        <input type="text" name="nomineeRelationship" class="form-control" placeholder="Relationship">
                                    </div>
                                    <div class="col-md-4">
                                        <input type="tel" name="nomineePhone" class="form-control" pattern="[6-9][0-9]{9}" placeholder="Nominee Phone">
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg shadow-sm">Submit Registration</button>
                                    <a href="${pageContext.request.contextPath}/login?role=CUSTOMER" class="btn btn-outline-secondary">Already registered? Log in</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>