package com.crimsonlogic.bankingloanmanagementsystem.utility;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    private PasswordUtil() {}

    public static String hash(String plainText) {
        if (plainText == null || plainText.trim().isEmpty()) {
            return null;
        }
        return BCrypt.hashpw(plainText, BCrypt.gensalt(10));
    }

    public static boolean verify(String plainText, String storedValue) {
        if (plainText == null || storedValue == null) {
            return false;
        }
        
        // 1. Direct match (works when DB has plaintext)
        if (plainText.equals(storedValue)) {
            return true;
        }

        // 2. BCrypt hash check
        if (storedValue.startsWith("$2a$") || storedValue.startsWith("$2b$") || storedValue.startsWith("$2y$")) {
            try {
                return BCrypt.checkpw(plainText, storedValue);
            } catch (Exception e) {
                return false;
            }
        }
        
        return false;
    }
}