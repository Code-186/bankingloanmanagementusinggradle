package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class InvalidMpinException extends Exception {
    private static final long serialVersionUID = 1L;
    public InvalidMpinException(String message) { super(message); }
}