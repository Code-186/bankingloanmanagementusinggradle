package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.model.Loan;

@Mapper
public interface LoanMapper {
    int insertLoan(Loan loan);
    Loan findLoanById(@Param("loanId") String loanId);
    List<Loan> findLoansByCustomerId(@Param("customerId") String customerId);
    List<Loan> findAllLoans();
    List<Loan> findLoansByStatus(@Param("status") String status);
    int updateLoanStatus(@Param("loanId") String loanId, @Param("status") String status);
}