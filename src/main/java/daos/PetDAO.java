package daos;

import java.sql.*;
import java.util.*;
import models.Pet;
import utils.DBConnection;

public class PetDAO {
    // Create a new pet
    public static boolean create(Pet pet) {
        String sql = "INSERT INTO Pet (Name) VALUES (?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, pet.getName());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to pet object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    pet.setPetID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating pet: " + e.getMessage());
        }
        return false;
    }
    
    // Get a pet by ID
    public static Pet getById(int petID) {
        String sql = "SELECT * FROM Pet WHERE PetID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, petID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                pet.setName(rs.getString("Name"));
                return pet;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving pet: " + e.getMessage());
        }
        return null;
    }
    
    // Get all pets
    public static List<Pet> getAll() {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM Pet";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetID(rs.getInt("PetID"));
                pet.setName(rs.getString("Name"));
                pets.add(pet);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all pets: " + e.getMessage());
        }
        return pets;
    }
    
    // Update a pet
    public static boolean update(Pet pet) {
        String sql = "UPDATE Pet SET Name = ? WHERE PetID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, pet.getName());
            ps.setInt(2, pet.getPetID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating pet: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a pet
    public static boolean delete(int petID) {
        String sql = "DELETE FROM Pet WHERE PetID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, petID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting pet: " + e.getMessage());
        }
        return false;
    }
}
