package com.crimsonlogic.bankingloanmanagementsystem.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.crimsonlogic.bankingloanmanagementsystem.dao.BeneficiaryMapper;
import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.BeneficiaryNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.Beneficiary;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IBeneficiaryService;
import com.crimsonlogic.bankingloanmanagementsystem.utility.IdGeneratorUtil;

@Service
public class BeneficiaryService implements IBeneficiaryService {

    @Autowired
    private BeneficiaryMapper beneficiaryMapper;

    @Override
    public Beneficiary addBeneficiary(Beneficiary beneficiary) {
        beneficiary.setBeneficiaryId(IdGeneratorUtil.generateBeneficiaryId());
        beneficiaryMapper.insertBeneficiary(beneficiary);
        return beneficiary;
    }

    @Override
    public boolean removeBeneficiary(String beneficiaryId, String customerId) throws BeneficiaryNotFoundException {
        int rows = beneficiaryMapper.deleteBeneficiary(beneficiaryId, customerId);
        if (rows == 0) throw new BeneficiaryNotFoundException("Beneficiary ID " + beneficiaryId + " not found.");
        return true;
    }

    @Override
    public Beneficiary searchBeneficiary(String accountNumber, String customerId) throws BeneficiaryNotFoundException {
        Beneficiary ben = beneficiaryMapper.searchBeneficiaryByAccount(accountNumber, customerId);
        if (ben == null) throw new BeneficiaryNotFoundException("No beneficiary found with account " + accountNumber);
        return ben;
    }

    @Override
    public List<Beneficiary> getAllBeneficiaries(String customerId) {
        return beneficiaryMapper.findBeneficiariesByCustomerId(customerId);
    }
}