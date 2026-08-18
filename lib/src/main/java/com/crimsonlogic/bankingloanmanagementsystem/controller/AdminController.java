package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.EmployeeNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.LoanNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.Loan;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAdminService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ILoanService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Admin;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private ILoanService loanService;

    private boolean isAdmin(HttpSession session) {
        Object user = session.getAttribute("loggedInUser");
        return (user instanceof Admin);
    }

    private Admin getLoggedInAdmin(HttpSession session) {
        Object user = session.getAttribute("loggedInUser");
        if (user instanceof Admin) {
            return (Admin) user;
        }
        return null;
    }

    // 1. DASHBOARD - STRICT BRANCH FILTERING
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Admin admin = getLoggedInAdmin(session);
        if (admin == null) {
            return "redirect:/login?role=ADMIN";
        }
        model.addAttribute("admin", admin);

        // Filter strictly by this admin's branchId
        List<Admin> allAdmins = adminService.getAllAdmins();
        List<Admin> branchAdmins = (allAdmins != null) ? allAdmins.stream()
                .filter(a -> a.getBranchId() != null && a.getBranchId().equalsIgnoreCase(admin.getBranchId()))
                .collect(Collectors.toList()) : List.of();

        List<Employee> allEmployees = adminService.getAllEmployees();
        List<Employee> branchEmployees = (allEmployees != null) ? allEmployees.stream()
                .filter(e -> e.getBranchId() != null && e.getBranchId().equalsIgnoreCase(admin.getBranchId()))
                .collect(Collectors.toList()) : List.of();

        List<Customer> allCustomers = adminService.getAllCustomers();
        List<Customer> branchCustomers = (allCustomers != null) ? allCustomers.stream()
                .filter(c -> c.getBranchId() != null && c.getBranchId().equalsIgnoreCase(admin.getBranchId()))
                .collect(Collectors.toList()) : List.of();

        List<Loan> allLoans = loanService.getAllLoans();
        List<Loan> pendingLoans = loanService.getPendingLoans();
        List<Loan> approvedLoans = loanService.getApprovedLoans();

        model.addAttribute("admins", branchAdmins);
        model.addAttribute("employees", branchEmployees);
        model.addAttribute("customers", branchCustomers);
        model.addAttribute("allLoans", allLoans);
        model.addAttribute("pendingLoans", pendingLoans);
        model.addAttribute("approvedLoans", approvedLoans);

        model.addAttribute("totalAdmins", branchAdmins.size());
        model.addAttribute("totalEmployees", branchEmployees.size());
        model.addAttribute("totalCustomers", branchCustomers.size());

        return "admin/admin-dashboard";
    }

    // 2. SHOW REGISTER EMPLOYEE
    @GetMapping("/employees/register")
    public String showRegisterEmployeeForm(HttpSession session, Model model) {
        Admin admin = getLoggedInAdmin(session);
        if (admin == null) return "redirect:/login?role=ADMIN";
        model.addAttribute("admin", admin);
        return "admin/employee-registration";
    }

    // 3. PROCESS REGISTER EMPLOYEE
    @PostMapping("/employees/register")
    public String processRegisterEmployee(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("phone") String phone,
            @RequestParam("dob") String dobStr,
            @RequestParam("role") String designation,
            @RequestParam("salary") BigDecimal salary,
            @RequestParam(value = "address", required = false) String address,
            HttpSession session,
            Model model) {

        Admin admin = getLoggedInAdmin(session);
        if (admin == null) return "redirect:/login?role=ADMIN";

        if (!ValidationUtil.validateName(name)) {
            model.addAttribute("admin", admin);
            model.addAttribute("error", "Invalid Name: Letters only (min 3 chars).");
            return "admin/employee-registration";
        }
        if (!ValidationUtil.validateEmail(email)) {
            model.addAttribute("admin", admin);
            model.addAttribute("error", "Invalid Email format.");
            return "admin/employee-registration";
        }
        if (!ValidationUtil.validatePhone(phone)) {
            model.addAttribute("admin", admin);
            model.addAttribute("error", "Invalid Phone: Must be 10 digits starting with 6-9.");
            return "admin/employee-registration";
        }
        if (!ValidationUtil.validatePassword(password)) {
            model.addAttribute("admin", admin);
            model.addAttribute("error", "Password must have 8-20 chars, 1 uppercase, 1 lowercase, 1 number, 1 special.");
            return "admin/employee-registration";
        }

        try {
            Employee newEmp = new Employee();
            newEmp.setName(name);
            newEmp.setPhoneNumber(phone);
            newEmp.setEmail(email);
            newEmp.setAddress(address);
            newEmp.setPassword(password);
            newEmp.setDateOfBirth(LocalDate.parse(dobStr));
            newEmp.setBankName(admin.getBankName());
            newEmp.setBranchId(admin.getBranchId());
            newEmp.setStatus("ACTIVE");
            newEmp.setDesignation(designation);
            newEmp.setSalary(salary);

            Employee saved = adminService.registerEmployee(newEmp);

            showDashboard(session, model);
            model.addAttribute("registeredEmployee", saved);
            model.addAttribute("activeTab", "tab-all-emp");
            model.addAttribute("successMessage", "Employee successfully registered and activated!");
            return "admin/admin-dashboard";

        } catch (org.springframework.dao.DuplicateKeyException e) {
            model.addAttribute("admin", admin);
            model.addAttribute("error", "An employee account with email '" + email + "' already exists.");
            return "admin/employee-registration";
        }
    }

    // 4. ADD NEW ADMIN
    @PostMapping("/admins/register")
    public String processRegisterAdmin(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("phone") String phone,
            @RequestParam("dob") String dobStr,
            @RequestParam("role") String role,
            @RequestParam("salary") BigDecimal salary,
            @RequestParam(value = "address", required = false) String address,
            HttpSession session,
            Model model) {

        Admin currentAdmin = getLoggedInAdmin(session);
        if (currentAdmin == null) return "redirect:/login?role=ADMIN";

        if (!ValidationUtil.validateName(name)) {
            showDashboard(session, model);
            model.addAttribute("errorMessage", "Invalid Name: Letters only (min 3 chars).");
            model.addAttribute("activeTab", "tab-add-admin");
            return "admin/admin-dashboard";
        }
        if (!ValidationUtil.validatePhone(phone)) {
            showDashboard(session, model);
            model.addAttribute("errorMessage", "Invalid Phone: Must be 10 digits starting with 6-9.");
            model.addAttribute("activeTab", "tab-add-admin");
            return "admin/admin-dashboard";
        }

        try {
            Admin newAdmin = new Admin();
            newAdmin.setName(name);
            newAdmin.setPhoneNumber(phone);
            newAdmin.setEmail(email);
            newAdmin.setAddress(address);
            newAdmin.setPassword(password);
            newAdmin.setDateOfBirth(LocalDate.parse(dobStr));
            newAdmin.setBankName(currentAdmin.getBankName());
            newAdmin.setBranchId(currentAdmin.getBranchId());
            newAdmin.setStatus("ACTIVE");
            newAdmin.setRole(role);
            newAdmin.setSalary(salary);

            Admin savedAdmin = adminService.registerAdmin(newAdmin);

            showDashboard(session, model);
            model.addAttribute("registeredAdmin", savedAdmin);
            model.addAttribute("activeTab", "tab-view-admins");
            model.addAttribute("successMessage", "New Admin successfully registered for " + currentAdmin.getBankName());
            return "admin/admin-dashboard";

        } catch (org.springframework.dao.DuplicateKeyException e) {
            showDashboard(session, model);
            model.addAttribute("errorMessage", "Admin email '" + email + "' already exists.");
            model.addAttribute("activeTab", "tab-add-admin");
            return "admin/admin-dashboard";
        }
    }

    // 5. DELETE EMPLOYEE (Soft Delete)
    @PostMapping("/employees/delete/{id}")
    public String deleteEmployee(@PathVariable("id") String employeeId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            adminService.deleteEmployee(employeeId);
            showDashboard(session, model);
            model.addAttribute("successMessage", "Employee ID " + employeeId + " status updated to INACTIVE (Soft Deleted).");
            model.addAttribute("activeTab", "tab-all-emp");
        } catch (EmployeeNotFoundException e) {
            showDashboard(session, model);
            model.addAttribute("errorMessage", "Employee ID " + employeeId + " not found.");
            model.addAttribute("activeTab", "tab-delete-emp");
        }
        return "admin/admin-dashboard";
    }

    // 6. DELETE CUSTOMER (Soft Delete)
    @PostMapping("/customers/delete/{id}")
    public String deleteCustomer(@PathVariable("id") String customerId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            adminService.deleteCustomer(customerId);
            showDashboard(session, model);
            model.addAttribute("successMessage", "Customer ID " + customerId + " status updated to INACTIVE (Soft Deleted).");
            model.addAttribute("activeTab", "tab-all-cust");
        } catch (CustomerNotFoundException e) {
            showDashboard(session, model);
            model.addAttribute("errorMessage", "Customer ID " + customerId + " not found.");
            model.addAttribute("activeTab", "tab-delete-cust");
        }
        return "admin/admin-dashboard";
    }

    // 7. APPROVE LOAN
    @PostMapping("/loan/approve/{loanId}")
    public String approveLoan(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            loanService.approveLoan(loanId);
            showDashboard(session, model);
            model.addAttribute("successMessage", "Loan ID " + loanId + " approved and monthly EMI schedule generated.");
            model.addAttribute("activeTab", "tab-approved-loans");
        } catch (LoanNotFoundException e) {
            showDashboard(session, model);
            model.addAttribute("errorMessage", "Loan ID " + loanId + " not found.");
            model.addAttribute("activeTab", "tab-approve-loan");
        }
        return "admin/admin-dashboard";
    }

    // 8. REJECT LOAN
    @PostMapping("/loan/reject/{loanId}")
    public String rejectLoan(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            loanService.rejectLoan(loanId);
            showDashboard(session, model);
            model.addAttribute("successMessage", "Loan ID " + loanId + " rejected.");
            model.addAttribute("activeTab", "tab-all-loans");
        } catch (LoanNotFoundException e) {
            showDashboard(session, model);
            model.addAttribute("errorMessage", "Loan ID " + loanId + " not found.");
            model.addAttribute("activeTab", "tab-reject-loan");
        }
        return "admin/admin-dashboard";
    }
}