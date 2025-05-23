package dtos;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import models.User;

public class UserDetailDTO {
    private User user;       // Instead of userID
    private String firstName, lastName, tel;
    private LocalDate dob;
    private String gender, avatar;

    public UserDetailDTO() {
    }

    public UserDetailDTO(User user, String firstName, String lastName, 
                       String tel, LocalDate dob, String gender, String avatar) {
        this.user = user;
        this.firstName = firstName;
        this.lastName = lastName;
        this.tel = tel;
        this.dob = dob;
        this.gender = gender;
        this.avatar = avatar;
    }
    
    // Constructor that takes a UserDetail model
    public UserDetailDTO(models.UserDetail userDetail, User user) {
        this.user = user;
        this.firstName = userDetail.getFirstName();
        this.lastName = userDetail.getLastName();
        this.tel = userDetail.getTel();
        this.dob = userDetail.dob;
        this.gender = userDetail.getGender();
        this.avatar = userDetail.getAvatar();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getDob() {
        if(dob == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd").format(dob);
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    
    // Convert DTO back to original model (without the linked objects)
    public models.UserDetail toUserDetail() {
        models.UserDetail userDetail = new models.UserDetail();
        userDetail.setUserID(this.user != null ? this.user.getUserId() : 0);
        userDetail.setFirstName(this.firstName);
        userDetail.setLastName(this.lastName);
        userDetail.setTel(this.tel);
        userDetail.dob = this.dob;
        userDetail.setGender(this.gender);
        userDetail.setAvatar(this.avatar);
        return userDetail;
    }
}
