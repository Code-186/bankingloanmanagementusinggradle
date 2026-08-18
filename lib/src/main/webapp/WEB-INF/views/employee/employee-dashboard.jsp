<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Desk | Banking System</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #f1f5f9; color: #1e293b; display: flex; min-height: 100vh; }
        
        .sidebar { width: 260px; background-color: #0f172a; color: white; display: flex; flex-direction: column; flex-shrink: 0; }
        .sidebar-brand { padding: 1.5rem; font-size: 1.2rem; font-weight: 700; border-bottom: 1px solid #1e293b; }
        .sidebar-brand span { color: #10b981; display: block; font-size: 0.85rem; font-weight: normal; margin-top: 4px; }
        .sidebar-menu { list-style: none; padding: 1rem 0; flex: 1; }
        .menu-category { font-size: 0.75rem; text-transform: uppercase; color: #64748b; padding: 0.75rem 1.5rem 0.25rem; font-weight: 700; }
        .menu-item { display: flex; align-items: center; padding: 0.75rem 1.5rem; color: #cbd5e1; text-decoration: none; cursor: pointer; font-size: 0.95rem; }
        .menu-item:hover, .menu-item.active { background-color: #1e293b; color: #10b981; border-left: 4px solid #10b981; }
        .sidebar-footer { padding: 1rem 1.5rem; border-top: 1px solid #1e293b; }
        .btn-logout { display: block; width: 100%; text-align: center; background-color: #ef4444; color: white; padding: 0.6rem; border-radius: 6px; text-decoration: none; font-weight: 600; }

        .main-wrapper { flex: 1; display: flex; flex-direction: column; overflow-x: hidden; }
        .topbar { background: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #e2e8f0; }
        .content-area { padding: 2rem; max-width: 1300px; width: 100%; margin: 0 auto; }

        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 1.5rem; margin-bottom: 1.5rem; }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem; }
        .search-bar { display: flex; gap: 0.75rem; align-items: center; }
        .input-control { padding: 0.6rem 0.85rem; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 0.9rem; }
        .btn { padding: 0.6rem 1.2rem; border-radius: 6px; text-decoration: none; font-weight: 600; cursor: pointer; border: none; font-size: 0.9rem; }
        .btn-primary { background-color: #10b981; color: white; }
        .btn-primary:hover { background-color: #059669; }
        .btn-action { background-color: #2563eb; color: white; padding: 0.35rem 0.75rem; font-size: 0.8rem; border-radius: 4px; text-decoration: none; margin-right: 4px; }
        .btn-danger { background-color: #ef4444; color: white; padding: 0.35rem 0.75rem; font-size: 0.8rem; border-radius: 4px; text-decoration: none; }
        
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background-color: #0f172a; color: white; padding: 0.75rem 1rem; font-size: 0.85rem; }
        td { padding: 0.85rem 1rem; border-bottom: 1px solid #e2e8f0; font-size: 0.9rem; }
        tr:hover { background-color: #f8fafc; }
        .badge { padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.75rem; font-weight: 700; }
        .badge-active { background-color: #dcfce7; color: #166534; }
        .badge-pending { background-color: #fef9c3; color: #854d0e; }

        .tab-panel { display: none; }
        .tab-panel.active { display: block; }
    </style>
</head>
<body>

    <aside class="sidebar">
        <div class="sidebar-brand">
            🏦 Employee Desk
            <span>Branch: ${sessionScope.loggedUser.branchId}</span>
        </div>
        <ul class="sidebar-menu">
            <li class="menu-category">Customer Operations</li>
            <li><a class="menu-item active" onclick="showEmpTab(event, 'customersPanel')">👤 View Branch Customers</a></li>
            <li><a class="menu-item" href="${pageContext.request.contextPath}/employee/register-customer">➕ Register New Customer</a></li>

            <li class="menu-category">Account Desk</li>
            <li><a class="menu-item" href="${pageContext.request.contextPath}/account/open-savings">💳 Open Savings Account</a></li>
            <li><a class="menu-item" href="${pageContext.request.contextPath}/account/open-current">🏢 Open Current Account</a></li>
            <li><a class="menu-item" href="${pageContext.request.contextPath}/account/deposit">📥 Cash Deposit</a></li>
            <li><a class="menu-item" href="${pageContext.request.contextPath}/account/withdraw">📤 Counter Withdrawal</a></li>

            <li class="menu-category">Loan Processing</li>
            <li><a class="menu-item" onclick="showEmpTab(event, 'loansPanel')">📋 Pending Loan Applications</a></li>
        </ul>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </aside>

    <main class="main-wrapper">
        <header class="topbar">
            <h2>Officer: <strong>${sessionScope.loggedUser.name}</strong> (${sessionScope.loggedUser.designation})</h2>
            <a href="${pageContext.request.contextPath}/employee/register-customer" class="btn btn-primary">+ Onboard Customer</a>
        </header>

        <div class="content-area">
            
            <section id="customersPanel" class="tab-panel active">
                <div class="card">
                    <div class="card-header">
                        <h3>Branch Customers Directory</h3>
                        <div class="search-bar">
                            <input type="text" id="empCustSearch" class="input-control" placeholder="Search Customer ID / Name..." onkeyup="filterData('empCustSearch', 'empCustomerTable')">
                        </div>
                    </div>
                    <table id="empCustomerTable">
                        <thead>
                            <tr>
                                <th>Customer ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${customerList}">
                                <tr>
                                    <td><strong>${c.customerId}</strong></td>
                                    <td>${c.name}</td>
                                    <td>${c.email}</td>
                                    <td>${c.phoneNumber}</td>
                                    <td><span class="badge badge-active">${c.status}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/account/view-details?customerId=${c.customerId}" class="btn-action">View Accounts</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="loansPanel" class="tab-panel">
                <div class="card">
                    <div class="card-header">
                        <h3>Pending Loan Applications</h3>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Loan ID</th>
                                <th>Customer ID</th>
                                <th>Type</th>
                                <th>Amount (₹)</th>
                                <th>Tenure</th>
                                <th>Interest</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${pendingLoanList}">
                                <tr>
                                    <td><strong>${l.loanId}</strong></td>
                                    <td>${l.customerId}</td>
                                    <td>${l.loanType}</td>
                                    <td>₹ ${l.loanAmount}</td>
                                    <td>${l.tenureMonths} Months</td>
                                    <td>${l.interestRate}%</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/loan/approve?loanId=${l.loanId}" class="btn-action" onclick="return confirm('Approve this loan and generate EMI schedule?')">Approve</a>
                                        <a href="${pageContext.request.contextPath}/loan/reject?loanId=${l.loanId}" class="btn-danger" onclick="return confirm('Reject this loan application?')">Reject</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>

        </div>
    </main>

    <script>
        function showEmpTab(event, panelId) {
            document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
            document.querySelectorAll('.menu-item').forEach(m => m.classList.remove('active'));
            document.getElementById(panelId).classList.add('active');
            event.currentTarget.classList.add('active');
        }

        function filterData(inputId, tableId) {
            let filter = document.getElementById(inputId).value.toLowerCase();
            let rows = document.querySelectorAll('#' + tableId + ' tbody tr');
            rows.forEach(r => {
                r.style.display = r.innerText.toLowerCase().includes(filter) ? '' : 'none';
            });
        }
    </script>
</body>
</html>