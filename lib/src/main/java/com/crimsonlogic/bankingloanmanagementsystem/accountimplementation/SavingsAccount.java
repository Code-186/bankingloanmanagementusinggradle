package com.crimsonlogic.bankingloanmanagementsystem.accountimplementation;

import java.time.LocalDate;
import java.util.Objects;

import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;

public class SavingsAccount extends Account {

    private double interestRate;

    public SavingsAccount(long accountNumber,
                          double balance,
                          LocalDate openedDate,
                          boolean active,
                          int customerId,
                          double interestRate) {

        super(accountNumber,
                balance,
                openedDate,
                active,
                customerId);

        this.interestRate = interestRate;
    }

    @Override
    public void withdraw(double amount) {

        if(amount > getBalance()) {

            System.out.println(
                    "Insufficient Balance");

            return;
        }

        if(getBalance() - amount < 1000) {

            System.out.println(
                    "Minimum balance should be maintained");

            return;
        }

        setBalance(
                getBalance() - amount);
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    @Override
    public String toString() {
        return "SavingsAccount{" +
                "interestRate=" + interestRate +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        SavingsAccount that = (SavingsAccount) o;
        return Double.compare(interestRate, that.interestRate) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), interestRate);
    }
}
