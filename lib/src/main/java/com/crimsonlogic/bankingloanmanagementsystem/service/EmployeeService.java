package com.crimsonlogic.bankingloanmanagementsystem.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.crimsonlogic.bankingloanmanagementsystem.dao.EmployeeMapper;
import com.crimsonlogic.bankingloanmanagementsystem.dao.CustomerMapper;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.EmployeeNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IEmployeeService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.IdGeneratorUtil;

@Service
public class EmployeeService implements IEmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Employee login(String email, String password) throws EmployeeNotFoundException {
        Employee employee = employeeMapper.findByEmail(email);
        if (employee == null || !employee.getPassword().equals(password) || "INACTIVE".equalsIgnoreCase(employee.getStatus())) {
            throw new EmployeeNotFoundException("Invalid credentials or Employee account is inactive.");
        }
        return employee;
    }

    @Override
    public Customer registerCustomer(Customer customer) {
        customer.setCustomerId(IdGeneratorUtil.generateCustomerId());
        customer.setStatus("REGISTERED");
        customerMapper.insertCustomer(customer);
        return customer;
    }

    @Override
    public Customer viewCustomer(String customerId) throws CustomerNotFoundException {
        Customer customer = customerMapper.findById(customerId);
        if (customer == null) throw new CustomerNotFoundException("Customer not found: " + customerId);
        return customer;
    }

    @Override
    public List<Customer> viewAllCustomers(String branchId) {
        if (branchId == null || branchId.trim().isEmpty()) {
            return customerMapper.findAllCustomers();
        }
        return customerMapper.findCustomersByBranch(branchId);
    }
}