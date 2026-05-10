DROP DATABASE IF EXISTS hotel_db;
CREATE DATABASE hotel_db;
USE hotel_db;
SELECT * FROM BOOKINGS;
CREATE TABLE Rooms (room_id INT AUTO_INCREMENT PRIMARY KEY, room_number VARCHAR(10), price_per_night INT);
CREATE TABLE Bookings (booking_id INT AUTO_INCREMENT PRIMARY KEY, guest_name VARCHAR(100), room_id INT, check_in DATE, check_out DATE);
INSERT INTO Rooms VALUES 
(1,'101',100), (2,'102',100), (3,'201',200),
(4,'202',200), (5,'301',300), (6,'302',300),
(7,'103',120), (8,'104',120), (9,'203',220),
(10,'204',220), (11,'303',320), (12,'304',320),
(13,'401',400), (14,'402',400), (15,'501',500);