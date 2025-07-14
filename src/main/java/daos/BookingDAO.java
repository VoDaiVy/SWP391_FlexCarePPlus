package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import models.Booking;
import utils.DBConnection;

public class BookingDAO {

    // Create a new booking
    public static boolean create(Booking booking) {
        String sql = "INSERT INTO Booking (UserID, DateBooked, TotalPrice, Paid, State, Note, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, booking.getUserID());

            // Handle LocalDateTime conversion to SQL Timestamp
            ps.setTimestamp(2, booking.dateBooked != null ? Timestamp.valueOf(booking.dateBooked) : null);

            ps.setFloat(3, booking.getTotalPrice());
            ps.setFloat(4, booking.getPaid());
            ps.setString(5, booking.getState());
            ps.setString(6, booking.getNote());
            ps.setBoolean(7, booking.isStatus());

            int rowsAffected = ps.executeUpdate();

            // Get generated ID and set it to booking object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    booking.setBookingID(rs.getInt(1));
                }
                rs.close();
                return true;
            }

        } catch (SQLException e) {
            System.out.println("Error creating booking: " + e.getMessage());
        }
        return false;
    }
    // Get a booking by ID

    public static Booking getById(int bookingID) {
        String sql = "SELECT * FROM Booking WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));

                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }

                booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));
                return booking;
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving booking: " + e.getMessage());
        }
        return null;
    }
    // Get all bookings

    public static List<Booking> getAll() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));

                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }

                booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));
                bookings.add(booking);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving all bookings: " + e.getMessage());
        }
        return bookings;
    }
    // Get bookings by user ID

    public static List<Booking> getByUserId(int userID) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));

                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }

                booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));
                bookings.add(booking);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving bookings by user ID: " + e.getMessage());
        }
        return bookings;
    }
    // Update a booking

    public static boolean update(Booking booking) {
        String sql = "UPDATE Booking SET UserID = ?, DateBooked = ?, TotalPrice = ?, Paid = ?, State = ?, Note = ?, Status = ? WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking.getUserID());

            // Handle LocalDateTime conversion to SQL Timestamp
            LocalDateTime dateBooked = null;
            if (!booking.getDateBooked().isEmpty()) {
                dateBooked = LocalDateTime.parse(booking.getDateBooked(),
                        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            ps.setTimestamp(2, dateBooked != null ? Timestamp.valueOf(dateBooked) : null);

            ps.setFloat(3, booking.getTotalPrice());
            ps.setFloat(4, booking.getPaid());
            ps.setString(5, booking.getState());
            ps.setString(6, booking.getNote());
            ps.setBoolean(7, booking.isStatus());
            ps.setInt(8, booking.getBookingID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error updating booking: " + e.getMessage());
        }
        return false;
    }
    // Delete a booking (soft delete by setting status to false)

    public static boolean delete(int bookingID) {
        String sql = "UPDATE Booking SET Status = 0 WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting booking: " + e.getMessage());
        }
        return false;
    }
    // Hard delete a booking (remove from database)

    public static boolean hardDelete(int bookingID) {
        String sql = "DELETE FROM Booking WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error hard deleting booking: " + e.getMessage());
        }
        return false;
    }
    // Get bookings by state

    public static List<Booking> getByState(String state) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE State = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, state);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));

                // Handle SQL Timestamp to LocalDateTime conversion
                Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }

                booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));
                bookings.add(booking);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving bookings by state: " + e.getMessage());
        }
        return bookings;
    }

    // Get bookings by user ID and state
    public static List<Booking> getByUserIdAndState(int userID, String state) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE UserID = ? AND State = ? AND Status = 1 ORDER BY BookingID DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setString(2, state);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));

                Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }

                booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));

                bookings.add(booking);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving bookings by user ID and state: " + e.getMessage());
        }
        return bookings;
    }

    public static List<Booking> getByMonthYear(int month, int year) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE MONTH(DateBooked) = ? AND YEAR(DateBooked) = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));
                Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }
                booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving bookings by month/year: " + e.getMessage());
        }
        return bookings;
    }

    public static List<Booking> getByDate(int day, int month, int year) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE DAY(DateBooked) = ? AND MONTH(DateBooked) = ? AND YEAR(DateBooked) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, day);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ResultSet rs = ps.executeQuery();
          while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));
            Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }
            booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));
            bookings.add(booking);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving bookings by day/month/year: " + e.getMessage());
        }
        return bookings;
    }

public static List<Booking> getByUserIdExcludeStates(int userID, String[] excludeStates) {
    public static List<Booking> getByUserIdExcludeStates(int userID, String[] excludeStates) {
        List<Booking> bookings = new ArrayList<>();

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < excludeStates.length; i++) {
            if (i > 0) {
                placeholders.append(", ");
            }
            placeholders.append("?");
        }

        String sql = "SELECT * FROM Booking WHERE UserID = ? AND Status = 1 AND State NOT IN ("
                + placeholders.toString() + ") ORDER BY DateBooked DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);

            for (int i = 0; i < excludeStates.length; i++) {
                ps.setString(2 + i, excludeStates[i]);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setUserID(rs.getInt("UserID"));
                Timestamp dateBookedTimestamp = rs.getTimestamp("DateBooked");
                if (dateBookedTimestamp != null) {
                    booking.setDateBooked(dateBookedTimestamp.toLocalDateTime());
                }
                booking.setTotalPrice(rs.getFloat("TotalPrice"));
                booking.setPaid(rs.getFloat("Paid"));
                booking.setState(rs.getString("State"));
                booking.setNote(rs.getString("Note"));
                booking.setStatus(rs.getBoolean("Status"));
              bookings.add(booking);
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving bookings by user ID excluding states: " + e.getMessage());
        }
        return bookings;
    }

    public static boolean updateState(int bookingId, String newState) {
        String sql = "UPDATE Booking SET State = ? WHERE BookingID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newState);
            ps.setInt(2, bookingId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating booking state: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateBookingDate(int bookingId) {
        String sql = "UPDATE Booking SET DateBooked = GETDATE() WHERE BookingID = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating booking date: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static int updateCompletedBookingsToFinished(List<Integer> bookingIds) {
        if (bookingIds.isEmpty()) {
            return 0;
        }

        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < bookingIds.size(); i++) {
            placeholders.append("?");
            if (i < bookingIds.size() - 1) {
                placeholders.append(",");
            }
        }

        String sql = "UPDATE Booking SET State = ? WHERE BookingID IN (" + placeholders.toString() + ") AND State = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, Booking.BookingState.FINISHED.toString());

            for (int i = 0; i < bookingIds.size(); i++) {
                ps.setInt(i + 2, bookingIds.get(i));
            }

            ps.setString(bookingIds.size() + 2, Booking.BookingState.BOOKED.toString());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected;

        } catch (SQLException e) {
            System.err.println("Error updating completed bookings to finished: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
}
