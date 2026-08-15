package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Employee;

@Mapper
public interface EmployeeMapper {
    Employee findByEmail(@Param("email") String email);
    Employee findById(@Param("employeeId") String employeeId);
    List<Employee> findAllEmployees();
    List<Employee> findEmployeesByBranch(@Param("branchId") String branchId);
    int insertEmployee(Employee employee);
    int updateEmployeeStatus(@Param("employeeId") String employeeId, @Param("status") String status);
}