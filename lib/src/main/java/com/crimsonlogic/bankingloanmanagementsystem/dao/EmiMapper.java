package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.model.EMI;

@Mapper
public interface EmiMapper {
    int insertEmi(EMI emi);
    EMI findEmiById(@Param("emiId") String emiId);
    List<EMI> findEmisByLoanId(@Param("loanId") String loanId);
    List<EMI> findEmisByCustomerId(@Param("customerId") String customerId);
    int updateEmiStatus(@Param("emiId") String emiId, @Param("status") String status);
}