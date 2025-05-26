package dtos;

import models.Service;
import models.User;

public class CartDTO {
    private User user;           // Instead of userID
    private Service service;     // Instead of serviceID
    private int stock;
    private boolean statusBooking, display;

    public CartDTO() {
    }

    public CartDTO(User user, Service service, int stock, boolean statusBooking, boolean display) {
        this.user = user;
        this.service = service;
        this.stock = stock;
        this.statusBooking = statusBooking;
        this.display = display;
    }
    
    // Constructor that takes a Cart model
    public CartDTO(models.Cart cart, User user, Service service) {
        this.user = user;
        this.service = service;
        this.stock = cart.getStock();
        this.statusBooking = cart.isStatusBooking();
        this.display = cart.isDisplay();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public boolean isStatusBooking() {
        return statusBooking;
    }

    public void setStatusBooking(boolean statusBooking) {
        this.statusBooking = statusBooking;
    }

    public boolean isDisplay() {
        return display;
    }

    public void setDisplay(boolean display) {
        this.display = display;
    }
    
    // Convert DTO back to original model (without the linked objects)
    public models.Cart toCart() {
        models.Cart cart = new models.Cart();
        cart.setUserID(this.user != null ? this.user.getUserId() : 0);
        cart.setServiceID(this.service != null ? this.service.getServiceID() : 0);
        cart.setStock(this.stock);
        cart.setStatusBooking(this.statusBooking);
        cart.setDisplay(this.display);
        return cart;
    }
}
