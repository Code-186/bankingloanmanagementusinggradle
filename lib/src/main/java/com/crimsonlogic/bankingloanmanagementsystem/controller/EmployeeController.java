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

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IEmployeeService;
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

    private boolean isEmployee(HttpSession session) {
        return "EMPLOYEE".equals(session.getAttribute("userRole"));
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        Employee employee = (Employee) session.getAttribute("loggedInUser");
        model.addAttribute("employee", employee);
        return "employee-dashboard";
    }

    // Register Customer (Branch Assisted)
    @GetMapping("/customer/register")
    public String showRegisterCustomer(HttpSession session, Model model) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        Employee employee = (Employee) session.getAttribute("loggedInUser");
        model.addAttribute("bankName", employee.getBankName());
        model.addAttribute("branchId", employee.getBranchId());
        return "employee-customer-register";
    }

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
            HttpSession session, Model model) {

        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        Employee employee = (Employee) session.getAttribute("loggedInUser");

        if (!ValidationUtil.validateName(name) || !ValidationUtil.validatePhone(phone) || !ValidationUtil.validateEmail(email)) {
            model.addAttribute("error", "Validation error: Check Name, Phone, and Email formats.");
            return "employee-customer-register";
        }

        Customer cust = new Customer(null, name, phone, email, address, password, LocalDate.parse(dobStr),
                employee.getBankName(), employee.getBranchId(), "REGISTERED", nomineeName, nomineeRelationship, nomineePhone);

        Customer registered = employeeService.registerCustomer(cust);
        model.addAttribute("customer", registered);
        return "registration-success";
    }

    @GetMapping("/customers")
    public String viewCustomers(HttpSession session, Model model) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        Employee employee = (Employee) session.getAttribute("loggedInUser");
        model.addAttribute("customers", employeeService.viewAllCustomers(employee.getBranchId()));
        return "employee-customer-list";
    }

    @GetMapping("/customer/{custId}")
    public String viewCustomerDetail(@PathVariable("custId") String custId, HttpSession session, Model model) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        try {
            model.addAttribute("customer", employeeService.viewCustomer(custId));
            model.addAttribute("accounts", accountService.getAccountsByCustomerId(custId));
            return "customer-detail";
        } catch (CustomerNotFoundException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/employee/customers";
        }
    }

    // Open Account
    @GetMapping("/account/open")
    public String showOpenAccount(HttpSession session) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        return "account-open";
    }

    @PostMapping("/account/open")
    public String processOpenAccount(
            @RequestParam("customerId") String customerId,
            @RequestParam("accountType") String accountType,
            @RequestParam("initialDeposit") BigDecimal initialDeposit,
            @RequestParam("mpin") String mpin,
            HttpSession session, Model model) {

        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";

        if (!ValidationUtil.validateMPin(mpin)) {
            model.addAttribute("error", "MPIN must be exactly 4 digits.");
            return "account-open";
        }

        if ("SAVINGS".equalsIgnoreCase(accountType)) {
            if (initialDeposit.compareTo(new BigDecimal("1000.00")) < 0) {
                model.addAttribute("error", "Minimum initial deposit for Savings Account is ₹1000.00");
                return "account-open";
            }
            accountService.openSavingsAccount(customerId, initialDeposit, mpin, new BigDecimal("4.00"));
        } else {
            if (initialDeposit.compareTo(new BigDecimal("5000.00")) < 0) {
                model.addAttribute("error", "Minimum initial deposit for Current Account is ₹5000.00");
                return "account-open";
            }
            accountService.openCurrentAccount(customerId, initialDeposit, mpin, new BigDecimal("25000.00"));
        }

        model.addAttribute("message", "Account successfully created and activated.");
        return "employee-dashboard";
    }

    // Deposit & Withdraw
    @GetMapping("/deposit")
    public String showDepositPage(HttpSession session) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        return "deposit";
    }

    @PostMapping("/deposit")
    public String processDeposit(@RequestParam("accountNumber") String accountNumber,
                                 @RequestParam("amount") BigDecimal amount,
                                 HttpSession session, Model model) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        try {
            accountService.deposit(accountNumber, amount);
            model.addAttribute("message", "Deposit of ₹" + amount + " successful to Account: " + accountNumber);
        } catch (AccountNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "deposit";
    }

    @GetMapping("/withdraw")
    public String showWithdrawPage(HttpSession session) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        return "withdraw";
    }

    @PostMapping("/withdraw")
    public String processWithdraw(@RequestParam("accountNumber") String accountNumber,
                                  @RequestParam("amount") BigDecimal amount,
                                  @RequestParam("mpin") String mpin,
                                  HttpSession session, Model model) {
        if (!isEmployee(session)) return "redirect:/login?role=EMPLOYEE";
        try {
            accountService.withdraw(accountNumber, amount, mpin);
            model.addAttribute("message", "Withdrawal of ₹" + amount + " completed.");
        } catch (AccountNotFoundException | InsufficientBalanceException | InvalidMpinException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "withdraw";
    }
}