package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Admin;

@Mapper
public interface AdminMapper {
    Admin findByEmail(@Param("email") String email);
    Admin findById(@Param("adminId") String adminId);
    int insertAdmin(Admin admin);
    List<Admin> findAllAdmins();
    int updateAdminStatus(@Param("adminId") String adminId, @Param("status") String status);
}