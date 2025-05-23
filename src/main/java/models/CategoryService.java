
package models;

public class CategoryService {
    public int categoryServiceID;
    public String name;
    public boolean status;

    public CategoryService() {
    }

    public CategoryService(int categoryServiceID, String name, boolean status) {
        this.categoryServiceID = categoryServiceID;
        this.name = name;
        this.status = status;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "CategoryService{" + "categoryServiceID=" + categoryServiceID + ", name=" + name + ", status=" + status + '}';
    }
    
}
