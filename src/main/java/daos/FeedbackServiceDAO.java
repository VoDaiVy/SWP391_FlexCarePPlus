package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import models.FeedbackService;
import utils.DBConnection;

public class FeedbackServiceDAO {
    
    // Create a new feedback
    public static boolean create(FeedbackService feedback) {
        String sql = "INSERT INTO FeedbackService (UserID, BookingID, ServiceID, DateCreated, Rating, Comment, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, feedback.getUserID());
            ps.setInt(2, feedback.getBookingID());
            ps.setInt(3, feedback.getServiceID());
            
            // Set current time if dateCreated is null
            if (feedback.getDateCreated().isEmpty()) {
                ps.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            } else {
                ps.setTimestamp(4, Timestamp.valueOf(LocalDateTime.parse(feedback.getDateCreated(), 
                        java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))));
            }
            
            ps.setInt(5, feedback.getRating());
            ps.setString(6, feedback.getComment());
            ps.setBoolean(7, feedback.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to feedback object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    feedback.setFeedbackServiceID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating feedback: " + e.getMessage());
        }
        return false;
    }
      // Get a feedback by ID
    public static FeedbackService getById(int feedbackServiceID) {
        String sql = "SELECT * FROM FeedbackService WHERE FeedbackServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, feedbackServiceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                FeedbackService feedback = new FeedbackService();
                feedback.setFeedbackServiceID(rs.getInt("FeedbackServiceID"));
                feedback.setUserID(rs.getInt("UserID"));
                feedback.setBookingID(rs.getInt("BookingID"));
                feedback.setServiceID(rs.getInt("ServiceID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    feedback.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setStatus(rs.getBoolean("Status"));
                return feedback;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving feedback: " + e.getMessage());
        }
        return null;
    }
      // Get all feedbacks
    public static List<FeedbackService> getAll() {
        List<FeedbackService> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM FeedbackService";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                FeedbackService feedback = new FeedbackService();
                feedback.setFeedbackServiceID(rs.getInt("FeedbackServiceID"));
                feedback.setUserID(rs.getInt("UserID"));
                feedback.setBookingID(rs.getInt("BookingID"));
                feedback.setServiceID(rs.getInt("ServiceID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    feedback.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedbacks.add(feedback);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all feedbacks: " + e.getMessage());
        }
        return feedbacks;
    }
      // Get feedbacks by service ID
    public static List<FeedbackService> getByServiceId(int serviceID) {
        List<FeedbackService> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM FeedbackService WHERE ServiceID = ? AND Status = 1 ORDER BY DateCreated DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                FeedbackService feedback = new FeedbackService();
                feedback.setFeedbackServiceID(rs.getInt("FeedbackServiceID"));
                feedback.setUserID(rs.getInt("UserID"));
                feedback.setBookingID(rs.getInt("BookingID"));
                feedback.setServiceID(rs.getInt("ServiceID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    feedback.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedbacks.add(feedback);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving feedbacks by service ID: " + e.getMessage());
        }
        return feedbacks;
    }
      // Get feedbacks by user ID
    public static List<FeedbackService> getByUserId(int userID) {
        List<FeedbackService> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM FeedbackService WHERE UserID = ? ORDER BY DateCreated DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                FeedbackService feedback = new FeedbackService();
                feedback.setFeedbackServiceID(rs.getInt("FeedbackServiceID"));
                feedback.setUserID(rs.getInt("UserID"));
                feedback.setBookingID(rs.getInt("BookingID"));
                feedback.setServiceID(rs.getInt("ServiceID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    feedback.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedbacks.add(feedback);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving feedbacks by user ID: " + e.getMessage());
        }
        return feedbacks;
    }
      // Update a feedback
    public static boolean update(FeedbackService feedback) {
        String sql = "UPDATE FeedbackService SET UserID = ?, BookingID = ?, ServiceID = ?, Rating = ?, Comment = ?, Status = ? WHERE FeedbackServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, feedback.getUserID());
            ps.setInt(2, feedback.getBookingID());
            ps.setInt(3, feedback.getServiceID());
            ps.setInt(4, feedback.getRating());
            ps.setString(5, feedback.getComment());
            ps.setBoolean(6, feedback.isStatus());
            ps.setInt(7, feedback.getFeedbackServiceID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating feedback: " + e.getMessage());
        }
        return false;
    }
      // Delete a feedback (soft delete by setting status to false)
    public static boolean delete(int feedbackServiceID) {
        String sql = "UPDATE FeedbackService SET Status = 0 WHERE FeedbackServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, feedbackServiceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting feedback: " + e.getMessage());
        }
        return false;
    }
      // Hard delete a feedback (remove from database)
    public static boolean hardDelete(int feedbackServiceID) {
        String sql = "DELETE FROM FeedbackService WHERE FeedbackServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, feedbackServiceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error hard deleting feedback: " + e.getMessage());
        }
        return false;
    }
      // Get average rating for a service
    public static double getAverageRatingForService(int serviceID) {
        String sql = "SELECT AVG(Rating) AS AverageRating FROM FeedbackService WHERE ServiceID = ? AND Status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("AverageRating");
            }
            
        } catch (SQLException e) {
            System.out.println("Error getting average rating: " + e.getMessage());
        }
        return 0;
    }
      // Count feedbacks for a service
    public static int countFeedbacksForService(int serviceID) {
        String sql = "SELECT COUNT(*) AS FeedbackCount FROM FeedbackService WHERE ServiceID = ? AND Status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("FeedbackCount");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting feedbacks: " + e.getMessage());
        }
        return 0;
    }

      // Get feedbacks by service ID
    public static List<FeedbackService> adminGetByServiceId(int serviceID) {
        List<FeedbackService> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM FeedbackService WHERE ServiceID = ? ORDER BY DateCreated DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                FeedbackService feedback = new FeedbackService();
                feedback.setFeedbackServiceID(rs.getInt("FeedbackServiceID"));
                feedback.setUserID(rs.getInt("UserID"));
                feedback.setBookingID(rs.getInt("BookingID"));
                feedback.setServiceID(rs.getInt("ServiceID"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateCreatedTimestamp = rs.getTimestamp("DateCreated");
                if (dateCreatedTimestamp != null) {
                    feedback.setDateCreated(dateCreatedTimestamp.toLocalDateTime());
                }
                
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setStatus(rs.getBoolean("Status"));
                feedbacks.add(feedback);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving feedbacks by service ID: " + e.getMessage());
        }
        return feedbacks;
    }
}
