package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
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
import com.crimsonlogic.bankingloanmanagementsystem.utility.BankDetailsUtil;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private ILoanService loanService;

    private boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("userRole"));
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        Admin admin = (Admin) session.getAttribute("loggedInUser");
        model.addAttribute("admin", admin);
        return "admin-dashboard";
    }

    // ===== EMPLOYEE MANAGEMENT =====
    @GetMapping("/employee/register")
    public String showEmployeeRegister(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        Admin admin = (Admin) session.getAttribute("loggedInUser");
        model.addAttribute("bankName", admin.getBankName());
        model.addAttribute("branchId", admin.getBranchId());
        return "employee-register";
    }

    @PostMapping("/employee/register")
    public String processEmployeeRegister(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("phone") String phone,
            @RequestParam("dob") String dobStr,
            @RequestParam("designation") String designation,
            @RequestParam("salary") BigDecimal salary,
            @RequestParam(value = "address", required = false) String address,
            HttpSession session, Model model) {

        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        Admin admin = (Admin) session.getAttribute("loggedInUser");

        if (!BankDetailsUtil.isValidOfficialEmail(email, admin.getBankName())) {
            model.addAttribute("error", "Official email must end with: " + BankDetailsUtil.getOfficialDomainByBankName(admin.getBankName()));
            return "employee-register";
        }
        if (!ValidationUtil.validatePassword(password)) {
            model.addAttribute("error", "Password must satisfy security policy (8+ chars, uppercase, lowercase, digit, special character).");
            return "employee-register";
        }

        Employee emp = new Employee(null, name, phone, email, address, password, LocalDate.parse(dobStr),
                admin.getBankName(), admin.getBranchId(), "ACTIVE", designation, salary);

        Employee registered = adminService.registerEmployee(emp);
        model.addAttribute("employee", registered);
        return "employee-success";
    }

    @PostMapping("/employee/delete")
    public String deleteEmployee(@RequestParam("employeeId") String employeeId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            adminService.deleteEmployee(employeeId);
            model.addAttribute("message", "Employee " + employeeId + " deactivated successfully.");
        } catch (EmployeeNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/admin/view/employees";
    }

    @PostMapping("/customer/delete")
    public String deleteCustomer(@RequestParam("customerId") String customerId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            adminService.deleteCustomer(customerId);
            model.addAttribute("message", "Customer " + customerId + " deactivated successfully.");
        } catch (CustomerNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/admin/view/customers";
    }

    // ===== VIEW MANAGEMENT =====
    @GetMapping("/view/admins")
    public String viewAllAdmins(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("admins", adminService.getAllAdmins());
        return "admin-list";
    }

    @GetMapping("/view/employees")
    public String viewAllEmployees(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("employees", adminService.getAllEmployees());
        return "employee-list";
    }

    @GetMapping("/view/employee/{empId}")
    public String viewEmployee(@PathVariable("empId") String empId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            model.addAttribute("employee", adminService.getEmployeeById(empId));
            return "employee-detail";
        } catch (EmployeeNotFoundException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/admin/view/employees";
        }
    }

    @GetMapping("/view/customers")
    public String viewAllCustomers(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("customers", adminService.getAllCustomers());
        return "customer-list";
    }

    @GetMapping("/view/customer/{custId}")
    public String viewCustomer(@PathVariable("custId") String custId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            model.addAttribute("customer", adminService.getCustomerById(custId));
            return "customer-detail";
        } catch (CustomerNotFoundException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/admin/view/customers";
        }
    }

    // ===== LOAN MANAGEMENT =====
    @GetMapping("/loan/pending")
    public String viewPendingLoans(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("loans", loanService.getPendingLoans());
        return "loan-pending-list";
    }

    @GetMapping("/loan/approved")
    public String viewApprovedLoans(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("loans", loanService.getApprovedLoans());
        return "loan-approved-list";
    }

    @GetMapping("/loan/all")
    public String viewAllLoans(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("loans", loanService.getAllLoans());
        return "loan-all-list";
    }

    @PostMapping("/loan/approve/{loanId}")
    public String approveLoan(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            loanService.approveLoan(loanId);
            model.addAttribute("message", "Loan " + loanId + " approved and EMI schedules generated.");
        } catch (LoanNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/admin/loan/pending";
    }

    @PostMapping("/loan/reject/{loanId}")
    public String rejectLoan(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        try {
            loanService.rejectLoan(loanId);
            model.addAttribute("message", "Loan " + loanId + " rejected.");
        } catch (LoanNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/admin/loan/pending";
    }

    // ===== REPORTS MENU =====
    @GetMapping("/reports")
    public String showReportsHub(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        return "reports-hub";
    }
}