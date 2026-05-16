package service;

import model.Notification;
import model.User;
import util.FileHandler;
import util.IdGenerator;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class NotificationService {

    private static final String NOTIFICATION_FILE = "notifications.txt";

    public Notification createNotification(String userId, String type,
                                           String title, String message) {
        String notificationId = IdGenerator.generateNotificationId();

        String createdAt =
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(new java.util.Date());

        Notification notification =
                new Notification(notificationId, userId, type,
                        title, message, createdAt);

        FileHandler.writeLine(
                NOTIFICATION_FILE,
                notification.toString(),
                true
        );

        return notification;
    }

    public void notifyOrderPlaced(String userId, String orderId) {
        createNotification(userId, "ORDER_PLACED", "Order Confirmed",
                "Your order #" + orderId + " has been placed successfully!");
    }

    public void notifyPaymentSuccess(String userId, String orderId, double amount) {
        createNotification(userId, "PAYMENT_SUCCESS", "Payment Received",
                "Payment of $" + amount + " for order #" + orderId + " was successful!");
    }

    public void notifyDeliveryAssigned(String userId, String orderId, String driverName) {
        createNotification(userId, "DELIVERY_ASSIGNED", "Delivery Partner Assigned",
                driverName + " will deliver your order #" + orderId);
    }

    public void notifyDeliveryStatusUpdate(String userId, String orderId, String status) {
        createNotification(userId, "DELIVERY_STATUS", "Order Status Updated",
                "Your order #" + orderId + " is now: " + status);
    }

    public void notifyReviewSubmitted(String userId, String reviewType) {
        createNotification(userId, "REVIEW_SUBMITTED", "Review Submitted",
                "Thank you for your " + reviewType + " review!");
    }

    // ==============================
    // ADMIN OFFER NOTIFICATION TO ALL CUSTOMERS
    // ==============================
    public int sendOfferToAllUsers(String title, String message) {

        UserService userService =
                new UserService();

        List<User> users =
                userService.getAllUsers();

        int sentCount =
                0;

        for (User user : users) {

            if ("CUSTOMER".equalsIgnoreCase(user.getRole())) {

                createNotification(
                        user.getUserId(),
                        "OFFER",
                        title,
                        message
                );

                sentCount++;
            }
        }

        return sentCount;
    }

    public List<Notification> getNotificationsByUser(String userId) {
        List<Notification> notifications = new ArrayList<>();
        List<String> lines = FileHandler.readFromFile(NOTIFICATION_FILE);

        for (String line : lines) {
            Notification notification = parseNotification(line);
            if (notification != null && notification.getUserId().equals(userId)) {
                notifications.add(notification);
            }
        }
        return notifications;
    }

    public List<Notification> getUnreadNotifications(String userId) {
        return getNotificationsByUser(userId).stream()
                .filter(n -> !n.isRead())
                .collect(Collectors.toList());
    }

    public boolean markAsRead(String notificationId) {
        List<String> lines = FileHandler.readFromFile(NOTIFICATION_FILE);

        for (int i = 0; i < lines.size(); i++) {
            String[] parts = lines.get(i).split("\\|");

            if (parts.length > 0 && parts[0].equals(notificationId)) {

                parts[6] = "true";

                String newLine =
                        String.join("|", parts);

                lines.set(i, newLine);

                FileHandler.writeToFile(NOTIFICATION_FILE, lines, false);

                return true;
            }
        }

        return false;
    }

    public boolean markAllAsRead(String userId) {
        List<Notification> userNotifications = getNotificationsByUser(userId);

        boolean allMarked = true;

        for (Notification n : userNotifications) {
            if (!markAsRead(n.getNotificationId())) {
                allMarked = false;
            }
        }

        return allMarked;
    }

    public boolean deleteNotification(String notificationId) {
        return FileHandler.deleteLine(NOTIFICATION_FILE, notificationId, 0);
    }

    public boolean clearAllNotifications(String userId) {
        List<Notification> userNotifications =
                getNotificationsByUser(userId);

        boolean allDeleted =
                true;

        for (Notification n : userNotifications) {
            if (!deleteNotification(n.getNotificationId())) {
                allDeleted = false;
            }
        }

        return allDeleted;
    }

    private Notification parseNotification(String line) {
        String[] parts = line.split("\\|");

        if (parts.length >= 7) {
            Notification notification =
                    new Notification(
                            parts[0],
                            parts[1],
                            parts[2],
                            parts[3],
                            parts[4],
                            parts[5]
                    );

            notification.setRead(Boolean.parseBoolean(parts[6]));

            return notification;
        }

        return null;
    }

    public int getUnreadCount(String userId) {
        return getUnreadNotifications(userId).size();
    }
}