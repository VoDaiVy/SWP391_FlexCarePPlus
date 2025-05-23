
package models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class FeedbackService {
    public int feedbackServiceID, userID, bookingID, serviceID;
    public LocalDateTime dateCreated;
    public int rating;
    public String comment;
    public boolean status;

    public FeedbackService() {
    }

    public FeedbackService(int feedbackServiceID, int userID, int bookingID, int serviceID, String dateCreated, int rating, String comment, boolean status) {
        this.feedbackServiceID = feedbackServiceID;
        this.userID = userID;
        this.bookingID = bookingID;
        this.serviceID = serviceID;
        this.dateCreated = LocalDateTime.parse(dateCreated, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.rating = rating;
        this.comment = comment;
        this.status = status;
    }

    public int getFeedbackServiceID() {
        return feedbackServiceID;
    }

    public void setFeedbackServiceID(int feedbackServiceID) {
        this.feedbackServiceID = feedbackServiceID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public String getDateCreated() {
        if(dateCreated == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(dateCreated);
    }

    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "FeedbackService{" + "feedbackServiceID=" + feedbackServiceID + ", userID=" + userID + ", bookingID=" + bookingID + ", serviceID=" + serviceID + ", dateCreated=" + dateCreated + ", rating=" + rating + ", comment=" + comment + ", status=" + status + '}';
    }
    
}
