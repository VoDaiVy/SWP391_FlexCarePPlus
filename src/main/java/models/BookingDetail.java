
package models;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class BookingDetail {
    public int bookingID, serviceID, stockBooking;
    public LocalDateTime dateStartService, dateEndService;
    public LocalTime startTime, endTime;
    public float price;

    public BookingDetail() {
    }

    public BookingDetail(int bookingID, int serviceID, int stockBooking, String dateStartService, String dateEndService, String startTime, String endTime, float price) {
        this.bookingID = bookingID;
        this.serviceID = serviceID;
        this.stockBooking = stockBooking;
        this.dateStartService = LocalDateTime.parse(dateStartService, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.dateEndService = LocalDateTime.parse(dateEndService, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.startTime = LocalTime.parse(startTime, DateTimeFormatter.ofPattern("HH:mm:ss"));
        this.endTime = LocalTime.parse(endTime, DateTimeFormatter.ofPattern("HH:mm:ss"));
        this.price = price;
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
    
}
