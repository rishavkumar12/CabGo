package com.cab.servlet;

import com.cab.util.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

/**
 * DB Test Servlet
 * Visit: http://localhost:8087/CabBookingSystem/test-db
 */
@WebServlet("/test-db")
public class DBTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html><html><head><title>DB Test - CabGo</title>");
        out.println("<style>");
        out.println("*{margin:0;padding:0;box-sizing:border-box}");
        out.println("body{font-family:Arial,sans-serif;background:#0d0d16;color:#e8e8f0;min-height:100vh;display:flex;align-items:center;justify-content:center}");
        out.println(".box{width:500px;background:#1a1a28;border-radius:20px;padding:36px;border:1px solid rgba(255,255,255,.1);text-align:center}");
        out.println("h1{color:#f5c842;font-size:1.8rem;margin-bottom:6px}");
        out.println(".sub{color:#7878a8;font-size:.9rem;margin-bottom:24px}");
        out.println(".ok{background:rgba(34,197,94,.1);border:1px solid rgba(34,197,94,.3);border-radius:12px;padding:18px;color:#22c55e;font-size:1rem;margin:16px 0}");
        out.println(".fail{background:rgba(239,68,68,.1);border:1px solid rgba(239,68,68,.3);border-radius:12px;padding:18px;color:#ef4444;font-size:.95rem;margin:16px 0;text-align:left}");
        out.println(".row{display:flex;justify-content:space-between;padding:8px 0;border-bottom:1px solid rgba(255,255,255,.05);font-size:.88rem}");
        out.println(".row:last-child{border:none}");
        out.println(".lbl{color:#7878a8}.val{color:#e8e8f0;font-weight:bold}");
        out.println(".btn{display:inline-block;background:#f5c842;color:#0d0d16;padding:11px 26px;border-radius:50px;text-decoration:none;font-weight:700;margin-top:20px;font-size:.9rem}");
        out.println(".fix{background:rgba(245,200,66,.08);border:1px solid rgba(245,200,66,.2);border-radius:10px;padding:14px;margin-top:14px;text-align:left;font-size:.82rem;color:#f5c842;line-height:1.8}");
        out.println("</style></head><body><div class='box'>");
        out.println("<h1>CabGo DB Test</h1>");
        out.println("<p class='sub'>MySQL Connection Status &bull; Port 3306</p>");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null && !conn.isClosed()) {

                Statement st = conn.createStatement();

                ResultSet rt = st.executeQuery(
                    "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='cab_booking_db'");
                int tables = rt.next() ? rt.getInt(1) : 0;

                ResultSet ru = st.executeQuery("SELECT COUNT(*) FROM user_details");
                int users = ru.next() ? ru.getInt(1) : 0;

                ResultSet rd = st.executeQuery("SELECT COUNT(*) FROM driver_details");
                int drivers = rd.next() ? rd.getInt(1) : 0;

                ResultSet rb = st.executeQuery("SELECT COUNT(*) FROM booking_details");
                int bookings = rb.next() ? rb.getInt(1) : 0;

                out.println("<div class='ok'>&#10003;&nbsp; Database Connected Successfully!</div>");
                out.println("<div style='background:rgba(255,255,255,.03);border-radius:10px;padding:14px;margin-top:8px'>");
                out.println("<div class='row'><span class='lbl'>Host</span><span class='val'>localhost:3306</span></div>");
                out.println("<div class='row'><span class='lbl'>Database</span><span class='val'>cab_booking_db</span></div>");
                out.println("<div class='row'><span class='lbl'>Tables</span><span class='val'>" + tables + " found</span></div>");
                out.println("<div class='row'><span class='lbl'>Users</span><span class='val'>" + users + "</span></div>");
                out.println("<div class='row'><span class='lbl'>Drivers</span><span class='val'>" + drivers + "</span></div>");
                out.println("<div class='row'><span class='lbl'>Bookings</span><span class='val'>" + bookings + "</span></div>");
                out.println("</div>");
                out.println("<a class='btn' href='index.jsp'>&#128663; Go to Home Page</a>");

            }
        } catch (SQLException e) {
            out.println("<div class='fail'>&#10007;&nbsp; Connection FAILED!<br><br>");
            out.println("<strong>Error:</strong><br>" + e.getMessage() + "</div>");
            out.println("<div class='fix'>");
            out.println("<strong>Fix karo:</strong><br>");
            out.println("1. MySQL server chalu hai? (XAMPP/WAMP/MySQL Workbench)<br>");
            out.println("2. <code>database_schema.sql</code> run kiya hai?<br>");
            out.println("3. DBConnection.java mein password sahi hai?<br>");
            out.println("4. Port 3306 correct hai?");
            out.println("</div>");
        }

        out.println("</div></body></html>");
    }
}
