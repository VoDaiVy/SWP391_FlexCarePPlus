package dtos;

import models.CategoryService;

public class ServiceDTO {
    private int serviceID;
    private CategoryService categoryService;    // Instead of categoryServiceID
    private String name, description;
    private float price;
    private int time, views;
    private String imgURL;
    private boolean status;

    public ServiceDTO() {
    }

    public ServiceDTO(int serviceID, CategoryService categoryService, String name, String description,
                    float price, int time, int views, String imgURL, boolean status) {
        this.serviceID = serviceID;
        this.categoryService = categoryService;
        this.name = name;
        this.description = description;
        this.price = price;
        this.time = time;
        this.views = views;
        this.imgURL = imgURL;
        this.status = status;
    }
    
    // Constructor that takes a Service model
    public ServiceDTO(models.Service service, CategoryService categoryService) {
        this.serviceID = service.getServiceID();
        this.categoryService = categoryService;
        this.name = service.getName();
        this.description = service.getDescription();
        this.price = service.getPrice();
        this.time = service.getTime();
        this.views = service.getViews();
        this.imgURL = service.getImgURL();
        this.status = service.isStatus();
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    // Convert DTO back to original model (without the linked objects)
    public models.Service toService() {
        models.Service service = new models.Service();
        service.setServiceID(this.serviceID);
        service.setCategoryServiceID(this.categoryService != null ? this.categoryService.getCategoryServiceID() : 0);
        service.setName(this.name);
        service.setDescription(this.description);
        service.setPrice(this.price);
        service.setTime(this.time);
        service.setViews(this.views);
        service.setImgURL(this.imgURL);
        service.setStatus(this.status);
        return service;
    }
}
