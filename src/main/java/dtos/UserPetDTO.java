package dtos;
import models.User;
import models.Pet;
import models.UserPet;
import daos.UserDAO;
import daos.PetDAO;

public class UserPetDTO {
    private int userPetID;
    private User user;         // Instead of userID
    private Pet pet;           // Instead of petID
    private String petName;

    public UserPetDTO() {}
    
    public UserPetDTO(UserPet userPet, User user, Pet pet) {
        this.userPetID = userPet.getUserPetID();
        this.user = user;
        this.pet = pet;
        this.petName = userPet.getPetName();
    }
    
    // Constructor from model with just IDs
    public UserPetDTO(UserPet userPet) {
        this.userPetID = userPet.getUserPetID();
        this.user = UserDAO.getById(userPet.getUserID());  // Load User object from ID
        this.pet = PetDAO.getById(userPet.getPetID());    // Load Pet object from ID
        this.petName = userPet.getPetName();
    }
    
    public int getUserPetID() { 
        return userPetID; 
    }
    
    public void setUserPetID(int userPetID) { 
        this.userPetID = userPetID; 
    }
    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Pet getPet() {
        return pet;
    }

    public void setPet(Pet pet) {
        this.pet = pet;
    }
    
    public String getPetName() { 
        return petName; 
    }
    
    public void setPetName(String petName) { 
        this.petName = petName; 
    }
    
    // Convert DTO back to original model
    public UserPet toUserPet() {
        UserPet userPet = new UserPet();
        userPet.setUserPetID(this.userPetID);
        userPet.setUserID(this.user != null ? this.user.getUserId() : 0);
        userPet.setPetID(this.pet != null ? this.pet.getPetID() : 0);
        userPet.setPetName(this.petName);
        return userPet;
    }
}
