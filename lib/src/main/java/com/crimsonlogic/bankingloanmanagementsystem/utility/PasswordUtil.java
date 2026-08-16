package com.crimsonlogic.bankingloanmanagementsystem.utility;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    private PasswordUtil() {}

    /**
     * Hashes any plaintext string (password or MPIN) using BCrypt with salt rounds.
     */
    public static String hash(String plainText) {
        if (plainText == null || plainText.trim().isEmpty()) {
            return null;
        }
        return BCrypt.hashpw(plainText, BCrypt.gensalt(10));
    }

    /**
     * Verifies if a plaintext input matches the hashed value stored in the database.
     */
    public static boolean verify(String plainText, String hashedValue) {
        if (plainText == null || hashedValue == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainText, hashedValue);
        } catch (IllegalArgumentException e) {
            // Handles cases where hashedValue is not a valid BCrypt hash format
            return false;
        }
    }
}