
package models;

public class Service {
    public int serviceID, categoryServiceID;
    public String name, description;
    public float price;
    public int time, views;
    public String imgURL;
    public boolean status;

    public Service() {
    }

    public Service(int serviceID, int categoryServiceID, String name, String description, float price, int time, int views, String imgURL, boolean status) {
        this.serviceID = serviceID;
        this.categoryServiceID = categoryServiceID;
        this.name = name;
        this.description = description;
        this.price = price;
        this.time = time;
        this.views = views;
        this.imgURL = imgURL;
        this.status = status;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
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

    @Override
    public String toString() {
        return "Service{" + "serviceID=" + serviceID + ", categoryServiceID=" + categoryServiceID + ", name=" + name + ", description=" + description + ", price=" + price + ", time=" + time + ", views=" + views + ", imgURL=" + imgURL + ", status=" + status + '}';
    }
    
}
