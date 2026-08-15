package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.math.BigDecimal;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.Account;
import com.crimsonlogic.bankingloanmanagementsystem.accountimplementation.SavingsAccount;
import com.crimsonlogic.bankingloanmanagementsystem.accountimplementation.CurrentAccount;

@Mapper
public interface AccountMapper {
    int insertSavingsAccount(SavingsAccount account);
    int insertCurrentAccount(CurrentAccount account);
    Account findByAccountNumber(@Param("accountNumber") String accountNumber);
    List<Account> findAccountsByCustomerId(@Param("customerId") String customerId);
    List<Account> findAllAccounts();
    int updateBalance(@Param("accountNumber") String accountNumber, @Param("balance") BigDecimal balance);
    int updateAccountStatus(@Param("accountNumber") String accountNumber, @Param("accountStatus") String accountStatus);
}