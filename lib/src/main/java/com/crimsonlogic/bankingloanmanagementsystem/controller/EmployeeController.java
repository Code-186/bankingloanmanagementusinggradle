package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.Loan;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IEmployeeService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ILoanService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private IEmployeeService employeeService;

    @Autowired
    private IAccountService accountService;

    @Autowired
    private ILoanService loanService;

    private boolean isEmployee(HttpSession session) {
        return "EMPLOYEE".equals(session.getAttribute("userRole"));
    }

    // 1. EMPLOYEE DASHBOARD
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isEmployee(session)) {
            return "redirect:/login?role=EMPLOYEE";
        }
        Employee employee = (Employee) session.getAttribute("loggedInUser");
        List<Customer> customerList = employeeService.viewAllCustomers(employee.getBranchId());
        List<Loan> pendingLoans = loanService.getPendingLoans();

        model.addAttribute("employee", employee);
        model.addAttribute("customerList", customerList);
        model.addAttribute("loanList", pendingLoans);
        return "employee/employee-dashboard";
    }

    // 2. ASSISTED CUSTOMER ONBOARDING (SHOW FORM)
    @GetMapping("/customer/register")
    public String showRegisterCustomer(HttpSession session, Model model) {
        if (!isEmployee(session)) {
            return "redirect:/login?role=EMPLOYEE";
        }
        Employee employee = (Employee) session.getAttribute("loggedInUser");
        model.addAttribute("bankName", employee.getBankName());
        model.addAttribute("branchId", employee.getBranchId());
        return "employee/customer-register";
    }

    // 3. ASSISTED CUSTOMER ONBOARDING (SUBMIT)
    @PostMapping("/customer/register")
    public String processRegisterCustomer(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("phone") String phone,
            @RequestParam("dob") String dobStr,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "nomineeName", required = false) String nomineeName,
            @RequestParam(value = "nomineeRelationship", required = false) String nomineeRelationship,
            @RequestParam(value = "nomineePhone", required = false) String nomineePhone,
            HttpSession session,
            Model model) {

        if (!isEmployee(session)) {
            return "redirect:/login?role=EMPLOYEE";
        }

        Employee employee = (Employee) session.getAttribute("loggedInUser");

        if (!ValidationUtil.validateName(name) || !ValidationUtil.validatePhone(phone) || !ValidationUtil.validateEmail(email)) {
            model.addAttribute("error", "Validation error: Check Name, Phone, and Email formats.");
            model.addAttribute("bankName", employee.getBankName());
            model.addAttribute("branchId", employee.getBranchId());
            return "employee/customer-register";
        }

        Customer cust = new Customer(null, name, phone, email, address, password,
                LocalDate.parse(dobStr), employee.getBankName(), employee.getBranchId(),
                "REGISTERED", nomineeName, nomineeRelationship, nomineePhone);

        employeeService.registerCustomer(cust);
        model.addAttribute("message", "Customer " + cust.getName() + " onboarded successfully!");
        return "redirect:/employee/dashboard";
    }

    // 4. VIEW BRANCH CUSTOMERS
    @GetMapping("/customers")
    public String viewCustomers(HttpSession session, Model model) {
        if (!isEmployee(session)) {
            return "redirect:/login?role=EMPLOYEE";
        }
        Employee employee = (Employee) session.getAttribute("loggedInUser");
        model.addAttribute("customers", employeeService.viewAllCustomers(employee.getBranchId()));
        return "employee/customer-list";
    }

    // 5. VIEW SINGLE CUSTOMER BY ID
    @GetMapping("/customer/{id}")
    public String viewCustomerById(@PathVariable("id") String customerId, HttpSession session, Model model) {
        if (!isEmployee(session)) {
            return "redirect:/login?role=EMPLOYEE";
        }
        try {
            Customer customer = employeeService.viewCustomer(customerId);
            model.addAttribute("customer", customer);
            return "employee/customer-detail";
        } catch (CustomerNotFoundException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/employee/customers";
        }
    }
}