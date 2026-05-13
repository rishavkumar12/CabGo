-- ============================================================
-- Smart & Pocket-Friendly Cab Booking System - Database Schema
-- Database: cab_booking_db
-- ============================================================

CREATE DATABASE IF NOT EXISTS cab_booking_db;
USE cab_booking_db;

-- ========================
-- 1. User Details Table
-- ========================
CREATE TABLE IF NOT EXISTS user_details (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    phone         VARCHAR(15)  NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    profile_pic   VARCHAR(255) DEFAULT 'default_user.png',
    address       TEXT,
    is_active     TINYINT(1)   DEFAULT 1,
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- 2. Driver Details Table
-- ========================
CREATE TABLE IF NOT EXISTS driver_details (
    driver_id     INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    phone         VARCHAR(15)  NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    license_no    VARCHAR(50)  NOT NULL UNIQUE,
    cab_type      ENUM('Bike','Mini','Sedan') NOT NULL DEFAULT 'Mini',
    vehicle_no    VARCHAR(30)  NOT NULL,
    vehicle_model VARCHAR(100),
    rating        DECIMAL(3,2) DEFAULT 5.00,
    is_online     TINYINT(1)   DEFAULT 0,
    is_active     TINYINT(1)   DEFAULT 1,
    total_rides   INT          DEFAULT 0,
    total_earnings DECIMAL(10,2) DEFAULT 0.00,
    current_lat   DECIMAL(10,8),
    current_lng   DECIMAL(11,8),
    profile_pic   VARCHAR(255) DEFAULT 'default_driver.png',
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- 3. Cab Types / Fare Table
-- ========================
CREATE TABLE IF NOT EXISTS cab_details (
    cab_id        INT AUTO_INCREMENT PRIMARY KEY,
    cab_type      ENUM('Bike','Mini','Sedan') NOT NULL UNIQUE,
    base_fare     DECIMAL(8,2) NOT NULL DEFAULT 20.00,
    per_km_rate   DECIMAL(8,2) NOT NULL DEFAULT 8.00,
    per_min_rate  DECIMAL(8,2) NOT NULL DEFAULT 1.00,
    capacity      INT          DEFAULT 2,
    description   TEXT,
    icon          VARCHAR(100),
    is_active     TINYINT(1)   DEFAULT 1
);

-- ========================
-- 4. Booking Details Table
-- ========================
CREATE TABLE IF NOT EXISTS booking_details (
    booking_id      INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    driver_id       INT,
    cab_type        ENUM('Bike','Mini','Sedan') NOT NULL,
    pickup_address  TEXT NOT NULL,
    drop_address    TEXT NOT NULL,
    pickup_lat      DECIMAL(10,8),
    pickup_lng      DECIMAL(11,8),
    drop_lat        DECIMAL(10,8),
    drop_lng        DECIMAL(11,8),
    distance_km     DECIMAL(8,2),
    estimated_fare  DECIMAL(10,2),
    final_fare      DECIMAL(10,2),
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    status          ENUM('Pending','Accepted','In-Progress','Completed','Cancelled') DEFAULT 'Pending',
    booking_time    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    pickup_time     DATETIME,
    drop_time       DATETIME,
    payment_method  ENUM('Cash','UPI','Wallet') DEFAULT 'Cash',
    payment_status  ENUM('Pending','Paid') DEFAULT 'Pending',
    rating_by_user  INT,
    review_by_user  TEXT,
    FOREIGN KEY (user_id)   REFERENCES user_details(user_id)  ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES driver_details(driver_id) ON DELETE SET NULL
);

-- ========================
-- 5. Payment Details Table
-- ========================
CREATE TABLE IF NOT EXISTS payment_details (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    booking_id      INT NOT NULL UNIQUE,
    user_id         INT NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    payment_method  ENUM('Cash','UPI','Wallet') DEFAULT 'Cash',
    transaction_id  VARCHAR(100),
    status          ENUM('Success','Failed','Pending') DEFAULT 'Pending',
    payment_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES booking_details(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)    REFERENCES user_details(user_id)       ON DELETE CASCADE
);

-- ========================
-- 6. Admin Table
-- ========================
CREATE TABLE IF NOT EXISTS admin_details (
    admin_id      INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name     VARCHAR(100),
    email         VARCHAR(100),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- 7. Discount Table
-- ========================
CREATE TABLE IF NOT EXISTS discount_details (
    discount_id    INT AUTO_INCREMENT PRIMARY KEY,
    promo_code     VARCHAR(30)  NOT NULL UNIQUE,
    discount_pct   INT          NOT NULL DEFAULT 10,
    max_discount   DECIMAL(8,2) DEFAULT 50.00,
    valid_from     DATE,
    valid_to       DATE,
    is_active      TINYINT(1)   DEFAULT 1,
    description    TEXT
);

-- ========================
-- Default Data Inserts
-- ========================

-- Cab fare rates
INSERT INTO cab_details (cab_type, base_fare, per_km_rate, per_min_rate, capacity, description, icon) VALUES
('Bike',  15.00,  6.00, 0.50, 1, 'Fastest & cheapest option for solo riders',  'fa-motorcycle'),
('Mini',  25.00,  9.00, 1.00, 3, 'Affordable hatchback for up to 3 passengers', 'fa-car'),
('Sedan', 40.00, 13.00, 1.50, 4, 'Comfortable sedan for up to 4 passengers',   'fa-car-side');

-- Default admin (password: Admin@123)
INSERT INTO admin_details (username, password_hash, full_name, email) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'System Admin', 'admin@cabgo.com');

-- Sample off-peak discount
INSERT INTO discount_details (promo_code, discount_pct, max_discount, valid_from, valid_to, description) VALUES
('OFFPEAK20', 20, 50.00, '2025-01-01', '2026-12-31', '20% off during off-peak hours (10PM-6AM)'),
('FIRSTRIDE', 30, 80.00, '2025-01-01', '2026-12-31', '30% off on your first ride'),
('CABGO10',   10, 30.00, '2025-01-01', '2026-12-31', 'Flat 10% off on all rides');

-- Sample drivers
INSERT INTO driver_details (full_name, email, phone, password_hash, license_no, cab_type, vehicle_no, vehicle_model, rating, is_online) VALUES
('Rajesh Kumar',   'rajesh@driver.com', '9876543210', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'DL1234567', 'Mini',  'DL3C AB1234', 'Maruti Swift',   4.8, 1),
('Anil Sharma',    'anil@driver.com',   '9876543211', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'DL2345678', 'Sedan', 'DL4C CD5678', 'Honda City',     4.9, 1),
('Suresh Yadav',   'suresh@driver.com', '9876543212', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'DL3456789', 'Bike',  'DL5C EF9012', 'Honda Activa',   4.7, 0),
('Deepak Verma',   'deepak@driver.com', '9876543213', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'DL4567890', 'Mini',  'DL6C GH3456', 'Hyundai i10',    4.6, 1),
('Mohit Gupta',    'mohit@driver.com',  '9876543214', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'DL5678901', 'Sedan', 'DL7C IJ7890', 'Toyota Innova',  4.95,1);
