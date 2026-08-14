package com.crimsonlogic.bankingloanmanagementsystem.abstractclasses;
import java.util.Objects;

public abstract class User {

    private int userId;
    private String name;
    private String phoneNumber;
    private String email;
    private String address;

    public User() {
    }

    public User(int userId, String name, String phoneNumber,
                String email, String address) {
        this.userId = userId;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId);
    }

    @Override
    public boolean equals(Object obj) {

        if(this == obj)
            return true;

        if(obj == null || getClass() != obj.getClass())
            return false;

        User user = (User) obj;

        return userId == user.userId;
    }

    @Override
    public String toString() {
        return "User [userId=" + userId
                + ", name=" + name
                + ", phoneNumber=" + phoneNumber
                + ", email=" + email
                + ", address=" + address + "]";
    }
}