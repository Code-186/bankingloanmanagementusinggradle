package com.crimsonlogic.bankingloanmanagementsystem.userimplementation;

import java.time.LocalDate;
import com.crimsonlogic.bankingloanmanagementsystem.abstractclasses.User;

public class Customer extends User {
    private static final long serialVersionUID = 1L;

    private String nomineeName;
    private String nomineeRelationship;
    private String nomineePhoneNumber;

    public Customer() { super(); }

    public Customer(String customerId, String name, String phoneNumber, String email, String address, 
                    String password, LocalDate dateOfBirth, String bankName, String branchId, 
                    String status, String nomineeName, String nomineeRelationship, String nomineePhoneNumber) {
        super(customerId, name, phoneNumber, email, address, password, dateOfBirth, bankName, branchId, status);
        this.nomineeName = nomineeName;
        this.nomineeRelationship = nomineeRelationship;
        this.nomineePhoneNumber = nomineePhoneNumber;
    }

    public String getCustomerId() { return getUserId(); }
    public void setCustomerId(String customerId) { setUserId(customerId); }

    public String getNomineeName() { return nomineeName; }
    public void setNomineeName(String nomineeName) { this.nomineeName = nomineeName; }

    public String getNomineeRelationship() { return nomineeRelationship; }
    public void setNomineeRelationship(String nomineeRelationship) { this.nomineeRelationship = nomineeRelationship; }

    public String getNomineePhoneNumber() { return nomineePhoneNumber; }
    public void setNomineePhoneNumber(String nomineePhoneNumber) { this.nomineePhoneNumber = nomineePhoneNumber; }
}