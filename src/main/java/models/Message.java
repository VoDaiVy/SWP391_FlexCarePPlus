package models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Message {
    private int messageID, userID, userReceiveID;
    private LocalDateTime timeChat;
    private String content;
    private boolean status;

    public Message() {
    }

    public Message(int messageID, int userID, int userReceiveID, String timeChat, String content, boolean status) {
        this.messageID = messageID;
        this.userID = userID;
        this.userReceiveID = userReceiveID;
        this.timeChat = LocalDateTime.parse(timeChat, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        this.content = content;
        this.status = status;
    }

    public int getMessageID() {
        return messageID;
    }

    public void setMessageID(int messageID) {
        this.messageID = messageID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getUserReceiveID() {
        return userReceiveID;
    }

    public void setUserReceiveID(int userReceiveID) {
        this.userReceiveID = userReceiveID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTimeChat() {
        if(timeChat == null) return "";
        else return DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(timeChat);
    }

    public void setTimeChat(LocalDateTime timeChat) {
        this.timeChat = timeChat;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Message{" + "messageID=" + messageID + ", userID=" + userID + ", userReceiveID=" + userReceiveID + ", content=" + content + ", timeChat=" + timeChat + ", status=" + status + '}';
    }
    
    
}
