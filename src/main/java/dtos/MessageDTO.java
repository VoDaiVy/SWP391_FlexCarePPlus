package dtos;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import models.User;

public class MessageDTO {
    private int messageID;
    private User sender;             // Instead of userID
    private User receiver;           // Instead of userReceiveID
    private LocalDateTime timeChat;
    private String content;
    private boolean status;

    public MessageDTO() {
    }

    public MessageDTO(int messageID, User sender, User receiver, 
                    LocalDateTime timeChat, String content, boolean status) {
        this.messageID = messageID;
        this.sender = sender;
        this.receiver = receiver;
        this.timeChat = timeChat;
        this.content = content;
        this.status = status;
    }
    
    // Constructor that takes a Message model
    public MessageDTO(models.Message message, User sender, User receiver) {
        this.messageID = message.getMessageID();
        this.sender = sender;
        this.receiver = receiver;
        this.timeChat = LocalDateTime.parse(message.getTimeChat(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.content = message.getContent();
        this.status = message.isStatus();
    }

    public int getMessageID() {
        return messageID;
    }

    public void setMessageID(int messageID) {
        this.messageID = messageID;
    }

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public User getReceiver() {
        return receiver;
    }

    public void setReceiver(User receiver) {
        this.receiver = receiver;
    }

    public String getTimeChat() {
        if(timeChat == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(timeChat);
    }

    public void setTimeChat(LocalDateTime timeChat) {
        this.timeChat = timeChat;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    // Convert DTO back to original model (without the linked objects)
    public models.Message toMessage() {
        models.Message message = new models.Message();
        message.setMessageID(this.messageID);
        message.setUserID(this.sender != null ? this.sender.getUserId() : 0);
        message.setUserReceiveID(this.receiver != null ? this.receiver.getUserId() : 0);
        message.setTimeChat(this.timeChat);
        message.setContent(this.content);
        message.setStatus(this.status);
        return message;
    }
}
