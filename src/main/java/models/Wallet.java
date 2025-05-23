package models;

public class Wallet {
    private int userID;
    private float amount;
    private boolean status;

    public Wallet() {
    }

    public Wallet(int userID, float amount, boolean status) {
        this.userID = userID;
        this.amount = amount;
        this.status = status;
    }
    
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Wallet{" + "userID=" + userID + ", amount=" + amount + ", status=" + status + '}';
    }
}
