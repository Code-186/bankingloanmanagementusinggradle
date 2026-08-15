package com.crimsonlogic.bankingloanmanagementsystem.utility;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

public class BankDetailsUtil {

    private static final Map<String, String> BANK_BRANCH_MAP;
    private static final Map<String, String> BANK_EMAIL_DOMAIN_MAP;

    static {
        Map<String, String> branchMap = new LinkedHashMap<>();
        branchMap.put("State Bank of India", "SBIN0101");
        branchMap.put("Canara Bank", "CNRB0202");
        branchMap.put("Karnataka Bank", "KARB0303");
        branchMap.put("Union Bank of India", "UBIN0404");
        BANK_BRANCH_MAP = Collections.unmodifiableMap(branchMap);

        Map<String, String> domainMap = new LinkedHashMap<>();
        domainMap.put("State Bank of India", "@sbi.co.in");
        domainMap.put("Canara Bank", "@cnr.co.in");
        domainMap.put("Karnataka Bank", "@karb.co.in");
        domainMap.put("Union Bank of India", "@ubin.co.in");
        BANK_EMAIL_DOMAIN_MAP = Collections.unmodifiableMap(domainMap);
    }

    private BankDetailsUtil() {}

    public static Map<String, String> getAllBanks() {
        return BANK_BRANCH_MAP;
    }

    public static String getBranchIdByBankName(String bankName) {
        return BANK_BRANCH_MAP.getOrDefault(bankName, "");
    }

    public static String getOfficialDomainByBankName(String bankName) {
        return BANK_EMAIL_DOMAIN_MAP.getOrDefault(bankName, "");
    }

    public static boolean isValidOfficialEmail(String email, String bankName) {
        String expectedDomain = getOfficialDomainByBankName(bankName);
        return email != null && !expectedDomain.isEmpty() && email.toLowerCase().endsWith(expectedDomain.toLowerCase());
    }
}