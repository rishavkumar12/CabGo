package com.cab.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Utility
 * CabGo - Smart Cab Booking System
 * Apache Tomcat port: 8087 | MySQL port: 3306
 */
public class DBConnection {

    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";
    private static final String HOST     = "localhost";
    private static final String PORT     = "3306";
    private static final String DB_NAME  = "cab_booking_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Rishav@123";

    private static final String URL =
        "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME
        + "?useSSL=false"
        + "&serverTimezone=Asia/Kolkata"
        + "&allowPublicKeyRetrieval=true"
        + "&useUnicode=true"
        + "&characterEncoding=UTF-8"
        + "&autoReconnect=true"
        + "&failOverReadOnly=false"
        + "&maxReconnects=5";

    static {
        try {
            Class.forName(DRIVER);
            System.out.println("[CabGo] MySQL Driver loaded OK.");
        } catch (ClassNotFoundException e) {
            System.err.println("[CabGo] ERROR: MySQL Driver not found! " + e.getMessage());
            throw new RuntimeException("MySQL Driver not found!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            System.err.println("[CabGo] DB Connection FAILED: " + e.getMessage());
            throw e;
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); }
            catch (SQLException e) {
                System.err.println("[CabGo] Error closing connection: " + e.getMessage());
            }
        }
    }

    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("[CabGo] Test FAILED: " + e.getMessage());
            return false;
        }
    }
}
