package dtos;

import models.News;

public class NewsImageDTO {
    private int newsImageID;
    private News news;      // Instead of newsID
    private String imgURL;

    public NewsImageDTO() {
    }

    public NewsImageDTO(int newsImageID, News news, String imgURL) {
        this.newsImageID = newsImageID;
        this.news = news;
        this.imgURL = imgURL;
    }
    
    // Constructor that takes a NewsImage model
    public NewsImageDTO(models.NewsImage newsImage, News news) {
        this.newsImageID = newsImage.getNewsImageID();
        this.news = news;
        this.imgURL = newsImage.getImgURL();
    }

    public int getNewsImageID() {
        return newsImageID;
    }

    public void setNewsImageID(int newsImageID) {
        this.newsImageID = newsImageID;
    }

    public News getNews() {
        return news;
    }

    public void setNews(News news) {
        this.news = news;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }
    
    // Convert DTO back to original model (without the linked objects)
    public models.NewsImage toNewsImage() {
        models.NewsImage newsImage = new models.NewsImage();
        newsImage.setNewsImageID(this.newsImageID);
        newsImage.setNewsID(this.news != null ? this.news.getNewsID() : 0);
        newsImage.setImgURL(this.imgURL);
        return newsImage;
    }
}
