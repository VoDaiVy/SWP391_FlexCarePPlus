package dtos;

import models.User;

public class WalletTransferDTO {
    private int walletTransferID;
    private String transCode, timeCode, content;
    private User user;           // Instead of userID
    private boolean isRefunded;
    private float amount;
    
    public WalletTransferDTO() {
    }
    
    public WalletTransferDTO(int walletTransferID, String transCode, String timeCode, 
                           String content, User user, boolean isRefunded, float amount) {
        this.walletTransferID = walletTransferID;
        this.transCode = transCode;
        this.timeCode = timeCode;
        this.content = content;
        this.user = user;
        this.isRefunded = isRefunded;
        this.amount = amount;
    }
    
    // Constructor that takes a WalletTransfer model
    public WalletTransferDTO(models.WalletTransfer walletTransfer, User user) {
        this.walletTransferID = walletTransfer.getWalletTransferID();
        this.transCode = walletTransfer.getTransCode();
        this.timeCode = walletTransfer.getTimeCode();
        this.content = walletTransfer.getContent();
        this.user = user;
        this.isRefunded = walletTransfer.isIsRefunded();
        this.amount = walletTransfer.getAmount();
    }
    
    public int getWalletTransferID() {
        return walletTransferID;
    }
    
    public void setWalletTransferID(int walletTransferID) {
        this.walletTransferID = walletTransferID;
    }
    
    public String getTransCode() {
        return transCode;
    }
    
    public void setTransCode(String transCode) {
        this.transCode = transCode;
    }
    
    public String getTimeCode() {
        return timeCode;
    }
    
    public void setTimeCode(String timeCode) {
        this.timeCode = timeCode;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public boolean isRefunded() {
        return isRefunded;
    }
    
    public void setRefunded(boolean isRefunded) {
        this.isRefunded = isRefunded;
    }
    
    public float getAmount() {
        return amount;
    }
    
    public void setAmount(float amount) {
        this.amount = amount;
    }
    
    // Convert DTO back to original model (without the linked objects)
    public models.WalletTransfer toWalletTransfer() {
        models.WalletTransfer walletTransfer = new models.WalletTransfer();
        walletTransfer.setWalletTransferID(this.walletTransferID);
        walletTransfer.setTransCode(this.transCode);
        walletTransfer.setTimeCode(this.timeCode);
        walletTransfer.setContent(this.content);
        walletTransfer.setUserID(this.user != null ? this.user.getUserId() : 0);
        walletTransfer.setIsRefunded(this.isRefunded);
        walletTransfer.setAmount(this.amount);
        return walletTransfer;
    }
}
