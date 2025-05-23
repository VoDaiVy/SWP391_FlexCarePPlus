package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.WalletTransfer;
import utils.DBConnection;

public class WalletTransferDAO {
    
    // Create a new wallet transfer record
    public boolean create(WalletTransfer transfer) {
        String sql = "INSERT INTO WalletTransfer (TransCode, TimeCode, UserID, IsRefunded, Amount, Content) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, transfer.getTransCode());
            ps.setString(2, transfer.getTimeCode());
            ps.setInt(3, transfer.getUserID());
            ps.setBoolean(4, transfer.isIsRefunded());
            ps.setFloat(5, transfer.getAmount());
            ps.setString(6, transfer.getContent());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to transfer object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    transfer.setWalletTransferID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating wallet transfer: " + e.getMessage());
        }
        return false;
    }
    
    // Get a wallet transfer by ID
    public WalletTransfer getById(int walletTransferID) {
        String sql = "SELECT * FROM WalletTransfer WHERE WalletTransferID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, walletTransferID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                WalletTransfer transfer = new WalletTransfer();
                transfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                transfer.setTransCode(rs.getString("TransCode"));
                transfer.setTimeCode(rs.getString("TimeCode"));
                transfer.setUserID(rs.getInt("UserID"));
                transfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                transfer.setAmount(rs.getFloat("Amount"));
                transfer.setContent(rs.getString("Content"));
                return transfer;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving wallet transfer: " + e.getMessage());
        }
        return null;
    }
    
    // Get a wallet transfer by transaction code
    public WalletTransfer getByTransCode(String transCode) {
        String sql = "SELECT * FROM WalletTransfer WHERE TransCode = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, transCode);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                WalletTransfer transfer = new WalletTransfer();
                transfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                transfer.setTransCode(rs.getString("TransCode"));
                transfer.setTimeCode(rs.getString("TimeCode"));
                transfer.setUserID(rs.getInt("UserID"));
                transfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                transfer.setAmount(rs.getFloat("Amount"));
                transfer.setContent(rs.getString("Content"));
                return transfer;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving wallet transfer by transaction code: " + e.getMessage());
        }
        return null;
    }
    
    // Get all wallet transfers
    public List<WalletTransfer> getAll() {
        List<WalletTransfer> transfers = new ArrayList<>();
        String sql = "SELECT * FROM WalletTransfer";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                WalletTransfer transfer = new WalletTransfer();
                transfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                transfer.setTransCode(rs.getString("TransCode"));
                transfer.setTimeCode(rs.getString("TimeCode"));
                transfer.setUserID(rs.getInt("UserID"));
                transfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                transfer.setAmount(rs.getFloat("Amount"));
                transfer.setContent(rs.getString("Content"));
                transfers.add(transfer);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all wallet transfers: " + e.getMessage());
        }
        return transfers;
    }
    
    // Get transfers by user ID
    public List<WalletTransfer> getByUserId(int userID) {
        List<WalletTransfer> transfers = new ArrayList<>();
        String sql = "SELECT * FROM WalletTransfer WHERE UserID = ? ORDER BY TimeCode DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                WalletTransfer transfer = new WalletTransfer();
                transfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                transfer.setTransCode(rs.getString("TransCode"));
                transfer.setTimeCode(rs.getString("TimeCode"));
                transfer.setUserID(rs.getInt("UserID"));
                transfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                transfer.setAmount(rs.getFloat("Amount"));
                transfer.setContent(rs.getString("Content"));
                transfers.add(transfer);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving wallet transfers by user ID: " + e.getMessage());
        }
        return transfers;
    }
    
    // Update a wallet transfer
    public boolean update(WalletTransfer transfer) {
        String sql = "UPDATE WalletTransfer SET TransCode = ?, TimeCode = ?, UserID = ?, IsRefunded = ?, Amount = ?, Content = ? WHERE WalletTransferID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, transfer.getTransCode());
            ps.setString(2, transfer.getTimeCode());
            ps.setInt(3, transfer.getUserID());
            ps.setBoolean(4, transfer.isIsRefunded());
            ps.setFloat(5, transfer.getAmount());
            ps.setString(6, transfer.getContent());
            ps.setInt(7, transfer.getWalletTransferID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating wallet transfer: " + e.getMessage());
        }
        return false;
    }
    
    // Mark a transfer as refunded
    public boolean markAsRefunded(int walletTransferID) {
        String sql = "UPDATE WalletTransfer SET IsRefunded = 1 WHERE WalletTransferID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, walletTransferID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error marking transfer as refunded: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a wallet transfer
    public boolean delete(int walletTransferID) {
        String sql = "DELETE FROM WalletTransfer WHERE WalletTransferID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, walletTransferID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting wallet transfer: " + e.getMessage());
        }
        return false;
    }
    
    // Get total amount transferred by a user
    public float getTotalAmountByUserId(int userID) {
        String sql = "SELECT SUM(Amount) AS TotalAmount FROM WalletTransfer WHERE UserID = ? AND IsRefunded = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getFloat("TotalAmount");
            }
            
        } catch (SQLException e) {
            System.out.println("Error getting total transfer amount: " + e.getMessage());
        }
        return 0;
    }
    
    // Get recent wallet transfers by user ID (with limit)
    public List<WalletTransfer> getRecentByUserId(int userID, int limit) {
        List<WalletTransfer> transfers = new ArrayList<>();
        String sql = "SELECT * FROM WalletTransfer WHERE UserID = ? ORDER BY TimeCode DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                WalletTransfer transfer = new WalletTransfer();
                transfer.setWalletTransferID(rs.getInt("WalletTransferID"));
                transfer.setTransCode(rs.getString("TransCode"));
                transfer.setTimeCode(rs.getString("TimeCode"));
                transfer.setUserID(rs.getInt("UserID"));
                transfer.setIsRefunded(rs.getBoolean("IsRefunded"));
                transfer.setAmount(rs.getFloat("Amount"));
                transfer.setContent(rs.getString("Content"));
                transfers.add(transfer);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving recent wallet transfers: " + e.getMessage());
        }
        return transfers;
    }
}
