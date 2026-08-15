package com.crimsonlogic.bankingloanmanagementsystem.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.crimsonlogic.bankingloanmanagementsystem.model.Transaction;

@Mapper
public interface TransactionMapper {
    int insertTransaction(Transaction transaction);
    List<Transaction> findTransactionsByAccountNumber(@Param("accountNumber") String accountNumber);
    List<Transaction> findAllTransactions();
    Transaction findLatestTransaction();
}