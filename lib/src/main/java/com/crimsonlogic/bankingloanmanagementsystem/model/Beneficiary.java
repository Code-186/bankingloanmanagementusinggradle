package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.io.Serializable;

public class Beneficiary implements Serializable {
    private static final long serialVersionUID = 1L;

    private String beneficiaryId;
    private String beneficiaryName;
    private String beneficiaryAccountNumber;
    private String bankName;
    private String customerId;

    public Beneficiary() {}

    public Beneficiary(String beneficiaryId, String beneficiaryName, String beneficiaryAccountNumber, 
                       String bankName, String customerId) {
        this.beneficiaryId = beneficiaryId;
        this.beneficiaryName = beneficiaryName;
        this.beneficiaryAccountNumber = beneficiaryAccountNumber;
        this.bankName = bankName;
        this.customerId = customerId;
    }

    public String getBeneficiaryId() { return beneficiaryId; }
    public void setBeneficiaryId(String beneficiaryId) { this.beneficiaryId = beneficiaryId; }

    public String getBeneficiaryName() { return beneficiaryName; }
    public void setBeneficiaryName(String beneficiaryName) { this.beneficiaryName = beneficiaryName; }

    public String getBeneficiaryAccountNumber() { return beneficiaryAccountNumber; }
    public void setBeneficiaryAccountNumber(String beneficiaryAccountNumber) { this.beneficiaryAccountNumber = beneficiaryAccountNumber; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }
}