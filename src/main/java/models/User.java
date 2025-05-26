
package models;

public class User {
    public int userID;
    public String role, userName, password, email;
    public boolean status;
    public static enum RoleName {ADMIN, CUSTOMER, STAFF};

    public User() {
    }

    public User(int userID, String role, String userName, String password, String email, boolean status) {
        this.userID = userID;
        this.role = role;
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.status = status;
    }

    public int getUserId() {
        return userID;
    }

    public void setUserId(int userId) {
        this.userID = userId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "User{" + "userID=" + userID + ", role=" + role + ", userName=" + userName + ", password=" + password + ", email=" + email + ", status=" + status + '}';
    }
    
}
