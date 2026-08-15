package com.crimsonlogic.bankingloanmanagementsystem.service.interfaces;

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;

public interface ICustomerService {
    Customer login(String email, String password) throws CustomerNotFoundException;
    Customer registerCustomer(Customer customer);
    Customer getProfile(String customerId) throws CustomerNotFoundException;
    boolean updateProfile(Customer customer);
    boolean changePassword(String customerId, String oldPassword, String newPassword);
}