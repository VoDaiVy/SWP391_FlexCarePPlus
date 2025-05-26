package models;

public class NotificationUser {
    private int userID, notificationID;
    private boolean status, hasRead;

    public NotificationUser() {
    }

    public NotificationUser(int userID, int notificationID, boolean status, boolean hasRead) {
        this.userID = userID;
        this.notificationID = notificationID;
        this.status = status;
        this.hasRead = hasRead;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isHasRead() {
        return hasRead;
    }

    public void setHasRead(boolean hasRead) {
        this.hasRead = hasRead;
    }
    
}
