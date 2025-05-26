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
import models.Message;
import utils.DBConnection;

public class MessageDAO {
    
    // Create a new message
    public static boolean create(Message message) {
        String sql = "INSERT INTO Message (UserID, UserReceiveID, TimeChat, Content, Status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, message.getUserID());
            ps.setInt(2, message.getUserReceiveID());
            
            // Handle LocalDateTime conversion to SQL Timestamp
            LocalDateTime timeChat = null;
            if (!message.getTimeChat().isEmpty()) {
                timeChat = LocalDateTime.parse(message.getTimeChat(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            } else {
                timeChat = LocalDateTime.now();
            }
            ps.setTimestamp(3, Timestamp.valueOf(timeChat));
            
            ps.setString(4, message.getContent());
            ps.setBoolean(5, message.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to message object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    message.setMessageID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating message: " + e.getMessage());
        }
        return false;
    }
    
    // Get a message by ID
    public static Message getById(int messageID) {
        String sql = "SELECT * FROM Message WHERE MessageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, messageID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Message message = new Message();
                message.setMessageID(rs.getInt("MessageID"));
                message.setUserID(rs.getInt("UserID"));
                message.setUserReceiveID(rs.getInt("UserReceiveID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp timeChatTimestamp = rs.getTimestamp("TimeChat");
                if (timeChatTimestamp != null) {
                    message.setTimeChat(timeChatTimestamp.toLocalDateTime());
                }
                
                message.setContent(rs.getString("Content"));
                message.setStatus(rs.getBoolean("Status"));
                return message;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving message: " + e.getMessage());
        }
        return null;
    }
    
    // Get messages between two users
    public static List<Message> getMessagesBetweenUsers(int userID1, int userID2) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM Message WHERE (UserID = ? AND UserReceiveID = ?) OR (UserID = ? AND UserReceiveID = ?) " +
                     "ORDER BY TimeChat ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID1);
            ps.setInt(2, userID2);
            ps.setInt(3, userID2);
            ps.setInt(4, userID1);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Message message = new Message();
                message.setMessageID(rs.getInt("MessageID"));
                message.setUserID(rs.getInt("UserID"));
                message.setUserReceiveID(rs.getInt("UserReceiveID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp timeChatTimestamp = rs.getTimestamp("TimeChat");
                if (timeChatTimestamp != null) {
                    message.setTimeChat(timeChatTimestamp.toLocalDateTime());
                }
                
                message.setContent(rs.getString("Content"));
                message.setStatus(rs.getBoolean("Status"));
                messages.add(message);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving messages between users: " + e.getMessage());
        }
        return messages;
    }
    
    // Get messages sent by a user
    public static List<Message> getMessagesByUser(int userID) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM Message WHERE UserID = ? ORDER BY TimeChat DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Message message = new Message();
                message.setMessageID(rs.getInt("MessageID"));
                message.setUserID(rs.getInt("UserID"));
                message.setUserReceiveID(rs.getInt("UserReceiveID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp timeChatTimestamp = rs.getTimestamp("TimeChat");
                if (timeChatTimestamp != null) {
                    message.setTimeChat(timeChatTimestamp.toLocalDateTime());
                }
                
                message.setContent(rs.getString("Content"));
                message.setStatus(rs.getBoolean("Status"));
                messages.add(message);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving messages by user: " + e.getMessage());
        }
        return messages;
    }
    
    // Get messages received by a user
    public static List<Message> getMessagesToUser(int userReceiveID) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM Message WHERE UserReceiveID = ? ORDER BY TimeChat DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userReceiveID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Message message = new Message();
                message.setMessageID(rs.getInt("MessageID"));
                message.setUserID(rs.getInt("UserID"));
                message.setUserReceiveID(rs.getInt("UserReceiveID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp timeChatTimestamp = rs.getTimestamp("TimeChat");
                if (timeChatTimestamp != null) {
                    message.setTimeChat(timeChatTimestamp.toLocalDateTime());
                }
                
                message.setContent(rs.getString("Content"));
                message.setStatus(rs.getBoolean("Status"));
                messages.add(message);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving messages to user: " + e.getMessage());
        }
        return messages;
    }
    
    // Get unread messages count for a user
    public static int getUnreadMessageCount(int userReceiveID) {
        String sql = "SELECT COUNT(*) AS UnreadCount FROM Message WHERE UserReceiveID = ? AND Status = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userReceiveID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("UnreadCount");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting unread messages: " + e.getMessage());
        }
        return 0;
    }
    
    // Mark a message as read
    public static boolean markAsRead(int messageID) {
        String sql = "UPDATE Message SET Status = 1 WHERE MessageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, messageID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error marking message as read: " + e.getMessage());
        }
        return false;
    }
    
    // Mark all messages as read between two users
    public static boolean markAllAsRead(int userID, int userReceiveID) {
        String sql = "UPDATE Message SET Status = 1 WHERE UserID = ? AND UserReceiveID = ? AND Status = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ps.setInt(2, userReceiveID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error marking all messages as read: " + e.getMessage());
        }
        return false;
    }
    
    // Update a message's content
    public static boolean update(Message message) {
        String sql = "UPDATE Message SET Content = ? WHERE MessageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, message.getContent());
            ps.setInt(2, message.getMessageID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating message: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a message
    public static boolean delete(int messageID) {
        String sql = "DELETE FROM Message WHERE MessageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, messageID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting message: " + e.getMessage());
        }
        return false;
    }
    
    // Delete all messages between two users
    public static boolean deleteAllMessagesBetweenUsers(int userID1, int userID2) {
        String sql = "DELETE FROM Message WHERE (UserID = ? AND UserReceiveID = ?) OR (UserID = ? AND UserReceiveID = ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID1);
            ps.setInt(2, userID2);
            ps.setInt(3, userID2);
            ps.setInt(4, userID1);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting messages between users: " + e.getMessage());
        }
        return false;
    }
}
