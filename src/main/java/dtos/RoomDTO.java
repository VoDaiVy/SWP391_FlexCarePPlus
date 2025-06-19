package dtos;

import models.CategoryService;

public class RoomDTO {
    private int roomID;
    private CategoryService categoryService;     // Instead of serviceID
    private String name;
    private int roomNumber;
    private boolean status;

    public RoomDTO() {
    }

    public RoomDTO(int roomID, CategoryService categoryService, String name, int roomNumber, boolean status) {
        this.roomID = roomID;
        this.categoryService = categoryService;
        this.name = name;
        this.roomNumber = roomNumber;
        this.status = status;
    }
    
    // Constructor that takes a Room model
    public RoomDTO(models.Room room, CategoryService categoryService) {
        this.roomID = room.getRoomID();
        this.categoryService = categoryService;
        this.name = room.getName();
        this.roomNumber = room.getRoomNumber();
        this.status = room.isStatus();
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public CategoryService getCategoryService() {
        return categoryService;
    }

    public void setCategoryService(CategoryService categoryService) {
        this.categoryService = categoryService;
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
    
    // Convert DTO back to original model (without the linked objects)
    public models.Room toRoom() {
        models.Room room = new models.Room();
        room.setRoomID(this.roomID);
        room.setCategoryServiceID(this.categoryService != null ? this.categoryService.getCategoryServiceID(): 0);
        room.setName(this.name);
        room.setRoomNumber(this.roomNumber);
        room.setStatus(this.status);
        return room;
    }
}
