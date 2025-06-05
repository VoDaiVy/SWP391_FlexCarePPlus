package models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MedicalRecords {
    public int medicalRecordsID;
    public int userPetID;
    public int userID;
    public LocalDateTime dateVisit;
    public String condition;
    public String diagnosis;
    public String treatment;
    public String notes;
    public LocalDateTime treatmentStart;
    public LocalDateTime treatmentEnd;
    public boolean followUpRequired;
    public Integer nextBookingID;
    public String state;
    public Boolean status;

    public MedicalRecords() {}

    public MedicalRecords(int medicalRecordsID, int userPetID, int userID, String dateVisit, 
                          String condition, String diagnosis, String treatment, String notes, 
                          String treatmentStart, String treatmentEnd, boolean followUpRequired, 
                          Integer nextBookingID, String state, Boolean status) {
        this.medicalRecordsID = medicalRecordsID;
        this.userPetID = userPetID;
        this.userID = userID;
        this.dateVisit = dateVisit != null ? LocalDateTime.parse(dateVisit, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null;
        this.condition = condition;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.notes = notes;
        this.treatmentStart = treatmentStart != null ? LocalDateTime.parse(treatmentStart, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null;
        this.treatmentEnd = treatmentEnd != null ? LocalDateTime.parse(treatmentEnd, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null;
        this.followUpRequired = followUpRequired;
        this.nextBookingID = nextBookingID;
        this.state = state;
        this.status = status;
    }

    public int getMedicalRecordsID() {
        return medicalRecordsID;
    }

    public void setMedicalRecordsID(int medicalRecordsID) {
        this.medicalRecordsID = medicalRecordsID;
    }

    public int getUserPetID() {
        return userPetID;
    }

    public void setUserPetID(int userPetID) {
        this.userPetID = userPetID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
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

    public Integer getNextBookingID() {
        return nextBookingID;
    }

    public void setNextBookingID(Integer nextBookingID) {
        this.nextBookingID = nextBookingID;
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
    
    @Override
    public String toString() {
        return "MedicalRecords{" + "medicalRecordsID=" + medicalRecordsID + ", userPetID=" + userPetID + 
                ", userID=" + userID + ", dateVisit=" + dateVisit + ", condition=" + condition + 
                ", diagnosis=" + diagnosis + ", treatment=" + treatment + ", notes=" + notes + 
                ", treatmentStart=" + treatmentStart + ", treatmentEnd=" + treatmentEnd + 
                ", followUpRequired=" + followUpRequired + ", nextBookingID=" + nextBookingID + 
                ", state=" + state + ", status=" + status + '}';
    }
}
