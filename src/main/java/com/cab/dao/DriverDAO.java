package com.cab.dao;

import com.cab.model.Driver;
import com.cab.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {

    public boolean registerDriver(Driver d) throws SQLException {
        String sql = "INSERT INTO driver_details (full_name,email,phone,password_hash,license_no,cab_type,vehicle_no,vehicle_model) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String hashed = BCrypt.hashpw(d.getPasswordHash(), BCrypt.gensalt(10));
            ps.setString(1, d.getFullName());
            ps.setString(2, d.getEmail());
            ps.setString(3, d.getPhone());
            ps.setString(4, hashed);
            ps.setString(5, d.getLicenseNo());
            ps.setString(6, d.getCabType());
            ps.setString(7, d.getVehicleNo());
            ps.setString(8, d.getVehicleModel());
            return ps.executeUpdate() > 0;
        }
    }

    public Driver loginDriver(String email, String password) throws SQLException {
        String sql = "SELECT * FROM driver_details WHERE email=? AND is_active=1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && BCrypt.checkpw(password, rs.getString("password_hash"))) {
                return mapDriver(rs);
            }
        }
        return null;
    }

    public Driver getDriverById(int driverId) throws SQLException {
        String sql = "SELECT * FROM driver_details WHERE driver_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, driverId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapDriver(rs);
        }
        return null;
    }

    public List<Driver> getAllDrivers() throws SQLException {
        List<Driver> list = new ArrayList<>();
        String sql = "SELECT * FROM driver_details ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapDriver(rs));
        }
        return list;
    }

    public List<Driver> getOnlineDriversByType(String cabType) throws SQLException {
        List<Driver> list = new ArrayList<>();
        String sql = "SELECT * FROM driver_details WHERE cab_type=? AND is_online=1 AND is_active=1 ORDER BY rating DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cabType);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapDriver(rs));
        }
        return list;
    }

    public boolean updateOnlineStatus(int driverId, int status) throws SQLException {
        String sql = "UPDATE driver_details SET is_online=? WHERE driver_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, driverId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateEarnings(int driverId, double amount) throws SQLException {
        String sql = "UPDATE driver_details SET total_earnings=total_earnings+?, total_rides=total_rides+1 WHERE driver_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, amount);
            ps.setInt(2, driverId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean toggleDriverStatus(int driverId, int status) throws SQLException {
        String sql = "UPDATE driver_details SET is_active=? WHERE driver_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, driverId);
            return ps.executeUpdate() > 0;
        }
    }

    public int getTotalDrivers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM driver_details";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int getOnlineDriverCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM driver_details WHERE is_online=1";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Driver mapDriver(ResultSet rs) throws SQLException {
        Driver d = new Driver();
        d.setDriverId(rs.getInt("driver_id"));
        d.setFullName(rs.getString("full_name"));
        d.setEmail(rs.getString("email"));
        d.setPhone(rs.getString("phone"));
        d.setPasswordHash(rs.getString("password_hash"));
        d.setLicenseNo(rs.getString("license_no"));
        d.setCabType(rs.getString("cab_type"));
        d.setVehicleNo(rs.getString("vehicle_no"));
        d.setVehicleModel(rs.getString("vehicle_model"));
        d.setRating(rs.getDouble("rating"));
        d.setIsOnline(rs.getInt("is_online"));
        d.setIsActive(rs.getInt("is_active"));
        d.setTotalRides(rs.getInt("total_rides"));
        d.setTotalEarnings(rs.getDouble("total_earnings"));
        d.setProfilePic(rs.getString("profile_pic"));
        d.setCreatedAt(rs.getTimestamp("created_at"));
        return d;
    }
}
