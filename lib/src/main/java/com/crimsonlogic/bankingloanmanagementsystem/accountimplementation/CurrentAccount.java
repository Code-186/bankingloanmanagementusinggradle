package com.crimsonlogic.bankingloanmanagementsystem.accountimplementation;

import java.time.LocalDate;
import java.util.Objects;

import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;


public class CurrentAccount extends Account {

    private double overdraftLimit;

    public CurrentAccount() {
    }

    public CurrentAccount(long accountNumber,
                          double balance,
                          LocalDate openedDate,
                          boolean active,
                          int customerId,
                          double overdraftLimit) {

        super(accountNumber, balance,
                openedDate, active, customerId);

        this.overdraftLimit = overdraftLimit;
    }

    @Override
    public void withdraw(double amount) {

        if(getBalance() + overdraftLimit < amount) {
            System.out.println("Overdraft limit exceeded");
            return;
        }

        setBalance(getBalance() - amount);
    }

    public double getOverdraftLimit() {
        return overdraftLimit;
    }

    public void setOverdraftLimit(double overdraftLimit) {
        this.overdraftLimit = overdraftLimit;
    }

    @Override
    public String toString() {
        return "CurrentAccount [overdraftLimit=" + overdraftLimit + "]";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        CurrentAccount that = (CurrentAccount) o;
        return Double.compare(overdraftLimit, that.overdraftLimit) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), overdraftLimit);
    }
}
