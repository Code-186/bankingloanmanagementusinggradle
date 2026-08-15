package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class AdminNotFoundException extends UserNotFoundException {
    private static final long serialVersionUID = 1L;
    public AdminNotFoundException(String message) { super(message); }
}