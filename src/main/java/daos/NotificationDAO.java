package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import models.Notification;
import utils.DBConnection;

public class NotificationDAO {
    
    // Create a new notification
    public static boolean create(Notification notification) {
        String sql = "INSERT INTO Notification (Content, DateCreated) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, notification.getContent());
            
            // Handle LocalDateTime conversion to SQL Timestamp
            LocalDateTime dateCreated = null;
            if (!notification.getDateCreated().isEmpty()) {
                dateCreated = LocalDateTime.parse(notification.getDateCreated(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            } else {
                dateCreated = LocalDateTime.now();
            }
            ps.setTimestamp(2, Timestamp.valueOf(dateCreated));
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to notification object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    notification.setNotificationID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating notification: " + e.getMessage());
        }
        return false;
    }
    
    // Get a notification by ID
    public static Notification getById(int notificationID) {
        String sql = "SELECT * FROM Notification WHERE NotificationID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, notificationID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationID(rs.getInt("NotificationID"));
                notification.setContent(rs.getString("Content"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    notification.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                return notification;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving notification: " + e.getMessage());
        }
        return null;
    }
    
    // Get all notifications
    public static List<Notification> getAll() {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM Notification ORDER BY DateCreated DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationID(rs.getInt("NotificationID"));
                notification.setContent(rs.getString("Content"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    notification.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                notifications.add(notification);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all notifications: " + e.getMessage());
        }
        return notifications;
    }
    
    // Get recent notifications (limit by count)
    public static List<Notification> getRecent(int limit) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM Notification ORDER BY DateCreated DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationID(rs.getInt("NotificationID"));
                notification.setContent(rs.getString("Content"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    notification.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                notifications.add(notification);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving recent notifications: " + e.getMessage());
        }
        return notifications;
    }
    
    // Update a notification
    public static boolean update(Notification notification) {
        String sql = "UPDATE Notification SET Content = ? WHERE NotificationID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, notification.getContent());
            ps.setInt(2, notification.getNotificationID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating notification: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a notification
    public static boolean delete(int notificationID) {
        String sql = "DELETE FROM Notification WHERE NotificationID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, notificationID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting notification: " + e.getMessage());
        }
        return false;
    }
    
    // Delete notifications older than a specified number of days
    public static boolean deleteOlderThan(int days) {
        String sql = "DELETE FROM Notification WHERE DateCreated < DATE_SUB(NOW(), INTERVAL ? DAY)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, days);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting old notifications: " + e.getMessage());
        }
        return false;
    }
    
    // Count total notifications
    public static int countTotal() {
        String sql = "SELECT COUNT(*) AS TotalNotifications FROM Notification";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt("TotalNotifications");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting notifications: " + e.getMessage());
        }
        return 0;
    }
}
