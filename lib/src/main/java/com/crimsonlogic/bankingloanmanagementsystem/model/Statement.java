package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.io.Serializable;
import java.util.List;

public class Statement implements Serializable {
    private static final long serialVersionUID = 1L;

    private String accountNumber;
    private String customerName;
    private String bankName;
    private String branchId;
    private List<Transaction> transactions;

    public Statement() {}

    public Statement(String accountNumber, String customerName, String bankName, String branchId, List<Transaction> transactions) {
        this.accountNumber = accountNumber;
        this.customerName = customerName;
        this.bankName = bankName;
        this.branchId = branchId;
        this.transactions = transactions;
    }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getBranchId() { return branchId; }
    public void setBranchId(String branchId) { this.branchId = branchId; }

    public List<Transaction> getTransactions() { return transactions; }
    public void setTransactions(List<Transaction> transactions) { this.transactions = transactions; }
}