package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class BeneficiaryNotFoundException extends Exception {
    private static final long serialVersionUID = 1L;
    public BeneficiaryNotFoundException(String message) { super(message); }
}