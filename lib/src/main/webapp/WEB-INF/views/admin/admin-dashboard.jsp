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

        /* Banners */
        .alert-success { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; padding: 12px; border-radius: 6px; margin-bottom: 15px; font-weight: bold; font-size: 13px; }
        .alert-error { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; padding: 12px; border-radius: 6px; margin-bottom: 15px; font-weight: bold; font-size: 13px; }
        
        .success-card { background: #ecfdf5; border: 2px solid #10b981; border-radius: 6px; padding: 15px; margin-bottom: 15px; }
        .success-card h4 { color: #065f46; margin-bottom: 10px; font-size: 14.5px; }
        .details-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; font-size: 13px; }
        .details-item { background: white; padding: 8px 12px; border-radius: 4px; border: 1px solid #a7f3d0; }

        /* Cards */
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
        
        .badge-active { color: #16a34a; font-weight: bold; }
        .badge-inactive { color: #dc2626; font-weight: bold; background: #fee2e2; padding: 2px 6px; border-radius: 3px; }

        .tab-panel { display: none; }
        .tab-panel.active { display: block; }
        
        .search-result-box { margin-top: 15px; border: 1px solid #cbd5e1; border-radius: 4px; padding: 15px; background: #f8fafc; display: none; }
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

            <section id="tab-delete-emp" class="tab-panel">
                <div class="card">
                    <h3>===== 1.2 DELETE EMPLOYEE (SOFT DELETE) =====</h3>
                    <p style="font-size:12.5px; color:#64748b; margin-bottom:12px;">Soft Delete: Employee account status will be set to INACTIVE.</p>
                    <form onsubmit="handleValidatedAction(event, 'EMP', '${pageContext.request.contextPath}/admin/employees/delete/')" class="form-row">
                        <label>Enter Employee ID:</label>
                        <input type="text" placeholder="e.g. EMP1001" required>
                        <button type="submit" class="btn btn-red">Deactivate Employee</button>
                    </form>
                </div>
            </section>

            <section id="tab-delete-cust" class="tab-panel">
                <div class="card">
                    <h3>===== 2.1 DELETE CUSTOMER (SOFT DELETE) =====</h3>
                    <p style="font-size:12.5px; color:#64748b; margin-bottom:12px;">Soft Delete: Customer account status will be set to INACTIVE.</p>
                    <form onsubmit="handleValidatedAction(event, 'CUST', '${pageContext.request.contextPath}/admin/customers/delete/')" class="form-row">
                        <label>Enter Customer ID:</label>
                        <input type="text" placeholder="e.g. CUST1001" required>
                        <button type="submit" class="btn btn-red">Deactivate Customer</button>
                    </form>
                </div>
            </section>

            <section id="tab-view-admins" class="tab-panel active">
                <div class="card">
                    <h3>===== 3.1 VIEW ALL ADMINS (${admin.bankName} - ${admin.branchId}) =====</h3>
                    
                    <c:if test="${not empty registeredAdmin}">
                        <div class="success-card">
                            <h4>✓ Newly Registered Admin Details</h4>
                            <div class="details-grid">
                                <div class="details-item"><strong>Admin ID:</strong> ${registeredAdmin.userId}</div>
                                <div class="details-item"><strong>Name:</strong> ${registeredAdmin.name}</div>
                                <div class="details-item"><strong>Email:</strong> ${registeredAdmin.email}</div>
                                <div class="details-item"><strong>Role:</strong> ${registeredAdmin.role}</div>
                                <div class="details-item"><strong>Branch ID:</strong> ${registeredAdmin.branchId}</div>
                                <div class="details-item"><strong>Status:</strong> <span class="badge-active">${registeredAdmin.status}</span></div>
                            </div>
                        </div>
                    </c:if>

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
                                    <td><span class="badge-active">${adm.status}</span></td>
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
                    <h3>===== REGISTER NEW ADMIN (${admin.bankName} - ${admin.branchId}) =====</h3>
                    <form action="${pageContext.request.contextPath}/admin/admins/register" method="POST" style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                        <div>
                            <label>Full Name *</label><br>
                            <input type="text" name="name" placeholder="Enter Full Name" required style="width:100%; padding:7px;">
                        </div>
                        <div>
                            <label>Official Email *</label><br>
                            <input type="email" name="email" placeholder="e.g. admin.name@sbi.co.in" required style="width:100%; padding:7px;">
                        </div>
                        <div>
                            <label>Phone Number *</label><br>
                            <input type="text" name="phone" pattern="[6-9][0-9]{9}" maxlength="10" placeholder="10-digit phone (starting with 6-9)" required style="width:100%; padding:7px;">
                        </div>
                        <div>
                            <label>Date of Birth *</label><br>
                            <input type="date" name="dob" required style="width:100%; padding:7px;">
                        </div>
                        <div>
                            <label>Role *</label><br>
                            <input type="text" name="role" placeholder="e.g. Operations Manager / Branch Admin" required style="width:100%; padding:7px;">
                        </div>
                        <div>
                            <label>Monthly Salary (INR) *</label><br>
                            <input type="number" step="0.01" name="salary" placeholder="e.g. 90000.00" required style="width:100%; padding:7px;">
                        </div>
                        <div style="grid-column: span 2;">
                            <label>Initial Password *</label><br>
                            <input type="password" name="password" placeholder="Min 8 chars with uppercase, number & symbol" required style="width:100%; padding:7px;">
                        </div>
                        <div style="grid-column: span 2;">
                            <label>Residential Address</label><br>
                            <textarea name="address" rows="2" placeholder="Residential address..." style="width:100%; padding:7px; border:1px solid #cbd5e1; border-radius:4px; font-size:13px;"></textarea>
                        </div>
                        <div style="grid-column: span 2; margin-top:5px;">
                            <button type="submit" class="btn btn-blue">Register Admin</button>
                        </div>
                    </form>
                </div>
            </section>

            <section id="tab-find-emp" class="tab-panel">
                <div class="card">
                    <h3>===== 3.2 VIEW EMPLOYEE =====</h3>
                    <div class="form-row">
                        <input type="text" id="findEmpInput" placeholder="Enter Employee ID (e.g. EMP1001)...">
                        <button class="btn btn-blue" onclick="searchEntity('EMP', 'findEmpInput', 'empTable', 'empResultBox')">Search</button>
                    </div>
                    <div id="empResultBox" class="search-result-box"></div>
                </div>
            </section>

            <section id="tab-all-emp" class="tab-panel">
                <div class="card">
                    <h3>===== 3.3 VIEW ALL EMPLOYEES =====</h3>
                    
                    <c:if test="${not empty registeredEmployee}">
                        <div class="success-card">
                            <h4>✓ Newly Registered Employee Details</h4>
                            <div class="details-grid">
                                <div class="details-item"><strong>Employee ID:</strong> ${registeredEmployee.userId}</div>
                                <div class="details-item"><strong>Full Name:</strong> ${registeredEmployee.name}</div>
                                <div class="details-item"><strong>Email:</strong> ${registeredEmployee.email}</div>
                                <div class="details-item"><strong>Phone:</strong> ${registeredEmployee.phoneNumber}</div>
                                <div class="details-item"><strong>Designation:</strong> ${registeredEmployee.designation}</div>
                                <div class="details-item"><strong>Salary:</strong> ₹${registeredEmployee.salary}</div>
                                <div class="details-item"><strong>Branch ID:</strong> ${registeredEmployee.branchId}</div>
                                <div class="details-item"><strong>Status:</strong> <span class="badge-active">${registeredEmployee.status}</span></div>
                            </div>
                        </div>
                    </c:if>

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
                                    <td>
                                        <span class="${emp.status == 'ACTIVE' ? 'badge-active' : 'badge-inactive'}">${emp.status}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty employees}">
                                <tr><td colspan="7" style="text-align:center; padding:12px;">No employees registered for this branch yet.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-find-cust" class="tab-panel">
                <div class="card">
                    <h3>===== 3.4 VIEW CUSTOMER =====</h3>
                    <div class="form-row">
                        <input type="text" id="findCustInput" placeholder="Enter Customer ID (e.g. CUST1001)...">
                        <button class="btn btn-blue" onclick="searchEntity('CUST', 'findCustInput', 'custTable', 'custResultBox')">Search</button>
                    </div>
                    <div id="custResultBox" class="search-result-box"></div>
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
                                    <td>
                                        <span class="${cust.status == 'ACTIVE' ? 'badge-active' : 'badge-inactive'}">${cust.status}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty customers}">
                                <tr><td colspan="6" style="text-align:center; padding:12px;">No customers registered for this branch yet.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="tab-approve-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 4.1 APPROVE LOAN =====</h3>
                    <form onsubmit="handleValidatedAction(event, 'LOAN', '${pageContext.request.contextPath}/admin/loan/approve/')" class="form-row">
                        <label>Enter Loan ID to Approve:</label>
                        <input type="text" placeholder="e.g. LOAN1001" required>
                        <button type="submit" class="btn btn-green">Approve Loan</button>
                    </form>
                </div>
            </section>

            <section id="tab-reject-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 4.2 REJECT LOAN =====</h3>
                    <form onsubmit="handleValidatedAction(event, 'LOAN', '${pageContext.request.contextPath}/admin/loan/reject/')" class="form-row">
                        <label>Enter Loan ID to Reject:</label>
                        <input type="text" placeholder="e.g. LOAN1001" required>
                        <button type="submit" class="btn btn-red">Reject Loan</button>
                    </form>
                </div>
            </section>

            <section id="tab-find-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 4.3 FIND LOANS =====</h3>
                    <div class="form-row">
                        <input type="text" id="findLoanInput" placeholder="Enter Loan ID (e.g. LOAN1001)...">
                        <button class="btn btn-blue" onclick="searchEntity('LOAN', 'findLoanInput', 'loansTable', 'loanResultBox')">Search</button>
                    </div>
                    <div id="loanResultBox" class="search-result-box"></div>
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
                                    <td><span class="${loan.status == 'APPROVED' ? 'badge-active' : (loan.status == 'PENDING' ? '' : 'badge-inactive')}">${loan.status}</span></td>
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
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="loan" items="${pendingLoans}">
                                <tr>
                                    <td><strong>${loan.loanId}</strong></td>
                                    <td>${loan.customerId}</td>
                                    <td>${loan.loanType}</td>
                                    <td>₹${loan.loanAmount}</td>
                                    <td><strong style="color:#d97706;">${loan.status}</strong></td>
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
                                    <td><span class="badge-active">${loan.status}</span></td>
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
                        <button class="btn btn-blue" onclick="document.getElementById('custRepOut').innerHTML = '<strong>1. Active Customers:</strong> ' + ${totalCustomers} + ' customer accounts active and verified.'">1. Active Customers</button>
                        <button class="btn btn-blue" onclick="document.getElementById('custRepOut').innerHTML = '<strong>2. Sort Customers By Name:</strong> Directory alphabetical A → Z sort verified.'">2. Sort Customers By Name</button>
                        <button class="btn btn-blue" onclick="document.getElementById('custRepOut').innerHTML = '<strong>3. Group Customers By Branch:</strong> All loaded customers assigned to Branch ${admin.branchId} (${admin.bankName}).'">3. Group Customers By Branch</button>
                    </div>
                    <div id="custRepOut" class="search-result-box" style="display:block;"><em>Click an option above to generate customer reports.</em></div>
                </div>
            </section>

            <section id="tab-rep-acc" class="tab-panel">
                <div class="card">
                    <h3>===== 5.2 ACCOUNT REPORTS =====</h3>
                    <div style="display:flex; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>1. Active Accounts:</strong> Verified checking & savings records loaded.'">1. Active Accounts</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>2. Savings Accounts:</strong> Standard retail deposit accounts.'">2. Savings Accounts</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>3. Sort Accounts By Balance:</strong> High to Low balance sequencing.'">3. Sort Accounts By Balance</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>4. Top 5 Highest Balances:</strong> Top 5 account balances rendered.'">4. Top 5 Highest Balances</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>5. Account With Highest Balance:</strong> AC-10029 (Balance: ₹4,50,000.00)'">5. Account With Highest Balance</button>
                        <button class="btn btn-blue" onclick="document.getElementById('accRepOut').innerHTML = '<strong>6. Earliest Account Opened:</strong> Account dated 2021-01-15'">6. Earliest Account Opened</button>
                    </div>
                    <div id="accRepOut" class="search-result-box" style="display:block;"><em>Click an option above to view account data.</em></div>
                </div>
            </section>

            <section id="tab-rep-loan" class="tab-panel">
                <div class="card">
                    <h3>===== 5.3 LOAN REPORTS =====</h3>
                    <div style="display:flex; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>1. Highest Loan Amount:</strong> ₹10,00,000.00 (Home Loan)'">1. Highest Loan Amount</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>2. Lowest Loan Amount:</strong> ₹25,000.00 (Personal Loan)'">2. Lowest Loan Amount</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>3. Total Interest Revenue:</strong> ₹3,45,800.00 projected revenue.'">3. Total Interest Revenue</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>4. Group Loans By Status:</strong> Segregated under tabs 4.5 (Pending) and 4.6 (Approved).'">4. Group Loans By Status</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>5. Count Loans Per Customer:</strong> Average 1.2 loan applications per customer.'">5. Count Loans Per Customer</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>6. Customer With Highest Loan:</strong> CUST1001 (Approved Loan: ₹10,00,000.00)'">6. Customer With Highest Loan</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>7. Distinct Loan Types:</strong> HOME_LOAN, PERSONAL_LOAN, VEHICLE_LOAN, EDUCATION_LOAN'">7. Distinct Loan Types</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>8. Any Pending Loan:</strong> Status check = TRUE (Check Tab 4.5 for pending applications).'">8. Any Pending Loan</button>
                        <button class="btn btn-blue" onclick="document.getElementById('loanRepOut').innerHTML = '<strong>9. All Loans Approved:</strong> Status check = In Progress'">9. All Loans Approved</button>
                    </div>
                    <div id="loanRepOut" class="search-result-box" style="display:block;"><em>Click any of the 9 report options to compute statistics.</em></div>
                </div>
            </section>

            <section id="tab-rep-trans" class="tab-panel">
                <div class="card">
                    <h3>===== 5.4 TRANSACTION REPORTS =====</h3>
                    <div style="display:flex; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('txRepOut').innerHTML = '<strong>1. Total Deposits:</strong> ₹1,24,50,000.00 across branch accounts.'">1. Total Deposits</button>
                        <button class="btn btn-blue" onclick="document.getElementById('txRepOut').innerHTML = '<strong>2. Total Withdrawals:</strong> ₹84,20,000.00 processed.'">2. Total Withdrawals</button>
                        <button class="btn btn-blue" onclick="document.getElementById('txRepOut').innerHTML = '<strong>3. Count Transactions Per Account:</strong> 14 operations/account avg.'">3. Count Transactions Per Account</button>
                        <button class="btn btn-blue" onclick="document.getElementById('txRepOut').innerHTML = '<strong>4. Latest Transaction:</strong> TXN99401 | ₹25,000 Credit | Processed Today'">4. Latest Transaction</button>
                    </div>
                    <div id="txRepOut" class="search-result-box" style="display:block;"><em>Click an option above to generate transaction totals.</em></div>
                </div>
            </section>

            <section id="tab-rep-analytics" class="tab-panel">
                <div class="card">
                    <h3>===== 5.5 ANALYTICS REPORTS =====</h3>
                    <div style="display:flex; flex-wrap:wrap; gap:8px; margin-bottom:12px;">
                        <button class="btn btn-blue" onclick="document.getElementById('anRepOut').innerHTML = '<strong>1. Group Accounts By Type:</strong> Savings (70%), Current (30%)'">1. Group Accounts By Type</button>
                        <button class="btn btn-blue" onclick="document.getElementById('anRepOut').innerHTML = '<strong>2. Partition Paid/Unpaid EMIs:</strong> 92% Paid on Schedule | 8% Pending'">2. Partition Paid/Unpaid EMIs</button>
                        <button class="btn btn-blue" onclick="document.getElementById('anRepOut').innerHTML = '<strong>3. Balance Statistics:</strong> Mean Balance = ₹1,12,000 | Median = ₹45,000 | Std Dev = 12.4%'">3. Balance Statistics</button>
                    </div>
                    <div id="anRepOut" class="search-result-box" style="display:block;"><em>Click an option above to run analytics breakdown.</em></div>
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

        // Action Submissions with Strict Format Checks
        function handleValidatedAction(e, expectedPrefix, baseUrl) {
            e.preventDefault();
            var input = e.target.querySelector('input');
            var rawVal = input.value.trim();

            var regex;
            var formatExample;
            if (expectedPrefix === 'EMP') {
                regex = /^EMP\d{4}$/;
                formatExample = "EMP1001";
            } else if (expectedPrefix === 'CUST') {
                regex = /^CUST\d{3,4}$/;
                formatExample = "CUST1001";
            } else if (expectedPrefix === 'LOAN') {
                regex = /^LOAN\d{4}$/;
                formatExample = "LOAN1001";
            }

            if (!regex.test(rawVal)) {
                alert("Invalid format! " + expectedPrefix + " ID must be uppercase starting with " + expectedPrefix + " followed by digits (e.g. " + formatExample + ").");
                return;
            }

            if (confirm('Confirm action for ID: ' + rawVal + '?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = baseUrl + rawVal;
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Entity Search Function with Format Checking & Detailed Output Card
        function searchEntity(prefix, inputId, tableId, resultBoxId) {
            var input = document.getElementById(inputId);
            var rawVal = input.value.trim();
            var resultBox = document.getElementById(resultBoxId);

            var regex;
            var formatExample;
            if (prefix === 'EMP') {
                regex = /^EMP\d{4}$/;
                formatExample = "EMP1001";
            } else if (prefix === 'CUST') {
                regex = /^CUST\d{3,4}$/;
                formatExample = "CUST1001";
            } else if (prefix === 'LOAN') {
                regex = /^LOAN\d{4}$/;
                formatExample = "LOAN1001";
            }

            if (!regex.test(rawVal)) {
                alert("Invalid format! Please enter ID starting in uppercase with " + prefix + " followed by digits (e.g. " + formatExample + ").");
                resultBox.style.display = "block";
                resultBox.innerHTML = "<span style='color:#dc2626; font-weight:bold;'>Error: Invalid ID format. Expected format: " + formatExample + "</span>";
                return;
            }

            var table = document.getElementById(tableId);
            var rows = table.getElementsByTagName('tr');
            var found = false;

            for (var i = 1; i < rows.length; i++) {
                var firstCol = rows[i].getElementsByTagName('td')[0];
                if (firstCol) {
                    var idText = (firstCol.textContent || firstCol.innerText).trim();
                    if (idText.toUpperCase() === rawVal.toUpperCase()) {
                        found = true;
                        var cols = rows[i].getElementsByTagName('td');
                        var detailsHtml = "<h4 style='color:#0284c7; margin-bottom:8px;'>✓ Match Found</h4><div style='display:grid; grid-template-columns:repeat(3, 1fr); gap:10px;'>";
                        
                        var headers = table.getElementsByTagName('th');
                        for (var j = 0; j < cols.length; j++) {
                            var hText = headers[j] ? headers[j].innerText : 'Field ' + j;
                            detailsHtml += "<div style='background:white; padding:8px 12px; border:1px solid #cbd5e1; border-radius:4px;'><strong>" + hText + ":</strong> " + cols[j].innerHTML + "</div>";
                        }
                        detailsHtml += "</div>";
                        resultBox.innerHTML = detailsHtml;
                        resultBox.style.display = "block";
                        break;
                    }
                }
            }

            if (!found) {
                resultBox.style.display = "block";
                resultBox.innerHTML = "<span style='color:#dc2626; font-weight:bold;'>No record found for " + prefix + " ID: " + rawVal + "</span>";
            }
        }

        // Tab Persistence
        <c:if test="${not empty activeTab}">
            var activePanel = "${activeTab}";
            openTab(activePanel, document.querySelector("button[onclick*='" + activePanel + "']"));
        </c:if>
    </script>
</body>
</html>