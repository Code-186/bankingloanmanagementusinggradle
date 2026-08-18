<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Registration</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background-color: #f1f5f9; padding: 30px; display: flex; justify-content: center; }
        .form-card { background: white; border: 1px solid #cbd5e1; border-radius: 6px; width: 650px; padding: 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        h2 { margin-bottom: 20px; color: #0f172a; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; }
        .alert-error { background: #fee2e2; color: #991b1b; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 13px; border: 1px solid #fecaca; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .form-group { display: flex; flex-direction: column; gap: 5px; }
        .full-width { grid-column: span 2; }
        label { font-size: 13px; font-weight: bold; color: #334155; }
        input, select, textarea { padding: 8px 10px; border: 1px solid #cbd5e1; border-radius: 4px; font-size: 13px; }
        input[readonly] { background-color: #e2e8f0; cursor: not-allowed; }
        .actions-group { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; border-top: 1px solid #e2e8f0; padding-top: 15px; }
        .btn { padding: 8px 18px; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; text-decoration: none; font-size: 13px; }
        .btn-submit { background: #0284c7; color: white; }
        .btn-cancel { background: #e2e8f0; color: #475569; }
    </style>
</head>
<body>

<div class="form-card">
    <h2>===== 1.1 REGISTER EMPLOYEE =====</h2>

    <c:if test="${not empty error}">
        <div class="alert-error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/employees/register" method="POST">
        <div class="form-grid">
            <div class="form-group">
                <label for="name">Full Name *</label>
                <input type="text" id="name" name="name" placeholder="e.g. Sunil Kumar" required>
            </div>
            <div class="form-group">
                <label for="email">Official Email *</label>
                <input type="email" id="email" name="email" placeholder="e.g. sunil.kumar@sbi.co.in" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number *</label>
                <input type="text" id="phone" name="phone" placeholder="10-digit mobile number" required>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth *</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label>Bank Assignment</label>
                <input type="text" value="${admin.bankName}" readonly>
            </div>
            <div class="form-group">
                <label>Branch ID</label>
                <input type="text" value="${admin.branchId}" readonly>
            </div>
            <div class="form-group">
                <label for="role">Designation / Role *</label>
                <select id="role" name="role" required>
                    <option value="Loan Officer">Loan Officer</option>
                    <option value="Verification Executive">Verification Executive</option>
                    <option value="Branch Accountant">Branch Accountant</option>
                    <option value="Customer Service Officer">Customer Service Officer</option>
                </select>
            </div>
            <div class="form-group">
                <label for="salary">Monthly Salary (INR) *</label>
                <input type="number" step="0.01" id="salary" name="salary" placeholder="50000.00" required>
            </div>
            <div class="form-group full-width">
                <label for="password">Initial Password *</label>
                <input type="password" id="password" name="password" placeholder="Min 8 chars (Upper, Lower, Num, Special)" required>
            </div>
            <div class="form-group full-width">
                <label for="address">Residential Address</label>
                <textarea id="address" name="address" rows="2" placeholder="Residential address details..."></textarea>
            </div>
        </div>

        <div class="actions-group">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-cancel">Cancel</a>
            <button type="submit" class="btn btn-submit">Register Employee</button>
        </div>
    </form>
</div>

</body>
</html>