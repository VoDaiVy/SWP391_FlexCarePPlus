
package models;

public class NewsImage {
    public int newsImageID, newsID;
    public String imgURL;

    public NewsImage() {
    }

    public NewsImage(int newsImageID, int newsID, String imgURL) {
        this.newsImageID = newsImageID;
        this.newsID = newsID;
        this.imgURL = imgURL;
    }

    public int getNewsImageID() {
        return newsImageID;
    }

    public void setNewsImageID(int newsImageID) {
        this.newsImageID = newsImageID;
    }

    public int getNewsID() {
        return newsID;
    }

    public void setNewsID(int newsID) {
        this.newsID = newsID;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }
    
}
