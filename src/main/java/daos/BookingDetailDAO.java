package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import models.BookingDetail;
import utils.DBConnection;

public class BookingDetailDAO {
    
    // Create a new booking detail
    public static boolean create(BookingDetail bookingDetail) {
        String sql = "INSERT INTO BookingDetail (BookingID, ServiceID, StockBooking, DateStartService, DateEndService, StartTime, EndTime, Price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingDetail.getBookingID());
            ps.setInt(2, bookingDetail.getServiceID());
            ps.setInt(3, bookingDetail.getStockBooking());
            
            // Handle LocalDateTime conversion to SQL Timestamp
            LocalDateTime dateStartService = null;
            if (!bookingDetail.getDateStartService().isEmpty()) {
                dateStartService = LocalDateTime.parse(bookingDetail.getDateStartService(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            ps.setTimestamp(4, dateStartService != null ? Timestamp.valueOf(dateStartService) : null);
            
            LocalDateTime dateEndService = null;
            if (!bookingDetail.getDateEndService().isEmpty()) {
                dateEndService = LocalDateTime.parse(bookingDetail.getDateEndService(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            ps.setTimestamp(5, dateEndService != null ? Timestamp.valueOf(dateEndService) : null);
            
            // Handle LocalTime conversion to SQL Time
            LocalTime startTime = null;
            if (!bookingDetail.getStartTime().isEmpty()) {
                startTime = LocalTime.parse(bookingDetail.getStartTime(), 
                    DateTimeFormatter.ofPattern("HH:mm:ss"));
            }
            ps.setTime(6, startTime != null ? Time.valueOf(startTime) : null);
            
            LocalTime endTime = null;
            if (!bookingDetail.getEndTime().isEmpty()) {
                endTime = LocalTime.parse(bookingDetail.getEndTime(), 
                    DateTimeFormatter.ofPattern("HH:mm:ss"));
            }
            ps.setTime(7, endTime != null ? Time.valueOf(endTime) : null);
            
            ps.setFloat(8, bookingDetail.getPrice());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error creating booking detail: " + e.getMessage());
        }
        return false;
    }
      // Get booking details by booking ID
    public static List<BookingDetail> getByBookingId(int bookingID) {
        List<BookingDetail> bookingDetails = new ArrayList<>();
        String sql = "SELECT * FROM BookingDetail WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BookingDetail bookingDetail = new BookingDetail();
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setStockBooking(rs.getInt("StockBooking"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateStartServiceTimestamp = rs.getTimestamp("DateStartService");
                if (dateStartServiceTimestamp != null) {
                    bookingDetail.setDateStartService(dateStartServiceTimestamp.toLocalDateTime());
                }
                
                Timestamp dateEndServiceTimestamp = rs.getTimestamp("DateEndService");
                if (dateEndServiceTimestamp != null) {
                    bookingDetail.setDateEndService(dateEndServiceTimestamp.toLocalDateTime());
                }
                
                // Handle SQL Time to LocalTime conversion
                Time startTimeValue = rs.getTime("StartTime");
                if (startTimeValue != null) {
                    bookingDetail.setStartTime(startTimeValue.toLocalTime());
                }
                
                Time endTimeValue = rs.getTime("EndTime");
                if (endTimeValue != null) {
                    bookingDetail.setEndTime(endTimeValue.toLocalTime());
                }
                
                bookingDetail.setPrice(rs.getFloat("Price"));
                bookingDetails.add(bookingDetail);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving booking details by booking ID: " + e.getMessage());
        }
        return bookingDetails;
    }
      // Get booking details by service ID
    public static List<BookingDetail> getByServiceId(int serviceID) {
        List<BookingDetail> bookingDetails = new ArrayList<>();
        String sql = "SELECT * FROM BookingDetail WHERE ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                BookingDetail bookingDetail = new BookingDetail();
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setStockBooking(rs.getInt("StockBooking"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateStartServiceTimestamp = rs.getTimestamp("DateStartService");
                if (dateStartServiceTimestamp != null) {
                    bookingDetail.setDateStartService(dateStartServiceTimestamp.toLocalDateTime());
                }
                
                Timestamp dateEndServiceTimestamp = rs.getTimestamp("DateEndService");
                if (dateEndServiceTimestamp != null) {
                    bookingDetail.setDateEndService(dateEndServiceTimestamp.toLocalDateTime());
                }
                
                // Handle SQL Time to LocalTime conversion
                Time startTimeValue = rs.getTime("StartTime");
                if (startTimeValue != null) {
                    bookingDetail.setStartTime(startTimeValue.toLocalTime());
                }
                
                Time endTimeValue = rs.getTime("EndTime");
                if (endTimeValue != null) {
                    bookingDetail.setEndTime(endTimeValue.toLocalTime());
                }
                
                bookingDetail.setPrice(rs.getFloat("Price"));
                bookingDetails.add(bookingDetail);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving booking details by service ID: " + e.getMessage());
        }
        return bookingDetails;
    }
      // Get a specific booking detail by booking ID and service ID
    public static BookingDetail getByBookingIdAndServiceId(int bookingID, int serviceID) {
        String sql = "SELECT * FROM BookingDetail WHERE BookingID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingID);
            ps.setInt(2, serviceID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                BookingDetail bookingDetail = new BookingDetail();
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setStockBooking(rs.getInt("StockBooking"));
                
                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateStartServiceTimestamp = rs.getTimestamp("DateStartService");
                if (dateStartServiceTimestamp != null) {
                    bookingDetail.setDateStartService(dateStartServiceTimestamp.toLocalDateTime());
                }
                
                Timestamp dateEndServiceTimestamp = rs.getTimestamp("DateEndService");
                if (dateEndServiceTimestamp != null) {
                    bookingDetail.setDateEndService(dateEndServiceTimestamp.toLocalDateTime());
                }
                
                // Handle SQL Time to LocalTime conversion
                Time startTimeValue = rs.getTime("StartTime");
                if (startTimeValue != null) {
                    bookingDetail.setStartTime(startTimeValue.toLocalTime());
                }
                
                Time endTimeValue = rs.getTime("EndTime");
                if (endTimeValue != null) {
                    bookingDetail.setEndTime(endTimeValue.toLocalTime());
                }
                
                bookingDetail.setPrice(rs.getFloat("Price"));
                return bookingDetail;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving booking detail: " + e.getMessage());
        }
        return null;
    }
      // Update a booking detail
    public static boolean update(BookingDetail bookingDetail) {
        String sql = "UPDATE BookingDetail SET StockBooking = ?, DateStartService = ?, DateEndService = ?, StartTime = ?, EndTime = ?, Price = ? WHERE BookingID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingDetail.getStockBooking());
            
            // Handle LocalDateTime conversion to SQL Timestamp
            LocalDateTime dateStartService = null;
            if (!bookingDetail.getDateStartService().isEmpty()) {
                dateStartService = LocalDateTime.parse(bookingDetail.getDateStartService(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            ps.setTimestamp(2, dateStartService != null ? Timestamp.valueOf(dateStartService) : null);
            
            LocalDateTime dateEndService = null;
            if (!bookingDetail.getDateEndService().isEmpty()) {
                dateEndService = LocalDateTime.parse(bookingDetail.getDateEndService(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            ps.setTimestamp(3, dateEndService != null ? Timestamp.valueOf(dateEndService) : null);
            
            // Handle LocalTime conversion to SQL Time
            LocalTime startTime = null;
            if (!bookingDetail.getStartTime().isEmpty()) {
                startTime = LocalTime.parse(bookingDetail.getStartTime(), 
                    DateTimeFormatter.ofPattern("HH:mm:ss"));
            }
            ps.setTime(4, startTime != null ? Time.valueOf(startTime) : null);
            
            LocalTime endTime = null;
            if (!bookingDetail.getEndTime().isEmpty()) {
                endTime = LocalTime.parse(bookingDetail.getEndTime(), 
                    DateTimeFormatter.ofPattern("HH:mm:ss"));
            }
            ps.setTime(5, endTime != null ? Time.valueOf(endTime) : null);
            
            ps.setFloat(6, bookingDetail.getPrice());
            ps.setInt(7, bookingDetail.getBookingID());
            ps.setInt(8, bookingDetail.getServiceID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating booking detail: " + e.getMessage());
        }
        return false;
    }
      // Delete a booking detail
    public static boolean delete(int bookingID, int serviceID) {
        String sql = "DELETE FROM BookingDetail WHERE BookingID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingID);
            ps.setInt(2, serviceID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting booking detail: " + e.getMessage());
        }
        return false;
    }
      // Delete all booking details for a specific booking
    public static boolean deleteByBookingId(int bookingID) {
        String sql = "DELETE FROM BookingDetail WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting booking details: " + e.getMessage());
        }
        return false;
    }
}
