package models;

public class UserPet {
    public int userPetID;
    public int userID;
    public int petID;
    public String petName;

    public UserPet() {}

    public UserPet(int userPetID, int userID, int petID, String petName) {
        this.userPetID = userPetID;
        this.userID = userID;
        this.petID = petID;
        this.petName = petName;
    }

    public int getUserPetID() {
        return userPetID;
    }

    public void setUserPetID(int userPetID) {
        this.userPetID = userPetID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getPetID() {
        return petID;
    }

    public void setPetID(int petID) {
        this.petID = petID;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }
    
    @Override
    public String toString() {
        return "UserPet{" + "userPetID=" + userPetID + ", userID=" + userID + 
                ", petID=" + petID + ", petName=" + petName + '}';
    }
}
