package com.cab.servlet;

import com.cab.dao.UserDAO;
import com.cab.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/register": handleRegister(req, resp); break;
            case "/login":    handleLogin(req, resp);    break;
            case "/logout":   handleLogout(req, resp);   break;
            default:
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/logout".equals(path)) handleLogout(req, resp);
        else resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name     = req.getParameter("fullName").trim();
        String email    = req.getParameter("email").trim().toLowerCase();
        String phone    = req.getParameter("phone").trim();
        String password = req.getParameter("password");
        String address  = req.getParameter("address");

        try {
            if (userDAO.emailExists(email)) {
                req.setAttribute("error", "Email already registered.");
                req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
                return;
            }
            if (userDAO.phoneExists(phone)) {
                req.setAttribute("error", "Phone number already registered.");
                req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
                return;
            }

            User user = new User(name, email, phone, password);
            user.setAddress(address);
            boolean success = userDAO.registerUser(user);

            if (success) {
                req.setAttribute("success", "Registration successful! Please login.");
                req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Registration failed. Please try again.");
                req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Server error: " + e.getMessage());
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email    = req.getParameter("email").trim().toLowerCase();
        String password = req.getParameter("password");

        try {
            User user = userDAO.loginUser(email, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userRole", "user");
                resp.sendRedirect(req.getContextPath() + "/pages/book-cab.jsp");
            } else {
                req.setAttribute("error", "Invalid email or password.");
                req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Login failed: " + e.getMessage());
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}
