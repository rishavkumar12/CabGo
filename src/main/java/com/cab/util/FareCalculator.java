package com.cab.util;

import java.time.LocalTime;

/**
 * Smart Fare Calculator
 * Handles distance-based pricing with off-peak discounts
 */
public class FareCalculator {

    /**
     * Calculate fare based on cab type and distance
     */
    public static double calculateFare(String cabType, double distanceKm) {
        double baseFare, perKmRate;

        switch (cabType.toLowerCase()) {
            case "bike":
                baseFare  = 15.0;
                perKmRate = 6.0;
                break;
            case "sedan":
                baseFare  = 40.0;
                perKmRate = 13.0;
                break;
            case "mini":
            default:
                baseFare  = 25.0;
                perKmRate = 9.0;
                break;
        }

        double fare = baseFare + (perKmRate * distanceKm);

        // Off-peak discount: 10% off between 10 PM and 6 AM
        if (isOffPeakHour()) {
            fare = fare * 0.90;
        }

        return Math.round(fare * 10.0) / 10.0; // round to 1 decimal
    }

    /**
     * Apply promo code discount
     */
    public static double applyDiscount(double fare, int discountPct, double maxDiscount) {
        double discount = fare * discountPct / 100.0;
        discount = Math.min(discount, maxDiscount);
        return Math.max(0, fare - discount);
    }

    /**
     * Check if current time is off-peak (10 PM to 6 AM)
     */
    public static boolean isOffPeakHour() {
        LocalTime now = LocalTime.now();
        return now.isAfter(LocalTime.of(22, 0)) || now.isBefore(LocalTime.of(6, 0));
    }

    /**
     * Haversine formula to calculate distance between two lat/lng points
     */
    public static double calculateDistanceKm(double lat1, double lng1, double lat2, double lng2) {
        final int EARTH_RADIUS_KM = 6371;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLng = Math.toRadians(lng2 - lng1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                 + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                 * Math.sin(dLng / 2) * Math.sin(dLng / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return Math.round(EARTH_RADIUS_KM * c * 10.0) / 10.0;
    }

    /**
     * Estimate travel time in minutes (assuming avg 30 km/h in city)
     */
    public static int estimateTravelMinutes(double distanceKm) {
        return (int) Math.ceil((distanceKm / 30.0) * 60);
    }
}
