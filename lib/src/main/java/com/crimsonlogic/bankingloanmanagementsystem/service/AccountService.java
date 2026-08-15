package com.crimsonlogic.bankingloanmanagementsystem.service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;
import com.crimsonlogic.bankingloanmanagementsystem.accountimplementation.SavingsAccount;
import com.crimsonlogic.bankingloanmanagementsystem.accountimplementation.CurrentAccount;
import com.crimsonlogic.bankingloanmanagementsystem.dao.AccountMapper;
import com.crimsonlogic.bankingloanmanagementsystem.dao.CustomerMapper;
import com.crimsonlogic.bankingloanmanagementsystem.dao.TransactionMapper;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AccountNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InsufficientBalanceException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.InvalidMpinException;
import com.crimsonlogic.bankingloanmanagementsystem.model.Transaction;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAccountService;
import com.crimsonlogic.bankingloanmanagementsystem.utility.IdGeneratorUtil;

@Service
public class AccountService implements IAccountService {

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private TransactionMapper transactionMapper;

    @Override
    @Transactional
    public SavingsAccount openSavingsAccount(String customerId, BigDecimal initialDeposit, String mpin, BigDecimal interestRate) {
        String accNo = String.valueOf(IdGeneratorUtil.generateAccountNumber());
        SavingsAccount acc = new SavingsAccount(accNo, initialDeposit, LocalDate.now(), "ACTIVE", mpin, customerId, interestRate);
        accountMapper.insertSavingsAccount(acc);
        customerMapper.updateCustomerStatus(customerId, "ACTIVE");

        // Record Initial Deposit Transaction
        recordTxn(accNo, "INITIAL_DEPOSIT", initialDeposit);
        return acc;
    }

    @Override
    @Transactional
    public CurrentAccount openCurrentAccount(String customerId, BigDecimal initialDeposit, String mpin, BigDecimal overdraftLimit) {
        String accNo = String.valueOf(IdGeneratorUtil.generateAccountNumber());
        CurrentAccount acc = new CurrentAccount(accNo, initialDeposit, LocalDate.now(), "ACTIVE", mpin, customerId, overdraftLimit);
        accountMapper.insertCurrentAccount(acc);
        customerMapper.updateCustomerStatus(customerId, "ACTIVE");

        recordTxn(accNo, "INITIAL_DEPOSIT", initialDeposit);
        return acc;
    }

    @Override
    public Account getAccountByNumber(String accountNumber) throws AccountNotFoundException {
        Account acc = accountMapper.findByAccountNumber(accountNumber);
        if (acc == null) throw new AccountNotFoundException("Account Number " + accountNumber + " not found.");
        return acc;
    }

    @Override
    public List<Account> getAccountsByCustomerId(String customerId) {
        return accountMapper.findAccountsByCustomerId(customerId);
    }

    @Override
    public List<Account> getAllAccounts() {
        return accountMapper.findAllAccounts();
    }

    @Override
    @Transactional
    public boolean deposit(String accountNumber, BigDecimal amount) throws AccountNotFoundException {
        Account acc = getAccountByNumber(accountNumber);
        BigDecimal newBalance = acc.getBalance().add(amount);
        accountMapper.updateBalance(accountNumber, newBalance);
        
        // Re-activate if was below min balance
        if (newBalance.compareTo(acc.getMinimumBalance()) >= 0 && !"ACTIVE".equalsIgnoreCase(acc.getAccountStatus())) {
            accountMapper.updateAccountStatus(accountNumber, "ACTIVE");
        }
        recordTxn(accountNumber, "DEPOSIT", amount);
        return true;
    }

    @Override
    @Transactional
    public boolean withdraw(String accountNumber, BigDecimal amount, String mpin) 
            throws AccountNotFoundException, InsufficientBalanceException, InvalidMpinException {
        Account acc = getAccountByNumber(accountNumber);
        if (!acc.getMpin().equals(mpin)) {
            throw new InvalidMpinException("Invalid 4-digit MPIN entered.");
        }
        BigDecimal available = acc.getBalance();
        BigDecimal minBal = acc.getMinimumBalance();
        
        if (available.subtract(amount).compareTo(minBal) < 0) {
            throw new InsufficientBalanceException("Insufficient balance. Minimum mandatory balance is ₹" + minBal);
        }
        
        BigDecimal newBalance = available.subtract(amount);
        accountMapper.updateBalance(accountNumber, newBalance);
        recordTxn(accountNumber, "WITHDRAWAL", amount);
        return true;
    }

    @Override
    @Transactional
    public boolean transferFunds(String fromAccount, String toAccount, BigDecimal amount, String mpin) 
            throws AccountNotFoundException, InsufficientBalanceException, InvalidMpinException {
        withdraw(fromAccount, amount, mpin);
        deposit(toAccount, amount);
        return true;
    }

    private void recordTxn(String accNo, String type, BigDecimal amount) {
        Transaction txn = new Transaction(
            IdGeneratorUtil.generateTransactionId(),
            accNo,
            type,
            amount,
            "SUCCESS",
            new Timestamp(System.currentTimeMillis())
        );
        transactionMapper.insertTransaction(txn);
    }
}