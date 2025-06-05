package models;

public class Pet {
    public int petID;
    public String name;

    public Pet() {}

    public Pet(int petID, String name) {
        this.petID = petID;
        this.name = name;
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
    
    @Override
    public String toString() {
        return "Pet{" + "petID=" + petID + ", name=" + name + '}';
    }
}
