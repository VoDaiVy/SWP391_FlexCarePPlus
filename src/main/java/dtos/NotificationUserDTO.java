package dtos;

import models.Notification;
import models.User;

public class NotificationUserDTO {
    private User user;                   // Instead of userID
    private Notification notification;   // Instead of notificationID
    private boolean status, hasRead;

    public NotificationUserDTO() {
    }

    public NotificationUserDTO(User user, Notification notification, boolean status, boolean hasRead) {
        this.user = user;
        this.notification = notification;
        this.status = status;
        this.hasRead = hasRead;
    }
    
    // Constructor that takes a NotificationUser model
    public NotificationUserDTO(models.NotificationUser notificationUser, User user, Notification notification) {
        this.user = user;
        this.notification = notification;
        this.status = notificationUser.isStatus();
        this.hasRead = notificationUser.isHasRead();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Notification getNotification() {
        return notification;
    }

    public void setNotification(Notification notification) {
        this.notification = notification;
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
    
    // Convert DTO back to original model (without the linked objects)
    public models.NotificationUser toNotificationUser() {
        models.NotificationUser notificationUser = new models.NotificationUser();
        notificationUser.setUserID(this.user != null ? this.user.getUserId() : 0);
        notificationUser.setNotificationID(this.notification != null ? this.notification.getNotificationID() : 0);
        notificationUser.setStatus(this.status);
        notificationUser.setHasRead(this.hasRead);
        return notificationUser;
    }
}
