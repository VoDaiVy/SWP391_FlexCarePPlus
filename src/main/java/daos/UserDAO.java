package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.User;
import utils.DBConnection;

public class UserDAO {

    // Create a new user
    public static boolean create(User user) {
        String sql = "INSERT INTO [Users] (Role, UserName, Password, Email, Status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getRole());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setBoolean(5, user.isStatus());

            int rowsAffected = ps.executeUpdate();

            // Get generated ID and set it to user object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    user.setUserId(rs.getInt(1));
                }
                rs.close();
                return true;
            }

        } catch (SQLException e) {
            System.out.println("Error creating user: " + e.getMessage());
        }
        return false;
    }
    // Get a user by ID

    public static User getById(int userID) {
        String sql = "SELECT * FROM [Users] WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setRole(rs.getString("Role"));
                user.setUserName(rs.getString("UserName"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getBoolean("Status"));
                return user;
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving user: " + e.getMessage());
        }
        return null;
    }
    // Get all users

    public static List<User> getAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [Users]";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setRole(rs.getString("Role"));
                user.setUserName(rs.getString("UserName"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getBoolean("Status"));
                users.add(user);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving all users: " + e.getMessage());
        }
        return users;
    }
    // Update a user

    public static boolean update(User user) {
        String sql = "UPDATE [Users] SET Role = ?, UserName = ?, Password = ?, Email = ?, Status = ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getRole());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setBoolean(5, user.isStatus());
            ps.setInt(6, user.getUserId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error updating user: " + e.getMessage());
        }
        return false;
    }
    // Delete a user (soft delete by setting status to false)

    public static boolean delete(int userID) {
        String sql = "UPDATE [Users] SET Status = 0 WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting user: " + e.getMessage());
        }
        return false;
    }
    // Hard delete a user (remove from database)

    public static boolean hardDelete(int userID) {
        String sql = "DELETE FROM [Users] WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error hard deleting user: " + e.getMessage());
        }
        return false;
    }
    // Find user by username

    public static User getByUsername(String username) {
        String sql = "SELECT * FROM [Users] WHERE UserName = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setRole(rs.getString("Role"));
                user.setUserName(rs.getString("UserName"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getBoolean("Status"));
                return user;
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving user by username: " + e.getMessage());
        }
        return null;
    }
    // Find user by email

    public static User getByEmail(String email) {
        String sql = "SELECT * FROM [Users] WHERE Email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setRole(rs.getString("Role"));
                user.setUserName(rs.getString("UserName"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getBoolean("Status"));
                return user;
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving user by email: " + e.getMessage());
        }
        return null;
    }

    public static User getByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM [Users] WHERE UserName = ? and PassWord = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setRole(rs.getString("Role"));
                user.setUserName(rs.getString("UserName"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getBoolean("Status"));
                return user;
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving user by email: " + e.getMessage());
        }
        return null;
    }

    public static List<User> adminGetAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [Users] WHERE Role <> 'admin'";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setRole(rs.getString("Role"));
                user.setUserName(rs.getString("UserName"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setStatus(rs.getBoolean("Status"));
                users.add(user);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving all users except admin: " + e.getMessage());
        }
        return users;
    }
}
