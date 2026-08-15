package com.crimsonlogic.bankingloanmanagementsystem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.crimsonlogic.bankingloanmanagementsystem.dao.CustomerMapper;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ICustomerService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.IdGeneratorUtil;

@Service
public class CustomerService implements ICustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Customer login(String email, String password) throws CustomerNotFoundException {
        Customer customer = customerMapper.findByEmail(email);
        if (customer == null || !customer.getPassword().equals(password) || "INACTIVE".equalsIgnoreCase(customer.getStatus())) {
            throw new CustomerNotFoundException("Invalid credentials or Customer account is inactive.");
        }
        return customer;
    }

    @Override
    public Customer registerCustomer(Customer customer) {
        customer.setCustomerId(IdGeneratorUtil.generateCustomerId());
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
        if (customer != null && customer.getPassword().equals(oldPassword)) {
            return customerMapper.updatePassword(customerId, newPassword) > 0;
        }
        return false;
    }
}