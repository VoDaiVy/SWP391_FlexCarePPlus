
package models;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Policy {
    public int policyID;
    public String title, description;
    public LocalDate dateCreated;
    public boolean status;

    public Policy() {
    }

    public Policy(int policyID, String title, String description, String dateCreated, boolean status) {
        this.policyID = policyID;
        this.title = title;
        this.description = description;
        this.dateCreated = LocalDate.parse(dateCreated, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        this.status = status;
    }

    public int getPolicyID() {
        return policyID;
    }

    public void setPolicyID(int policyID) {
        this.policyID = policyID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDateCreated() {
        if (dateCreated == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd").format(dateCreated);
    }

    public void setDateCreated(LocalDate dateCreated) {
        this.dateCreated = dateCreated;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Policy{" + "policyID=" + policyID + ", title=" + title + ", description=" + description + ", dateCreated=" + dateCreated + ", status=" + status + '}';
    }
    
}
