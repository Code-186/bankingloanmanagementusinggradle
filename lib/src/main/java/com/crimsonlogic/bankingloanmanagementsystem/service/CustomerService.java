package com.crimsonlogic.bankingloanmanagementsystem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.crimsonlogic.bankingloanmanagementsystem.dao.CustomerMapper;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ICustomerService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.IdGeneratorUtil;
import com.crimsonlogic.bankingloanmanagementsystem.utility.PasswordUtil;

@Service
public class CustomerService implements ICustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Customer login(String email, String password) throws CustomerNotFoundException {
        Customer customer = customerMapper.findByEmail(email);
        
        // Secure BCrypt password check
        if (customer == null || !PasswordUtil.verify(password, customer.getPassword()) || "INACTIVE".equalsIgnoreCase(customer.getStatus())) {
            throw new CustomerNotFoundException("Invalid credentials or Customer account is inactive.");
        }
        return customer;
    }

    @Override
    @Transactional
    public Customer registerCustomer(Customer customer) {
        customer.setCustomerId(IdGeneratorUtil.generateCustomerId());
        // Hash password before saving
        customer.setPassword(PasswordUtil.hash(customer.getPassword()));
        customer.setStatus("REGISTERED");
        customerMapper.insertCustomer(customer);
        return customer;
    }

    @Override
    public Customer getProfile(String customerId) throws CustomerNotFoundException {
        Customer customer = customerMapper.findById(customerId);
        if (customer == null) throw new CustomerNotFoundException("Customer profile not found: " + customerId);
        return customer;
    }

    @Override
    public boolean updateProfile(Customer customer) {
        return customerMapper.updateCustomerProfile(customer) > 0;
    }

    @Override
    public boolean changePassword(String customerId, String oldPassword, String newPassword) {
        Customer customer = customerMapper.findById(customerId);
        if (customer != null && PasswordUtil.verify(oldPassword, customer.getPassword())) {
            String hashedNewPassword = PasswordUtil.hash(newPassword);
            return customerMapper.updatePassword(customerId, hashedNewPassword) > 0;
        }
        return false;
    }
}