package com.crimsonlogic.bankingloanmanagementsystem.userimplementation;

import java.util.Objects;

import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.User;

public class Customer extends User {

    private String customerStatus;
    private int branchId;

    public Customer() {
    }

    public Customer(int userId, String name,
                    String phoneNumber,
                    String email,
                    String address,
                    String customerStatus,
                    int branchId) {

        super(userId, name, phoneNumber, email, address);

        this.customerStatus = customerStatus;
        this.branchId = branchId;
    }

    public String getCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(String customerStatus) {
        this.customerStatus = customerStatus;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Customer customer = (Customer) o;
        return branchId == customer.branchId && Objects.equals(customerStatus, customer.customerStatus);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), customerStatus, branchId);
    }


    @Override
    public String toString() {
        return super.toString()
                + ", customerStatus=" + customerStatus
                + ", branchId=" + branchId;
    }

}
