package model;

import java.io.Serializable;

public class Notification implements Serializable {
    private static final long serialVersionUID = 1L;

    private String notificationId;
    private String userId;
    private String type;
    private String title;
    private String message;
    private String createdAt;
    private boolean isRead;

    public Notification() {
        this.isRead = false;
    }

    public Notification(String notificationId, String userId, String type,
                        String title, String message, String createdAt) {
        this.notificationId = notificationId;
        this.userId = userId;
        this.type = type;
        this.title = title;
        this.message = message;
        this.createdAt = createdAt;
        this.isRead = false;
    }

    public String getNotificationId() { return notificationId; }
    public void setNotificationId(String notificationId) { this.notificationId = notificationId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    @Override
    public String toString() {
        return notificationId + "|" + userId + "|" + type + "|" +
                title + "|" + message + "|" + createdAt + "|" + isRead;
    }
}