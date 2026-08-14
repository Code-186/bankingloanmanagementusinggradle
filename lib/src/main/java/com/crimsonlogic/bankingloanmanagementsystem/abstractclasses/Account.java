package com.crimsonlogic.bankingloanmanagementsystem.abstractclasses;



import java.time.LocalDate;
import java.util.Objects;

public abstract class Account {

    private long accountNumber;
    private double balance;
    private LocalDate openedDate;
    private boolean active;
    private int customerId;

    public Account() {
    }

    public Account(long accountNumber,
                   double balance,
                   LocalDate openedDate,
                   boolean active,
                   int customerId) {

        this.accountNumber = accountNumber;
        this.balance = balance;
        this.openedDate = openedDate;
        this.active = active;
        this.customerId = customerId;
    }

    public void deposit(double amount) {
        balance += amount;
    }

    public abstract void withdraw(double amount);

    public long getAccountNumber() {
        return accountNumber;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public LocalDate getOpenedDate() {
        return openedDate;
    }

    public boolean isActive() {
        return active;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setActive(boolean active) {
        this.active = active;
    }


    public void setAccountNumber(long accountNumber) {
        this.accountNumber = accountNumber;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Account account = (Account) o;
        return accountNumber == account.accountNumber && Double.compare(balance, account.balance) == 0 && active == account.active && customerId == account.customerId && Objects.equals(openedDate, account.openedDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(accountNumber, balance, openedDate, active, customerId);
    }

    @Override
    public String toString() {
        return "Account{" +
                "accountNumber=" + accountNumber +
                ", balance=" + balance +
                ", openedDate=" + openedDate +
                ", active=" + active +
                ", customerId=" + customerId +
                '}';
    }
}
