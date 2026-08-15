package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class CustomerNotFoundException extends UserNotFoundException {
    private static final long serialVersionUID = 1L;
    public CustomerNotFoundException(String message) { super(message); }
}