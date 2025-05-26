package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.Cart;
import utils.DBConnection;

public class CartDAO {
    
    // Create a cart item
    public static boolean create(Cart cart) {
        String sql = "INSERT INTO Cart (UserID, ServiceID, Stock, StatusBooking, Display) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, cart.getUserID());
            ps.setInt(2, cart.getServiceID());
            ps.setInt(3, cart.getStock());
            ps.setBoolean(4, cart.isStatusBooking());
            ps.setBoolean(5, cart.isDisplay());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error creating cart item: " + e.getMessage());
        }
        return false;
    }
    
    // Get a cart item by user ID and service ID
    public static Cart getByUserAndService(int userID, int serviceID) {
        String sql = "SELECT * FROM Cart WHERE UserID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ps.setInt(2, serviceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setUserID(rs.getInt("UserID"));
                cart.setServiceID(rs.getInt("ServiceID"));
                cart.setStock(rs.getInt("Stock"));
                cart.setStatusBooking(rs.getBoolean("StatusBooking"));
                cart.setDisplay(rs.getBoolean("Display"));
                return cart;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving cart item: " + e.getMessage());
        }
        return null;
    }
    
    // Get all cart items for a user
    public static List<Cart> getByUserId(int userID) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE UserID = ? AND Display = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setUserID(rs.getInt("UserID"));
                cart.setServiceID(rs.getInt("ServiceID"));
                cart.setStock(rs.getInt("Stock"));
                cart.setStatusBooking(rs.getBoolean("StatusBooking"));
                cart.setDisplay(rs.getBoolean("Display"));
                cartItems.add(cart);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving user's cart items: " + e.getMessage());
        }
        return cartItems;
    }
    
    // Get all cart items
    public static List<Cart> getAll() {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM Cart";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setUserID(rs.getInt("UserID"));
                cart.setServiceID(rs.getInt("ServiceID"));
                cart.setStock(rs.getInt("Stock"));
                cart.setStatusBooking(rs.getBoolean("StatusBooking"));
                cart.setDisplay(rs.getBoolean("Display"));
                cartItems.add(cart);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all cart items: " + e.getMessage());
        }
        return cartItems;
    }
    
    // Update a cart item
    public static boolean update(Cart cart) {
        String sql = "UPDATE Cart SET Stock = ?, StatusBooking = ?, Display = ? WHERE UserID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, cart.getStock());
            ps.setBoolean(2, cart.isStatusBooking());
            ps.setBoolean(3, cart.isDisplay());
            ps.setInt(4, cart.getUserID());
            ps.setInt(5, cart.getServiceID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating cart item: " + e.getMessage());
        }
        return false;
    }
    
    // Update stock for a cart item
    public static boolean updateStock(int userID, int serviceID, int stock) {
        String sql = "UPDATE Cart SET Stock = ? WHERE UserID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, stock);
            ps.setInt(2, userID);
            ps.setInt(3, serviceID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating cart item stock: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a cart item (hard delete)
    public static boolean delete(int userID, int serviceID) {
        String sql = "DELETE FROM Cart WHERE UserID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ps.setInt(2, serviceID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting cart item: " + e.getMessage());
        }
        return false;
    }
    
    // Soft delete (hide) a cart item by setting Display to false
    public static boolean hideCartItem(int userID, int serviceID) {
        String sql = "UPDATE Cart SET Display = 0 WHERE UserID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ps.setInt(2, serviceID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error hiding cart item: " + e.getMessage());
        }
        return false;
    }
    
    // Clear all items in a user's cart (hard delete)
    public static boolean clearUserCart(int userID) {
        String sql = "DELETE FROM Cart WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error clearing user cart: " + e.getMessage());
        }
        return false;
    }
    
    // Count the number of items in a user's cart
    public static int countUserCartItems(int userID) {
        String sql = "SELECT COUNT(*) AS ItemCount FROM Cart WHERE UserID = ? AND Display = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("ItemCount");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting user's cart items: " + e.getMessage());
        }
        return 0;
    }
    
    // Check if a service exists in a user's cart
    public static boolean existsInCart(int userID, int serviceID) {
        String sql = "SELECT COUNT(*) AS ItemExists FROM Cart WHERE UserID = ? AND ServiceID = ? AND Display = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ps.setInt(2, serviceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("ItemExists") > 0;
            }
            
        } catch (SQLException e) {
            System.out.println("Error checking if service exists in cart: " + e.getMessage());
        }
        return false;
    }
}
