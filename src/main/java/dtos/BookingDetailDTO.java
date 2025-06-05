package dtos;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import models.Booking;
import models.Service;
import models.Room;
import models.UserPet;
import daos.BookingDAO;
import daos.ServiceDAO;
import daos.RoomDAO;
import daos.UserPetDAO;

public class BookingDetailDTO {
    private int bookingDetailID;
    private Booking booking;     // Instead of bookingID
    private Service service;     // Instead of serviceID
    private Room room;           // Instead of roomID
    private models.UserPet userPet;   // Instead of userPetID
    private int stockBooking;
    private LocalDateTime dateStartService, dateEndService;
    private LocalTime startTime, endTime;
    private float price;

    public BookingDetailDTO() {
    }

    public BookingDetailDTO(int bookingDetailID, Booking booking, Service service, Room room, UserPet userPet, int stockBooking,
                            LocalDateTime dateStartService, LocalDateTime dateEndService,
                            LocalTime startTime, LocalTime endTime, float price) {
        this.bookingDetailID = bookingDetailID;
        this.booking = booking;
        this.service = service;
        this.room = room;
        this.userPet = userPet;
        this.stockBooking = stockBooking;
        this.dateStartService = dateStartService;
        this.dateEndService = dateEndService;
        this.startTime = startTime;
        this.endTime = endTime;
        this.price = price;
    }
      // Constructor that takes a BookingDetail model with full objects
    public BookingDetailDTO(models.BookingDetail bookingDetail, Booking booking, Service service, Room room, UserPet userPet) {
        this.bookingDetailID = bookingDetail.getBookingDetailID();
        this.booking = booking;
        this.service = service;
        this.room = room;
        this.userPet = userPet;
        this.stockBooking = bookingDetail.getStockBooking();
        this.dateStartService = bookingDetail.dateStartService;
        this.dateEndService = bookingDetail.dateEndService;
        this.startTime = bookingDetail.startTime;
        this.endTime = bookingDetail.endTime;
        this.price = bookingDetail.getPrice();
    }
          // Constructor that takes only a BookingDetail model
    public BookingDetailDTO(models.BookingDetail bookingDetail) {
        this.bookingDetailID = bookingDetail.getBookingDetailID();
        this.booking = BookingDAO.getById(bookingDetail.getBookingID());
        this.service = ServiceDAO.getById(bookingDetail.getServiceID());
        this.room = RoomDAO.getById(bookingDetail.getRoomID());
        this.userPet = UserPetDAO.getById(bookingDetail.getUserPetID());
        this.stockBooking = bookingDetail.getStockBooking();
        this.dateStartService = bookingDetail.dateStartService;
        this.dateEndService = bookingDetail.dateEndService;
        this.startTime = bookingDetail.startTime;
        this.endTime = bookingDetail.endTime;
        this.price = bookingDetail.getPrice();
    }
    
    public int getBookingDetailID() {
        return bookingDetailID;
    }

    public void setBookingDetailID(int bookingDetailID) {
        this.bookingDetailID = bookingDetailID;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public int getBookingID() {
        return booking != null ? booking.getBookingID() : 0;
    }

    public void setBookingID(int bookingID) {
        this.booking = BookingDAO.getById(bookingID);
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public int getServiceID() {
        return service != null ? service.getServiceID() : 0;
    }

    public void setServiceID(int serviceID) {
        this.service = ServiceDAO.getById(serviceID);
    }
    
    public Room getRoom() {
        return room;
    }    public void setRoom(Room room) {
        this.room = room;
    }
    
    public int getRoomID() {
        return room != null ? room.getRoomID() : 0;
    }

    public void setRoomID(int roomID) {
        this.room = RoomDAO.getById(roomID);
    }

    public UserPet getUserPet() {
        return userPet;
    }
    
    public void setUserPet(UserPet userPet) {
        this.userPet = userPet;
    }
    
    public int getUserPetID() {
        return userPet != null ? userPet.getUserPetID() : 0;
    }
    
    public void setUserPetID(int userPetID) {
        this.userPet = UserPetDAO.getById(userPetID);
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
    }      // Convert DTO back to original model
    public models.BookingDetail toBookingDetail() {
        models.BookingDetail bookingDetail = new models.BookingDetail();
        bookingDetail.setBookingDetailID(this.bookingDetailID);
        bookingDetail.setBookingID(this.booking != null ? this.booking.getBookingID() : 0);
        bookingDetail.setServiceID(this.service != null ? this.service.getServiceID() : 0);
        bookingDetail.setRoomID(this.room != null ? this.room.getRoomID() : 0);
        bookingDetail.setUserPetID(this.userPet != null ? this.userPet.getUserPetID() : 0);
        bookingDetail.setStockBooking(this.stockBooking);
        bookingDetail.dateStartService = this.dateStartService;
        bookingDetail.dateEndService = this.dateEndService;
        bookingDetail.startTime = this.startTime;
        bookingDetail.endTime = this.endTime;
        bookingDetail.setPrice(this.price);
        return bookingDetail;
    }
}
