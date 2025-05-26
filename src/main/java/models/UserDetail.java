
package models;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class UserDetail {
    public int userID;
    public String firstName, lastName, tel;
    public LocalDate dob;
    public String gender, avatar;

    public UserDetail() {
    }

    public UserDetail(int userID, String firstName, String lastName, String tel, String dob, String gender, String avatar) {
        this.userID = userID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.tel = tel;
        this.dob = LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        this.gender = gender;
        this.avatar = avatar;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
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

    @Override
    public String toString() {
        return "UserDetail{" + "userID=" + userID + ", firstName=" + firstName + ", lastName=" + lastName + ", tel=" + tel + ", dob=" + dob + ", gender=" + gender + ", avatar=" + avatar + '}';
    }
}
