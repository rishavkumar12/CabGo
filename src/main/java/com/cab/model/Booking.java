package com.cab.model;

import java.sql.Timestamp;

public class Booking {
    private int    bookingId;
    private int    userId;
    private int    driverId;
    private String cabType;
    private String pickupAddress;
    private String dropAddress;
    private double pickupLat;
    private double pickupLng;
    private double dropLat;
    private double dropLng;
    private double distanceKm;
    private double estimatedFare;
    private double finalFare;
    private double discountAmount;
    private String status;
    private Timestamp bookingTime;
    private String pickupTime;
    private String dropTime;
    private String paymentMethod;
    private String paymentStatus;
    private int    ratingByUser;
    private String reviewByUser;

    // Extra joined fields
    private String userName;
    private String driverName;
    private String vehicleNo;

    public Booking() {}

    // Getters & Setters
    public int    getBookingId()               { return bookingId; }
    public void   setBookingId(int id)         { this.bookingId = id; }

    public int    getUserId()                  { return userId; }
    public void   setUserId(int id)            { this.userId = id; }

    public int    getDriverId()                { return driverId; }
    public void   setDriverId(int id)          { this.driverId = id; }

    public String getCabType()                 { return cabType; }
    public void   setCabType(String c)         { this.cabType = c; }

    public String getPickupAddress()           { return pickupAddress; }
    public void   setPickupAddress(String p)   { this.pickupAddress = p; }

    public String getDropAddress()             { return dropAddress; }
    public void   setDropAddress(String d)     { this.dropAddress = d; }

    public double getPickupLat()               { return pickupLat; }
    public void   setPickupLat(double lat)     { this.pickupLat = lat; }

    public double getPickupLng()               { return pickupLng; }
    public void   setPickupLng(double lng)     { this.pickupLng = lng; }

    public double getDropLat()                 { return dropLat; }
    public void   setDropLat(double lat)       { this.dropLat = lat; }

    public double getDropLng()                 { return dropLng; }
    public void   setDropLng(double lng)       { this.dropLng = lng; }

    public double getDistanceKm()              { return distanceKm; }
    public void   setDistanceKm(double d)      { this.distanceKm = d; }

    public double getEstimatedFare()           { return estimatedFare; }
    public void   setEstimatedFare(double f)   { this.estimatedFare = f; }

    public double getFinalFare()               { return finalFare; }
    public void   setFinalFare(double f)       { this.finalFare = f; }

    public double getDiscountAmount()          { return discountAmount; }
    public void   setDiscountAmount(double d)  { this.discountAmount = d; }

    public String getStatus()                  { return status; }
    public void   setStatus(String s)          { this.status = s; }

    public Timestamp getBookingTime()          { return bookingTime; }
    public void      setBookingTime(Timestamp t){ this.bookingTime = t; }

    public String getPickupTime()              { return pickupTime; }
    public void   setPickupTime(String t)      { this.pickupTime = t; }

    public String getDropTime()                { return dropTime; }
    public void   setDropTime(String t)        { this.dropTime = t; }

    public String getPaymentMethod()           { return paymentMethod; }
    public void   setPaymentMethod(String m)   { this.paymentMethod = m; }

    public String getPaymentStatus()           { return paymentStatus; }
    public void   setPaymentStatus(String s)   { this.paymentStatus = s; }

    public int    getRatingByUser()            { return ratingByUser; }
    public void   setRatingByUser(int r)       { this.ratingByUser = r; }

    public String getReviewByUser()            { return reviewByUser; }
    public void   setReviewByUser(String r)    { this.reviewByUser = r; }

    public String getUserName()                { return userName; }
    public void   setUserName(String n)        { this.userName = n; }

    public String getDriverName()              { return driverName; }
    public void   setDriverName(String n)      { this.driverName = n; }

    public String getVehicleNo()               { return vehicleNo; }
    public void   setVehicleNo(String v)       { this.vehicleNo = v; }
}
