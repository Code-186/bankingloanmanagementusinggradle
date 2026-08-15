package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class EmployeeNotFoundException extends UserNotFoundException {
    private static final long serialVersionUID = 1L;
    public EmployeeNotFoundException(String message) { super(message); }
}