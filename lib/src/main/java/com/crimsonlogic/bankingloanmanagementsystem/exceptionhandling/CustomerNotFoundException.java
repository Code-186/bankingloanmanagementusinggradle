package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;
public class CustomerNotFoundException
extends RuntimeException {

public CustomerNotFoundException(String message) {
super(message);
}
}
