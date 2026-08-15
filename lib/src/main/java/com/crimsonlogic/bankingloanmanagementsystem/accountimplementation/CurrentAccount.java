package com.crimsonlogic.bankingloanmanagementsystem.accountimplementation;

import java.math.BigDecimal;
import java.time.LocalDate;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;

public class CurrentAccount extends Account {
    private static final long serialVersionUID = 1L;
    private static final BigDecimal MIN_BALANCE = new BigDecimal("5000.00");

    private BigDecimal overdraftLimit;

    public CurrentAccount() {
        super();
        setAccountType("CURRENT");
    }

    public CurrentAccount(String accountNumber, BigDecimal balance, LocalDate openingDate, 
                          String accountStatus, String mpin, String customerId, BigDecimal overdraftLimit) {
        super(accountNumber, balance, openingDate, accountStatus, mpin, customerId, "CURRENT");
        this.overdraftLimit = overdraftLimit;
    }

    @Override
    public BigDecimal getMinimumBalance() {
        return MIN_BALANCE;
    }

    public BigDecimal getOverdraftLimit() { return overdraftLimit; }
    public void setOverdraftLimit(BigDecimal overdraftLimit) { this.overdraftLimit = overdraftLimit; }
}