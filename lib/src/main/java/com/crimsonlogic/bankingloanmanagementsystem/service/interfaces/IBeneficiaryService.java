package com.crimsonlogic.bankingloanmanagementsystem.service.interfaces;

import java.util.List;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.BeneficiaryNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.Beneficiary;

public interface IBeneficiaryService {
    Beneficiary addBeneficiary(Beneficiary beneficiary);
    boolean removeBeneficiary(String beneficiaryId, String customerId) throws BeneficiaryNotFoundException;
    Beneficiary searchBeneficiary(String accountNumber, String customerId) throws BeneficiaryNotFoundException;
    List<Beneficiary> getAllBeneficiaries(String customerId);
}