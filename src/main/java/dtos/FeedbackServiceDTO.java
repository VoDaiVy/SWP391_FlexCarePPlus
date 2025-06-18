package dtos;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import models.Booking;
import models.Service;
import models.User;

public class FeedbackServiceDTO {
    private int feedbackServiceID;
    private User user;               // Instead of userID
    private Booking booking;         // Instead of bookingID
    private Service service;         // Instead of serviceID
    private LocalDateTime dateCreated;
    private int rating;
    private String comment;
    private boolean status;

    public FeedbackServiceDTO() {
    }

    public FeedbackServiceDTO(int feedbackServiceID, User user, Booking booking, Service service,
                            LocalDateTime dateCreated, int rating, String comment, boolean status) {
        this.feedbackServiceID = feedbackServiceID;
        this.user = user;
        this.booking = booking;
        this.service = service;
        this.dateCreated = dateCreated;
        this.rating = rating;
        this.comment = comment;
        this.status = status;
    }
    
    // Constructor that takes a FeedbackService model
    public FeedbackServiceDTO(models.FeedbackService feedbackService, User user, Booking booking, Service service) {
        this.feedbackServiceID = feedbackService.getFeedbackServiceID();
        this.user = user;
        this.booking = booking;
        this.service = service;
        this.dateCreated = feedbackService.dateCreated;
        this.rating = feedbackService.getRating();
        this.comment = feedbackService.getComment();
        this.status = feedbackService.isStatus();
    }

    public int getFeedbackServiceID() {
        return feedbackServiceID;
    }

    public void setFeedbackServiceID(int feedbackServiceID) {
        this.feedbackServiceID = feedbackServiceID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
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
    
    // Convert DTO back to original model (without the linked objects)
    public models.FeedbackService toFeedbackService() {
        models.FeedbackService feedbackService = new models.FeedbackService();
        feedbackService.setFeedbackServiceID(this.feedbackServiceID);
        feedbackService.setUserID(this.user != null ? this.user.getUserId() : 0);
        feedbackService.setBookingID(this.booking != null ? this.booking.getBookingID() : 0);
        feedbackService.setServiceID(this.service != null ? this.service.getServiceID() : 0);
        feedbackService.dateCreated = this.dateCreated;
        feedbackService.setRating(this.rating);
        feedbackService.setComment(this.comment);
        feedbackService.setStatus(this.status);
        return feedbackService;
    }
}
