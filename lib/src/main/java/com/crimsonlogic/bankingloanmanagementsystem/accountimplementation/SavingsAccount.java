package com.crimsonlogic.bankingloanmanagementsystem.accountimplementation;

import java.math.BigDecimal;
import java.time.LocalDate;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;

public class SavingsAccount extends Account {
    private static final long serialVersionUID = 1L;
    private static final BigDecimal MIN_BALANCE = new BigDecimal("1000.00");

    private BigDecimal interestRate;

    public SavingsAccount() {
        super();
        setAccountType("SAVINGS");
    }

    public SavingsAccount(String accountNumber, BigDecimal balance, LocalDate openingDate, 
                          String accountStatus, String mpin, String customerId, BigDecimal interestRate) {
        super(accountNumber, balance, openingDate, accountStatus, mpin, customerId, "SAVINGS");
        this.interestRate = interestRate;
    }

    @Override
    public BigDecimal getMinimumBalance() {
        return MIN_BALANCE;
    }

    public BigDecimal getInterestRate() { return interestRate; }
    public void setInterestRate(BigDecimal interestRate) { this.interestRate = interestRate; }
}