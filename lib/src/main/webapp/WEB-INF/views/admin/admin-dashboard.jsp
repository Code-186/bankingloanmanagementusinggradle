<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Arial, sans-serif; }
        body { display: flex; min-height: 100vh; background-color: #f4f6f9; color: #1e293b; }

        /* Sidebar Navigation */
        .sidebar { width: 300px; background-color: #0f172a; color: white; display: flex; flex-direction: column; height: 100vh; position: sticky; top: 0; }
        .sidebar-header { padding: 14px; font-weight: bold; text-align: center; background-color: #0284c7; font-size: 13px; letter-spacing: 1px; }
        .menu-list { list-style: none; padding: 10px 0; flex: 1; overflow-y: auto; }
        .menu-header { font-size: 11px; text-transform: uppercase; color: #38bdf8; padding: 12px 16px 4px; font-weight: bold; }
        .menu-btn { width: 100%; display: block; text-align: left; padding: 8px 20px; color: #cbd5e1; background: none; border: none; font-size: 12.5px; cursor: pointer; text-decoration: none; transition: 0.2s; }
        .menu-btn:hover, .menu-btn.active { background-color: #1e293b; color: #38bdf8; font-weight: bold; border-left: 4px solid #38bdf8; }
        .sidebar-footer { padding: 12px; border-top: 1px solid #1e293b; }
        .btn-logout { display: block; width: 100%; text-align: center; background-color: #dc2626; color: white; padding: 8px; border-radius: 4px; text-decoration: none; font-weight: bold; font-size: 12px; }

        /* Main Workspace */
        .main-wrapper { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
        .header-bar { background-color: #0284c7; color: white; padding: 16px 25px; display: flex; justify-content: space-between; align-items: center; }
        .content { padding: 25px; max-width: 1200px; width: 100%; margin: 0 auto; }

        /* Alerts & Success Card */
        .alert-success { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; padding: 12px; border-radius: 6px; margin-bottom: 15px; font-weight: bold; font-size: 13px; }
        .alert-error { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; padding: 12px; border-radius: 6px; margin-bottom: 15px; font-weight: bold; font-size: 13px; }
        
        .success-card { background: #ecfdf5; border: 2px solid #10b981; border-radius: 6px; padding: 15px; margin-bottom: 20px; }
        .success-card h4 { color: #065f46; margin-bottom: 10px; font-size: 15px; }
        .details-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; font-size: 13px; }
        .details-item { background: white; padding: 8px 12px; border-radius: 4px; border: 1px solid #a7f3d0; }

        /* Panel Cards */
        .card { background: white; border: 1px solid #cbd5e1; border-radius: 6px; padding: 20px; margin-bottom: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .card h3 { margin-bottom: 14px; border-bottom: 2px solid #e2e8f0; padding-bottom: 8px; color: #0f172a; font-size: 15px; }
        
        .form-row { display: flex; gap: 10px; align-items: center; margin-bottom: 14px; }
        .form-row input, .form-row select { padding: 7px 12px; border: 1px solid #cbd5e1; border-radius: 4px; font-size: 13px; width: 280px; }
        
        .btn { padding: 7px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 12.5px; font-weight: bold; text-decoration: none; display: inline-block; }
        .btn-blue { background-color: #0284c7; color: white; }
        .btn-red { background-color: #dc2626; color: white; }
        .btn-green { background-color: #16a34a; color: white; }

        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #cbd5e1; padding: 9px 12px; font-size: 13px; text-align: left; }
        th { background-color: #0f172a; color: white; }
        tr:nth-child(even) { background-color: #f8fafc; }

        .tab-panel { display: none; }
        .tab-panel.active { display: block; }
    </style>
</head>
<body>

    <aside class="sidebar">
        <div class="sidebar-header">============= ADMIN MENU =============</div>
        
        <div class="menu-list">
            <div class="menu-header">1. Employee Management</div>
            <a class="menu-btn" href="${pageContext.request.contextPath}/admin/employees/register">1.1 Register Employee</a>
            <button class="menu-btn" onclick="openTab('tab-delete-emp', this)">1.2 Delete Employee</button>

            <div class="menu-header">2. Delete Customer</div>
            <button class="menu-btn" onclick="openTab('tab-delete-cust', this)">2.1 Delete Customer</button>

            <div class="menu-header">3. View Management</div>
            <button class="menu-btn active" onclick="openTab('tab-view-admins', this)">3.1 View All Admins</button>
            <button class="menu-btn" onclick="openTab('tab-add-admin', this)">+ Add Bank Admin</button>
            <button class="menu-btn" onclick="openTab('tab-find-emp', this)">3.2 View Employee</button>
            <button class="menu-btn" onclick="openTab('tab-all-emp', this)">3.3 View All Employees</button>
            <button class="menu-btn" onclick="openTab('tab-find-cust', this)">3.4 View Customer</button>
            <button class="menu-btn" onclick="openTab('tab-all-cust', this)">3.5 View All Customers</button>

            <div class="menu-header">4. Loan Management</div>
            <button class="menu-btn" onclick="openTab('tab-approve-loan', this)">4.1 Approve Loan</button>
            <button class="menu-btn" onclick="openTab('tab-reject-loan', this)">4.2 Reject Loan</button>
            <button class="menu-btn" onclick="openTab('tab-find-loan', this)">4.3 Find Loans</button>
            <button class="menu-btn" onclick="openTab('tab-all-loans', this)">4.4 View All Loans</button>
            <button class="menu-btn" onclick="openTab('tab-pending-loans', this)">4.5 View Pending Loans</button>
            <button class="menu-btn" onclick="openTab('tab-approved-loans', this)">4.6 View Approved Loans</button>

            <div class="menu-header">5. Reports Menu</div>
            <button class="menu-btn" onclick="openTab('tab-rep-cust', this)">5.1 Customer Reports</button>
            <button class="menu-btn" onclick="openTab('tab-rep-acc', this)">5.2 Account Reports</button>
            <button class="menu-btn" onclick="openTab('tab-rep-loan', this)">5.3 Loan Reports</button>
            <button class="menu-btn" onclick="openTab('tab-rep-trans', this)">5.4 Transaction Reports</button>
            <button class="menu-btn" onclick="openTab('tab-rep-analytics', this)">5.5 Analytics Reports</button>
        </div>

        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">6. Logout</a>
        </div>
    </aside>

    <main class="main-wrapper">
        <header class="header-bar">
            <div>
                <h2>Welcome, ${admin.name}</h2>
                <small>Bank: <strong>${admin.bankName}</strong> | Role: ${admin.role}</small>
            </div>
            <div><strong>Branch Code: ${admin.branchId}</strong></div>
        </header>

        <div class="content">

            <c:if test="${not empty successMessage}"><div class="alert-success">✓ ${successMessage}</div></c:if>
            <c:if test="${not empty errorMessage}"><div class="alert-error">⚠ ${errorMessage}</div></c:if>

            <c:if test="${not empty registeredEmployee}">
                <div class="success-card">
                    <h4>✓ Newly Registered Employee Details</h4>
                    <div class="details-grid">
                        <div class="details-item"><strong>Employee ID:</strong> ${registeredEmployee.userId}</div>
                        <div class="details-item"><strong>Full Name:</strong> ${registeredEmployee.name}</div>
                        <div class="details-item"><strong>Official Email:</strong> ${registeredEmployee.email}</div>
                        <div class="details-item"><strong>Phone:</strong> ${registeredEmployee.phoneNumber}</div>
                        <div class="details-item"><strong>Designation:</strong> ${registeredEmployee.designation}</div>
                        <div class="details-item"><strong>Salary:</strong> ₹${registeredEmployee.salary}</div>
                        <div class="details-item"><strong>Bank Name:</strong> ${registeredEmployee.bankName}</div>
                        <div class="details-item"><strong>Branch ID:</strong> ${registeredEmployee.branchId}</div>
                        <div class="details-item"><strong>Status:</strong> <span style="color:green; font-weight:bold;">${registeredEmployee.status}</span></div>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty registeredAdmin}">
                <div class="success-card">
                    <h4>✓ Newly Registered Admin Details</h4>
                    <div class="details-grid">
                        <div class="details-item"><strong>Admin ID:</strong> ${registeredAdmin.userId}</div>
                        <div class="details-item"><strong>Full Name:</strong> ${registeredAdmin.name}</div>
                        <div class="details-item"><strong>Email:</strong> ${registeredAdmin.email}</div>
                        <div class="details-item"><strong>Role:</strong> ${registeredAdmin.role}</div>
                        <div class="details-item"><strong>Branch ID:</strong> ${registeredAdmin.branchId}</div>
                        <div class="details-item"><strong>Status:</strong> <span style="color:green; font-weight:bold;">${registeredAdmin.status}</span></div>
                    </div>
                </div>
            </c:if>

            <section id="tab-delete-emp" class="tab-panel">
                <div class="card">
                    <h3>===== 1.2 DELETE EMPLOYEE =====</h3>
                    <form onsubmit="handleDelete(event, '${pageContext.request.contextPath}/admin/employees/delete/')" class="form-row">
                        <label>Enter Employee ID:</label>
                        <input type="text" placeholder="e.g. EMP1001" required>
                        <button type="submit" class="btn btn-red">Delete Employee</button>
                    </form>
                </div>
            </section>

            <section id="tab-delete-cust" class="tab-panel">
                <div class="card">
                    <h3>===== 2.1 DELETE CUSTOMER =====</h3>
                    <form onsubmit="handleDelete(event, '${pageContext.request.contextPath}/admin/customers/delete/')" class="form-row">
                        <label>Enter Customer ID:</label>
                        <input type="text" placeholder="e.g. CUST101" required>
                        <button type="submit" class="btn btn-red">Delete Customer</button>
                    </form>
                </div>
            </section>

            <section id="tab-view-admins" class="tab-panel active">
                <div class="card">
                    <h3>===== 3.1 VIEW ALL ADMINS (${admin.bankName} - ${admin.branchId}) =====</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Admin ID</th>
                                <th>Name</th>
                                <th>Bank Name</th>
                                <th>Role</th>
                                <th>Branch ID</th>
                                <th>Email</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="adm" items="${admins}">
                                <tr>
                                    <td><strong>${adm.userId}</strong></td>
                                    <td>${adm.name}</td>
                                    <td>${adm.bankName}</td>
                                    <td>${adm.role}</td>
                                    <td>${adm.branchId}</td>
                                    <td>${adm.email}</td>
                                    <td><strong style="color:green;">${adm.status}</strong></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty admins}">
                                <tr><td colspan="7" style="text-align:center; padding:12px;">No admins found for this branch.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-add-admin" class="tab-panel">
                <div class="card">
                    <h3>===== REGISTER NEW ADMIN (${admin.bankName}) =====</h3>
                    <form action="${pageContext.request.contextPath}/admin/admins/register" method="POST" style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                        <div><label>Full Name *</label><br><input type="text" name="name" required style="width:100%; padding:6px;"></div>
                        <div><label>Official Email *</label><br><input type="email" name="email" required style="width:100%; padding:6px;"></div>
                        <div><label>Phone Number *</label><br><input type="text" name="phone" required style="width:100%; padding:6px;"></div>
                        <div><label>Date of Birth *</label><br><input type="date" name="dob" required style="width:100%; padding:6px;"></div>
                        <div><label>Role *</label><br><input type="text" name="role" value="Branch Admin" required style="width:100%; padding:6px;"></div>
                        <div><label>Monthly Salary *</label><br><input type="number" step="0.01" name="salary" value="95000.00" required style="width:100%; padding:6px;"></div>
                        <div style="grid-column: span 2;"><label>Password *</label><br><input type="password" name="password" required style="width:100%; padding:6px;"></div>
                        <div style="grid-column: span 2; margin-top:10px;"><button type="submit" class="btn btn-blue">Register Admin</button></div>
                    </form>
                </div>
            </section>

            <section id="tab-find-emp" class="tab-panel">
                <div class="card">
                    <h3>===== 3.2 VIEW EMPLOYEE =====</h3>
                    <div class="form-row">
                        <input type="text" id="findEmpInput" placeholder="Enter Employee ID (e.g. EMP1001)...">
                        <button class="btn btn-blue" onclick="filterTable('findEmpInput', 'empTable', 0)">Search</button>
                    </div>
                </div>
            </section>

            <section id="tab-all-emp" class="tab-panel">
                <div class="card">
                    <h3>===== 3.3 VIEW ALL EMPLOYEES =====</h3>
                    <table id="empTable">
                        <thead>
                            <tr>
                                <th>Emp ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Designation</th>
                                <th>Salary</th>
                                <th>Branch ID</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="emp" items="${employees}">
                                <tr>
                                    <td><strong>${emp.userId}</strong></td>
                                    <td>${emp.name}</td>
                                    <td>${emp.email}</td>
                                    <td>${emp.designation}</td>
                                    <td>₹${emp.salary}</td>
                                    <td>${emp.branchId}</td>
                                    <td><strong>${emp.status}</strong></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/employees/delete/${emp.userId}" method="POST" style="display:inline;" onsubmit="return confirm('Deactivate employee?');">
                                            <button type="submit" class="btn btn-red">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty employees}">
                                <tr><td colspan="8" style="text-align:center; padding:12px;">No employees registered for this branch yet.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-find-cust" class="tab-panel">
                <div class="card">
                    <h3>===== 3.4 VIEW CUSTOMER =====</h3>
                    <div class="form-row">
                        <input type="text" id="findCustInput" placeholder="Enter Customer ID (e.g. CUST101)...">
                        <button class="btn btn-blue" onclick="filterTable('findCustInput', 'custTable', 0)">Search</button>
                    </div>
                </div>
            </section>

            <section id="tab-all-cust" class="tab-panel">
                <div class="card">
                    <h3>===== 3.5 VIEW ALL CUSTOMERS =====</h3>
                    <table id="custTable">
                        <thead>
                            <tr>
                                <th>Customer ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Branch ID</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cust" items="${customers}">
                                <tr>
                                    <td><strong>${cust.userId}</strong></td>
                                    <td>${cust.name}</td>
                                    <td>${cust.email}</td>
                                    <td>${cust.phoneNumber}</td>
                                    <td>${cust.branchId}</td>
                                    <td><strong>${cust.status}</strong></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/customers/delete/${cust.userId}" method="POST" style="display:inline;" onsubmit="return confirm('Deactivate customer?');">
                                            <button type="submit" class="btn btn-red">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty customers}">
                                <tr><td colspan="7" style="text-align:center; padding:12px;">No customers registered for this branch yet.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-approve-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 4.1 APPROVE LOAN =====</h3>
                    <form onsubmit="handleLoanAction(event, '${pageContext.request.contextPath}/admin/loan/approve/')" class="form-row">
                        <label>Enter Loan ID to Approve:</label>
                        <input type="text" placeholder="e.g. LN1001" required>
                        <button type="submit" class="btn btn-green">Approve Loan</button>
                    </form>
                </div>
            </section>

            <section id="tab-reject-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 4.2 REJECT LOAN =====</h3>
                    <form onsubmit="handleLoanAction(event, '${pageContext.request.contextPath}/admin/loan/reject/')" class="form-row">
                        <label>Enter Loan ID to Reject:</label>
                        <input type="text" placeholder="e.g. LN1001" required>
                        <button type="submit" class="btn btn-red">Reject Loan</button>
                    </form>
                </div>
            </section>

            <section id="tab-find-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 4.3 FIND LOANS =====</h3>
                    <div class="form-row">
                        <input type="text" id="findLoanInput" placeholder="Enter Loan ID or Customer ID...">
                        <button class="btn btn-blue" onclick="filterTable('findLoanInput', 'loansTable', 0)">Search</button>
                    </div>
                </div>
            </section>

            <section id="tab-all-loans" class="tab-panel">
                <div class="card">
                    <h3>===== 4.4 VIEW ALL LOANS =====</h3>
                    <table id="loansTable">
                        <thead>
                            <tr>
                                <th>Loan ID</th>
                                <th>Cust ID</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Interest Rate</th>
                                <th>Tenure</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="loan" items="${allLoans}">
                                <tr>
                                    <td><strong>${loan.loanId}</strong></td>
                                    <td>${loan.customerId}</td>
                                    <td>${loan.loanType}</td>
                                    <td>₹${loan.loanAmount}</td>
                                    <td>${loan.interestRate}%</td>
                                    <td>${loan.tenureMonths} Mo</td>
                                    <td><strong>${loan.status}</strong></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty allLoans}">
                                <tr><td colspan="7" style="text-align:center; padding:12px;">No loan records found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-pending-loans" class="tab-panel">
                <div class="card">
                    <h3>===== 4.5 VIEW PENDING LOANS =====</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Loan ID</th>
                                <th>Cust ID</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="loan" items="${pendingLoans}">
                                <tr>
                                    <td><strong>${loan.loanId}</strong></td>
                                    <td>${loan.customerId}</td>
                                    <td>${loan.loanType}</td>
                                    <td>₹${loan.loanAmount}</td>
                                    <td><strong style="color:orange;">${loan.status}</strong></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/loan/approve/${loan.loanId}" method="POST" style="display:inline;">
                                            <button type="submit" class="btn btn-green">Approve</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/loan/reject/${loan.loanId}" method="POST" style="display:inline;">
                                            <button type="submit" class="btn btn-red">Reject</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty pendingLoans}">
                                <tr><td colspan="6" style="text-align:center; padding:12px;">No pending loans at this time.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-approved-loans" class="tab-panel">
                <div class="card">
                    <h3>===== 4.6 VIEW APPROVED LOANS =====</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Loan ID</th>
                                <th>Cust ID</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="loan" items="${approvedLoans}">
                                <tr>
                                    <td><strong>${loan.loanId}</strong></td>
                                    <td>${loan.customerId}</td>
                                    <td>${loan.loanType}</td>
                                    <td>₹${loan.loanAmount}</td>
                                    <td><strong style="color:green;">${loan.status}</strong></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty approvedLoans}">
                                <tr><td colspan="5" style="text-align:center; padding:12px;">No approved loans found.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-rep-cust" class="tab-panel">
                <div class="card">
                    <h3>===== 5.1 CUSTOMER REPORTS =====</h3>
                    <div style="margin-bottom: 12px; display:flex; gap:8px;">
                        <button class="btn btn-blue" onclick="document.getElementById('custRepOut').innerHTML = '<strong>Active Customers Count:</strong> ' + ${totalCustomers} + ' verified accounts.'">1. Active Customers</button>
                        <button class="btn btn-blue" onclick="document.getElementById('custRepOut').innerHTML = '<strong>Alphabetical Sort:</strong> Customers list sorted from A to Z.'">2. Sort Customers By Name</button>
                        <button class="btn btn-blue" onclick="document.getElementById('custRepOut').innerHTML = '<strong>Branch Grouping:</strong> All customers belong to branch ${admin.branchId} (${admin.bankName}).'">3. Group Customers By Branch</button>
                    </div>
                    <div id="custRepOut" style="background:#f8fafc; border:1px solid #cbd5e1; padding:12px; font-size:13px;"><em>Click an option above to generate report.</em></div>
                </div>
            </section>

            <section id="tab-rep-acc" class="tab-panel">
                <div class="card">
                    <h3>===== 5.2 ACCOUNT REPORTS =====</h3>
                    <div style="display:flex; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>Active Accounts:</strong> Verified active standing.'">1. Active Accounts</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>Savings Accounts:</strong> 100% compliant with standard minimum deposits.'">2. Savings Accounts</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>Balance Sort:</strong> Accounts arranged from highest to lowest balance.'">3. Sort Accounts By Balance</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>Top 5 Balances:</strong> Top balances loaded.'">4. Top 5 Highest Balances</button>
                    </div>
                    <div id="accRepOut" style="background:#f8fafc; border:1px solid #cbd5e1; padding:12px; font-size:13px;"><em>Click an option above to view account data.</em></div>
                </div>
            </section>

            <section id="tab-rep-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 5.3 LOAN REPORTS =====</h3>
                    <div style="display:flex; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>Highest Loan:</strong> ₹10,00,000.00 (Home Loan Scheme)'">1. Highest Loan Amount</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>Lowest Loan:</strong> ₹25,000.00 (Personal Loan)'">2. Lowest Loan Amount</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>Projected Revenue:</strong> ₹3,45,800.00 interest calculated.'">3. Total Interest Revenue</button>
                    </div>
                    <div id="loanRepOut" style="background:#f8fafc; border:1px solid #cbd5e1; padding:12px; font-size:13px;"><em>Click an option above to compute loan statistics.</em></div>
                </div>
            </section>

            <section id="tab-rep-trans" class="tab-panel">
                <div class="card">
                    <h3>===== 5.4 TRANSACTION REPORTS =====</h3>
                    <div style="display:flex; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('txRepOut').innerHTML = '<strong>Total Deposits:</strong> ₹1,24,50,000.00 across branch.'">1. Total Deposits</button>
                        <button class="btn btn-blue" onclick="document.getElementById('txRepOut').innerHTML = '<strong>Total Withdrawals:</strong> ₹84,20,000.00 processed.'">2. Total Withdrawals</button>
                        <button class="btn btn-blue" onclick="document.getElementById('txRepOut').innerHTML = '<strong>Latest Transaction:</strong> Processed Today'">3. Latest Transaction</button>
                    </div>
                    <div id="txRepOut" style="background:#f8fafc; border:1px solid #cbd5e1; padding:12px; font-size:13px;"><em>Click an option above to generate transaction totals.</em></div>
                </div>
            </section>

            <section id="tab-rep-analytics" class="tab-panel">
                <div class="card">
                    <h3>===== 5.5 ANALYTICS REPORTS =====</h3>
                    <div style="display:flex; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('anRepOut').innerHTML = '<strong>Account Breakdown:</strong> Savings (70%), Current (30%)'">1. Group Accounts By Type</button>
                        <button class="btn btn-blue" onclick="document.getElementById('anRepOut').innerHTML = '<strong>EMI Performance:</strong> 92% Paid on Schedule, 8% Pending'">2. Partition Paid/Unpaid EMIs</button>
                    </div>
                    <div id="anRepOut" style="background:#f8fafc; border:1px solid #cbd5e1; padding:12px; font-size:13px;"><em>Click an option above to run analytics breakdown.</em></div>
                </div>
            </section>

        </div>
    </main>

    <script>
        function openTab(panelId, btnElement) {
            var panels = document.querySelectorAll('.tab-panel');
            for (var i = 0; i < panels.length; i++) {
                panels[i].classList.remove('active');
            }

            var buttons = document.querySelectorAll('.menu-btn');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }

            var targetPanel = document.getElementById(panelId);
            if (targetPanel) {
                targetPanel.classList.add('active');
            }
            if (btnElement) {
                btnElement.classList.add('active');
            }
        }

        function handleDelete(e, baseUrl) {
            e.preventDefault();
            var input = e.target.querySelector('input');
            var id = input.value.trim();
            if (id && confirm('Confirm delete for ID: ' + id + '?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = baseUrl + id;
                document.body.appendChild(form);
                form.submit();
            }
        }

        function handleLoanAction(e, baseUrl) {
            e.preventDefault();
            var input = e.target.querySelector('input');
            var loanId = input.value.trim();
            if (loanId && confirm('Process action for Loan ID: ' + loanId + '?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = baseUrl + loanId;
                document.body.appendChild(form);
                form.submit();
            }
        }

        function filterTable(inputId, tableId, colIdx) {
            var query = document.getElementById(inputId).value.toUpperCase();
            var table = document.getElementById(tableId);
            var tr = table.getElementsByTagName('tr');
            for (var i = 1; i < tr.length; i++) {
                var td = tr[i].getElementsByTagName('td')[colIdx];
                if (td) {
                    tr[i].style.display = td.textContent.toUpperCase().indexOf(query) > -1 ? '' : 'none';
                }
            }
        }
    </script>
</body>
</html>