package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.time.LocalDate;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AdminNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.EmployeeNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAdminService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ICustomerService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IEmployeeService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Admin;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;
import com.crimsonlogic.bankingloanmanagementsystem.utility.BankDetailsUtil;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

@Controller
public class AuthController {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IEmployeeService employeeService;

    @Autowired
    private ICustomerService customerService;

    @GetMapping("/")
    public String showIndex() {
        return "index";
    }

    @GetMapping("/login")
    public String showLoginPage(@RequestParam(value = "role", defaultValue = "CUSTOMER") String role, Model model) {
        model.addAttribute("role", role.toUpperCase());
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam("role") String role,
                               @RequestParam("email") String email,
                               @RequestParam("password") String password,
                               HttpSession session,
                               Model model) {
        model.addAttribute("role", role);
        try {
            switch (role.toUpperCase()) {
                case "ADMIN":
                    Admin admin = adminService.login(email, password);
                    session.setAttribute("loggedInUser", admin);
                    session.setAttribute("userRole", "ADMIN");
                    return "redirect:/admin/dashboard";

                case "EMPLOYEE":
                    Employee employee = employeeService.login(email, password);
                    session.setAttribute("loggedInUser", employee);
                    session.setAttribute("userRole", "EMPLOYEE");
                    return "redirect:/employee/dashboard";

                case "CUSTOMER":
                    Customer customer = customerService.login(email, password);
                    session.setAttribute("loggedInUser", customer);
                    session.setAttribute("userRole", "CUSTOMER");
                    return "redirect:/customer/dashboard";

                default:
                    model.addAttribute("error", "Invalid role selected.");
                    return "login";
            }
        } catch (AdminNotFoundException | EmployeeNotFoundException | CustomerNotFoundException e) {
            model.addAttribute("error", e.getMessage());
            return "login";
        }
    }

    @GetMapping("/register/customer")
    public String showCustomerSelfRegisterPage(Model model) {
        model.addAttribute("banks", BankDetailsUtil.getAllBanks());
        return "auth/customer-register";
    }

    @PostMapping("/register/customer")
    public String processCustomerSelfRegister(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("phone") String phone,
            @RequestParam("dob") String dobStr,
            @RequestParam("bankName") String bankName,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "nomineeName", required = false) String nomineeName,
            @RequestParam(value = "nomineeRelationship", required = false) String nomineeRelationship,
            @RequestParam(value = "nomineePhone", required = false) String nomineePhone,
            Model model) {

        model.addAttribute("banks", BankDetailsUtil.getAllBanks());

        // Field Validations
        if (!ValidationUtil.validateName(name)) {
            model.addAttribute("error", "Invalid Name: Must contain letters only (min 3 chars) and no continuous repeats.");
            return "auth/customer-register";
        }
        if (!ValidationUtil.validateEmail(email)) {
            model.addAttribute("error", "Invalid Email format.");
            return "auth/customer-register";
        }
        if (!ValidationUtil.validatePhone(phone)) {
            model.addAttribute("error", "Invalid Phone: Must be 10 digits starting with 6-9.");
            return "auth/customer-register";
        }
        if (!ValidationUtil.validatePassword(password)) {
            model.addAttribute("error", "Password must have 8-20 characters, 1 uppercase, 1 lowercase, 1 digit, and 1 special symbol.");
            return "auth/customer-register";
        }

        LocalDate dob = LocalDate.parse(dobStr);
        if (!ValidationUtil.validateDob(dob)) {
            model.addAttribute("error", "Age must be at least 18 years.");
            return "auth/customer-register";
        }

        String branchId = BankDetailsUtil.getBranchIdByBankName(bankName);

        Customer newCust = new Customer(null, name, phone, email, address, password, dob, bankName, branchId, "REGISTERED",
                nomineeName, nomineeRelationship, nomineePhone);

        Customer registered = customerService.registerCustomer(newCust);
        
        // Pass registered customer object back so JSTL renders the success card on the same page
        model.addAttribute("customer", registered);
        return "auth/customer-register";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}