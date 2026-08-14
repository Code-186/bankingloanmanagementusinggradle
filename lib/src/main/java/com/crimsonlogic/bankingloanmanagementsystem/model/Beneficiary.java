package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.util.Objects;

public class Beneficiary {

    private int beneficiaryId;
    private String beneficiaryName;
    private long accountNumber;
    private String bankName;

    public Beneficiary() {
    }

    public Beneficiary(int beneficiaryId,
                       String beneficiaryName,
                       long accountNumber,
                       String bankName) {

        this.beneficiaryId = beneficiaryId;
        this.beneficiaryName = beneficiaryName;
        this.accountNumber = accountNumber;
        this.bankName = bankName;
    }

    public int getBeneficiaryId() {
        return beneficiaryId;
    }

    public void setBeneficiaryId(int beneficiaryId) {
        this.beneficiaryId = beneficiaryId;
    }

    public String getBeneficiaryName() {
        return beneficiaryName;
    }

    public void setBeneficiaryName(String beneficiaryName) {
        this.beneficiaryName = beneficiaryName;
    }

    public long getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(long accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    @Override
    public String toString() {
        return "Beneficiary [beneficiaryId=" + beneficiaryId
                + ", beneficiaryName=" + beneficiaryName
                + ", accountNumber=" + accountNumber
                + ", bankName=" + bankName + "]";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Beneficiary that = (Beneficiary) o;
        return beneficiaryId == that.beneficiaryId && accountNumber == that.accountNumber && Objects.equals(beneficiaryName, that.beneficiaryName) && Objects.equals(bankName, that.bankName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(beneficiaryId, beneficiaryName, accountNumber, bankName);
    }
}
