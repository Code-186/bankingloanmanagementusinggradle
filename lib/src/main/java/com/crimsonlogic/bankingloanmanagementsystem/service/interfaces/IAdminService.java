package com.crimsonlogic.bankingloanmanagementsystem.service.interfaces;

import java.util.List;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.AdminNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.EmployeeNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Admin;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;

public interface IAdminService {
    Admin login(String email, String password) throws AdminNotFoundException;
    Admin registerAdmin(Admin admin);
    Employee registerEmployee(Employee employee);
    boolean deleteEmployee(String employeeId) throws EmployeeNotFoundException;
    boolean deleteCustomer(String customerId) throws CustomerNotFoundException;
    List<Admin> getAllAdmins();
    Employee getEmployeeById(String employeeId) throws EmployeeNotFoundException;
    List<Employee> getAllEmployees();
    Customer getCustomerById(String customerId) throws CustomerNotFoundException;
    List<Customer> getAllCustomers();
}