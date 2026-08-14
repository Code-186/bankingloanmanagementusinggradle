package com.crimsonlogic.bankingloanmanagementsystem.userimplementation;

import java.util.Objects;

import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.User;

public class Admin extends User {

    private String role;
    private double salary;
    private int branchId;

    public Admin() {
    }

    public Admin(int userId,
                 String name,
                 String phoneNumber,
                 String email,
                 String address,
                 String role,double salary,int branchId) {

        super(userId, name, phoneNumber, email, address);

        this.role = role;
        this.salary = salary;
        this.branchId = branchId;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Admin admin = (Admin) o;
        return Double.compare(salary, admin.salary) == 0 && branchId == admin.branchId && Objects.equals(role, admin.role);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), role, salary, branchId);
    }

    @Override
    public String toString() {

        return "Admin{" +
                "userId=" + getUserId() +
                ", name='" + getName() + '\'' +
                ", phoneNumber='" + getPhoneNumber() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", address='" + getAddress() + '\'' +
                ", role='" + role + '\'' +
                ", salary=" + salary +
                ", branchId=" + branchId +
                '}';
    }

}
