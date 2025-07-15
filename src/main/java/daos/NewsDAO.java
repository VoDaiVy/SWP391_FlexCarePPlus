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
import models.News;
import utils.DBConnection;

public class NewsDAO {
    
    // Create a new news
    public static boolean create(News news) {
        String sql = "INSERT INTO News (Title, Description, Views, ImgURL, DateCreated, Status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getDescription());
            ps.setInt(3, news.getViews());
            ps.setString(4, news.getImgURL());
            
            // Handle LocalDate conversion to SQL Date
            LocalDate dateCreated = null;
            if (!news.getDateCreated().isEmpty()) {
                dateCreated = LocalDate.parse(news.getDateCreated(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }
            ps.setDate(5, dateCreated != null ? Date.valueOf(dateCreated) : null);
            
            ps.setBoolean(6, news.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to news object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    news.setNewsID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating news: " + e.getMessage());
        }
        return false;
    }
    
    // Get a news by ID
    public static News getById(int newsID) {
        String sql = "SELECT * FROM News WHERE NewsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setTitle(rs.getString("Title"));
                news.setDescription(rs.getString("Description"));
                news.setViews(rs.getInt("Views"));
                news.setImgURL(rs.getString("ImgURL"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreatedDate = rs.getDate("DateCreated");
                if (dateCreatedDate != null) {
                    news.setDateCreated(dateCreatedDate.toLocalDate());
                }
                
                news.setStatus(rs.getBoolean("Status"));
                return news;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving news: " + e.getMessage());
        }
        return null;
    }
    
    // Get all news
    public static List<News> getAll() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM News";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setTitle(rs.getString("Title"));
                news.setDescription(rs.getString("Description"));
                news.setViews(rs.getInt("Views"));
                news.setImgURL(rs.getString("ImgURL"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreatedDate = rs.getDate("DateCreated");
                if (dateCreatedDate != null) {
                    news.setDateCreated(dateCreatedDate.toLocalDate());
                }
                
                news.setStatus(rs.getBoolean("Status"));
                newsList.add(news);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all news: " + e.getMessage());
        }
        return newsList;
    }
    
    // Get active news
    public static List<News> getAllActive() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM News WHERE Status = 1 ORDER BY DateCreated DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setTitle(rs.getString("Title"));
                news.setDescription(rs.getString("Description"));
                news.setViews(rs.getInt("Views"));
                news.setImgURL(rs.getString("ImgURL"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreatedDate = rs.getDate("DateCreated");
                if (dateCreatedDate != null) {
                    news.setDateCreated(dateCreatedDate.toLocalDate());
                }
                
                news.setStatus(rs.getBoolean("Status"));
                newsList.add(news);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving active news: " + e.getMessage());
        }
        return newsList;
    }
    
    // Update a news
    public static boolean update(News news) {
        String sql = "UPDATE News SET Title = ?, Description = ?, Views = ?, ImgURL = ?, DateCreated = ?, Status = ? WHERE NewsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getDescription());
            ps.setInt(3, news.getViews());
            ps.setString(4, news.getImgURL());
            
            // Handle LocalDate conversion to SQL Date
            LocalDate dateCreated = null;
            if (!news.getDateCreated().isEmpty()) {
                dateCreated = LocalDate.parse(news.getDateCreated(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }
            ps.setDate(5, dateCreated != null ? Date.valueOf(dateCreated) : null);
            
            ps.setBoolean(6, news.isStatus());
            ps.setInt(7, news.getNewsID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating news: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a news (soft delete by setting status to false)
    public static boolean delete(int newsID) {
        String sql = "UPDATE News SET Status = 0 WHERE NewsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting news: " + e.getMessage());
        }
        return false;
    }
    
    // Hard delete a news (remove from database)
    public static boolean hardDelete(int newsID) {
        String sql = "DELETE FROM News WHERE NewsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error hard deleting news: " + e.getMessage());
        }
        return false;
    }
    
    // Increment view count for a news
    public static boolean incrementViews(int newsID) {
        String sql = "UPDATE News SET Views = Views + 1 WHERE NewsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newsID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error incrementing views: " + e.getMessage());
        }
        return false;
    }
    
    // Get recent news with limit
    public static List<News> getRecent(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM News WHERE Status = 1 ORDER BY DateCreated DESC";
        try (Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {
      
            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setTitle(rs.getString("Title"));
                news.setDescription(rs.getString("Description"));
                news.setViews(rs.getInt("Views"));
                news.setImgURL(rs.getString("ImgURL"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreatedDate = rs.getDate("DateCreated");
                if (dateCreatedDate != null) {
                    news.setDateCreated(dateCreatedDate.toLocalDate());
                }
                
                news.setStatus(rs.getBoolean("Status"));
                newsList.add(news);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving recent news: " + e.getMessage());
        }
        return newsList;
    }
    
    // Search news by title (partial match)
    public static List<News> searchByTitle(String keyword) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM News WHERE Title LIKE ? AND Status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setTitle(rs.getString("Title"));
                news.setDescription(rs.getString("Description"));
                news.setViews(rs.getInt("Views"));
                news.setImgURL(rs.getString("ImgURL"));
                
                // Handle SQL Date to LocalDate conversion
                Date dateCreatedDate = rs.getDate("DateCreated");
                if (dateCreatedDate != null) {
                    news.setDateCreated(dateCreatedDate.toLocalDate());
                }
                
                news.setStatus(rs.getBoolean("Status"));
                newsList.add(news);
            }
            
        } catch (SQLException e) {
            System.out.println("Error searching news by title: " + e.getMessage());
        }
        return newsList;
    }
}
