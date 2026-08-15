package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.model.Beneficiary;

@Mapper
public interface BeneficiaryMapper {
    int insertBeneficiary(Beneficiary beneficiary);
    int deleteBeneficiary(@Param("beneficiaryId") String beneficiaryId, @Param("customerId") String customerId);
    Beneficiary findBeneficiaryById(@Param("beneficiaryId") String beneficiaryId, @Param("customerId") String customerId);
    List<Beneficiary> findBeneficiariesByCustomerId(@Param("customerId") String customerId);
    Beneficiary searchBeneficiaryByAccount(@Param("accountNumber") String accountNumber, @Param("customerId") String customerId);
}