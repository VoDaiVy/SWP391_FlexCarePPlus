package daos;

import java.sql.*;
import java.util.*;
import models.UserPet;
import utils.DBConnection;

public class UserPetDAO {
    // Create a new user pet
    public static boolean create(UserPet userPet) {
        String sql = "INSERT INTO UserPet (UserID, PetID, PetName) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, userPet.getUserID());
            ps.setInt(2, userPet.getPetID());
            ps.setString(3, userPet.getPetName());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to userPet object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    userPet.setUserPetID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating user pet: " + e.getMessage());
        }
        return false;
    }
    
    // Get a user pet by ID
    public static UserPet getById(int userPetID) {
        String sql = "SELECT * FROM UserPet WHERE UserPetID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userPetID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                UserPet userPet = new UserPet();
                userPet.setUserPetID(rs.getInt("UserPetID"));
                userPet.setUserID(rs.getInt("UserID"));
                userPet.setPetID(rs.getInt("PetID"));
                userPet.setPetName(rs.getString("PetName"));
                return userPet;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving user pet: " + e.getMessage());
        }
        return null;
    }
    
    // Get all user pets for a user
    public static List<UserPet> getByUserId(int userID) {
        List<UserPet> userPets = new ArrayList<>();
        String sql = "SELECT * FROM UserPet WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                UserPet userPet = new UserPet();
                userPet.setUserPetID(rs.getInt("UserPetID"));
                userPet.setUserID(rs.getInt("UserID"));
                userPet.setPetID(rs.getInt("PetID"));
                userPet.setPetName(rs.getString("PetName"));
                userPets.add(userPet);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving user pets: " + e.getMessage());
        }
        return userPets;
    }
    
    // Get all user pets
    public static List<UserPet> getAll() {
        List<UserPet> userPets = new ArrayList<>();
        String sql = "SELECT * FROM UserPet";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                UserPet userPet = new UserPet();
                userPet.setUserPetID(rs.getInt("UserPetID"));
                userPet.setUserID(rs.getInt("UserID"));
                userPet.setPetID(rs.getInt("PetID"));
                userPet.setPetName(rs.getString("PetName"));
                userPets.add(userPet);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all user pets: " + e.getMessage());
        }
        return userPets;
    }
    
    // Update a user pet
    public static boolean update(UserPet userPet) {
        String sql = "UPDATE UserPet SET UserID = ?, PetID = ?, PetName = ? WHERE UserPetID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userPet.getUserID());
            ps.setInt(2, userPet.getPetID());
            ps.setString(3, userPet.getPetName());
            ps.setInt(4, userPet.getUserPetID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating user pet: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a user pet
    public static boolean delete(int userPetID) {
        String sql = "DELETE FROM UserPet WHERE UserPetID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userPetID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting user pet: " + e.getMessage());
        }
        return false;
    }
}
