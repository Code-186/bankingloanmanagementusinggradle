package com.crimsonlogic.bankingloanmanagementsystem.service.interfaces;

import java.util.List;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.EmployeeNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;

public interface IEmployeeService {
    Employee login(String email, String password) throws EmployeeNotFoundException;
    Customer registerCustomer(Customer customer);
    Customer viewCustomer(String customerId) throws CustomerNotFoundException;
    List<Customer> viewAllCustomers(String branchId);
}