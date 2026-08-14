package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class InsufficientBalanceException extends Exception {

    public InsufficientBalanceException(String message) {
        super(message);
    }
}