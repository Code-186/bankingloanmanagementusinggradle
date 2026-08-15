package com.crimsonlogic.bankingloanmanagementsystem.utility;

import java.util.Random;

public class IdGeneratorUtil {

    private static final Random RANDOM = new Random();

    private IdGeneratorUtil() {
        // Private constructor to prevent instantiation
    }

    private static String generateFormattedId(String prefix) {
        int randomNumber = 1000 + RANDOM.nextInt(9000); // Generates a random 4-digit number
        return String.format("%s%04d", prefix, randomNumber);
    }

    public static String generateAdminId() {
        return generateFormattedId("ADM");
    }

    public static String generateEmployeeId() {
        return generateFormattedId("EMP");
    }

    public static String generateCustomerId() {
        return generateFormattedId("CUST");
    }

    public static String generateLoanId() {
        return generateFormattedId("LOAN");
    }

    public static String generateTransactionId() {
        return generateFormattedId("TXN");
    }

    public static String generateBeneficiaryId() {
        return generateFormattedId("BEN");
    }

    public static String generateEmiId() {
        return generateFormattedId("EMI");
    }

    public static long generateAccountNumber() {
        long basePrefix = 100000000000L; 
        long accountSequence = 100000000L + RANDOM.nextInt(900000000); 
        return basePrefix + (accountSequence % 1000000000L);
    }
}