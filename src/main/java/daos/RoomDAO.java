package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.Room;
import utils.DBConnection;

public class RoomDAO {
    
    // Create a new room
    public static boolean create(Room room) {
        String sql = "INSERT INTO Room (categoryServiceID, Name, RoomNumber, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, room.getCategoryServiceID());
            ps.setString(2, room.getName());
            ps.setInt(3, room.getRoomNumber());
            ps.setBoolean(4, room.isStatus());
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to room object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    room.setRoomID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating room: " + e.getMessage());
        }
        return false;
    }
      // Get a room by ID
    public static Room getById(int roomID) {
        String sql = "SELECT * FROM Room WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                room.setName(rs.getString("Name"));
                room.setRoomNumber(rs.getInt("RoomNumber"));
                room.setStatus(rs.getBoolean("Status"));
                return room;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving room: " + e.getMessage());
        }
        return null;
    }
      // Get all rooms
    public static List<Room> getAll() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM Room";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                room.setName(rs.getString("Name"));
                room.setRoomNumber(rs.getInt("RoomNumber"));
                room.setStatus(rs.getBoolean("Status"));
                rooms.add(room);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all rooms: " + e.getMessage());
        }
        return rooms;
    }
      // Get rooms by service ID
    public static List<Room> getByServiceId(int serviceID) {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM Room WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                room.setName(rs.getString("Name"));
                room.setRoomNumber(rs.getInt("RoomNumber"));
                room.setStatus(rs.getBoolean("Status"));
                rooms.add(room);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving rooms by service ID: " + e.getMessage());
        }
        return rooms;
    }
      // Get available rooms by service ID
    public static List<Room> getAvailableRoomsByServiceId(int serviceID) {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM Room WHERE CategoryServiceID = ? AND Status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                room.setName(rs.getString("Name"));
                room.setRoomNumber(rs.getInt("RoomNumber"));
                room.setStatus(rs.getBoolean("Status"));
                rooms.add(room);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving available rooms by service ID: " + e.getMessage());
        }
        return rooms;
    }
      // Update a room
    public static boolean update(Room room) {
        String sql = "UPDATE Room SET CategoryServiceID = ?, Name = ?, RoomNumber = ?, Status = ? WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, room.getCategoryServiceID());
            ps.setString(2, room.getName());
            ps.setInt(3, room.getRoomNumber());
            ps.setBoolean(4, room.isStatus());
            ps.setInt(5, room.getRoomID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating room: " + e.getMessage());
        }
        return false;
    }
      // Delete a room (soft delete by setting status to false)
    public static boolean delete(int roomID) {
        String sql = "UPDATE Room SET Status = 0 WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting room: " + e.getMessage());
        }
        return false;
    }
      // Hard delete a room (remove from database)
    public static boolean hardDelete(int roomID) {
        String sql = "DELETE FROM Room WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error hard deleting room: " + e.getMessage());
        }
        return false;
    }
      // Count rooms for a service
    public static int countRoomsByServiceId(int serviceID) {
        String sql = "SELECT COUNT(*) AS RoomCount FROM Room WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("RoomCount");
            }
            
        } catch (SQLException e) {
            System.out.println("Error counting rooms for service: " + e.getMessage());
        }
        return 0;
    }
      // Check if room is available
    public static boolean isRoomAvailable(int roomID) {
        String sql = "SELECT Status FROM Room WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getBoolean("Status");
            }
            
        } catch (SQLException e) {
            System.out.println("Error checking room availability: " + e.getMessage());
        }
        return false;
    }
    
    // Get rooms by category service ID
    public static List<Room> getByCategoryServiceId(int categoryServiceID) {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM Room WHERE categoryServiceID = ? AND Status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryServiceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setCategoryServiceID(rs.getInt("categoryServiceID"));
                room.setName(rs.getString("Name"));
                room.setRoomNumber(rs.getInt("RoomNumber"));
                room.setStatus(rs.getBoolean("Status"));
                rooms.add(room);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving rooms by category service ID: " + e.getMessage());
        }
        return rooms;
    }
}
