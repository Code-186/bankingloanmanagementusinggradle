package com.crimsonlogic.bankingloanmanagementsystem.utility;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.Period;

public class ValidationUtil {

    private ValidationUtil() {}

    public static boolean validateAmount(BigDecimal amount) {
        return amount != null && amount.compareTo(BigDecimal.ZERO) > 0;
    }

    public static boolean validateEmail(String email) {
        return email != null
                && email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
                && !email.matches(".*(.)\\1\\1\\1.*");
    }

    public static boolean validatePhone(String phone) {
        return phone != null && phone.matches("[6-9]\\d{9}");
    }

    public static boolean validateName(String name) {
        if (name == null) {
            return false;
        }
        name = name.trim();
        return name.matches("^[A-Za-z]{3,}(\\s[A-Za-z]{2,})*$") && !name.matches("^(.)\\1+$");
    }

    public static boolean validateSalary(BigDecimal salary) {
        return salary != null && salary.compareTo(BigDecimal.ZERO) > 0;
    }

    public static boolean validateBranchId(String branchId) {
        return branchId != null && !branchId.trim().isEmpty();
    }

    public static boolean validatePassword(String password) {
        return password != null
                && password.matches("^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,20}$");
    }

    public static boolean validateBankName(String bankName) {
        return bankName != null && bankName.matches("[A-Za-z ]{3,50}");
    }

    public static boolean validateDesignation(String designation) {
        return designation != null && designation.matches("[A-Za-z ]{2,50}");
    }

    public static boolean validateRole(String role) {
        return role != null && role.matches("[A-Za-z ]{2,50}");
    }

    public static boolean validateAccountNumber(String accountNumber) {
        return accountNumber != null && accountNumber.matches("\\d{12}");
    }

    public static boolean validateMPin(String mPin) {
        return mPin != null && mPin.matches("\\d{4}");
    }

    public static boolean validateDob(LocalDate dob) {
        if (dob == null) {
            return false;
        }
        int age = Period.between(dob, LocalDate.now()).getYears();
        return age >= 18;
    }

    public static boolean validateNomineeName(String nomineeName) {
        return validateName(nomineeName);
    }
}