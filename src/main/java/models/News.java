
package models;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class News {
    public int newsID;
    public String title, description;
    public int views;
    public String imgURL;
    public LocalDate dateCreated;
    public boolean status;

    public News() {
    }

    public News(int newsID, String title, String description, int views, String imgURL, String dateCreated, boolean status) {
        this.newsID = newsID;
        this.title = title;
        this.description = description;
        this.views = views;
        this.imgURL = imgURL;
        this.dateCreated = LocalDate.parse(dateCreated, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        this.status = status;
    }

    public int getNewsID() {
        return newsID;
    }

    public void setNewsID(int newsID) {
        this.newsID = newsID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public String getDateCreated() {
        if (dateCreated == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd").format(dateCreated);
    }

    public void setDateCreated(LocalDate dateCreated) {
        this.dateCreated = dateCreated;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
}
