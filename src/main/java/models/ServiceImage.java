
package models;

public class ServiceImage {
    public int serviceImageID, serviceID;
    public String imgURL;

    public ServiceImage() {
    }

    public ServiceImage(int serviceImageID, int serviceID, String imgURL) {
        this.serviceImageID = serviceImageID;
        this.serviceID = serviceID;
        this.imgURL = imgURL;
    }

    public int getServiceImageID() {
        return serviceImageID;
    }

    public void setServiceImageID(int serviceImageID) {
        this.serviceImageID = serviceImageID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }
    
}
