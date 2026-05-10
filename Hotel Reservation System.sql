-- HOTEL RESERVATION SYSTEM (Complete DBMS Project)

-- 1. CREATE DATABASE

CREATE DATABASE Hotel_Reservation_System;

-- 2. USE Database

USE Hotel_Reservation_System;

-- 3. CREATE TABLES

-- Guests Table
CREATE TABLE Guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    city VARCHAR(50),
    check_in DATE,
    check_out DATE
);

-- Rooms Table
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number INT UNIQUE NOT NULL,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    availability_status VARCHAR(20) DEFAULT 'Available'
);

-- Reservations Table
CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    booking_date DATE,
    total_days INT,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    amount_paid DECIMAL(10,2),

    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);

-- 4. INSERT VALID DATA

-- Guests Data
INSERT INTO Guests (guest_name, phone, city, check_in, check_out)
VALUES
('Ali Khan', '03001234567', 'Lahore', '2026-04-20', '2026-04-25'),
('Sara Ahmed', '03111234567', 'Karachi', '2026-04-21', '2026-04-24'),
('Usman Tariq', '03221234567', 'Multan', '2026-04-22', '2026-04-28');
-- Duplicate phone (UNIQUE constraint error)

INSERT INTO Guests (guest_name, phone, city, check_in, check_out)
VALUES
('Test User', '03001234567', 'Lahore', '2026-04-25', '2026-04-28');

-- Invalid foreign key (FK constraint error)

INSERT INTO Reservations (guest_id, room_id, booking_date, total_days, total_amount)
VALUES
(99, 1, '2026-04-25', 2, 10000.00);

-- Rooms Data
INSERT INTO Rooms (room_number, room_type, price_per_night, availability_status)
VALUES
(101, 'Single', 5000.00, 'Available'),
(102, 'Double', 8000.00, 'Booked'),
(103, 'Suite', 12000.00, 'Available'),
(101, 'Single', 5000.00, 'Booked'),
(102, 'Double', 8000.00, 'Booked'),
(103, 'Suite', 12000.00, 'Booked'),
(201, 'Single', 5000.00, 'Booked'),
(202, 'Double', 8500.00, 'Booked'),
(301, 'Suite', 15000.00, 'Booked'),
(302, 'Penthouse', 25000.00, 'Booked'),
(401, 'Deluxe', 10000.00, 'Booked');

-- Reservations Data
INSERT INTO Reservations (guest_id, room_id, booking_date, total_days, total_amount)
VALUES
(1, 2, '2026-04-20', 5, 40000.00),
(2, 1, '2026-04-21', 3, 15000.00),
(1, 1, '2026-05-10', 5, 25000.00),
(2, 2, '2026-05-11', 3, 24000.00),
(3, 3, '2026-05-12', 6, 72000.00),
(4, 4, '2026-05-13', 4, 20000.00),
(5, 5, '2026-05-14', 2, 17000.00),
(6, 6, '2026-05-15', 5, 75000.00),
(7, 7, '2026-05-16', 3, 75000.00),
(8, 8, '2026-05-17', 4, 40000.00);

-- Payments Data
INSERT INTO Payments (reservation_id, payment_date, payment_method, amount_paid)
VALUES
(1, '2026-04-20', 'Cash', 40000.00),
(2, '2026-04-21', 'Card', 15000.00),
(1, '2026-05-10', 'Cash', 25000.00),
(2, '2026-05-11', 'Card', 24000.00),
(3, '2026-05-12', 'Online', 72000.00),
(4, '2026-05-13', 'Cash', 20000.00),
(5, '2026-05-14', 'Card', 17000.00),
(6, '2026-05-15', 'Online', 75000.00),
(7, '2026-05-16', 'Cash', 75000.00),
(8, '2026-05-17', 'Card', 40000.00);

-- 5. VIEW ALL DATA

SELECT * FROM Guests;
SELECT * FROM Rooms;
SELECT * FROM Reservations;
SELECT * FROM Payments;

-- 6. CHECK AVAILABLE ROOMS

SELECT * FROM Rooms
WHERE availability_status = 'Available';

-- 7. CUSTOMER BOOKING QUERY

