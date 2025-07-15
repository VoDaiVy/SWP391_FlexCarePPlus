package daos;

import dtos.NotificationDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.Notification;
import models.NotificationUser;
import models.User;
import utils.DBConnection;
import dtos.NotificationUserDTO;

public class NotificationUserDAO {

    // Create a new notification-user relationship
    public static boolean create(NotificationUser notificationUser) {
        String sql = "INSERT INTO NotificationUser (UserID, NotificationID, Status, HasRead) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationUser.getUserID());
            ps.setInt(2, notificationUser.getNotificationID());
            ps.setBoolean(3, notificationUser.isStatus());
            ps.setBoolean(4, notificationUser.isHasRead());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error creating notification-user relationship: " + e.getMessage());
        }
        return false;
    }

    // Get by ID
    public static NotificationUser getById(int notificationUserID) {
        String sql = "SELECT * FROM NotificationUser WHERE NotificationUserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationUserID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                NotificationUser notificationUser = new NotificationUser();
                notificationUser.setNotificationUserID(rs.getInt("NotificationUserID"));
                notificationUser.setUserID(rs.getInt("UserID"));
                notificationUser.setNotificationID(rs.getInt("NotificationID"));
                notificationUser.setStatus(rs.getBoolean("Status"));
                notificationUser.setHasRead(rs.getBoolean("HasRead"));
                return notificationUser;
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving notification-user by ID: " + e.getMessage());
        }
        return null;
    }

    // Get all notification-user relationships
    public static List<NotificationUser> getAll() {
        List<NotificationUser> notificationUsers = new ArrayList<>();
        String sql = "SELECT * FROM NotificationUser";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                NotificationUser notificationUser = new NotificationUser();
                notificationUser.setNotificationUserID(rs.getInt("NotificationUserID"));
                notificationUser.setUserID(rs.getInt("UserID"));
                notificationUser.setNotificationID(rs.getInt("NotificationID"));
                notificationUser.setStatus(rs.getBoolean("Status"));
                notificationUser.setHasRead(rs.getBoolean("HasRead"));
                notificationUsers.add(notificationUser);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving all notification-users: " + e.getMessage());
        }
        return notificationUsers;
    }

    // Create a notification-user relationship using DTO
    public static boolean createFromDTO(NotificationUserDTO dto) {
        NotificationUser notificationUser = dto.toNotificationUser();
        return create(notificationUser);
    }

    // Convert NotificationUser to NotificationUserDTO (with full objects)
    public static NotificationUserDTO toDTO(NotificationUser notificationUser) {
        User user = UserDAO.getById(notificationUser.getUserID());
        Notification notification = NotificationDAO.getById(notificationUser.getNotificationID());
        return new NotificationUserDTO(notificationUser, user, notification);
    }

    // Get NotificationUserDTO by ID
    public static NotificationUserDTO getDTOById(int notificationUserID) {
        NotificationUser notificationUser = getById(notificationUserID);
        if (notificationUser != null) {
            return toDTO(notificationUser);
        }
        return null;
    }

    // Get all NotificationUserDTOs
    public static List<NotificationUserDTO> getAllDTOs() {
        List<NotificationUser> notificationUsers = getAll();
        List<NotificationUserDTO> dtos = new ArrayList<>();
        for (NotificationUser notificationUser : notificationUsers) {
            dtos.add(toDTO(notificationUser));
        }
        return dtos;
    }

    // Check if a notification-user relationship exists
    public static boolean exists(int userID, int notificationID) {
        String sql = "SELECT COUNT(*) AS Count FROM NotificationUser WHERE UserID = ? AND NotificationID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setInt(2, notificationID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("Count") > 0;
            }

        } catch (SQLException e) {
            System.out.println("Error checking notification-user existence: " + e.getMessage());
        }
        return false;
    }

    // Get notification-user by user ID and notification ID
    public static NotificationUser getByIds(int userID, int notificationID) {
        String sql = "SELECT * FROM NotificationUser WHERE UserID = ? AND NotificationID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setInt(2, notificationID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                NotificationUser notificationUser = new NotificationUser();
                notificationUser.setUserID(rs.getInt("UserID"));
                notificationUser.setNotificationID(rs.getInt("NotificationID"));
                notificationUser.setStatus(rs.getBoolean("Status"));
                notificationUser.setHasRead(rs.getBoolean("HasRead"));
                return notificationUser;
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving notification-user: " + e.getMessage());
        }
        return null;
    }

    // Get NotificationUserDTO by user ID and notification ID
    public static NotificationUserDTO getDTOByIds(int userID, int notificationID) {
        NotificationUser notificationUser = getByIds(userID, notificationID);
        if (notificationUser != null) {
            return toDTO(notificationUser);
        }
        return null;
    }

    // Get all notifications for a user
    public static List<Notification> getNotificationsForUser(int userID) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT TOP 10 n.* FROM Notifications n "
                + "JOIN NotificationUser nu ON n.NotificationID = nu.NotificationID "
                + "WHERE nu.UserID = ? AND nu.Status = 1 "
                + "ORDER BY n.DateCreated DESC ";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notification notification = new Notification();
                notification.setNotificationID(rs.getInt("NotificationID"));
                notification.setContent(rs.getString("Content"));

                // Handle timestamp conversion
                if (rs.getTimestamp("DateCreated") != null) {
                    notification.setDateCreated(rs.getTimestamp("DateCreated").toLocalDateTime());
                }

                notifications.add(notification);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving notifications for user: " + e.getMessage());
        }
        return notifications;
    }

    // Get all NotificationUserDTOs for a user
    public static List<NotificationUserDTO> getDTOsForUser(int userID) {
        List<NotificationUserDTO> dtos = new ArrayList<>();
        String sql = "SELECT * FROM NotificationUser WHERE UserID = ? ORDER BY NotificationUserID DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                NotificationUser notificationUser = new NotificationUser();
                notificationUser.setNotificationUserID(rs.getInt("NotificationUserID"));
                notificationUser.setUserID(rs.getInt("UserID"));
                notificationUser.setNotificationID(rs.getInt("NotificationID"));
                notificationUser.setStatus(rs.getBoolean("Status"));
                notificationUser.setHasRead(rs.getBoolean("HasRead"));

                dtos.add(toDTO(notificationUser));
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving notification-user DTOs for user: " + e.getMessage());
        }
        return dtos;
    }

    // Get unread notifications count for a user
    public static int getUnreadCountForUser(int userID) {
        String sql = "SELECT COUNT(*) AS UnreadCount FROM NotificationUser "
                + "WHERE UserID = ? AND Status = 1 AND HasRead = 0";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("UnreadCount");
            }

        } catch (SQLException e) {
            System.out.println("Error counting unread notifications: " + e.getMessage());
        }
        return 0;
    }

    // Mark a notification as read for a user
    public static boolean markAsRead(int userID, int notificationID) {
        String sql = "UPDATE NotificationUser SET HasRead = 1 WHERE UserID = ? AND NotificationID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setInt(2, notificationID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error marking notification as read: " + e.getMessage());
        }
        return false;
    }

    // Mark all notifications as read for a user
    public static boolean markAllAsRead(int userID) {
        String sql = "UPDATE NotificationUser SET HasRead = 1 WHERE UserID = ? AND Status = 1 AND HasRead = 0";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error marking all notifications as read: " + e.getMessage());
        }
        return false;
    }

    // Update notification-user status
    public static boolean updateStatus(int userID, int notificationID, boolean status) {
        String sql = "UPDATE NotificationUser SET Status = ? WHERE UserID = ? AND NotificationID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            ps.setInt(2, userID);
            ps.setInt(3, notificationID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error updating notification-user status: " + e.getMessage());
        }
        return false;
    }

    // Update notification-user from DTO
    public static boolean updateFromDTO(NotificationUserDTO dto) {
        NotificationUser notificationUser = dto.toNotificationUser();
        String sql = "UPDATE NotificationUser SET Status = ?, HasRead = ? WHERE UserID = ? AND NotificationID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, notificationUser.isStatus());
            ps.setBoolean(2, notificationUser.isHasRead());
            ps.setInt(3, notificationUser.getUserID());
            ps.setInt(4, notificationUser.getNotificationID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error updating notification-user from DTO: " + e.getMessage());
        }
        return false;
    }

    // Delete notification-user relationship
    public static boolean delete(int userID, int notificationID) {
        String sql = "DELETE FROM NotificationUser WHERE UserID = ? AND NotificationID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setInt(2, notificationID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting notification-user relationship: " + e.getMessage());
        }
        return false;
    }

    // Delete notification-user by ID
    public static boolean deleteById(int notificationUserID) {
        String sql = "DELETE FROM NotificationUser WHERE NotificationUserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationUserID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting notification-user by ID: " + e.getMessage());
        }
        return false;
    }

    // Delete all notification-user relationships for a user
    public static boolean deleteAllForUser(int userID) {
        String sql = "DELETE FROM NotificationUser WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting all notification-user relationships for user: " + e.getMessage());
        }
        return false;
    }

    // Delete all notification-user relationships for a notification
    public static boolean deleteAllForNotification(int notificationID) {
        String sql = "DELETE FROM NotificationUser WHERE NotificationID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting all notification-user relationships for notification: " + e.getMessage());
        }
        return false;
    }

    // Get all NotificationUserDTOs for a user
    public static List<NotificationDTO> getForUser(int userID) {
        List<NotificationDTO> dtos = new ArrayList<>();
        String sql = "SELECT TOP 10 \n"
                + "    n.NotificationID,\n"
                + "    n.Content,\n"
                + "    nu.HasRead\n"
                + "FROM \n"
                + "    NotificationUser nu\n"
                + "JOIN \n"
                + "    Notifications n ON nu.NotificationID = n.NotificationID\n"
                + "WHERE \n"
                + "    nu.UserID = ? and nu.Status = 1\n"
                + "ORDER BY \n"
                + "    n.DateCreated DESC;";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                NotificationDTO notification = new NotificationDTO();
                notification.setNotificationID(rs.getInt("NotificationID"));
                notification.setHasRead(rs.getBoolean("HasRead"));
                notification.setContent(rs.getNString("Content"));
                dtos.add(notification);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving notification-user DTOs for user: " + e.getMessage());
        }
        return dtos;
    }
}
