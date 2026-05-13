package com.cab.dao;

import com.cab.model.Booking;
import com.cab.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public int createBooking(Booking b) throws SQLException {
        String sql = "INSERT INTO booking_details (user_id,cab_type,pickup_address,drop_address," +
                     "pickup_lat,pickup_lng,drop_lat,drop_lng,distance_km,estimated_fare,final_fare," +
                     "discount_amount,payment_method,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,'Pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, b.getUserId());
            ps.setString(2, b.getCabType());
            ps.setString(3, b.getPickupAddress());
            ps.setString(4, b.getDropAddress());
            ps.setDouble(5, b.getPickupLat());
            ps.setDouble(6, b.getPickupLng());
            ps.setDouble(7, b.getDropLat());
            ps.setDouble(8, b.getDropLng());
            ps.setDouble(9, b.getDistanceKm());
            ps.setDouble(10, b.getEstimatedFare());
            ps.setDouble(11, b.getFinalFare());
            ps.setDouble(12, b.getDiscountAmount());
            ps.setString(13, b.getPaymentMethod());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public Booking getBookingById(int bookingId) throws SQLException {
        String sql = "SELECT b.*, u.full_name AS user_name, d.full_name AS driver_name, d.vehicle_no " +
                     "FROM booking_details b " +
                     "LEFT JOIN user_details u ON b.user_id=u.user_id " +
                     "LEFT JOIN driver_details d ON b.driver_id=d.driver_id " +
                     "WHERE b.booking_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapBooking(rs);
        }
        return null;
    }

    public List<Booking> getBookingsByUser(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, d.full_name AS driver_name, d.vehicle_no " +
                     "FROM booking_details b " +
                     "LEFT JOIN user_details u ON b.user_id=u.user_id " +
                     "LEFT JOIN driver_details d ON b.driver_id=d.driver_id " +
                     "WHERE b.user_id=? ORDER BY b.booking_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapBooking(rs));
        }
        return list;
    }

    public List<Booking> getBookingsByDriver(int driverId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, d.full_name AS driver_name, d.vehicle_no " +
                     "FROM booking_details b " +
                     "LEFT JOIN user_details u ON b.user_id=u.user_id " +
                     "LEFT JOIN driver_details d ON b.driver_id=d.driver_id " +
                     "WHERE b.driver_id=? ORDER BY b.booking_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, driverId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapBooking(rs));
        }
        return list;
    }

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, d.full_name AS driver_name, d.vehicle_no " +
                     "FROM booking_details b " +
                     "LEFT JOIN user_details u ON b.user_id=u.user_id " +
                     "LEFT JOIN driver_details d ON b.driver_id=d.driver_id " +
                     "ORDER BY b.booking_time DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapBooking(rs));
        }
        return list;
    }

    public List<Booking> getPendingBookings() throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name AS user_name, '' AS driver_name, '' AS vehicle_no " +
                     "FROM booking_details b " +
                     "JOIN user_details u ON b.user_id=u.user_id " +
                     "WHERE b.status='Pending' ORDER BY b.booking_time ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapBooking(rs));
        }
        return list;
    }

    public boolean updateBookingStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE booking_details SET status=? WHERE booking_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean assignDriver(int bookingId, int driverId) throws SQLException {
        String sql = "UPDATE booking_details SET driver_id=?, status='Accepted', pickup_time=NOW() WHERE booking_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, driverId);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean completeBooking(int bookingId) throws SQLException {
        String sql = "UPDATE booking_details SET status='Completed', drop_time=NOW(), payment_status='Paid' WHERE booking_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    public int getTotalBookings() throws SQLException {
        String sql = "SELECT COUNT(*) FROM booking_details";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT COALESCE(SUM(final_fare),0) FROM booking_details WHERE status='Completed'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble(1);
        }
        return 0;
    }

    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setDriverId(rs.getInt("driver_id"));
        b.setCabType(rs.getString("cab_type"));
        b.setPickupAddress(rs.getString("pickup_address"));
        b.setDropAddress(rs.getString("drop_address"));
        b.setDistanceKm(rs.getDouble("distance_km"));
        b.setEstimatedFare(rs.getDouble("estimated_fare"));
        b.setFinalFare(rs.getDouble("final_fare"));
        b.setDiscountAmount(rs.getDouble("discount_amount"));
        b.setStatus(rs.getString("status"));
        b.setBookingTime(rs.getTimestamp("booking_time"));
        b.setPaymentMethod(rs.getString("payment_method"));
        b.setPaymentStatus(rs.getString("payment_status"));
        try { b.setUserName(rs.getString("user_name")); } catch (Exception ignored) {}
        try { b.setDriverName(rs.getString("driver_name")); } catch (Exception ignored) {}
        try { b.setVehicleNo(rs.getString("vehicle_no")); } catch (Exception ignored) {}
        return b;
    }
}
