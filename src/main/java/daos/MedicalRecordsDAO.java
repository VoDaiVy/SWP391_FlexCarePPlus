package daos;

import java.sql.*;
import java.util.*;
import models.MedicalRecords;
import utils.DBConnection;
import java.time.LocalDateTime;

public class MedicalRecordsDAO {
    // Create a new medical record
    public static boolean create(MedicalRecords record) {
        String sql = "INSERT INTO MedicalRecords (UserPetID, UserID, DateVisit, Condition, Diagnosis, Treatment, Notes, " +
                     "TreatmentStart, TreatmentEnd, FollowUpRequired, NextBookingID, State, Status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, record.getUserPetID());
            ps.setInt(2, record.getUserID());
            
            // Handle date visit (defaults to current time if null)
            ps.setTimestamp(3, record.dateVisit != null ? 
                Timestamp.valueOf(record.dateVisit) : 
                Timestamp.valueOf(LocalDateTime.now()));
                
            ps.setString(4, record.getCondition());
            ps.setString(5, record.getDiagnosis());
            ps.setString(6, record.getTreatment());
            ps.setString(7, record.getNotes());
            
            ps.setTimestamp(8, record.treatmentStart != null ? Timestamp.valueOf(record.treatmentStart) : null);
            ps.setTimestamp(9, record.treatmentEnd != null ? Timestamp.valueOf(record.treatmentEnd) : null);
            
            ps.setBoolean(10, record.isFollowUpRequired());
            
            if (record.getNextBookingID() != null) {
                ps.setInt(11, record.getNextBookingID());
            } else {
                ps.setNull(11, java.sql.Types.INTEGER);
            }
            
            ps.setString(12, record.getState());
            ps.setBoolean(13, record.getStatus() != null ? record.getStatus() : false);
            
            int rowsAffected = ps.executeUpdate();
            
            // Get generated ID and set it to record object
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    record.setMedicalRecordsID(rs.getInt(1));
                }
                rs.close();
                return true;
            }
            
        } catch (SQLException e) {
            System.out.println("Error creating medical record: " + e.getMessage());
        }
        return false;
    }
    
    // Get a medical record by ID
    public static MedicalRecords getById(int medicalRecordsID) {
        String sql = "SELECT * FROM MedicalRecords WHERE MedicalRecordsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, medicalRecordsID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                MedicalRecords record = new MedicalRecords();
                record.setMedicalRecordsID(rs.getInt("MedicalRecordsID"));
                record.setUserPetID(rs.getInt("UserPetID"));
                record.setUserID(rs.getInt("UserID"));
                
                Timestamp dateVisit = rs.getTimestamp("DateVisit");
                if (dateVisit != null) {
                    record.setDateVisit(dateVisit.toLocalDateTime());
                }
                
                record.setCondition(rs.getString("Condition"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setTreatment(rs.getString("Treatment"));
                record.setNotes(rs.getString("Notes"));
                
                Timestamp treatmentStart = rs.getTimestamp("TreatmentStart");
                if (treatmentStart != null) {
                    record.setTreatmentStart(treatmentStart.toLocalDateTime());
                }
                
                Timestamp treatmentEnd = rs.getTimestamp("TreatmentEnd");
                if (treatmentEnd != null) {
                    record.setTreatmentEnd(treatmentEnd.toLocalDateTime());
                }
                
                record.setFollowUpRequired(rs.getBoolean("FollowUpRequired"));
                
                int nextBookingID = rs.getInt("NextBookingID");
                if (!rs.wasNull()) {
                    record.setNextBookingID(nextBookingID);
                }
                
                record.setState(rs.getString("State"));
                record.setStatus(rs.getBoolean("Status"));
                
                return record;
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving medical record: " + e.getMessage());
        }
        return null;
    }
    
    // Get all medical records for a user pet
    public static List<MedicalRecords> getByUserPetId(int userPetID) {
        List<MedicalRecords> records = new ArrayList<>();
        String sql = "SELECT * FROM MedicalRecords WHERE UserPetID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userPetID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                MedicalRecords record = new MedicalRecords();
                record.setMedicalRecordsID(rs.getInt("MedicalRecordsID"));
                record.setUserPetID(rs.getInt("UserPetID"));
                record.setUserID(rs.getInt("UserID"));
                
                Timestamp dateVisit = rs.getTimestamp("DateVisit");
                if (dateVisit != null) {
                    record.setDateVisit(dateVisit.toLocalDateTime());
                }
                
                record.setCondition(rs.getString("Condition"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setTreatment(rs.getString("Treatment"));
                record.setNotes(rs.getString("Notes"));
                
                Timestamp treatmentStart = rs.getTimestamp("TreatmentStart");
                if (treatmentStart != null) {
                    record.setTreatmentStart(treatmentStart.toLocalDateTime());
                }
                
                Timestamp treatmentEnd = rs.getTimestamp("TreatmentEnd");
                if (treatmentEnd != null) {
                    record.setTreatmentEnd(treatmentEnd.toLocalDateTime());
                }
                
                record.setFollowUpRequired(rs.getBoolean("FollowUpRequired"));
                
                int nextBookingID = rs.getInt("NextBookingID");
                if (!rs.wasNull()) {
                    record.setNextBookingID(nextBookingID);
                }
                
                record.setState(rs.getString("State"));
                record.setStatus(rs.getBoolean("Status"));
                
                records.add(record);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving medical records: " + e.getMessage());
        }
        return records;
    }
    
    // Get all medical records for a user
    public static List<MedicalRecords> getByUserId(int userID) {
        List<MedicalRecords> records = new ArrayList<>();
        String sql = "SELECT * FROM MedicalRecords WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                MedicalRecords record = new MedicalRecords();
                record.setMedicalRecordsID(rs.getInt("MedicalRecordsID"));
                record.setUserPetID(rs.getInt("UserPetID"));
                record.setUserID(rs.getInt("UserID"));
                
                Timestamp dateVisit = rs.getTimestamp("DateVisit");
                if (dateVisit != null) {
                    record.setDateVisit(dateVisit.toLocalDateTime());
                }
                
                record.setCondition(rs.getString("Condition"));
                record.setDiagnosis(rs.getString("Diagnosis"));
                record.setTreatment(rs.getString("Treatment"));
                record.setNotes(rs.getString("Notes"));
                
                Timestamp treatmentStart = rs.getTimestamp("TreatmentStart");
                if (treatmentStart != null) {
                    record.setTreatmentStart(treatmentStart.toLocalDateTime());
                }
                
                Timestamp treatmentEnd = rs.getTimestamp("TreatmentEnd");
                if (treatmentEnd != null) {
                    record.setTreatmentEnd(treatmentEnd.toLocalDateTime());
                }
                
                record.setFollowUpRequired(rs.getBoolean("FollowUpRequired"));
                
                int nextBookingID = rs.getInt("NextBookingID");
                if (!rs.wasNull()) {
                    record.setNextBookingID(nextBookingID);
                }
                
                record.setState(rs.getString("State"));
                record.setStatus(rs.getBoolean("Status"));
                
                records.add(record);
            }
            
        } catch (SQLException e) {
            System.out.println("Error retrieving medical records: " + e.getMessage());
        }
        return records;
    }
    
    // Update a medical record
    public static boolean update(MedicalRecords record) {
        String sql = "UPDATE MedicalRecords SET UserPetID = ?, UserID = ?, DateVisit = ?, Condition = ?, " +
                     "Diagnosis = ?, Treatment = ?, Notes = ?, TreatmentStart = ?, TreatmentEnd = ?, " +
                     "FollowUpRequired = ?, NextBookingID = ?, State = ?, Status = ? " +
                     "WHERE MedicalRecordsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, record.getUserPetID());
            ps.setInt(2, record.getUserID());
            
            ps.setTimestamp(3, record.dateVisit != null ? Timestamp.valueOf(record.dateVisit) : null);
            
            ps.setString(4, record.getCondition());
            ps.setString(5, record.getDiagnosis());
            ps.setString(6, record.getTreatment());
            ps.setString(7, record.getNotes());
            
            ps.setTimestamp(8, record.treatmentStart != null ? Timestamp.valueOf(record.treatmentStart) : null);
            ps.setTimestamp(9, record.treatmentEnd != null ? Timestamp.valueOf(record.treatmentEnd) : null);
            
            ps.setBoolean(10, record.isFollowUpRequired());
            
            if (record.getNextBookingID() != null) {
                ps.setInt(11, record.getNextBookingID());
            } else {
                ps.setNull(11, java.sql.Types.INTEGER);
            }
            
            ps.setString(12, record.getState());
            ps.setBoolean(13, record.getStatus() != null ? record.getStatus() : false);
            ps.setInt(14, record.getMedicalRecordsID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error updating medical record: " + e.getMessage());
        }
        return false;
    }
    
    // Delete a medical record
    public static boolean delete(int medicalRecordsID) {
        String sql = "DELETE FROM MedicalRecords WHERE MedicalRecordsID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, medicalRecordsID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.out.println("Error deleting medical record: " + e.getMessage());
        }
        return false;
    }
}
