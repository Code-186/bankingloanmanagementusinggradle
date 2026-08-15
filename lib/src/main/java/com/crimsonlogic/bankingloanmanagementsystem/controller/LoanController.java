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

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.LoanNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.EMI;
import com.crimsonlogic.bankingloanmanagementsystem.model.Loan;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ILoanService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

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
        return "loan-apply";
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

        if (!ValidationUtil.validateAmount(amount)) {
            model.addAttribute("error", "Loan amount must be greater than ₹0.00");
            return "loan-apply";
        }

        // Set interest rate based on loan type
        BigDecimal interestRate = "HOME_LOAN".equalsIgnoreCase(loanType) ? new BigDecimal("8.50") : new BigDecimal("12.00");

        Loan createdLoan = loanService.applyLoan(customer.getCustomerId(), loanType, amount, interestRate, tenureMonths);

        model.addAttribute("message", "Loan Application submitted successfully! Your generated Loan ID is " + createdLoan.getLoanId());
        model.addAttribute("loan", createdLoan);
        return "loan-status";
    }

    // 2. Customer: View My Loans
    @GetMapping("/my-loans")
    public String viewCustomerLoans(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }

        List<Loan> loans = loanService.getLoansByCustomerId(customer.getCustomerId());
        model.addAttribute("loans", loans);
        return "customer-loans";
    }

    // 3. Customer: View EMIs & Pay EMI
    @GetMapping("/emis")
    public String viewCustomerEmis(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null || !"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=CUSTOMER";
        }

        List<EMI> emis = loanService.getEmisByCustomerId(customer.getCustomerId());
        model.addAttribute("emis", emis);
        model.addAttribute("accounts", accountService.getAccountsByCustomerId(customer.getCustomerId()));
        return "customer-emis";
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

    // 4. Admin: View All Loans
    @GetMapping("/admin/all")
    public String viewAllLoansAdmin(HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        model.addAttribute("loans", loanService.getAllLoans());
        return "loan-all-list";
    }

    // 5. Admin: View Pending Loans
    @GetMapping("/admin/pending")
    public String viewPendingLoansAdmin(HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        model.addAttribute("loans", loanService.getPendingLoans());
        return "loan-pending-list";
    }

    // 6. Admin: View Approved Loans
    @GetMapping("/admin/approved")
    public String viewApprovedLoansAdmin(HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        model.addAttribute("loans", loanService.getApprovedLoans());
        return "loan-approved-list";
    }

    // 7. Admin: Approve Loan
    @PostMapping("/admin/approve/{loanId}")
    public String approveLoanAdmin(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        try {
            loanService.approveLoan(loanId);
            model.addAttribute("message", "Loan " + loanId + " approved and EMI schedules generated.");
        } catch (LoanNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/loan/admin/pending";
    }

    // 8. Admin: Reject Loan
    @PostMapping("/admin/reject/{loanId}")
    public String rejectLoanAdmin(@PathVariable("loanId") String loanId, HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login?role=ADMIN";
        }
        try {
            loanService.rejectLoan(loanId);
            model.addAttribute("message", "Loan " + loanId + " has been rejected.");
        } catch (LoanNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/loan/admin/pending";
    }
}