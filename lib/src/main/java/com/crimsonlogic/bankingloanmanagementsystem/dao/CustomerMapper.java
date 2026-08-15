package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;

@Mapper
public interface CustomerMapper {
    Customer findByEmail(@Param("email") String email);
    Customer findById(@Param("customerId") String customerId);
    List<Customer> findAllCustomers();
    List<Customer> findCustomersByBranch(@Param("branchId") String branchId);
    int insertCustomer(Customer customer);
    int updateCustomerStatus(@Param("customerId") String customerId, @Param("status") String status);
    int updateCustomerProfile(Customer customer);
    int updatePassword(@Param("customerId") String customerId, @Param("password") String password);
}