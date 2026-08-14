package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.time.LocalDate;
import java.util.Objects;

public class Loan {

    private int loanId;
    private int customerId;
    private String loanType;
    private double loanAmount;
    private double interestRate;
    private int tenureInMonths;
    private String status;
    private LocalDate appliedDate;

    public Loan() {
    }

    public Loan(int loanId,
                int customerId,
                String loanType,
                double loanAmount,
                double interestRate,
                int tenureInMonths,
                String status,
                LocalDate appliedDate) {

        this.loanId = loanId;
        this.customerId = customerId;
        this.loanType = loanType;
        this.loanAmount = loanAmount;
        this.interestRate = interestRate;
        this.tenureInMonths = tenureInMonths;
        this.status = status;
        this.appliedDate = appliedDate;
    }

    // Generate getters and setters

    @Override
    public String toString() {
        return "Loan [loanId=" + loanId
                + ", customerId=" + customerId
                + ", loanType=" + loanType
                + ", loanAmount=" + loanAmount
                + ", status=" + status + "]";
    }

    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getLoanType() {
        return loanType;
    }

    public void setLoanType(String loanType) {
        this.loanType = loanType;
    }

    public double getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(double loanAmount) {
        this.loanAmount = loanAmount;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    public int getTenureInMonths() {
        return tenureInMonths;
    }

    public void setTenureInMonths(int tenureInMonths) {
        this.tenureInMonths = tenureInMonths;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getAppliedDate() {
        return appliedDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Loan loan = (Loan) o;
        return loanId == loan.loanId && customerId == loan.customerId && Double.compare(loanAmount, loan.loanAmount) == 0 && Double.compare(interestRate, loan.interestRate) == 0 && tenureInMonths == loan.tenureInMonths && Objects.equals(loanType, loan.loanType) && Objects.equals(status, loan.status) && Objects.equals(appliedDate, loan.appliedDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(loanId, customerId, loanType, loanAmount, interestRate, tenureInMonths, status, appliedDate);
    }

    public void setAppliedDate(LocalDate appliedDate) {
        this.appliedDate = appliedDate;
    }

}