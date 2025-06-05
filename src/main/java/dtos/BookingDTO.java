package dtos;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import models.User;
import models.Booking;
import daos.UserDAO;

public class BookingDTO {
    private int bookingID;
    private User user;           // Instead of userID
    private LocalDateTime dateBooked;
    private float totalPrice, paid;
    private String state, note;
    private boolean status;

    public BookingDTO() {
    }

    public BookingDTO(int bookingID, User user, LocalDateTime dateBooked, 
                    float totalPrice, float paid, String state, String note, boolean status) {
        this.bookingID = bookingID;
        this.user = user;
        this.dateBooked = dateBooked;
        this.totalPrice = totalPrice;
        this.paid = paid;
        this.state = state;
        this.note = note;
        this.status = status;
    }

    // Constructor that takes a Booking model with User object
    public BookingDTO(models.Booking booking, User user) {
        this.bookingID = booking.getBookingID();
        this.user = user;
        this.dateBooked = booking.dateBooked;
        this.totalPrice = booking.getTotalPrice();
        this.paid = booking.getPaid();
        this.state = booking.getState();
        this.note = booking.getNote();
        this.status = booking.isStatus();
    }
      // Constructor that takes only a Booking model
    public BookingDTO(models.Booking booking) {
        this.bookingID = booking.getBookingID();
        this.user = UserDAO.getById(booking.getUserID());
        this.dateBooked = booking.dateBooked;
        this.totalPrice = booking.getTotalPrice();
        this.paid = booking.getPaid();
        this.state = booking.getState();
        this.note = booking.getNote();
        this.status = booking.isStatus();
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public User getUser() {
        return user;
    }    public void setUser(User user) {
        this.user = user;
    }
    
    public int getUserID() {
        return user != null ? user.getUserId() : 0;
    }

    public void setUserID(int userID) {
        this.user = UserDAO.getById(userID);
    }
    
    // Removed room getter and setter as it's not in the database schema

    public String getDateBooked() {
        if(dateBooked == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(dateBooked);
    }

    public void setDateBooked(LocalDateTime dateBooked) {
        this.dateBooked = dateBooked;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public float getPaid() {
        return paid;
    }

    public void setPaid(float paid) {
        this.paid = paid;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
      // Convert DTO back to original model
    public models.Booking toBooking() {
        models.Booking booking = new models.Booking();
        booking.setBookingID(this.bookingID);
        booking.setUserID(this.user != null ? this.user.getUserId() : 0);
        booking.setDateBooked(this.dateBooked);
        booking.setTotalPrice(this.totalPrice);
        booking.setPaid(this.paid);
        booking.setState(this.state);
        booking.setNote(this.note);
        booking.setStatus(this.status);
        return booking;
    }
}
