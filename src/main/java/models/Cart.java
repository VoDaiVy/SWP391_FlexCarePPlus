
package models;

public class Cart {
    public int userID, serviceID, stock;
    public boolean statusBooking, display;

    public Cart() {
    }

    public Cart(int userID, int serviceID, int stock, boolean statusBooking, boolean display) {
        this.userID = userID;
        this.serviceID = serviceID;
        this.stock = stock;
        this.statusBooking = statusBooking;
        this.display = display;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
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
    
}
