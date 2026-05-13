package com.cab.model;

import java.sql.Timestamp;

public class User {
    private int    userId;
    private String fullName;
    private String email;
    private String phone;
    private String passwordHash;
    private String profilePic;
    private String address;
    private int    isActive;
    private Timestamp createdAt;

    public User() {}

    public User(String fullName, String email, String phone, String passwordHash) {
        this.fullName     = fullName;
        this.email        = email;
        this.phone        = phone;
        this.passwordHash = passwordHash;
    }

    // Getters & Setters
    public int       getUserId()       { return userId; }
    public void      setUserId(int id) { this.userId = id; }

    public String    getFullName()            { return fullName; }
    public void      setFullName(String n)    { this.fullName = n; }

    public String    getEmail()               { return email; }
    public void      setEmail(String e)       { this.email = e; }

    public String    getPhone()               { return phone; }
    public void      setPhone(String p)       { this.phone = p; }

    public String    getPasswordHash()        { return passwordHash; }
    public void      setPasswordHash(String h){ this.passwordHash = h; }

    public String    getProfilePic()          { return profilePic; }
    public void      setProfilePic(String p)  { this.profilePic = p; }

    public String    getAddress()             { return address; }
    public void      setAddress(String a)     { this.address = a; }

    public int       getIsActive()            { return isActive; }
    public void      setIsActive(int a)       { this.isActive = a; }

    public Timestamp getCreatedAt()           { return createdAt; }
    public void      setCreatedAt(Timestamp t){ this.createdAt = t; }
}
