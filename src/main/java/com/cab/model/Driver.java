package com.cab.model;

import java.sql.Timestamp;

public class Driver {
    private int    driverId;
    private String fullName;
    private String email;
    private String phone;
    private String passwordHash;
    private String licenseNo;
    private String cabType;
    private String vehicleNo;
    private String vehicleModel;
    private double rating;
    private int    isOnline;
    private int    isActive;
    private int    totalRides;
    private double totalEarnings;
    private double currentLat;
    private double currentLng;
    private String profilePic;
    private Timestamp createdAt;

    public Driver() {}

    // Getters & Setters
    public int    getDriverId()                  { return driverId; }
    public void   setDriverId(int id)            { this.driverId = id; }

    public String getFullName()                  { return fullName; }
    public void   setFullName(String n)          { this.fullName = n; }

    public String getEmail()                     { return email; }
    public void   setEmail(String e)             { this.email = e; }

    public String getPhone()                     { return phone; }
    public void   setPhone(String p)             { this.phone = p; }

    public String getPasswordHash()              { return passwordHash; }
    public void   setPasswordHash(String h)      { this.passwordHash = h; }

    public String getLicenseNo()                 { return licenseNo; }
    public void   setLicenseNo(String l)         { this.licenseNo = l; }

    public String getCabType()                   { return cabType; }
    public void   setCabType(String c)           { this.cabType = c; }

    public String getVehicleNo()                 { return vehicleNo; }
    public void   setVehicleNo(String v)         { this.vehicleNo = v; }

    public String getVehicleModel()              { return vehicleModel; }
    public void   setVehicleModel(String v)      { this.vehicleModel = v; }

    public double getRating()                    { return rating; }
    public void   setRating(double r)            { this.rating = r; }

    public int    getIsOnline()                  { return isOnline; }
    public void   setIsOnline(int o)             { this.isOnline = o; }

    public int    getIsActive()                  { return isActive; }
    public void   setIsActive(int a)             { this.isActive = a; }

    public int    getTotalRides()                { return totalRides; }
    public void   setTotalRides(int t)           { this.totalRides = t; }

    public double getTotalEarnings()             { return totalEarnings; }
    public void   setTotalEarnings(double e)     { this.totalEarnings = e; }

    public double getCurrentLat()               { return currentLat; }
    public void   setCurrentLat(double lat)     { this.currentLat = lat; }

    public double getCurrentLng()               { return currentLng; }
    public void   setCurrentLng(double lng)     { this.currentLng = lng; }

    public String getProfilePic()               { return profilePic; }
    public void   setProfilePic(String p)       { this.profilePic = p; }

    public Timestamp getCreatedAt()             { return createdAt; }
    public void      setCreatedAt(Timestamp t)  { this.createdAt = t; }
}
