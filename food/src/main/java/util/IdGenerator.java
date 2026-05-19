package util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class IdGenerator {

    public static String generateUserId() {
        List<String> users = FileHandler.readFromFile("users.txt");
        int count = users.size() + 1;
        return "USR" + String.format("%04d", count);
    }

    public static String generateOrderId() {
        String datePrefix = new SimpleDateFormat("yyyyMMdd").format(new Date());
        List<String> orders = FileHandler.readFromFile("orders.txt");
        int count = orders.size() + 1;
        return "ORD" + datePrefix + String.format("%04d", count);
    }

    public static String generatePaymentId() {
        List<String> payments = FileHandler.readFromFile("payments.txt");
        int count = payments.size() + 1;
        return "PAY" + String.format("%06d", count);
    }

    public static String generateDeliveryId() {
        List<String> deliveries = FileHandler.readFromFile("deliveries.txt");
        int count = deliveries.size() + 1;
        return "DEL" + String.format("%06d", count);
    }

    public static String generateReviewId() {
        List<String> reviews = FileHandler.readFromFile("reviews.txt");
        int count = reviews.size() + 1;
        return "REV" + String.format("%06d", count);
    }

    public static String generateNotificationId() {
        List<String> notifications = FileHandler.readFromFile("notifications.txt");
        int count = notifications.size() + 1;
        return "NOT" + String.format("%06d", count);
    }

    public static String generateMenuItemId() {
        List<String> menuItems = FileHandler.readFromFile("menu.txt");
        int count = menuItems.size() + 1;
        return "M" + String.format("%03d", count);
    }
}