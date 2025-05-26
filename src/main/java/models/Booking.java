
package models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Booking {
    public int bookingID, userID, roomID;
    public LocalDateTime dateBooked;
    public float totalPrice, paid;
    public String state, note;
    public boolean status;
    public static enum BookingState {CANCEL, BOOKED, FINISHED};
    
    public Booking() {
    }

    public Booking(int bookingID, int userID, int roomID, String dateBooked, float totalPrice, float paid, String state, String note, boolean status) {
        this.bookingID = bookingID;
        this.userID = userID;
        this.roomID = roomID;
        this.dateBooked = LocalDateTime.parse(dateBooked, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.totalPrice = totalPrice;
        this.paid = paid;
        this.state = state;
        this.note = note;
        this.status = status;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

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

    @Override
    public String toString() {
        return "Booking{" + "bookingID=" + bookingID + ", userID=" + userID + ", roomID=" + roomID + ", dateBooked=" + dateBooked + ", totalPrice=" + totalPrice + ", paid=" + paid + ", state=" + state + ", note=" + note + ", status=" + status + '}';
    }
    
}
