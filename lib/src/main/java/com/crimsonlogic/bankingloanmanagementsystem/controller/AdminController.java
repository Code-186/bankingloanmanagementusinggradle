package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
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
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAdminService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ILoanService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Admin;
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
        return "admin/admin-dashboard";
    }

    // ===== STAFF MANAGEMENT =====
    @GetMapping("/view/employees")
    public String viewAllEmployees(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("employees", adminService.getAllEmployees());
        return "admin/staff-management";
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
            model.addAttribute("employees", adminService.getAllEmployees());
            return "admin/staff-management";
        }
        if (!ValidationUtil.validatePassword(password)) {
            model.addAttribute("error", "Password must satisfy security policy (8+ chars, uppercase, lowercase, digit, special character).");
            model.addAttribute("employees", adminService.getAllEmployees());
            return "admin/staff-management";
        }

        Employee emp = new Employee(null, name, phone, email, address, password, LocalDate.parse(dobStr),
                admin.getBankName(), admin.getBranchId(), "ACTIVE", designation, salary);

        adminService.registerEmployee(emp);
        model.addAttribute("message", "Employee registered successfully!");
        model.addAttribute("employees", adminService.getAllEmployees());
        return "admin/staff-management";
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

    // ===== CUSTOMER MANAGEMENT =====
    @GetMapping("/view/customers")
    public String viewAllCustomers(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        model.addAttribute("customers", adminService.getAllCustomers());
        return "admin/customer-management";
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

    // ===== REPORTS =====
    @GetMapping("/reports")
    public String showReportsHub(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login?role=ADMIN";
        return "admin/reports-hub";
    }
}