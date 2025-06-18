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
        String sql = "INSERT INTO BookingDetail (BookingID, ServiceID, RoomID, StockBooking, DateStartService, DateEndService, StartTime, EndTime, Price, UserPetID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingDetail.getBookingID());
            ps.setInt(2, bookingDetail.getServiceID());
            ps.setInt(3, bookingDetail.getRoomID());
            ps.setInt(4, bookingDetail.getStockBooking());
            
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
            }            ps.setTime(7, endTime != null ? Time.valueOf(endTime) : null);
            
            ps.setFloat(8, bookingDetail.getPrice());
            ps.setInt(9, bookingDetail.getUserPetID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error creating booking detail: " + e.getMessage());
        }
        return false;
    }
        // Get all booking details for a specific date (matching only the date part of DateStartService)
    public static List<BookingDetail> getByDate(java.time.LocalDate date) {
        List<BookingDetail> bookingDetails = new ArrayList<>();
        String sql = "SELECT * FROM BookingDetail WHERE CAST(DateStartService AS DATE) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, date.toString());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingDetail bookingDetail = new BookingDetail();
                bookingDetail.setBookingDetailID(rs.getInt("BookingDetailID"));
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setRoomID(rs.getInt("RoomID"));
                bookingDetail.setStockBooking(rs.getInt("StockBooking"));
                // Handle SQL Timestamp to LocalDateTime conversion
                java.sql.Timestamp dateStartServiceTimestamp = rs.getTimestamp("DateStartService");
                if (dateStartServiceTimestamp != null) {
                    bookingDetail.setDateStartService(dateStartServiceTimestamp.toLocalDateTime());
                }
                java.sql.Timestamp dateEndServiceTimestamp = rs.getTimestamp("DateEndService");
                if (dateEndServiceTimestamp != null) {
                    bookingDetail.setDateEndService(dateEndServiceTimestamp.toLocalDateTime());
                }
                java.sql.Time startTimeValue = rs.getTime("StartTime");
                if (startTimeValue != null) {
                    bookingDetail.setStartTime(startTimeValue.toLocalTime());
                }
                java.sql.Time endTimeValue = rs.getTime("EndTime");
                if (endTimeValue != null) {
                    bookingDetail.setEndTime(endTimeValue.toLocalTime());
                }
                bookingDetail.setPrice(rs.getFloat("Price"));
                bookingDetail.setUserPetID(rs.getInt("UserPetID"));
                bookingDetails.add(bookingDetail);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving booking details by date: " + e.getMessage());
        }
        return bookingDetails;
    }
      // Get a booking detail by ID
    public static BookingDetail getById(int bookingDetailID) {
        String sql = "SELECT * FROM BookingDetail WHERE BookingDetailID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingDetailID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                BookingDetail bookingDetail = new BookingDetail();
                bookingDetail.setBookingDetailID(rs.getInt("BookingDetailID"));
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setRoomID(rs.getInt("RoomID"));
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
                bookingDetail.setUserPetID(rs.getInt("UserPetID"));
                return bookingDetail;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving booking detail by ID: " + e.getMessage());
        }
        return null;
    }
    
    // Get all booking details
    public static List<BookingDetail> getAll() {
        List<BookingDetail> bookingDetails = new ArrayList<>();
        String sql = "SELECT * FROM BookingDetail";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                BookingDetail bookingDetail = new BookingDetail();
                bookingDetail.setBookingDetailID(rs.getInt("BookingDetailID"));
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setRoomID(rs.getInt("RoomID"));
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
                bookingDetail.setUserPetID(rs.getInt("UserPetID"));
                bookingDetails.add(bookingDetail);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving all booking details: " + e.getMessage());
        }
        return bookingDetails;
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
                bookingDetail.setBookingDetailID(rs.getInt("BookingDetailID"));
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setRoomID(rs.getInt("RoomID"));
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
                bookingDetail.setUserPetID(rs.getInt("UserPetID"));
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
                bookingDetail.setBookingDetailID(rs.getInt("BookingDetailID"));
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setRoomID(rs.getInt("RoomID"));
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
                bookingDetail.setUserPetID(rs.getInt("UserPetID"));
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
                bookingDetail.setBookingDetailID(rs.getInt("BookingDetailID"));
                bookingDetail.setBookingID(rs.getInt("BookingID"));
                bookingDetail.setServiceID(rs.getInt("ServiceID"));
                bookingDetail.setRoomID(rs.getInt("RoomID"));
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
                bookingDetail.setUserPetID(rs.getInt("UserPetID"));
                return bookingDetail;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving booking detail: " + e.getMessage());
        }
        return null;
    }    // Update a booking detail
    public static boolean update(BookingDetail bookingDetail) {
        String sql = "UPDATE BookingDetail SET RoomID = ?, StockBooking = ?, DateStartService = ?, DateEndService = ?, StartTime = ?, EndTime = ?, Price = ?, UserPetID = ? WHERE BookingID = ? AND ServiceID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingDetail.getRoomID());
            ps.setInt(2, bookingDetail.getStockBooking());
            
            // Handle LocalDateTime conversion to SQL Timestamp
            LocalDateTime dateStartService = null;            if (!bookingDetail.getDateStartService().isEmpty()) {
                dateStartService = LocalDateTime.parse(bookingDetail.getDateStartService(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            ps.setTimestamp(3, dateStartService != null ? Timestamp.valueOf(dateStartService) : null);
            
            LocalDateTime dateEndService = null;
            if (!bookingDetail.getDateEndService().isEmpty()) {
                dateEndService = LocalDateTime.parse(bookingDetail.getDateEndService(), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            ps.setTimestamp(4, dateEndService != null ? Timestamp.valueOf(dateEndService) : null);
            
            // Handle LocalTime conversion to SQL Time
            LocalTime startTime = null;            if (!bookingDetail.getStartTime().isEmpty()) {
                startTime = LocalTime.parse(bookingDetail.getStartTime(), 
                    DateTimeFormatter.ofPattern("HH:mm:ss"));
            }
            ps.setTime(5, startTime != null ? Time.valueOf(startTime) : null);
            
            LocalTime endTime = null;
            if (!bookingDetail.getEndTime().isEmpty()) {
                endTime = LocalTime.parse(bookingDetail.getEndTime(), 
                    DateTimeFormatter.ofPattern("HH:mm:ss"));
            }
            ps.setTime(6, endTime != null ? Time.valueOf(endTime) : null);
            
            ps.setFloat(7, bookingDetail.getPrice());
            ps.setInt(8, bookingDetail.getUserPetID());
            ps.setInt(9, bookingDetail.getBookingID());
            ps.setInt(10, bookingDetail.getServiceID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating booking detail: " + e.getMessage());
        }
        return false;
    }
      // Delete a booking detail
    public static boolean delete(int bookingDetailID) {
        String sql = "DELETE FROM BookingDetail WHERE BookingDetailID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, bookingDetailID);
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
    
    public static int countBooking() {
        String sql = "SELECT COUNT(*) FROM BookingDetail";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting bookingDetail: " + e.getMessage());
        }
        return 0;
    }
}
