package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.Service;
import utils.DBConnection;

public class ServiceDAO {
    
    // Create a new service
    public static boolean create(Service service) {
        String sql = "INSERT INTO Service (CategoryServiceID, Name, Description, Price, Time, Views, ImgURL, Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, service.getCategoryServiceID());
            ps.setString(2, service.getName());
            ps.setString(3, service.getDescription());
            ps.setFloat(4, service.getPrice());
            ps.setInt(5, service.getTime());
            ps.setInt(6, service.getViews());
            ps.setString(7, service.getImgURL());
            ps.setBoolean(8, service.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to service object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    service.setServiceID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating service: " + e.getMessage());
        }
        return false;
    }
      // Get a service by ID
    public static Service getById(int serviceID) {
        String sql = "SELECT * FROM Service WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                return service;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving service: " + e.getMessage());
        }
        return null;
    }
      // Get all services
    public static List<Service> getAll() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all services: " + e.getMessage());
        }
        return services;
    }
      // Get services by category ID
    public static List<Service> getByCategoryId(int categoryServiceID) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryServiceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving services by category ID: " + e.getMessage());
        }
        return services;
    }
      // Update a service
    public static boolean update(Service service) {
        String sql = "UPDATE Service SET CategoryServiceID = ?, Name = ?, Description = ?, Price = ?, Time = ?, Views = ?, ImgURL = ?, Status = ? WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, service.getCategoryServiceID());
            ps.setString(2, service.getName());
            ps.setString(3, service.getDescription());
            ps.setFloat(4, service.getPrice());
            ps.setInt(5, service.getTime());
            ps.setInt(6, service.getViews());
            ps.setString(7, service.getImgURL());
            ps.setBoolean(8, service.isStatus());
            ps.setInt(9, service.getServiceID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating service: " + e.getMessage());
        }
        return false;
    }
      // Delete a service (soft delete by setting status to false)
    public static boolean delete(int serviceID) {
        String sql = "UPDATE Service SET Status = 0 WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting service: " + e.getMessage());
        }
        return false;
    }
      // Hard delete a service (remove from database)
    public static boolean hardDelete(int serviceID) {
        String sql = "DELETE FROM Service WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error hard deleting service: " + e.getMessage());
        }
        return false;
    }
      // Search services by name (partial match)
    public static List<Service> searchByName(String keyword) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE Name LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }
            
        } catch (SQLException e) {
            System.out.println("Error searching services by name: " + e.getMessage());
        }
        return services;
    }
      // Increment view count for a service
    public static boolean incrementViews(int serviceID) {
        String sql = "UPDATE Service SET Views = Views + 1 WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error incrementing views: " + e.getMessage());
        }
        return false;
    }
    
    // Get most viewed services
    public List<Service> getMostViewed(int limit) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE Status = 1 ORDER BY Views DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving most viewed services: " + e.getMessage());
        }
        return services;
    }
}
