package dtos;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import models.Booking;
import models.Service;

public class BookingDetailDTO {
    private Booking booking;     // Instead of bookingID
    private Service service;     // Instead of serviceID
    private int stockBooking;
    private LocalDateTime dateStartService, dateEndService;
    private LocalTime startTime, endTime;
    private float price;

    public BookingDetailDTO() {
    }

    public BookingDetailDTO(Booking booking, Service service, int stockBooking, 
                          LocalDateTime dateStartService, LocalDateTime dateEndService, 
                          LocalTime startTime, LocalTime endTime, float price) {
        this.booking = booking;
        this.service = service;
        this.stockBooking = stockBooking;
        this.dateStartService = dateStartService;
        this.dateEndService = dateEndService;
        this.startTime = startTime;
        this.endTime = endTime;
        this.price = price;
    }
    
    // Constructor that takes a BookingDetail model
    public BookingDetailDTO(models.BookingDetail bookingDetail, Booking booking, Service service) {
        this.booking = booking;
        this.service = service;
        this.stockBooking = bookingDetail.getStockBooking();
        this.dateStartService = bookingDetail.dateStartService;
        this.dateEndService = bookingDetail.dateEndService;
        this.startTime = bookingDetail.startTime;
        this.endTime = bookingDetail.endTime;
        this.price = bookingDetail.getPrice();
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
    
    // Convert DTO back to original model (without the linked objects)
    public models.BookingDetail toBookingDetail() {
        models.BookingDetail bookingDetail = new models.BookingDetail();
        bookingDetail.setBookingID(this.booking != null ? this.booking.getBookingID() : 0);
        bookingDetail.setServiceID(this.service != null ? this.service.getServiceID() : 0);
        bookingDetail.setStockBooking(this.stockBooking);
        bookingDetail.dateStartService = this.dateStartService;
        bookingDetail.dateEndService = this.dateEndService;
        bookingDetail.startTime = this.startTime;
        bookingDetail.endTime = this.endTime;
        bookingDetail.setPrice(this.price);
        return bookingDetail;
    }
}
