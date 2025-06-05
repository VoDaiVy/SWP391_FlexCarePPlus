package dtos;
import models.Pet;

public class PetDTO {
    private int petID;
    private String name;

    public PetDTO() {}
    
    public PetDTO(Pet pet) {
        this.petID = pet.getPetID();
        this.name = pet.getName();
    }
    
    public int getPetID() { 
        return petID; 
    }
    
    public void setPetID(int petID) { 
        this.petID = petID; 
    }
    
    public String getName() { 
        return name; 
    }
    
    public void setName(String name) { 
        this.name = name; 
    }
    
    // Convert DTO back to original model
    public Pet toPet() {
        Pet pet = new Pet();
        pet.setPetID(this.petID);
        pet.setName(this.name);
        return pet;
    }
}