INSERT INTO Guests (guest_name, phone, city, check_in, check_out)
VALUES
('Ayesha Noor', '03331234567', 'Islamabad', '2026-04-23', '2026-04-27'),
('Ali Khan', '03001111111', 'Lahore', '2026-05-10', '2026-05-15'),
('Sara Ahmed', '03112222222', 'Karachi', '2026-05-11', '2026-05-14'),
('Usman Tariq', '03223333333', 'Multan', '2026-05-12', '2026-05-18'),
('Ayesha Noor', '03334444444', 'Islamabad', '2026-05-13', '2026-05-17'),
('Zain Malik', '03445555555', 'Faisalabad', '2026-05-14', '2026-05-16'),
('Hina Butt', '03556666666', 'Sialkot', '2026-05-15', '2026-05-20'),
('Bilal Sheikh', '03667777777', 'Peshawar', '2026-05-16', '2026-05-19'),
('Maria Jan', '03778888888', 'Quetta', '2026-05-17', '2026-05-21');

-- 8. ASSIGN ROOM TO CUSTOMER

INSERT INTO Reservations (guest_id, room_id, booking_date, total_days, total_amount)
VALUES
(4, 3, '2026-04-23', 4, 48000.00),
(1, 1, '2026-05-10', 5, 25000.00),
(2, 2, '2026-05-11', 3, 24000.00),
(3, 3, '2026-05-12', 6, 72000.00),
(4, 4, '2026-05-13', 4, 20000.00),
(5, 5, '2026-05-14', 2, 17000.00),
(6, 6, '2026-05-15', 5, 75000.00),
(7, 7, '2026-05-16', 3, 75000.00),
(8, 8, '2026-05-17', 4, 40000.00);

UPDATE Rooms
SET availability_status = 'Booked'
WHERE room_id = 3;

-- 9. UPDATE QUERY

UPDATE Guests
SET city = 'Rawalpindi'
WHERE guest_id = 2;

-- 10. LIKE QUERY

SELECT * FROM Guests
WHERE guest_name LIKE 'A%';

-- 11. WHERE + AND + OR QUERY

SELECT * FROM Rooms
WHERE room_type = 'Single'
AND price_per_night > 4000;

SELECT * FROM Guests
WHERE city = 'Lahore'
OR city = 'Karachi';

-- 12. LIMIT QUERY

SELECT * FROM Guests
LIMIT 2;

-- 13. DELETE CUSTOMER WHEN LEAVING

DELETE FROM Payments
WHERE reservation_id = 2;

DELETE FROM Reservations
WHERE guest_id = 2;

DELETE FROM Guests
WHERE guest_id = 2;

UPDATE Rooms
SET availability_status = 'Available'
WHERE room_id = 1;

-- 14. DELETE WITH FK RESTRICTION TEST

-- This may give error because FK exists

DELETE FROM Guests
WHERE guest_id = 1;

-- 15. AGGREGATE FUNCTIONS

-- COUNT
SELECT COUNT(*) AS Total_Guests
FROM Guests;

-- AVG
SELECT AVG(price_per_night) AS Average_Room_Price
FROM Rooms;

-- MIN
SELECT MIN(price_per_night) AS Minimum_Room_Price
FROM Rooms;

-- MAX
SELECT MAX(price_per_night) AS Maximum_Room_Price
FROM Rooms;

-- 16. INNER JOIN

SELECT g.guest_name, r.room_number, res.total_amount
FROM Guests g
INNER JOIN Reservations res
ON g.guest_id = res.guest_id
INNER JOIN Rooms r
ON r.room_id = res.room_id;

-- 17. LEFT JOIN

SELECT g.guest_name, res.reservation_id
FROM Guests g
LEFT JOIN Reservations res
ON g.guest_id = res.guest_id;

-- 18. RIGHT JOIN

SELECT g.guest_name, res.reservation_id
FROM Guests g
RIGHT JOIN Reservations res
ON g.guest_id = res.guest_id;

-- 19. FULL OUTER JOIN (MySQL Alternative)

SELECT g.guest_name, res.reservation_id
FROM Guests g
LEFT JOIN Reservations res
ON g.guest_id = res.guest_id

UNION

SELECT g.guest_name, res.reservation_id
FROM Guests g
RIGHT JOIN Reservations res
ON g.guest_id = res.guest_id;



-- 20. DROP DATABASE

DROP DATABASE Hotel_Reservation_System;