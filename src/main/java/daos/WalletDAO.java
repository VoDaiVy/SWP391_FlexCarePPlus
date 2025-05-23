package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.Wallet;
import utils.DBConnection;

public class WalletDAO {
    
    // Create a new wallet
    public static boolean create(Wallet wallet) {
        String sql = "INSERT INTO Wallet (UserID, Amount, Status) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, wallet.getUserID());
            ps.setFloat(2, wallet.getAmount());
            ps.setBoolean(3, wallet.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error creating wallet: " + e.getMessage());
        }
        return false;
    }
      // Get a wallet by user ID
    public static Wallet getByUserId(int userID) {
        String sql = "SELECT * FROM Wallet WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Wallet wallet = new Wallet();
                wallet.setUserID(rs.getInt("UserID"));
                wallet.setAmount(rs.getFloat("Amount"));
                wallet.setStatus(rs.getBoolean("Status"));
                return wallet;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving wallet: " + e.getMessage());
        }
        return null;
    }
      // Get all wallets
    public static List<Wallet> getAll() {
        List<Wallet> wallets = new ArrayList<>();
        String sql = "SELECT * FROM Wallet";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Wallet wallet = new Wallet();
                wallet.setUserID(rs.getInt("UserID"));
                wallet.setAmount(rs.getFloat("Amount"));
                wallet.setStatus(rs.getBoolean("Status"));
                wallets.add(wallet);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all wallets: " + e.getMessage());
        }
        return wallets;
    }
      // Update a wallet
    public static boolean update(Wallet wallet) {
        String sql = "UPDATE Wallet SET Amount = ?, Status = ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setFloat(1, wallet.getAmount());
            ps.setBoolean(2, wallet.isStatus());
            ps.setInt(3, wallet.getUserID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating wallet: " + e.getMessage());
        }
        return false;
    }
      // Delete a wallet
    public static boolean delete(int userID) {
        String sql = "DELETE FROM Wallet WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting wallet: " + e.getMessage());
        }
        return false;
    }
      // Disable a wallet (set status to false)
    public static boolean disable(int userID) {
        String sql = "UPDATE Wallet SET Status = 0 WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error disabling wallet: " + e.getMessage());
        }
        return false;
    }
      // Enable a wallet (set status to true)
    public static boolean enable(int userID) {
        String sql = "UPDATE Wallet SET Status = 1 WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error enabling wallet: " + e.getMessage());
        }
        return false;
    }
      // Add funds to wallet
    public static boolean addFunds(int userID, float amount) {
        String sql = "UPDATE Wallet SET Amount = Amount + ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setFloat(1, amount);
            ps.setInt(2, userID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error adding funds to wallet: " + e.getMessage());
        }
        return false;
    }
      // Withdraw funds from wallet
    public static boolean withdrawFunds(int userID, float amount) {
        // First check if user has enough funds
        Wallet wallet = getByUserId(userID);
        if (wallet == null || wallet.getAmount() < amount) {
            return false;
        }
        
        String sql = "UPDATE Wallet SET Amount = Amount - ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setFloat(1, amount);
            ps.setInt(2, userID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error withdrawing funds from wallet: " + e.getMessage());
        }
        return false;
    }
      // Transfer funds from one wallet to another
    public static boolean transferFunds(int fromUserID, int toUserID, float amount) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Check if source wallet has enough funds
            Wallet sourceWallet = getByUserId(fromUserID);
            if (sourceWallet == null || sourceWallet.getAmount() < amount) {
                return false;
            }
            
            // Withdraw from source wallet
            String withdrawSql = "UPDATE Wallet SET Amount = Amount - ? WHERE UserID = ?";
            try (PreparedStatement ps = conn.prepareStatement(withdrawSql)) {
                ps.setFloat(1, amount);
                ps.setInt(2, fromUserID);
                ps.executeUpdate();
            }
            
            // Add to destination wallet
            String addSql = "UPDATE Wallet SET Amount = Amount + ? WHERE UserID = ?";
            try (PreparedStatement ps = conn.prepareStatement(addSql)) {
                ps.setFloat(1, amount);
                ps.setInt(2, toUserID);
                ps.executeUpdate();
            }
            
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            System.out.println("Error transferring funds: " + e.getMessage());
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                System.out.println("Error rolling back transaction: " + ex.getMessage());
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
        return false;
    }
}
