package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.math.BigDecimal;
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

import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

@Controller
@RequestMapping("/account")
public class AccountController {

    @Autowired
    private IAccountService accountService;

    // 1. Open Account (Employee action)
    @GetMapping("/open")
    public String showOpenAccountPage(HttpSession session) {
        if (!"EMPLOYEE".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=EMPLOYEE";
        }
        return "account-open";
    }

    @PostMapping("/open")
    public String processOpenAccount(
            @RequestParam("customerId") String customerId,
            @RequestParam("accountType") String accountType,
            @RequestParam("initialDeposit") BigDecimal initialDeposit,
            @RequestParam("mpin") String mpin,
            HttpSession session, Model model) {

        if (!"EMPLOYEE".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=EMPLOYEE";
        }

        if (!ValidationUtil.validateMPin(mpin)) {
            model.addAttribute("error", "MPIN must be exactly 4 digits.");
            return "account-open";
        }

        if ("SAVINGS".equalsIgnoreCase(accountType)) {
            if (initialDeposit.compareTo(new BigDecimal("1000.00")) < 0) {
                model.addAttribute("error", "Minimum initial deposit for Savings Account is ₹1,000.00");
                return "account-open";
            }
            accountService.openSavingsAccount(customerId, initialDeposit, mpin, new BigDecimal("4.00"));
        } else {
            if (initialDeposit.compareTo(new BigDecimal("5000.00")) < 0) {
                model.addAttribute("error", "Minimum initial deposit for Current Account is ₹5,000.00");
                return "account-open";
            }
            accountService.openCurrentAccount(customerId, initialDeposit, mpin, new BigDecimal("25000.00"));
        }

        model.addAttribute("message", "Account successfully created and activated.");
        return "employee-dashboard";
    }

    // 2. View Accounts (Customer view)
    @GetMapping("/my-accounts")
    public String viewCustomerAccounts(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }

        List<Account> accounts = accountService.getAccountsByCustomerId(customer.getCustomerId());
        model.addAttribute("accounts", accounts);
        return "customer-accounts";
    }

    // 3. Deposit (Employee action)
    @GetMapping("/deposit")
    public String showDepositPage(HttpSession session) {
        if (!"EMPLOYEE".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=EMPLOYEE";
        }
        return "deposit";
    }

    @PostMapping("/deposit")
    public String processDeposit(
            @RequestParam("accountNumber") String accountNumber,
            @RequestParam("amount") BigDecimal amount,
            HttpSession session, Model model) {

        if (!"EMPLOYEE".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=EMPLOYEE";
        }

        if (!ValidationUtil.validateAmount(amount)) {
            model.addAttribute("error", "Deposit amount must be greater than ₹0.00");
            return "deposit";
        }

        try {
            accountService.deposit(accountNumber, amount);
            model.addAttribute("message", "Deposit of ₹" + amount + " successful to Account: " + accountNumber);
        } catch (AccountNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "deposit";
    }

    // 4. Withdraw (Employee / Teller action)
    @GetMapping("/withdraw")
    public String showWithdrawPage(HttpSession session) {
        if (!"EMPLOYEE".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=EMPLOYEE";
        }
        return "withdraw";
    }

    @PostMapping("/withdraw")
    public String processWithdraw(
            @RequestParam("accountNumber") String accountNumber,
            @RequestParam("amount") BigDecimal amount,
            @RequestParam("mpin") String mpin,
            HttpSession session, Model model) {

        if (!"EMPLOYEE".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=EMPLOYEE";
        }

        if (!ValidationUtil.validateAmount(amount)) {
            model.addAttribute("error", "Withdrawal amount must be greater than ₹0.00");
            return "withdraw";
        }

        try {
            accountService.withdraw(accountNumber, amount, mpin);
            model.addAttribute("message", "Withdrawal of ₹" + amount + " completed successfully.");
        } catch (AccountNotFoundException | InsufficientBalanceException | InvalidMpinException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "withdraw";
    }

    // 5. Transfer Funds (Customer action)
    @GetMapping("/transfer")
    public String showTransferPage(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }
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

        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }

        model.addAttribute("accounts", accountService.getAccountsByCustomerId(customer.getCustomerId()));

        if (!ValidationUtil.validateAmount(amount)) {
            model.addAttribute("error", "Transfer amount must be greater than ₹0.00");
            return "transfer-funds";
        }

        try {
            accountService.transferFunds(fromAccount, toAccount, amount, mpin);
            model.addAttribute("message", "Successfully transferred ₹" + amount + " to Account: " + toAccount);
        } catch (AccountNotFoundException | InsufficientBalanceException | InvalidMpinException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "transfer-funds";
    }
}