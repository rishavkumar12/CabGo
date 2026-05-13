package com.cab.servlet;

import com.cab.dao.BookingDAO;
import com.cab.dao.DriverDAO;
import com.cab.model.Booking;
import com.cab.model.Driver;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/driver/*")
public class DriverServlet extends HttpServlet {

    private final DriverDAO  driverDAO  = new DriverDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/register":     handleRegister(req, resp); break;
            case "/login":        handleLogin(req, resp);    break;
            case "/logout":       handleLogout(req, resp);   break;
            case "/toggle-status":handleToggleStatus(req, resp); break;
            case "/accept":       handleAcceptRide(req, resp);   break;
            case "/complete":     handleCompleteRide(req, resp); break;
            default:
                resp.sendRedirect(req.getContextPath() + "/pages/driver-login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/dashboard".equals(path)) handleDashboard(req, resp);
        else if ("/logout".equals(path)) handleLogout(req, resp);
        else resp.sendRedirect(req.getContextPath() + "/pages/driver-login.jsp");
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Driver d = new Driver();
            d.setFullName(req.getParameter("fullName").trim());
            d.setEmail(req.getParameter("email").trim().toLowerCase());
            d.setPhone(req.getParameter("phone").trim());
            d.setPasswordHash(req.getParameter("password"));
            d.setLicenseNo(req.getParameter("licenseNo").trim());
            d.setCabType(req.getParameter("cabType"));
            d.setVehicleNo(req.getParameter("vehicleNo").trim().toUpperCase());
            d.setVehicleModel(req.getParameter("vehicleModel").trim());

            boolean success = driverDAO.registerDriver(d);
            if (success) {
                req.setAttribute("success", "Driver registered! Please login.");
                req.getRequestDispatcher("/pages/driver-login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Registration failed.");
                req.getRequestDispatcher("/pages/driver-register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/pages/driver-register.jsp").forward(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email    = req.getParameter("email").trim().toLowerCase();
        String password = req.getParameter("password");
        try {
            Driver driver = driverDAO.loginDriver(email, password);
            if (driver != null) {
                HttpSession session = req.getSession();
                session.setAttribute("driver", driver);
                session.setAttribute("driverId", driver.getDriverId());
                session.setAttribute("userRole", "driver");
                resp.sendRedirect(req.getContextPath() + "/driver/dashboard");
            } else {
                req.setAttribute("error", "Invalid credentials.");
                req.getRequestDispatcher("/pages/driver-login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Login failed: " + e.getMessage());
            req.getRequestDispatcher("/pages/driver-login.jsp").forward(req, resp);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
        resp.sendRedirect(req.getContextPath() + "/pages/driver-login.jsp");
    }

    private void handleToggleStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) { resp.sendRedirect(req.getContextPath() + "/pages/driver-login.jsp"); return; }
        Driver driver = (Driver) session.getAttribute("driver");
        try {
            int newStatus = driver.getIsOnline() == 1 ? 0 : 1;
            driverDAO.updateOnlineStatus(driver.getDriverId(), newStatus);
            driver.setIsOnline(newStatus);
            session.setAttribute("driver", driver);
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/driver/dashboard");
    }

    private void handleAcceptRide(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) { resp.sendRedirect(req.getContextPath() + "/pages/driver-login.jsp"); return; }
        Driver driver = (Driver) session.getAttribute("driver");
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        try {
            bookingDAO.assignDriver(bookingId, driver.getDriverId());
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/driver/dashboard");
    }

    private void handleCompleteRide(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        try {
            Booking b = bookingDAO.getBookingById(bookingId);
            bookingDAO.completeBooking(bookingId);
            if (b != null) driverDAO.updateEarnings(b.getDriverId(), b.getFinalFare());
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/driver/dashboard");
    }

    private void handleDashboard(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("driver") == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/driver-login.jsp");
            return;
        }
        Driver driver = (Driver) session.getAttribute("driver");
        try {
            List<Booking> rides    = bookingDAO.getBookingsByDriver(driver.getDriverId());
            List<Booking> pending  = bookingDAO.getPendingBookings();
            req.setAttribute("rides", rides);
            req.setAttribute("pendingRides", pending);
            req.getRequestDispatcher("/pages/driver-dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            req.getRequestDispatcher("/pages/driver-dashboard.jsp").forward(req, resp);
        }
    }
}
