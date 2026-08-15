package com.crimsonlogic.bankingloanmanagementsystem.service.interfaces;

import java.math.BigDecimal;
import java.util.List;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;
import com.crimsonlogic.bankingloanmanagementsystem.accountimplementation.SavingsAccount;
import com.crimsonlogic.bankingloanmanagementsystem.accountimplementation.CurrentAccount;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;

public interface IAccountService {
    SavingsAccount openSavingsAccount(String customerId, BigDecimal initialDeposit, String mpin, BigDecimal interestRate);
    CurrentAccount openCurrentAccount(String customerId, BigDecimal initialDeposit, String mpin, BigDecimal overdraftLimit);
    Account getAccountByNumber(String accountNumber) throws AccountNotFoundException;
    List<Account> getAccountsByCustomerId(String customerId);
    List<Account> getAllAccounts();
    boolean deposit(String accountNumber, BigDecimal amount) throws AccountNotFoundException;
    boolean withdraw(String accountNumber, BigDecimal amount, String mpin) throws AccountNotFoundException, InsufficientBalanceException, InvalidMpinException;
    boolean transferFunds(String fromAccount, String toAccount, BigDecimal amount, String mpin) throws AccountNotFoundException, InsufficientBalanceException, InvalidMpinException;
}