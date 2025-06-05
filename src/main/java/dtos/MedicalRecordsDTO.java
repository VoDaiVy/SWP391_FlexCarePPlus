package dtos;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import models.MedicalRecords;
import models.User;
import models.UserPet;
import models.Booking;
import daos.UserPetDAO;
import daos.UserDAO;
import daos.BookingDAO;

public class MedicalRecordsDTO {
    private int medicalRecordsID;
    private UserPet userPet;         // Instead of userPetID
    private User user;               // Instead of userID
    private LocalDateTime dateVisit;
    private String condition;
    private String diagnosis;
    private String treatment;
    private String notes;
    private LocalDateTime treatmentStart;
    private LocalDateTime treatmentEnd;
    private boolean followUpRequired;
    private Booking nextBooking;     // Instead of nextBookingID
    private String state;
    private Boolean status;

    public MedicalRecordsDTO() {}
    
    // Constructor from full model with linked objects
    public MedicalRecordsDTO(MedicalRecords record, UserPet userPet, User user, Booking nextBooking) {
        this.medicalRecordsID = record.getMedicalRecordsID();
        this.userPet = userPet;
        this.user = user;
        this.dateVisit = record.dateVisit;
        this.condition = record.getCondition();
        this.diagnosis = record.getDiagnosis();
        this.treatment = record.getTreatment();
        this.notes = record.getNotes();
        this.treatmentStart = record.treatmentStart;
        this.treatmentEnd = record.treatmentEnd;
        this.followUpRequired = record.isFollowUpRequired();
        this.nextBooking = nextBooking;
        this.state = record.getState();
        this.status = record.getStatus();
    }
      // Constructor from model with just IDs
    public MedicalRecordsDTO(MedicalRecords record) {
        this.medicalRecordsID = record.getMedicalRecordsID();
        this.userPet = UserPetDAO.getById(record.getUserPetID());
        this.user = UserDAO.getById(record.getUserID());
        this.dateVisit = record.dateVisit;
        this.condition = record.getCondition();
        this.diagnosis = record.getDiagnosis();
        this.treatment = record.getTreatment();
        this.notes = record.getNotes();
        this.treatmentStart = record.treatmentStart;
        this.treatmentEnd = record.treatmentEnd;
        this.followUpRequired = record.isFollowUpRequired();
        if (record.getNextBookingID() != null) {
            this.nextBooking = BookingDAO.getById(record.getNextBookingID());
        }
        this.state = record.getState();
        this.status = record.getStatus();
    }
    
    public int getMedicalRecordsID() { 
        return medicalRecordsID; 
    }
    
    public void setMedicalRecordsID(int medicalRecordsID) { 
        this.medicalRecordsID = medicalRecordsID; 
    }
      public UserPet getUserPet() {
        return userPet;
    }

    public void setUserPet(UserPet userPet) {
        this.userPet = userPet;
    }
    
    public int getUserPetID() { 
        return userPet != null ? userPet.getUserPetID() : 0; 
    }
    
    public void setUserPetID(int userPetID) { 
        this.userPet = UserPetDAO.getById(userPetID);
    }
    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    public int getUserID() { 
        return user != null ? user.getUserId() : 0; 
    }
    
    public void setUserID(int userID) { 
        this.user = UserDAO.getById(userID);
    }
    
    public String getDateVisit() {
        if(dateVisit == null) return "";
        return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(dateVisit);
    }

    public void setDateVisit(LocalDateTime dateVisit) {
        this.dateVisit = dateVisit;
    }
    
    public String getCondition() { 
        return condition; 
    }
    
    public void setCondition(String condition) { 
        this.condition = condition; 
    }
    
    public String getDiagnosis() { 
        return diagnosis; 
    }
    
    public void setDiagnosis(String diagnosis) { 
        this.diagnosis = diagnosis; 
    }
    
    public String getTreatment() { 
        return treatment; 
    }
    
    public void setTreatment(String treatment) { 
        this.treatment = treatment; 
    }
    
    public String getNotes() { 
        return notes; 
    }
    
    public void setNotes(String notes) { 
        this.notes = notes; 
    }
    
    public String getTreatmentStart() {
        if(treatmentStart == null) return "";
        return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(treatmentStart);
    }

    public void setTreatmentStart(LocalDateTime treatmentStart) {
        this.treatmentStart = treatmentStart;
    }
    
    public String getTreatmentEnd() {
        if(treatmentEnd == null) return "";
        return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(treatmentEnd);
    }

    public void setTreatmentEnd(LocalDateTime treatmentEnd) {
        this.treatmentEnd = treatmentEnd;
    }
    
    public boolean isFollowUpRequired() {
        return followUpRequired;
    }

    public void setFollowUpRequired(boolean followUpRequired) {
        this.followUpRequired = followUpRequired;
    }
      public Booking getNextBooking() {
        return nextBooking;
    }

    public void setNextBooking(Booking nextBooking) {
        this.nextBooking = nextBooking;
    }
    
    public Integer getNextBookingID() {
        return nextBooking != null ? nextBooking.getBookingID() : null;
    }

    public void setNextBookingID(Integer nextBookingID) {
        if (nextBookingID != null) {
            this.nextBooking = BookingDAO.getById(nextBookingID);
        } else {
            this.nextBooking = null;
        }
    }
    
    public String getState() { 
        return state; 
    }
    
    public void setState(String state) { 
        this.state = state; 
    }
    
    public Boolean getStatus() { 
        return status; 
    }
    
    public void setStatus(Boolean status) { 
        this.status = status; 
    }
      // Convert DTO back to original model
    public MedicalRecords toMedicalRecord() {
        MedicalRecords record = new MedicalRecords();
        record.setMedicalRecordsID(this.medicalRecordsID);
        record.setUserPetID(this.userPet != null ? this.userPet.getUserPetID() : 0);
        record.setUserID(this.user != null ? this.user.getUserId() : 0);
        record.setDateVisit(this.dateVisit);
        record.setCondition(this.condition);
        record.setDiagnosis(this.diagnosis);
        record.setTreatment(this.treatment);
        record.setNotes(this.notes);
        record.setTreatmentStart(this.treatmentStart);
        record.setTreatmentEnd(this.treatmentEnd);
        record.setFollowUpRequired(this.followUpRequired);
        record.setNextBookingID(this.nextBooking != null ? this.nextBooking.getBookingID() : null);
        record.setState(this.state);
        record.setStatus(this.status);
        return record;
    }
}
