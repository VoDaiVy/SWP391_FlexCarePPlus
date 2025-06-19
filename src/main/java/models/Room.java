
package models;

public class Room {
    public int roomID, categoryServiceID;
    public String name;
    public int roomNumber;
    public boolean status;

    public Room() {
    }

    public Room(int roomID, int categoryServiceID, String name, int roomNumber, boolean status) {
        this.roomID = roomID;
        this.categoryServiceID = categoryServiceID;
        this.name = name;
        this.roomNumber = roomNumber;
        this.status = status;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getCategoryServiceID() {
        return categoryServiceID;
    }

    public void setCategoryServiceID(int categoryServiceID) {
        this.categoryServiceID = categoryServiceID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
}
