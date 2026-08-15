package com.crimsonlogic.bankingloanmanagementsystem.abstractclasses;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

public abstract class Account implements Serializable {
    private static final long serialVersionUID = 1L;

    private String accountNumber;
    private BigDecimal balance;
    private LocalDate openingDate;
    private String accountStatus;
    private String mpin;
    private String customerId;
    private String accountType;

    public Account() {}

    public Account(String accountNumber, BigDecimal balance, LocalDate openingDate, 
                   String accountStatus, String mpin, String customerId, String accountType) {
        this.accountNumber = accountNumber;
        this.balance = balance;
        this.openingDate = openingDate;
        this.accountStatus = accountStatus;
        this.mpin = mpin;
        this.customerId = customerId;
        this.accountType = accountType;
    }

    public abstract BigDecimal getMinimumBalance();

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public BigDecimal getBalance() { return balance; }
    public void setBalance(BigDecimal balance) { this.balance = balance; }

    public LocalDate getOpeningDate() { return openingDate; }
    public void setOpeningDate(LocalDate openingDate) { this.openingDate = openingDate; }

    public String getAccountStatus() { return accountStatus; }
    public void setAccountStatus(String accountStatus) { this.accountStatus = accountStatus; }

    public String getMpin() { return mpin; }
    public void setMpin(String mpin) { this.mpin = mpin; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getAccountType() { return accountType; }
    public void setAccountType(String accountType) { this.accountType = accountType; }
}