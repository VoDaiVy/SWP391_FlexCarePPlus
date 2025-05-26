package daos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import models.UserDetail;
import utils.DBConnection;

public class UserDetailDAO {
    
    // Create a new user detail
    public static boolean create(UserDetail userDetail) {
        String sql = "INSERT INTO UserDetail (UserID, FirstName, LastName, Tel, DOB, Gender, Avatar) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userDetail.getUserID());
            ps.setString(2, userDetail.getFirstName());
            ps.setString(3, userDetail.getLastName());
            ps.setString(4, userDetail.getTel());
            
            // Handle LocalDate conversion to SQL Date
            LocalDate dob = null;
            if (!userDetail.getDob().isEmpty()) {
                dob = LocalDate.parse(userDetail.getDob(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }
            ps.setDate(5, dob != null ? Date.valueOf(dob) : null);
            
            ps.setString(6, userDetail.getGender());
            ps.setString(7, userDetail.getAvatar());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error creating user detail: " + e.getMessage());
        }
        return false;
    }
    
    // Get a user detail by user ID
    public static UserDetail getByUserId(int userID) {
        String sql = "SELECT * FROM UserDetail WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                UserDetail userDetail = new UserDetail();
                userDetail.setUserID(rs.getInt("UserID"));
                userDetail.setFirstName(rs.getString("FirstName"));
                userDetail.setLastName(rs.getString("LastName"));
                userDetail.setTel(rs.getString("Tel"));
                
                // Handle SQL Date to LocalDate conversion
                Date dobDate = rs.getDate("DOB");
                if (dobDate != null) {
                    userDetail.setDob(dobDate.toLocalDate());
                }
                
                userDetail.setGender(rs.getString("Gender"));
                userDetail.setAvatar(rs.getString("Avatar"));
                return userDetail;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving user detail: " + e.getMessage());
        }
        return null;
    }
    
    // Update a user detail
    public static boolean update(UserDetail userDetail) {
        String sql = "UPDATE UserDetail SET FirstName = ?, LastName = ?, Tel = ?, DOB = ?, Gender = ?, Avatar = ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, userDetail.getFirstName());
            ps.setString(2, userDetail.getLastName());
            ps.setString(3, userDetail.getTel());
            
            // Handle LocalDate conversion to SQL Date
            LocalDate dob = null;
            if (!userDetail.getDob().isEmpty()) {
                dob = LocalDate.parse(userDetail.getDob(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }
            ps.setDate(4, dob != null ? Date.valueOf(dob) : null);
            
            ps.setString(5, userDetail.getGender());
            ps.setString(6, userDetail.getAvatar());
            ps.setInt(7, userDetail.getUserID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating user detail: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a user detail
    public static boolean delete(int userID) {
        String sql = "DELETE FROM UserDetail WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting user detail: " + e.getMessage());
        }
        return false;
    }
    
    // Check if user detail exists
    public static boolean exists(int userID) {
        String sql = "SELECT COUNT(*) AS Count FROM UserDetail WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("Count") > 0;
            }
            
        } catch (SQLException e) {
            System.out.println("Error checking if user detail exists: " + e.getMessage());
        }
        return false;
    }
    
    // Update user avatar
    public static boolean updateAvatar(int userID, String avatarUrl) {
        String sql = "UPDATE UserDetail SET Avatar = ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, avatarUrl);
            ps.setInt(2, userID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating user avatar: " + e.getMessage());
        }
        return false;
    }
}
