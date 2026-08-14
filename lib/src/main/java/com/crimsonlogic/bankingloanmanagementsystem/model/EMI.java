package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.time.LocalDate;
import java.util.Objects;

public class EMI {

    private int emiId;
    private int loanId;
    private double emiAmount;
    private LocalDate dueDate;
    private boolean paid;

    public EMI() {
    }

    public EMI(int emiId,
               int loanId,
               double emiAmount,
               LocalDate dueDate,
               boolean paid) {

        this.emiId = emiId;
        this.loanId = loanId;
        this.emiAmount = emiAmount;
        this.dueDate = dueDate;
        this.paid = paid;
    }

    public int getEmiId() {
        return emiId;
    }

    public void setEmiId(int emiId) {
        this.emiId = emiId;
    }

    public int getLoanId() {
        return loanId;
    }

    public void setLoanId(int loanId) {
        this.loanId = loanId;
    }

    public double getEmiAmount() {
        return emiAmount;
    }

    public void setEmiAmount(double emiAmount) {
        this.emiAmount = emiAmount;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public boolean isPaid() {
        return paid;
    }

    public void setPaid(boolean paid) {
        this.paid = paid;
    }
    @Override
    public String toString() {
        return "EMI{" +
                "emiId=" + emiId +
                ", loanId=" + loanId +
                ", emiAmount=" + emiAmount +
                ", dueDate=" + dueDate +
                ", paid=" + paid +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        EMI emi = (EMI) o;
        return emiId == emi.emiId && loanId == emi.loanId && Double.compare(emiAmount, emi.emiAmount) == 0 && paid == emi.paid && Objects.equals(dueDate, emi.dueDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(emiId, loanId, emiAmount, dueDate, paid);
    }
}
