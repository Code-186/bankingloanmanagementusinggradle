package com.crimsonlogic.bankingloanmanagementsystem.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.crimsonlogic.bankingloanmanagementsystem.dao.LoanMapper;
import com.crimsonlogic.bankingloanmanagementsystem.dao.EmiMapper;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.LoanNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.EMI;
import com.crimsonlogic.bankingloanmanagementsystem.model.Loan;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ILoanService;
import com.crimsonlogic.bankingloanmanagementsystem.utility.IdGeneratorUtil;

@Service
public class LoanService implements ILoanService {

    @Autowired
    private LoanMapper loanMapper;

    @Autowired
    private EmiMapper emiMapper;

    @Autowired
    private IAccountService accountService;

    @Override
    @Transactional
    public Loan applyLoan(String customerId, String loanType, BigDecimal amount, BigDecimal interestRate, Integer tenureMonths) {
        Loan loan = new Loan(
            IdGeneratorUtil.generateLoanId(),
            customerId,
            loanType,
            amount,
            interestRate,
            tenureMonths,
            "PENDING"
        );
        loanMapper.insertLoan(loan);
        return loan;
    }

    @Override
    @Transactional
    public boolean approveLoan(String loanId) throws LoanNotFoundException {
        Loan loan = loanMapper.findLoanById(loanId);
        if (loan == null) throw new LoanNotFoundException("Loan ID " + loanId + " not found.");

        loanMapper.updateLoanStatus(loanId, "APPROVED");

        // Calculate and create EMI Schedule
        BigDecimal principal = loan.getLoanAmount();
        BigDecimal annualRate = loan.getInterestRate();
        int months = loan.getTenureMonths();

        // Simple monthly EMI calculation: [P + (P * r * t)] / n
        BigDecimal totalInterest = principal.multiply(annualRate).multiply(BigDecimal.valueOf(months))
                                    .divide(BigDecimal.valueOf(1200), 2, RoundingMode.HALF_UP);
        BigDecimal totalPayable = principal.add(totalInterest);
        BigDecimal monthlyEmi = totalPayable.divide(BigDecimal.valueOf(months), 2, RoundingMode.HALF_UP);

        for (int i = 1; i <= months; i++) {
            EMI emi = new EMI(
                IdGeneratorUtil.generateEmiId(),
                loan.getLoanId(),
                loan.getCustomerId(),
                monthlyEmi,
                LocalDate.now().plusMonths(i),
                "UNPAID"
            );
            emiMapper.insertEmi(emi);
        }
        return true;
    }

    @Override
    public boolean rejectLoan(String loanId) throws LoanNotFoundException {
        Loan loan = loanMapper.findLoanById(loanId);
        if (loan == null) throw new LoanNotFoundException("Loan ID " + loanId + " not found.");
        return loanMapper.updateLoanStatus(loanId, "REJECTED") > 0;
    }

    @Override
    public Loan findLoanById(String loanId) throws LoanNotFoundException {
        Loan loan = loanMapper.findLoanById(loanId);
        if (loan == null) throw new LoanNotFoundException("Loan ID " + loanId + " not found.");
        return loan;
    }

    @Override
    public List<Loan> getAllLoans() {
        return loanMapper.findAllLoans();
    }

    @Override
    public List<Loan> getPendingLoans() {
        return loanMapper.findLoansByStatus("PENDING");
    }

    @Override
    public List<Loan> getApprovedLoans() {
        return loanMapper.findLoansByStatus("APPROVED");
    }

    @Override
    public List<Loan> getLoansByCustomerId(String customerId) {
        return loanMapper.findLoansByCustomerId(customerId);
    }

    @Override
    public List<EMI> getEmisByCustomerId(String customerId) {
        return emiMapper.findEmisByCustomerId(customerId);
    }

    @Override
    @Transactional
    public boolean payEmi(String emiId, String accountNumber, String mpin) 
            throws AccountNotFoundException, InsufficientBalanceException, InvalidMpinException {
        EMI emi = emiMapper.findEmiById(emiId);
        if (emi == null || "PAID".equalsIgnoreCase(emi.getStatus())) {
            return false;
        }
        // Deduct from account (MPIN checked via AccountService -> PasswordUtil)
        accountService.withdraw(accountNumber, emi.getEmiAmount(), mpin);
        emiMapper.updateEmiStatus(emiId, "PAID");
        return true;
    }
}