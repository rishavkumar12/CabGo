package com.cab.servlet;

import com.cab.dao.BookingDAO;
import com.cab.dao.DriverDAO;
import com.cab.dao.UserDAO;
import com.cab.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final UserDAO    userDAO    = new UserDAO();
    private final DriverDAO  driverDAO  = new DriverDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/login":         handleAdminLogin(req, resp);    break;
            case "/logout":        handleAdminLogout(req, resp);   break;
            case "/toggle-user":   handleToggleUser(req, resp);    break;
            case "/toggle-driver": handleToggleDriver(req, resp);  break;
            default:
                resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/logout".equals(path)) handleAdminLogout(req, resp);
        else if ("/dashboard".equals(path)) showDashboard(req, resp);
        else if ("/users".equals(path))     showUsers(req, resp);
        else if ("/drivers".equals(path))   showDrivers(req, resp);
        else if ("/bookings".equals(path))  showBookings(req, resp);
        else resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp");
    }

    private void handleAdminLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        try {
            String sql = "SELECT * FROM admin_details WHERE username=?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                if (rs.next() && BCrypt.checkpw(password, rs.getString("password_hash"))) {
                    HttpSession session = req.getSession();
                    session.setAttribute("adminId", rs.getInt("admin_id"));
                    session.setAttribute("adminName", rs.getString("full_name"));
                    session.setAttribute("userRole", "admin");
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                    return;
                }
            }
            req.setAttribute("error", "Invalid admin credentials.");
            req.getRequestDispatcher("/pages/admin-login.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/pages/admin-login.jsp").forward(req, resp);
        }
    }

    private void handleAdminLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
        resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp");
    }

    private void handleToggleUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp"); return; }
        int userId = Integer.parseInt(req.getParameter("userId"));
        int status = Integer.parseInt(req.getParameter("status"));
        try { userDAO.toggleUserStatus(userId, status); } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }

    private void handleToggleDriver(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp"); return; }
        int driverId = Integer.parseInt(req.getParameter("driverId"));
        int status   = Integer.parseInt(req.getParameter("status"));
        try { driverDAO.toggleDriverStatus(driverId, status); } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/admin/drivers");
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp"); return; }
        try {
            req.setAttribute("totalUsers",    userDAO.getTotalUsers());
            req.setAttribute("totalDrivers",  driverDAO.getTotalDrivers());
            req.setAttribute("onlineDrivers", driverDAO.getOnlineDriverCount());
            req.setAttribute("totalBookings", bookingDAO.getTotalBookings());
            req.setAttribute("totalRevenue",  bookingDAO.getTotalRevenue());
            req.setAttribute("recentBookings",bookingDAO.getAllBookings());
        } catch (Exception ignored) {}
        req.getRequestDispatcher("/pages/admin-dashboard.jsp").forward(req, resp);
    }

    private void showUsers(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp"); return; }
        try { req.setAttribute("users", userDAO.getAllUsers()); } catch (Exception ignored) {}
        req.getRequestDispatcher("/pages/admin-users.jsp").forward(req, resp);
    }

    private void showDrivers(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp"); return; }
        try { req.setAttribute("drivers", driverDAO.getAllDrivers()); } catch (Exception ignored) {}
        req.getRequestDispatcher("/pages/admin-drivers.jsp").forward(req, resp);
    }

    private void showBookings(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req)) { resp.sendRedirect(req.getContextPath() + "/pages/admin-login.jsp"); return; }
        try { req.setAttribute("bookings", bookingDAO.getAllBookings()); } catch (Exception ignored) {}
        req.getRequestDispatcher("/pages/admin-bookings.jsp").forward(req, resp);
    }

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null && "admin".equals(session.getAttribute("userRole"));
    }
}
