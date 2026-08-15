package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

public class EMI implements Serializable {
    private static final long serialVersionUID = 1L;

    private String emiId;
    private String loanId;
    private String customerId;
    private BigDecimal emiAmount;
    private LocalDate dueDate;
    private String status;

    public EMI() {}

    public EMI(String emiId, String loanId, String customerId, BigDecimal emiAmount, LocalDate dueDate, String status) {
        this.emiId = emiId;
        this.loanId = loanId;
        this.customerId = customerId;
        this.emiAmount = emiAmount;
        this.dueDate = dueDate;
        this.status = status;
    }

    public String getEmiId() { return emiId; }
    public void setEmiId(String emiId) { this.emiId = emiId; }

    public String getLoanId() { return loanId; }
    public void setLoanId(String loanId) { this.loanId = loanId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public BigDecimal getEmiAmount() { return emiAmount; }
    public void setEmiAmount(BigDecimal emiAmount) { this.emiAmount = emiAmount; }

    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}