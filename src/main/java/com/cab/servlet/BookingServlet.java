package com.cab.servlet;

import com.cab.dao.BookingDAO;
import com.cab.dao.DriverDAO;
import com.cab.model.Booking;
import com.cab.model.Driver;
import com.cab.model.User;
import com.cab.util.FareCalculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/booking/*")
public class BookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final DriverDAO  driverDAO  = new DriverDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/estimate":  handleFareEstimate(req, resp); break;
            case "/create":    handleCreateBooking(req, resp); break;
            case "/cancel":    handleCancelBooking(req, resp); break;
            case "/complete":  handleCompleteBooking(req, resp); break;
            default:
                resp.sendRedirect(req.getContextPath() + "/pages/book-cab.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/history".equals(path)) handleHistory(req, resp);
        else resp.sendRedirect(req.getContextPath() + "/pages/book-cab.jsp");
    }

    private void handleFareEstimate(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        try {
            double distance = Double.parseDouble(req.getParameter("distance"));
            String cabType  = req.getParameter("cabType");

            double fare   = FareCalculator.calculateFare(cabType, distance);
            int    mins   = FareCalculator.estimateTravelMinutes(distance);
            boolean offPk = FareCalculator.isOffPeakHour();

            out.print("{\"fare\":" + fare + ",\"minutes\":" + mins + ",\"offPeak\":" + offPk + "}");
        } catch (Exception e) {
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleCreateBooking(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            Booking b = new Booking();
            b.setUserId(user.getUserId());
            b.setCabType(req.getParameter("cabType"));
            b.setPickupAddress(req.getParameter("pickupAddress"));
            b.setDropAddress(req.getParameter("dropAddress"));
            b.setDistanceKm(Double.parseDouble(req.getParameter("distanceKm")));
            b.setEstimatedFare(Double.parseDouble(req.getParameter("estimatedFare")));
            b.setFinalFare(Double.parseDouble(req.getParameter("finalFare")));
            b.setDiscountAmount(Double.parseDouble(req.getParameter("discountAmount")));
            b.setPaymentMethod(req.getParameter("paymentMethod") != null ? req.getParameter("paymentMethod") : "Cash");

            // Auto-assign nearest/best-rated online driver
            List<Driver> available = driverDAO.getOnlineDriversByType(b.getCabType());
            if (!available.isEmpty()) {
                Driver assigned = available.get(0);
                b.setDriverId(assigned.getDriverId());
            }

            int bookingId = bookingDAO.createBooking(b);
            if (bookingId > 0 && b.getDriverId() > 0) {
                bookingDAO.assignDriver(bookingId, b.getDriverId());
            }

            if (bookingId > 0) {
                resp.sendRedirect(req.getContextPath() + "/pages/booking-confirm.jsp?id=" + bookingId);
            } else {
                req.setAttribute("error", "Booking failed. Please try again.");
                req.getRequestDispatcher("/pages/book-cab.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error creating booking: " + e.getMessage());
            req.getRequestDispatcher("/pages/book-cab.jsp").forward(req, resp);
        }
    }

    private void handleCancelBooking(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        if (session == null) { resp.sendRedirect(req.getContextPath() + "/pages/login.jsp"); return; }

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        try {
            bookingDAO.updateBookingStatus(bookingId, "Cancelled");
            resp.sendRedirect(req.getContextPath() + "/booking/history?msg=cancelled");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/booking/history?err=" + e.getMessage());
        }
    }

    private void handleCompleteBooking(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        try {
            Booking b = bookingDAO.getBookingById(bookingId);
            bookingDAO.completeBooking(bookingId);
            if (b != null && b.getDriverId() > 0) {
                driverDAO.updateEarnings(b.getDriverId(), b.getFinalFare());
            }
            resp.sendRedirect(req.getContextPath() + "/booking/history?msg=completed");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/booking/history?err=" + e.getMessage());
        }
    }

    private void handleHistory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        try {
            List<Booking> history = bookingDAO.getBookingsByUser(user.getUserId());
            req.setAttribute("bookings", history);
            req.getRequestDispatcher("/pages/ride-history.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/ride-history.jsp").forward(req, resp);
        }
    }
}
