package daos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import models.Policy;
import utils.DBConnection;

public class PolicyDAO {
    
    // Create a new policy
    public static boolean create(Policy policy) {
        String sql = "INSERT INTO Policy (Title, Description, DateCreated, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, policy.getTitle());
            ps.setString(2, policy.getDescription());
            
            // Handle LocalDate conversion to SQL Date
            LocalDate dateCreated = null;
            if (!policy.getDateCreated().isEmpty()) {
                dateCreated = LocalDate.parse(policy.getDateCreated(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            } else {
                dateCreated = LocalDate.now();
            }
            ps.setDate(3, Date.valueOf(dateCreated));
            ps.setBoolean(4, policy.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to policy object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    policy.setPolicyID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating policy: " + e.getMessage());
        }
        return false;
    }
    
    // Get a policy by ID
    public static Policy getById(int policyID) {
        String sql = "SELECT * FROM Policy WHERE PolicyID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, policyID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Policy policy = new Policy();
                policy.setPolicyID(rs.getInt("PolicyID"));
                policy.setTitle(rs.getString("Title"));
                policy.setDescription(rs.getString("Description"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreated = rs.getDate("DateCreated");
                if (dateCreated != null) {
                    policy.setDateCreated(dateCreated.toLocalDate());
                }
                
                policy.setStatus(rs.getBoolean("Status"));
                return policy;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving policy: " + e.getMessage());
        }
        return null;
    }
    
    // Get all policies
    public static List<Policy> getAll() {
        List<Policy> policies = new ArrayList<>();
        String sql = "SELECT * FROM Policy";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Policy policy = new Policy();
                policy.setPolicyID(rs.getInt("PolicyID"));
                policy.setTitle(rs.getString("Title"));
                policy.setDescription(rs.getString("Description"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreated = rs.getDate("DateCreated");
                if (dateCreated != null) {
                    policy.setDateCreated(dateCreated.toLocalDate());
                }
                
                policy.setStatus(rs.getBoolean("Status"));
                policies.add(policy);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all policies: " + e.getMessage());
        }
        return policies;
    }
    
    // Get all active policies
    public static List<Policy> getAllActive() {
        List<Policy> policies = new ArrayList<>();
        String sql = "SELECT * FROM Policy WHERE Status = 1";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Policy policy = new Policy();
                policy.setPolicyID(rs.getInt("PolicyID"));
                policy.setTitle(rs.getString("Title"));
                policy.setDescription(rs.getString("Description"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreated = rs.getDate("DateCreated");
                if (dateCreated != null) {
                    policy.setDateCreated(dateCreated.toLocalDate());
                }
                
                policy.setStatus(rs.getBoolean("Status"));
                policies.add(policy);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving active policies: " + e.getMessage());
        }
        return policies;
    }
    
    // Update a policy
    public static boolean update(Policy policy) {
        String sql = "UPDATE Policy SET Title = ?, Description = ?, Status = ? WHERE PolicyID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, policy.getTitle());
            ps.setString(2, policy.getDescription());
            ps.setBoolean(3, policy.isStatus());
            ps.setInt(4, policy.getPolicyID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating policy: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a policy (soft delete by setting status to false)
    public static boolean delete(int policyID) {
        String sql = "UPDATE Policy SET Status = 0 WHERE PolicyID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, policyID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting policy: " + e.getMessage());
        }
        return false;
    }
    
    // Hard delete a policy (remove from database)
    public static boolean hardDelete(int policyID) {
        String sql = "DELETE FROM Policy WHERE PolicyID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, policyID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error hard deleting policy: " + e.getMessage());
        }
        return false;
    }
    
    // Count total policies
    public static int countTotalPolicies() {
        String sql = "SELECT COUNT(*) AS TotalPolicies FROM Policy";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt("TotalPolicies");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting policies: " + e.getMessage());
        }
        return 0;
    }
    
    // Count active policies
    public static int countActivePolicies() {
        String sql = "SELECT COUNT(*) AS ActivePolicies FROM Policy WHERE Status = 1";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt("ActivePolicies");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting active policies: " + e.getMessage());
        }
        return 0;
    }
}
