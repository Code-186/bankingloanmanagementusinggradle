package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class LoanNotFoundException extends Exception {

    public LoanNotFoundException(String message) {
        super(message);
    }
}
