package models;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class BookingDetail {
    public int bookingDetailID, bookingID, serviceID, roomID, stockBooking, userPetID;
    public LocalDateTime dateStartService, dateEndService;
    public LocalTime startTime, endTime;
    public float price;

    public BookingDetail() {
    }    
    
    public BookingDetail(int bookingDetailID, int bookingID, int serviceID, int roomID, int stockBooking, 
                         String dateStartService, String dateEndService, String startTime, String endTime, float price, int userPetID) {
        this.bookingDetailID = bookingDetailID;
        this.bookingID = bookingID;
        this.serviceID = serviceID;
        this.roomID = roomID;
        this.stockBooking = stockBooking;
        this.dateStartService = dateStartService != null ? LocalDateTime.parse(dateStartService, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null;
        this.dateEndService = dateEndService != null ? LocalDateTime.parse(dateEndService, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null;
        this.startTime = startTime != null ? LocalTime.parse(startTime, DateTimeFormatter.ofPattern("HH:mm:ss")) : null;
        this.endTime = endTime != null ? LocalTime.parse(endTime, DateTimeFormatter.ofPattern("HH:mm:ss")) : null;
        this.price = price;
        this.userPetID = userPetID;
    }

    public int getBookingDetailID() {
        return bookingDetailID;
    }

    public void setBookingDetailID(int bookingDetailID) {
        this.bookingDetailID = bookingDetailID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }
    
    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public int getStockBooking() {
        return stockBooking;
    }

    public void setStockBooking(int stockBooking) {
        this.stockBooking = stockBooking;
    }

    public String getDateStartService() {
        if(dateStartService == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(dateStartService);
    }

    public void setDateStartService(LocalDateTime dateStartService) {
        this.dateStartService = dateStartService;
    }

    public String getDateEndService() {
        if(dateEndService == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(dateEndService);
    }

    public void setDateEndService(LocalDateTime dateEndService) {
        this.dateEndService = dateEndService;
    }

    public String getStartTime() {
        if(startTime == null) return "";
        else return DateTimeFormatter.ofPattern("HH:mm:ss").format(startTime);
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        if(endTime == null) return "";
        else return DateTimeFormatter.ofPattern("HH:mm:ss").format(endTime);
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
    
    public int getUserPetID() {
        return userPetID;
    }
    
    public void setUserPetID(int userPetID) {
        this.userPetID = userPetID;
    }
    
    // Additional helper methods for date handling in controllers
    public void setStartDate(java.util.Date date) {
        if (date != null) {
            this.dateStartService = LocalDateTime.ofInstant(date.toInstant(), java.time.ZoneId.systemDefault());
        }
    }
    
    public void setEndDate(java.util.Date date) {
        if (date != null) {
            this.dateEndService = LocalDateTime.ofInstant(date.toInstant(), java.time.ZoneId.systemDefault());
        }
    }
}
