package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.math.BigDecimal;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ICustomerService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ILoanService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IAccountService accountService;

    @Autowired
    private ILoanService loanService;

    private boolean isCustomer(HttpSession session) {
        return "CUSTOMER".equals(session.getAttribute("userRole"));
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        model.addAttribute("customer", customer);
        return "customer-dashboard";
    }

    @GetMapping("/accounts")
    public String viewAccounts(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        List<Account> accounts = accountService.getAccountsByCustomerId(customer.getCustomerId());
        model.addAttribute("accounts", accounts);
        return "customer-accounts";
    }

    // ===== TRANSFER FUNDS =====
    @GetMapping("/transfer")
    public String showTransfer(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        model.addAttribute("accounts", accountService.getAccountsByCustomerId(customer.getCustomerId()));
        return "transfer-funds";
    }

    @PostMapping("/transfer")
    public String processTransfer(
            @RequestParam("fromAccount") String fromAccount,
            @RequestParam("toAccount") String toAccount,
            @RequestParam("amount") BigDecimal amount,
            @RequestParam("mpin") String mpin,
            HttpSession session, Model model) {

        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";

        try {
            accountService.transferFunds(fromAccount, toAccount, amount, mpin);
            model.addAttribute("message", "Successfully transferred ₹" + amount + " to Account: " + toAccount);
        } catch (AccountNotFoundException | InsufficientBalanceException | InvalidMpinException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "transfer-funds";
    }

    // ===== LOANS & EMIs =====
    @GetMapping("/loan/apply")
    public String showApplyLoan(HttpSession session) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        return "loan-apply";
    }

    @PostMapping("/loan/apply")
    public String processApplyLoan(
            @RequestParam("loanType") String loanType,
            @RequestParam("amount") BigDecimal amount,
            @RequestParam("tenureMonths") Integer tenureMonths,
            HttpSession session, Model model) {

        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");

        BigDecimal interestRate = "HOME_LOAN".equalsIgnoreCase(loanType) ? new BigDecimal("8.50") : new BigDecimal("12.00");
        loanService.applyLoan(customer.getCustomerId(), loanType, amount, interestRate, tenureMonths);

        model.addAttribute("message", "Loan application submitted. Status is PENDING review.");
        return "loan-apply";
    }

    @GetMapping("/loan/my-loans")
    public String viewMyLoans(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        model.addAttribute("loans", loanService.getLoansByCustomerId(customer.getCustomerId()));
        return "customer-loans";
    }

    @GetMapping("/loan/emis")
    public String viewEmis(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        model.addAttribute("emis", loanService.getEmisByCustomerId(customer.getCustomerId()));
        model.addAttribute("accounts", accountService.getAccountsByCustomerId(customer.getCustomerId()));
        return "customer-emis";
    }

    @PostMapping("/loan/pay-emi")
    public String payEmi(
            @RequestParam("emiId") String emiId,
            @RequestParam("accountNumber") String accountNumber,
            @RequestParam("mpin") String mpin,
            HttpSession session, Model model) {

        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";

        try {
            loanService.payEmi(emiId, accountNumber, mpin);
            model.addAttribute("message", "EMI paid successfully.");
        } catch (AccountNotFoundException | InsufficientBalanceException | InvalidMpinException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/customer/loan/emis";
    }

    // ===== PROFILE UPDATE =====
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        try {
            model.addAttribute("customer", customerService.getProfile(customer.getCustomerId()));
        } catch (CustomerNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "customer-profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam("phoneNumber") String phone,
            @RequestParam("address") String address,
            @RequestParam("nomineeName") String nomineeName,
            @RequestParam("nomineeRelationship") String nomineeRelationship,
            @RequestParam("nomineePhoneNumber") String nomineePhone,
            HttpSession session, Model model) {

        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");

        customer.setPhoneNumber(phone);
        customer.setAddress(address);
        customer.setNomineeName(nomineeName);
        customer.setNomineeRelationship(nomineeRelationship);
        customer.setNomineePhoneNumber(nomineePhone);

        customerService.updateProfile(customer);
        model.addAttribute("message", "Profile updated successfully.");
        model.addAttribute("customer", customer);
        return "customer-profile";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            HttpSession session, Model model) {

        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");

        if (!ValidationUtil.validatePassword(newPassword)) {
            model.addAttribute("error", "New password does not meet security requirements.");
            return "customer-profile";
        }

        if (customerService.changePassword(customer.getCustomerId(), oldPassword, newPassword)) {
            model.addAttribute("message", "Password changed successfully.");
        } else {
            model.addAttribute("error", "Incorrect old password entered.");
        }
        return "customer-profile";
    }
}