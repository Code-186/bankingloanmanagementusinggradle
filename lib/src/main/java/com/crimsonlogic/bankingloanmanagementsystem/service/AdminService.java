package com.crimsonlogic.bankingloanmanagementsystem.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.crimsonlogic.bankingloanmanagementsystem.dao.AdminMapper;
import com.crimsonlogic.bankingloanmanagementsystem.dao.EmployeeMapper;
import com.crimsonlogic.bankingloanmanagementsystem.dao.CustomerMapper;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AdminNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.EmployeeNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IAdminService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Admin;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.IdGeneratorUtil;
import com.crimsonlogic.bankingloanmanagementsystem.utility.PasswordUtil;

@Service
public class AdminService implements IAdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Admin login(String email, String password) throws AdminNotFoundException {
        Admin admin = adminMapper.findByEmail(email);
        
        // Verifies against plain text or BCrypt via PasswordUtil.verify
        if (admin == null || !PasswordUtil.verify(password, admin.getPassword()) || !"ACTIVE".equalsIgnoreCase(admin.getStatus())) {
            throw new AdminNotFoundException("Invalid credentials or Admin account is inactive.");
        }
        return admin;
    }

    @Override
    @Transactional
    public Admin registerAdmin(Admin admin) {
        admin.setUserId(IdGeneratorUtil.generateAdminId());
        admin.setPassword(PasswordUtil.hash(admin.getPassword()));
        admin.setStatus("ACTIVE");
        adminMapper.insertAdmin(admin);
        return admin;
    }

    @Override
    @Transactional
    public Employee registerEmployee(Employee employee) {
        employee.setUserId(IdGeneratorUtil.generateEmployeeId());
        employee.setPassword(PasswordUtil.hash(employee.getPassword()));
        employee.setStatus("ACTIVE");
        employeeMapper.insertEmployee(employee);
        return employee;
    }

    @Override
    public boolean deleteEmployee(String employeeId) throws EmployeeNotFoundException {
        Employee emp = employeeMapper.findById(employeeId);
        if (emp == null) throw new EmployeeNotFoundException("Employee ID not found: " + employeeId);
        return employeeMapper.updateEmployeeStatus(employeeId, "INACTIVE") > 0;
    }

    @Override
    public boolean deleteCustomer(String customerId) throws CustomerNotFoundException {
        Customer cust = customerMapper.findById(customerId);
        if (cust == null) throw new CustomerNotFoundException("Customer ID not found: " + customerId);
        return customerMapper.updateCustomerStatus(customerId, "INACTIVE") > 0;
    }

    @Override
    public List<Admin> getAllAdmins() {
        return adminMapper.findAllAdmins();
    }

    @Override
    public Employee getEmployeeById(String employeeId) throws EmployeeNotFoundException {
        Employee emp = employeeMapper.findById(employeeId);
        if (emp == null) throw new EmployeeNotFoundException("Employee ID not found: " + employeeId);
        return emp;
    }

    @Override
    public List<Employee> getAllEmployees() {
        return employeeMapper.findAllEmployees();
    }

    @Override
    public Customer getCustomerById(String customerId) throws CustomerNotFoundException {
        Customer cust = customerMapper.findById(customerId);
        if (cust == null) throw new CustomerNotFoundException("Customer ID not found: " + customerId);
        return cust;
    }

    @Override
    public List<Customer> getAllCustomers() {
        return customerMapper.findAllCustomers();
    }
}