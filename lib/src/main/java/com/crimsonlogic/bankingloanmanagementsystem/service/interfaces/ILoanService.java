package com.crimsonlogic.bankingloanmanagementsystem.service.interfaces;

import java.math.BigDecimal;
import java.util.List;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.LoanNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.EMI;
import com.crimsonlogic.bankingloanmanagementsystem.model.Loan;

public interface ILoanService {
    Loan applyLoan(String customerId, String loanType, BigDecimal amount, BigDecimal interestRate, Integer tenureMonths);
    boolean approveLoan(String loanId) throws LoanNotFoundException;
    boolean rejectLoan(String loanId) throws LoanNotFoundException;
    Loan findLoanById(String loanId) throws LoanNotFoundException;
    List<Loan> getAllLoans();
    List<Loan> getPendingLoans();
    List<Loan> getApprovedLoans();
    List<Loan> getLoansByCustomerId(String customerId);
    List<EMI> getEmisByCustomerId(String customerId);
    boolean payEmi(String emiId, String accountNumber, String mpin) throws AccountNotFoundException, InsufficientBalanceException, InvalidMpinException;
}