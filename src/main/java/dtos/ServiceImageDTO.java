package dtos;

import models.Service;

public class ServiceImageDTO {
    private int serviceImageID;
    private Service service;     // Instead of serviceID
    private String imgURL;

    public ServiceImageDTO() {
    }

    public ServiceImageDTO(int serviceImageID, Service service, String imgURL) {
        this.serviceImageID = serviceImageID;
        this.service = service;
        this.imgURL = imgURL;
    }
    
    // Constructor that takes a ServiceImage model
    public ServiceImageDTO(models.ServiceImage serviceImage, Service service) {
        this.serviceImageID = serviceImage.getServiceImageID();
        this.service = service;
        this.imgURL = serviceImage.getImgURL();
    }

    public int getServiceImageID() {
        return serviceImageID;
    }

    public void setServiceImageID(int serviceImageID) {
        this.serviceImageID = serviceImageID;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }
    
    // Convert DTO back to original model (without the linked objects)
    public models.ServiceImage toServiceImage() {
        models.ServiceImage serviceImage = new models.ServiceImage();
        serviceImage.setServiceImageID(this.serviceImageID);
        serviceImage.setServiceID(this.service != null ? this.service.getServiceID() : 0);
        serviceImage.setImgURL(this.imgURL);
        return serviceImage;
    }
}
