package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.io.Serializable;

public class Branch implements Serializable {
    private static final long serialVersionUID = 1L;

    private String branchId;
    private String bankName;
    private String branchCity;

    public Branch() {}

    public Branch(String branchId, String bankName, String branchCity) {
        this.branchId = branchId;
        this.bankName = bankName;
        this.branchCity = branchCity;
    }

    public String getBranchId() { return branchId; }
    public void setBranchId(String branchId) { this.branchId = branchId; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getBranchCity() { return branchCity; }
    public void setBranchCity(String branchCity) { this.branchCity = branchCity; }
}