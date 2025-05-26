package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.ServiceImage;
import utils.DBConnection;

public class ServiceImageDAO {
    
    // Create a new service image
    public static boolean create(ServiceImage serviceImage) {
        String sql = "INSERT INTO ServiceImage (ServiceID, ImgURL) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, serviceImage.getServiceID());
            ps.setString(2, serviceImage.getImgURL());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to serviceImage object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    serviceImage.setServiceImageID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating service image: " + e.getMessage());
        }
        return false;
    }
    
    // Get a service image by ID
    public static ServiceImage getById(int serviceImageID) {
        String sql = "SELECT * FROM ServiceImage WHERE ServiceImageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceImageID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                ServiceImage serviceImage = new ServiceImage();
                serviceImage.setServiceImageID(rs.getInt("ServiceImageID"));
                serviceImage.setServiceID(rs.getInt("ServiceID"));
                serviceImage.setImgURL(rs.getString("ImgURL"));
                return serviceImage;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving service image: " + e.getMessage());
        }
        return null;
    }
    
    // Get all images for a specific service
    public static List<ServiceImage> getByServiceId(int serviceID) {
        List<ServiceImage> serviceImages = new ArrayList<>();
        String sql = "SELECT * FROM ServiceImage WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ServiceImage serviceImage = new ServiceImage();
                serviceImage.setServiceImageID(rs.getInt("ServiceImageID"));
                serviceImage.setServiceID(rs.getInt("ServiceID"));
                serviceImage.setImgURL(rs.getString("ImgURL"));
                serviceImages.add(serviceImage);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving service images by service ID: " + e.getMessage());
        }
        return serviceImages;
    }
    
    // Update a service image
    public static boolean update(ServiceImage serviceImage) {
        String sql = "UPDATE ServiceImage SET ServiceID = ?, ImgURL = ? WHERE ServiceImageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceImage.getServiceID());
            ps.setString(2, serviceImage.getImgURL());
            ps.setInt(3, serviceImage.getServiceImageID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating service image: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a service image
    public static boolean delete(int serviceImageID) {
        String sql = "DELETE FROM ServiceImage WHERE ServiceImageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceImageID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting service image: " + e.getMessage());
        }
        return false;
    }
    
    // Delete all images for a specific service
    public static boolean deleteByServiceId(int serviceID) {
        String sql = "DELETE FROM ServiceImage WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting service images by service ID: " + e.getMessage());
        }
        return false;
    }
}
