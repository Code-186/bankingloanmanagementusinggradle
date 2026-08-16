package com.crimsonlogic.bankingloanmanagementsystem.controller;

import java.math.BigDecimal;
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
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.LoanNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ILoanService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;

@Controller
@RequestMapping("/loan")
public class LoanController {

    @Autowired
    private ILoanService loanService;

    @Autowired
    private IAccountService accountService;

    // 1. Customer: Apply Loan
    @GetMapping("/apply")
    public String showApplyLoanForm(HttpSession session) {
        if (!"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }
        return "loan/loan-apply";
    }

    @PostMapping("/apply")
    public String processApplyLoan(
            @RequestParam("loanType") String loanType,
            @RequestParam("amount") BigDecimal amount,
            @RequestParam("tenureMonths") Integer tenureMonths,
            HttpSession session, Model model) {

        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }

        BigDecimal interestRate = "HOME_LOAN".equalsIgnoreCase(loanType) ? new BigDecimal("8.50") : new BigDecimal("12.00");
        loanService.applyLoan(customer.getCustomerId(), loanType, amount, interestRate, tenureMonths);

        model.addAttribute("message", "Loan application submitted successfully and is pending approval.");
        return "loan/loan-apply";
    }

    // 2. Customer: View Loans & EMIs
    @GetMapping("/my-loans")
    public String viewCustomerLoans(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }
        model.addAttribute("loans", loanService.getLoansByCustomerId(customer.getCustomerId()));
        return "loan/customer-loans";
    }

    @GetMapping("/emis")
    public String viewCustomerEmis(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }
        model.addAttribute("emis", loanService.getEmisByCustomerId(customer.getCustomerId()));
        model.addAttribute("accounts", accountService.getAccountsByCustomerId(customer.getCustomerId()));
        return "loan/customer-emis";
    }

    @PostMapping("/pay-emi")
    public String payEmi(
            @RequestParam("emiId") String emiId,
            @RequestParam("accountNumber") String accountNumber,
            @RequestParam("mpin") String mpin,
            HttpSession session, Model model) {

        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }

        try {
            loanService.payEmi(emiId, accountNumber, mpin);
            model.addAttribute("message", "EMI installment paid successfully.");
        } catch (AccountNotFoundException | InsufficientBalanceException | InvalidMpinException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/loan/emis";
    }

    // 3. Admin: Loan Approvals
    @GetMapping("/admin/pending")
    public String viewPendingLoansAdmin(HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        model.addAttribute("loans", loanService.getPendingLoans());
        return "admin/loan-management";
    }

    @PostMapping("/admin/approve/{loanId}")
    public String approveLoanAdmin(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        try {
            loanService.approveLoan(loanId);
            model.addAttribute("message", "Loan " + loanId + " approved and EMI schedule generated.");
        } catch (LoanNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/loan/admin/pending";
    }

    @PostMapping("/admin/reject/{loanId}")
    public String rejectLoanAdmin(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        try {
            loanService.rejectLoan(loanId);
            model.addAttribute("message", "Loan " + loanId + " rejected.");
        } catch (LoanNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/loan/admin/pending";
    }
}