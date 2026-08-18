<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Portal | Internet Banking</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #f8fafc; color: #0f172a; }
        
        .navbar { background-color: #1e3a8a; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-brand { font-size: 1.25rem; font-weight: 700; }
        .nav-links { display: flex; gap: 1rem; align-items: center; }
        .btn-logout { background-color: #ef4444; color: white; padding: 0.4rem 0.8rem; border-radius: 6px; text-decoration: none; font-size: 0.85rem; }

        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .grid-menu { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .menu-card { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); text-decoration: none; color: inherit; transition: transform 0.2s, box-shadow 0.2s; border-top: 4px solid #1e3a8a; }
        .menu-card:hover { transform: translateY(-3px); box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .menu-card h4 { font-size: 1.1rem; color: #1e3a8a; margin-bottom: 0.5rem; }
        .menu-card p { font-size: 0.85rem; color: #64748b; }

        .card { background: white; border-radius: 8px; padding: 1.5rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 1.5rem; }
        table { width: 100%; border-collapse: collapse; text-align: left; margin-top: 1rem; }
        th { background-color: #0f172a; color: white; padding: 0.75rem 1rem; font-size: 0.85rem; }
        td { padding: 0.85rem 1rem; border-bottom: 1px solid #e2e8f0; font-size: 0.9rem; }
        .badge { padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.75rem; font-weight: 700; }
        .badge-active { background-color: #dcfce7; color: #166534; }
    </style>
</head>
<body>

    <header class="navbar">
        <div class="nav-brand">🏦 ${sessionScope.loggedUser.bankName} Online Banking</div>
        <div class="nav-links">
            <span>Welcome, <strong>${sessionScope.loggedUser.name}</strong> (ID: ${sessionScope.loggedUser.customerId})</span>
            <a href="${pageContext.request.contextPath}/customer/profile" style="color: #93c5fd; text-decoration: none; font-size: 0.9rem;">My Profile</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </header>

    <div class="container">
        
        <div class="grid-menu">
            <a href="${pageContext.request.contextPath}/account/transfer" class="menu-card">
                <h4>💸 Transfer Funds</h4>
                <p>Transfer money securely to registered beneficiaries using your 4-digit MPIN.</p>
            </a>
            <a href="${pageContext.request.contextPath}/beneficiary/list" class="menu-card">
                <h4>👥 Beneficiary Management</h4>
                <p>Add, search, and manage verified payee beneficiary accounts.</p>
            </a>
            <a href="${pageContext.request.contextPath}/loan/apply" class="menu-card">
                <h4>📝 Apply for Loan</h4>
                <p>Submit applications for Personal, Home, or Vehicle loans instantly.</p>
            </a>
            <a href="${pageContext.request.contextPath}/loan/my-emis" class="menu-card">
                <h4>💳 Repay EMI</h4>
                <p>View upcoming loan installments and pay monthly EMIs with MPIN validation.</p>
            </a>
        </div>

        <div class="card">
            <div style="display:flex; justify-content: space-between; align-items:center;">
                <h3>My Active Bank Accounts</h3>
                <a href="${pageContext.request.contextPath}/account/statement" style="color:#2563eb; text-decoration:none; font-weight:600; font-size:0.9rem;">View Transaction Passbook &rarr;</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Account Number</th>
                        <th>Account Type</th>
                        <th>Current Balance</th>
                        <th>Opening Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="acc" items="${accountList}">
                        <tr>
                            <td><strong>${acc.accountNumber}</strong></td>
                            <td>${acc.accountType}</td>
                            <td><strong style="color:#166534;">₹ ${acc.balance}</strong></td>
                            <td>${acc.openingDate}</td>
                            <td><span class="badge badge-active">${acc.accountStatus}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

</body>
</html>