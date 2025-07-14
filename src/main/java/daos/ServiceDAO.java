package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Service;
import utils.DBConnection;

public class ServiceDAO {

    // Create a new service
    public static boolean create(Service service) {
        String sql = "INSERT INTO Service (CategoryServiceID, Name, Description, Price, Time, Views, ImgURL, Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, service.getCategoryServiceID());
            ps.setString(2, service.getName());
            ps.setString(3, service.getDescription());
            ps.setFloat(4, service.getPrice());
            ps.setInt(5, service.getTime());
            ps.setInt(6, service.getViews());
            ps.setString(7, service.getImgURL());
            ps.setBoolean(8, service.isStatus());

            int rowsAffected = ps.executeUpdate();

            // Get generated ID and set it to service object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    service.setServiceID(rs.getInt(1));
                }
                rs.close();
                return true;
            }

        } catch (SQLException e) {
            System.out.println("Error creating service: " + e.getMessage());
        }
        return false;
    }
    // Get a service by ID

    public static Service getById(int serviceID) {
        String sql = "SELECT * FROM Service WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                return service;
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving service: " + e.getMessage());
        }
        return null;
    }
    // Get all services

    public static List<Service> getAll() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving all services: " + e.getMessage());
        }
        return services;
    }
    // Get services by category ID

    public static List<Service> getByCategoryId(int categoryServiceID) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE CategoryServiceID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryServiceID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving services by category ID: " + e.getMessage());
        }
        return services;
    }
    // Update a service

    public static boolean update(Service service) {
        String sql = "UPDATE Service SET CategoryServiceID = ?, Name = ?, Description = ?, Price = ?, Time = ?, Views = ?, ImgURL = ?, Status = ? WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, service.getCategoryServiceID());
            ps.setString(2, service.getName());
            ps.setString(3, service.getDescription());
            ps.setFloat(4, service.getPrice());
            ps.setInt(5, service.getTime());
            ps.setInt(6, service.getViews());
            ps.setString(7, service.getImgURL());
            ps.setBoolean(8, service.isStatus());
            ps.setInt(9, service.getServiceID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error updating service: " + e.getMessage());
        }
        return false;
    }
    // Delete a service (soft delete by setting status to false)

    public static boolean delete(int serviceID) {
        String sql = "UPDATE Service SET Status = 0 WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting service: " + e.getMessage());
        }
        return false;
    }
    // Hard delete a service (remove from database)

    public static boolean hardDelete(int serviceID) {
        String sql = "DELETE FROM Service WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error hard deleting service: " + e.getMessage());
        }
        return false;
    }
    // Search services by name (partial match)

    public static List<Service> searchByName(String keyword) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE Name LIKE ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }

        } catch (SQLException e) {
            System.out.println("Error searching services by name: " + e.getMessage());
        }
        return services;
    }
    // Increment view count for a service

    public static boolean incrementViews(int serviceID) {
        String sql = "UPDATE Service SET Views = Views + 1 WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error incrementing views: " + e.getMessage());
        }
        return false;
    }

    // Get most viewed services
    public List<Service> getMostViewed(int limit) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE Status = 1 ORDER BY Views DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving most viewed services: " + e.getMessage());
        }
        return services;
    }

    // Count services with filtering options for pagination
    public static int countServices(int categoryId, String keyword) {
        StringBuilder sqlBuilder = new StringBuilder("SELECT COUNT(*) FROM Service WHERE Status = 1");
        List<Object> params = new ArrayList<>();

        if (categoryId > 0) {
            sqlBuilder.append(" AND CategoryServiceID = ?");
            params.add(categoryId);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sqlBuilder.append(" AND (Name LIKE ? OR Description LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sqlBuilder.toString())) {

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting services: " + e.getMessage());
        }

        return 0;
    }

    // Get services by filter with sorting and pagination
    public static List<Service> getServicesByFilter(int categoryId, String keyword,
            String sortField, String sortDirection, int offset, int limit) {
        List<Service> services = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM Service WHERE Status = 1");
        List<Object> params = new ArrayList<>();

        // Add category filter if needed
        if (categoryId > 0) {
            sqlBuilder.append(" AND CategoryServiceID = ?");
            params.add(categoryId);
        }

        // Add keyword search if needed
        if (keyword != null && !keyword.trim().isEmpty()) {
            sqlBuilder.append(" AND (Name LIKE ? OR Description LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        // Add sorting
        if (sortField != null && !sortField.trim().isEmpty()) {
            sqlBuilder.append(" ORDER BY ").append(sortField);

            if ("DESC".equalsIgnoreCase(sortDirection)) {
                sqlBuilder.append(" DESC");
            } else {
                sqlBuilder.append(" ASC");
            }
        } else {
            // Default sorting
            sqlBuilder.append(" ORDER BY Name ASC");
        }

        // Add pagination
        sqlBuilder.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sqlBuilder.toString())) {

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving filtered services: " + e.getMessage());
        }

        return services;
    }

    // Get related services (same category) excluding current service
    public static List<Service> getRelatedServices(int currentServiceId, int categoryId, int limit) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Service WHERE Status = 1 AND CategoryServiceID = ? AND ServiceID != ? ORDER BY NEWID()";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, categoryId);
            ps.setInt(3, currentServiceId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.add(service);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving related services: " + e.getMessage());
        }

        return services;
    }
    // Phương thức này được giữ lại nhưng đổi tên để phù hợp (không liên quan đến discount)

    public static Service getServiceById(int serviceId) {
        return getById(serviceId);
    }

    public static Map<Integer, Service> getByBookingDetails(int bookingID) {
        Map<Integer, Service> services = new HashMap<>();
        String sql = "SELECT s.*\n"
                + "FROM BookingDetail bd\n"
                + "JOIN Service s ON bd.ServiceID = s.ServiceID\n"
                + "WHERE bd.BookingID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingID);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("ServiceID"));
                service.setCategoryServiceID(rs.getInt("CategoryServiceID"));
                service.setName(rs.getString("Name"));
                service.setDescription(rs.getString("Description"));
                service.setPrice(rs.getFloat("Price"));
                service.setTime(rs.getInt("Time"));
                service.setViews(rs.getInt("Views"));
                service.setImgURL(rs.getString("ImgURL"));
                service.setStatus(rs.getBoolean("Status"));
                services.put(service.getServiceID(), service);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving related services: " + e.getMessage());
        }
        return services;
    }
}
