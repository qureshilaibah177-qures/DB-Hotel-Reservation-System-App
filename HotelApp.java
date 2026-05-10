/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javaapplication1;
import javax.swing.*;
import java.awt.*;
import java.sql.*;

/**
 *
 * @author qures
 */



public class HotelApp extends JFrame {
    // CHANGE THIS TO YOUR MYSQL PASSWORD
    String PASS = "LaibahS@33";
    
    // Theme colors
    Color LIGHT_GRAY = new Color(245, 245, 245);
    Color DARK_BLUE = new Color(41, 128, 185);
    
    JTextField nameField, roomField, inField, outField, idField;
    JTextArea output;
    Connection con;

    public HotelApp() {
        setTitle("Hotel Reservation");
        setSize(500, 450);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        getContentPane().setBackground(LIGHT_GRAY);
        
        // Connect DB
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", PASS);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "DB Error: " + e.getMessage());
            System.exit(0);
        }
        
        // UI
        JPanel p = new JPanel(new GridLayout(6, 2, 10, 10));
        p.setBackground(LIGHT_GRAY);
        p.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        p.add(label("Guest Name:")); nameField = field(); p.add(nameField);
        p.add(label("Room ID:")); roomField = field(); p.add(roomField);
        p.add(label("Check-in YYYY-MM-DD:")); inField = field(); p.add(inField);
        p.add(label("Check-out YYYY-MM-DD:")); outField = field(); p.add(outField);
        p.add(label("Booking ID to Cancel:")); idField = field(); p.add(idField);
        
        JButton bookBtn = button("Book Room"); 
        bookBtn.addActionListener(e -> book());
        p.add(bookBtn);
        
        JButton cancelBtn = button("Cancel Booking");
        cancelBtn.addActionListener(e -> cancel());
        p.add(cancelBtn);
        
        output = new JTextArea();
        output.setEditable(false);
        output.setBackground(Color.WHITE);
        JScrollPane scroll = new JScrollPane(output);
        scroll.setBorder(BorderFactory.createTitledBorder("All Bookings"));
        
        JButton viewBtn = button("Refresh Bookings");
        viewBtn.addActionListener(e -> view());
        
        setLayout(new BorderLayout(10, 10));
        add(p, BorderLayout.NORTH);
        add(scroll, BorderLayout.CENTER);
        add(viewBtn, BorderLayout.SOUTH);
        
        view(); // Load bookings on start
    }
    
    JLabel label(String t) {
        JLabel l = new JLabel(t);
        l.setForeground(new Color(44, 62, 80));
        l.setFont(new Font("Segoe UI", Font.PLAIN, 13));
        return l;
    }
    
    JTextField field() {
        JTextField f = new JTextField();
        f.setFont(new Font("Segoe UI", Font.PLAIN, 13));
        return f;
    }
    
    JButton button(String t) {
        JButton b = new JButton(t);
        b.setBackground(DARK_BLUE);
        b.setForeground(Color.WHITE);
        b.setFont(new Font("Segoe UI", Font.BOLD, 12));
        b.setFocusPainted(false);
        b.setBorderPainted(false);
        b.setCursor(new Cursor(Cursor.HAND_CURSOR));
        return b;
    }
    
    void book() {
        try {
            PreparedStatement ps = con.prepareStatement("INSERT INTO Bookings(guest_name,room_id,check_in,check_out) VALUES(?,?,?,?)");
            ps.setString(1, nameField.getText());
            ps.setInt(2, Integer.parseInt(roomField.getText()));
            ps.setString(3, inField.getText());
            ps.setString(4, outField.getText());
            ps.executeUpdate();
            JOptionPane.showMessageDialog(this, "Booked!");
            view();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Error: " + e.getMessage());
        }
    }
    
    void cancel() {
        try {
            con.createStatement().executeUpdate("DELETE FROM Bookings WHERE booking_id=" + idField.getText());
            JOptionPane.showMessageDialog(this, "Cancelled!");
            view();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Error: " + e.getMessage());
        }
    }
    
    void view() {
        try {
            ResultSet rs = con.createStatement().executeQuery("SELECT b.booking_id, b.guest_name, r.room_number, b.check_in, b.check_out FROM Bookings b JOIN Rooms r ON b.room_id=r.room_id");
            output.setText("");
            while(rs.next()) {
                output.append("ID: " + rs.getInt(1) + " | " + rs.getString(2) + " | Room " + rs.getString(3) + " | " + rs.getString(4) + " to " + rs.getString(5) + "\n");
            }
        } catch (Exception e) {
            output.setText("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new HotelApp().setVisible(true));
    }
}
    

