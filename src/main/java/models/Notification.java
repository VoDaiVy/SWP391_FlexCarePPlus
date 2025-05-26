package models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Notification {
    private int notificationID;
    private String content;
    private LocalDateTime dateCreated;

    public Notification() {
    }

    public Notification(int notificationID, String content, String dateCreated) {
        this.notificationID = notificationID;
        this.content = content;
        this.dateCreated = LocalDateTime.parse(dateCreated, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDateCreated() {
        if(dateCreated == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(dateCreated);
    }

    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }
    
}
