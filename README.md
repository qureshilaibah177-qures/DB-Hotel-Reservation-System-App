# DB-Hotel-Reservation-System-App
A Java-based desktop application that streamlines hotel operations by integrating a professional Swing GUI with a MySQL database to manage real-time guest bookings and room inventory.
# Project Overview
A full-stack desktop application that automates hotel room management. It bridges a Java Swing GUI with a MySQL database to allow front-desk staff to book, view, and cancel reservations in real-time.
# Key Features
Automated Booking: Input guest details and link them to specific Room IDs.

Live Dashboard: Real-time display of all active bookings using SQL Joins.

Inventory Tracking: Pre-configured room list with varying price points.

Dynamic Cancellation: Remove records instantly using unique Booking IDs.

# Backend (MySQL):
hotel_db database.
Rooms table (Static inventory).
Bookings table (Transactional guest data).

# Frontend (Java):
Swing API: For the window, buttons, and text fields.
JDBC (Java Database Connectivity): The bridge that executes SQL commands from within Java code.
