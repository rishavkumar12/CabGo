# 🚗 CabGo – Smart & Pocket-Friendly Cab Booking System

A complete web-based cab booking application built with **Java JSP/Servlet**, **MySQL**, and **Apache Maven**, deployable on **Apache Tomcat**.

---

## 🗂 Project Structure

```
CabBookingSystem/
├── pom.xml
├── database_schema.sql
└── src/main/
    ├── java/com/cab/
    │   ├── model/          User.java, Driver.java, Booking.java
    │   ├── dao/            UserDAO.java, DriverDAO.java, BookingDAO.java
    │   ├── servlet/        UserServlet.java, DriverServlet.java,
    │   │                   BookingServlet.java, AdminServlet.java
    │   └── util/           DBConnection.java, FareCalculator.java
    └── webapp/
        ├── index.jsp                    ← Home Page
        ├── WEB-INF/web.xml
        └── pages/
            ├── login.jsp                ← User Login
            ├── register.jsp             ← User Registration
            ├── book-cab.jsp             ← Book a Ride
            ├── booking-confirm.jsp      ← Booking Confirmation
            ├── ride-history.jsp         ← Ride History
            ├── driver-login.jsp         ← Driver Login
            ├── driver-register.jsp      ← Driver Registration
            ├── driver-dashboard.jsp     ← Driver Dashboard
            ├── admin-login.jsp          ← Admin Login
            ├── admin-dashboard.jsp      ← Admin Dashboard
            ├── admin-users.jsp          ← Manage Users
            ├── admin-drivers.jsp        ← Manage Drivers
            ├── admin-bookings.jsp       ← All Bookings
            └── error.jsp                ← Error Page
```

---

## ⚙️ Tech Stack

| Layer     | Technology                  |
|-----------|-----------------------------|
| Frontend  | HTML5, CSS3, JS, Bootstrap  |
| Backend   | Java 11, JSP, Servlets      |
| Database  | MySQL 8.x                   |
| Server    | Apache Tomcat 9+            |
| Build     | Apache Maven 3.x            |
| Security  | BCrypt password hashing     |

---

## 🚀 Setup & Installation

### Step 1 — Prerequisites
- JDK 11+
- Maven 3.6+
- MySQL 8.x
- Apache Tomcat 9+
- IDE: Eclipse / IntelliJ IDEA

### Step 2 — Database Setup
```sql
-- Run the provided SQL file
mysql -u root -p < database_schema.sql
```

### Step 3 — Configure DB Connection
Edit `src/main/java/com/cab/util/DBConnection.java`:
```java
private static final String URL      = "jdbc:mysql://localhost:3306/cab_booking_db";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password";
```

### Step 4 — Build with Maven
```bash
mvn clean package
```
This generates `target/CabBookingSystem.war`

### Step 5 — Deploy to Tomcat
Copy the WAR to Tomcat's `webapps/` folder:
```bash
cp target/CabBookingSystem.war $TOMCAT_HOME/webapps/
```
Start Tomcat and visit: **http://localhost:8080/CabBookingSystem/**

---

## 👥 Default Credentials

| Role   | Username/Email      | Password    |
|--------|---------------------|-------------|
| Admin  | admin               | Admin@123   |
| Driver | rajesh@driver.com   | Admin@123   |
| Driver | anil@driver.com     | Admin@123   |

---

## 🌐 Application URLs

| Page                | URL                                          |
|---------------------|----------------------------------------------|
| Home                | `/CabBookingSystem/`                         |
| User Register       | `/CabBookingSystem/pages/register.jsp`       |
| User Login          | `/CabBookingSystem/pages/login.jsp`          |
| Book a Ride         | `/CabBookingSystem/pages/book-cab.jsp`       |
| Ride History        | `/CabBookingSystem/pages/ride-history.jsp`   |
| Driver Login        | `/CabBookingSystem/pages/driver-login.jsp`   |
| Driver Dashboard    | `/CabBookingSystem/pages/driver-dashboard.jsp`|
| Admin Login         | `/CabBookingSystem/pages/admin-login.jsp`    |
| Admin Dashboard     | `/CabBookingSystem/pages/admin-dashboard.jsp`|

---

## 🔌 Servlet Endpoints

| Servlet         | URL Pattern   | Functions                             |
|-----------------|---------------|---------------------------------------|
| UserServlet     | `/user/*`     | register, login, logout               |
| DriverServlet   | `/driver/*`   | register, login, toggle-status, accept|
| BookingServlet  | `/booking/*`  | estimate, create, cancel, complete    |
| AdminServlet    | `/admin/*`    | login, dashboard, users, drivers      |

---

## 💡 Smart Features

- **Distance-based pricing** using the Haversine formula
- **Nearest driver assignment** (top-rated online driver)
- **Off-peak discount** — 20% off between 10 PM and 6 AM
- **Promo codes** — FIRSTRIDE (30%), OFFPEAK20 (20%), CABGO10 (10%)
- **BCrypt password hashing** for security
- **Session-based auth** for User / Driver / Admin

---

## 🗄 Database Tables

1. `user_details` — Registered users
2. `driver_details` — Registered drivers
3. `cab_details` — Cab types and fare rates
4. `booking_details` — All bookings
5. `payment_details` — Payment records
6. `admin_details` — Admin accounts
7. `discount_details` — Promo codes

---

## 🔮 Future Enhancements

- Live GPS tracking (Google Maps API)
- Real-time push notifications (WebSocket)
- Online payments (Razorpay/UPI)
- Mobile app (Android)
- Email/SMS OTP verification

---

*Built as an MCA project — Smart & Pocket-Friendly Cab Booking System*
