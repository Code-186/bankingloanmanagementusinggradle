<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Branch Customers | Staff Desk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/employee/dashboard">
            <i class="bi bi-bank2 me-2"></i>Staff Desk
        </a>
        <a href="${pageContext.request.contextPath}/employee/dashboard" class="btn btn-outline-light btn-sm">← Back</a>
    </div>
</nav>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Branch Customer Directory</h3>
            <p class="text-muted small mb-0">All customers registered under your branch</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/account/open" class="btn btn-primary btn-sm me-2">
                <i class="bi bi-plus-circle me-1"></i> Open Account
            </a>
            <a href="${pageContext.request.contextPath}/employee/customer/register" class="btn btn-success btn-sm">
                <i class="bi bi-person-plus me-1"></i> Onboard Customer
            </a>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>DOB</th>
                            <th>Nominee</th>
                            <th>Status</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cust" items="${customers}">
                            <tr>
                                <td class="fw-bold text-primary">${cust.userId}</td>
                                <td>${cust.name}</td>
                                <td>${cust.email}</td>
                                <td>${cust.phoneNumber}</td>
                                <td>${cust.dateOfBirth}</td>
                                <td>${empty cust.nomineeName ? '<span class=\"text-muted\">None</span>' : cust.nomineeName}</td>
                                <td>
                                    <span class="badge ${cust.status eq 'ACTIVE' ? 'bg-success' : (cust.status eq 'REGISTERED' ? 'bg-warning text-dark' : 'bg-danger')}">
                                        ${cust.status}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/employee/customer/${cust.userId}" class="btn btn-outline-primary btn-sm">
                                        <i class="bi bi-eye"></i> View Profile & Accounts
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customers}">
                            <tr>
                                <td colspan="8" class="text-center text-muted py-4">No customers found for this branch.</td>
                            </tr>
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