package com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling;

public class AccountNotFoundException
extends RuntimeException {

public AccountNotFoundException(String message) {
super(message);
}
}
