package com.crimsonlogic.bankingloanmanagementsystem.model;

import java.util.Objects;

public class Branch {

    private int branchId;
    private String branchName;
    private String location;

    public Branch() {
    }

    public Branch(int branchId,
                  String branchName,
                  String location) {

        this.branchId = branchId;
        this.branchName = branchName;
        this.location = location;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Override
    public int hashCode() {
        return Objects.hash(branchId);
    }

    @Override
    public boolean equals(Object obj) {

        if(this == obj)
            return true;

        if(obj == null || getClass() != obj.getClass())
            return false;

        Branch other = (Branch) obj;

        return branchId == other.branchId;
    }

    @Override
    public String toString() {
        return "Branch [branchId=" + branchId +
                ", branchName=" + branchName +
                ", location=" + location + "]";
    }
}