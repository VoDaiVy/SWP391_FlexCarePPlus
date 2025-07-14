package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.CategoryService;
import utils.DBConnection;

public class CategoryServiceDAO {
    
    // Create a new category service
    public static boolean create(CategoryService categoryService) {
        String sql = "INSERT INTO CategoryService (Name, Status) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, categoryService.getName());
            ps.setBoolean(2, categoryService.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to categoryService object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    categoryService.setCategoryServiceID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating category service: " + e.getMessage());
        }
        return false;
    }
      // Get a category service by ID
    public static CategoryService getById(int categoryServiceID) {
        String sql = "SELECT * FROM CategoryService WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryServiceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                CategoryService categoryService = new CategoryService();
                categoryService.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                categoryService.setName(rs.getString("Name"));
                categoryService.setStatus(rs.getBoolean("Status"));
                return categoryService;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving category service: " + e.getMessage());
        }
        return null;
    }
      // Get all category services
    public static List<CategoryService> getAll() {
        List<CategoryService> categories = new ArrayList<>();
        String sql = "SELECT * FROM CategoryService";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                CategoryService categoryService = new CategoryService();
                categoryService.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                categoryService.setName(rs.getString("Name"));
                categoryService.setStatus(rs.getBoolean("Status"));
                categories.add(categoryService);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all category services: " + e.getMessage());
        }
        return categories;
    }
      // Get all active category services
    public static List<CategoryService> getAllActive() {
        List<CategoryService> categories = new ArrayList<>();
        String sql = "SELECT * FROM CategoryService WHERE Status = 1";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                CategoryService categoryService = new CategoryService();
                categoryService.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                categoryService.setName(rs.getString("Name"));
                categoryService.setStatus(rs.getBoolean("Status"));
                categories.add(categoryService);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving active category services: " + e.getMessage());
        }
        return categories;
    }
      // Update a category service
    public static boolean update(CategoryService categoryService) {
        String sql = "UPDATE CategoryService SET Name = ?, Status = ? WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoryService.getName());
            ps.setBoolean(2, categoryService.isStatus());
            ps.setInt(3, categoryService.getCategoryServiceID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating category service: " + e.getMessage());
        }
        return false;
    }
      // Delete a category service (soft delete by setting status to false)
    public static boolean delete(int categoryServiceID) {
        String sql = "UPDATE CategoryService SET Status = 0 WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryServiceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting category service: " + e.getMessage());
        }
        return false;
    }
      // Hard delete a category service (remove from database)
    public static boolean hardDelete(int categoryServiceID) {
        String sql = "DELETE FROM CategoryService WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryServiceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error hard deleting category service: " + e.getMessage());
        }
        return false;
    }
      // Count services in a category
    public static int countServices(int categoryServiceID) {
        String sql = "SELECT COUNT(*) AS ServiceCount FROM Service WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryServiceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("ServiceCount");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting services in category: " + e.getMessage());
        }
        return 0;
    }
}
