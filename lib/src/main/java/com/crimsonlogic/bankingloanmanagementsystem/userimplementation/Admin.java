package com.crimsonlogic.bankingloanmanagementsystem.userimplementation;

import java.math.BigDecimal;
import java.time.LocalDate;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.User;

public class Admin extends User {
    private static final long serialVersionUID = 1L;

    private String role;
    private BigDecimal salary;

    public Admin() { super(); }

    public Admin(String adminId, String name, String phoneNumber, String email, String address, 
                 String password, LocalDate dateOfBirth, String bankName, String branchId, 
                 String status, String role, BigDecimal salary) {
        super(adminId, name, phoneNumber, email, address, password, dateOfBirth, bankName, branchId, status);
        this.role = role;
        this.salary = salary;
    }

    public String getAdminId() { return getUserId(); }
    public void setAdminId(String adminId) { setUserId(adminId); }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public BigDecimal getSalary() { return salary; }
    public void setSalary(BigDecimal salary) { this.salary = salary; }
}