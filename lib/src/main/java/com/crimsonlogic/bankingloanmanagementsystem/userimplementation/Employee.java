package com.crimsonlogic.bankingloanmanagementsystem.userimplementation;

import java.math.BigDecimal;
import java.time.LocalDate;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.User;

public class Employee extends User {
    private static final long serialVersionUID = 1L;

    private String designation;
    private BigDecimal salary;

    public Employee() { super(); }

    public Employee(String employeeId, String name, String phoneNumber, String email, String address, 
                    String password, LocalDate dateOfBirth, String bankName, String branchId, 
                    String status, String designation, BigDecimal salary) {
        super(employeeId, name, phoneNumber, email, address, password, dateOfBirth, bankName, branchId, status);
        this.designation = designation;
        this.salary = salary;
    }

    public String getEmployeeId() { return getUserId(); }
    public void setEmployeeId(String employeeId) { setUserId(employeeId); }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public BigDecimal getSalary() { return salary; }
    public void setSalary(BigDecimal salary) { this.salary = salary; }
}