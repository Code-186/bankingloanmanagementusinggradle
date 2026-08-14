package com.crimsonlogic.bankingloanmanagementsystem.userimplementation;

import java.util.Objects;

import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.User;

public class Employee extends User {

    private String designation;
    private double salary;
    private int branchId;

    public Employee() {
    }

    public Employee(int userId,
                    String name,
                    String phoneNumber,
                    String email,
                    String address,
                    String designation,
                    double salary,
                    int branchId) {

        super(userId, name, phoneNumber, email, address);

        this.designation = designation;
        this.salary = salary;
        this.branchId = branchId;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Employee employee = (Employee) o;
        return Double.compare(salary, employee.salary) == 0 && branchId == employee.branchId && Objects.equals(designation, employee.designation);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), designation, salary, branchId);
    }

    @Override
    public String toString() {

        return "Employee{" +
                "userId=" + getUserId() +
                ", name='" + getName() + '\'' +
                ", phoneNumber='" + getPhoneNumber() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", address='" + getAddress() + '\'' +
                ", designation='" + designation + '\'' +
                ", salary=" + salary +
                ", branchId=" + branchId +
                '}';
    }
}
