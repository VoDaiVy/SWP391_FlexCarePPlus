package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.NewsImage;
import utils.DBConnection;

public class NewsImageDAO {
    
    // Create a new news image
    public static boolean create(NewsImage newsImage) {
        String sql = "INSERT INTO NewsImage (NewsID, ImgURL) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, newsImage.getNewsID());
            ps.setString(2, newsImage.getImgURL());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to newsImage object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    newsImage.setNewsImageID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating news image: " + e.getMessage());
        }
        return false;
    }
    
    // Get a news image by ID
    public static NewsImage getById(int newsImageID) {
        String sql = "SELECT * FROM NewsImage WHERE NewsImageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsImageID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                NewsImage newsImage = new NewsImage();
                newsImage.setNewsImageID(rs.getInt("NewsImageID"));
                newsImage.setNewsID(rs.getInt("NewsID"));
                newsImage.setImgURL(rs.getString("ImgURL"));
                return newsImage;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving news image: " + e.getMessage());
        }
        return null;
    }
    
    // Get all images for a specific news
    public static List<NewsImage> getByNewsId(int newsID) {
        List<NewsImage> newsImages = new ArrayList<>();
        String sql = "SELECT * FROM NewsImage WHERE NewsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                NewsImage newsImage = new NewsImage();
                newsImage.setNewsImageID(rs.getInt("NewsImageID"));
                newsImage.setNewsID(rs.getInt("NewsID"));
                newsImage.setImgURL(rs.getString("ImgURL"));
                newsImages.add(newsImage);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving news images by news ID: " + e.getMessage());
        }
        return newsImages;
    }
    
    // Update a news image
    public static boolean update(NewsImage newsImage) {
        String sql = "UPDATE NewsImage SET NewsID = ?, ImgURL = ? WHERE NewsImageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsImage.getNewsID());
            ps.setString(2, newsImage.getImgURL());
            ps.setInt(3, newsImage.getNewsImageID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating news image: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a news image
    public static boolean delete(int newsImageID) {
        String sql = "DELETE FROM NewsImage WHERE NewsImageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsImageID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting news image: " + e.getMessage());
        }
        return false;
    }
    
    // Delete all images for a specific news
    public static boolean deleteByNewsId(int newsID) {
        String sql = "DELETE FROM NewsImage WHERE NewsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting news images by news ID: " + e.getMessage());
        }
        return false;
    }
}
