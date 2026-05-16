package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    // ==============================
    // SECTION 1: VARIABLES
    // ==============================
    private String orderId;

    private String customerId;

    private String orderDate;

    private double totalAmount;

    private String status;

    private String deliveryAddress;

    private List<OrderItem> items;

    // ==============================
    // SECTION 2: DEFAULT CONSTRUCTOR
    // ==============================
    public Order() {

        this.items = new ArrayList<>();

        this.status = "PENDING";

        this.deliveryAddress = "";

    }

    // ==============================
    // SECTION 3: CONSTRUCTOR
    // ==============================
    public Order(String orderId,
                 String customerId,
                 String orderDate,
                 double totalAmount,
                 String status) {

        this.orderId = orderId;

        this.customerId = customerId;

        this.orderDate = orderDate;

        this.totalAmount = totalAmount;

        this.status = status;

        this.deliveryAddress = "";

        this.items = new ArrayList<>();

    }

    // ==============================
    // SECTION 4: CONSTRUCTOR WITH ADDRESS
    // ==============================
    public Order(String orderId,
                 String customerId,
                 String orderDate,
                 double totalAmount,
                 String status,
                 String deliveryAddress) {

        this.orderId = orderId;

        this.customerId = customerId;

        this.orderDate = orderDate;

        this.totalAmount = totalAmount;

        this.status = status;

        this.deliveryAddress = deliveryAddress;

        this.items = new ArrayList<>();

    }

    // ==============================
    // SECTION 5: GETTERS AND SETTERS
    // ==============================
    public String getOrderId() {

        return orderId;

    }

    public void setOrderId(String orderId) {

        this.orderId = orderId;

    }

    public String getCustomerId() {

        return customerId;

    }

    public void setCustomerId(String customerId) {

        this.customerId = customerId;

    }

    public String getOrderDate() {

        return orderDate;

    }

    public void setOrderDate(String orderDate) {

        this.orderDate = orderDate;

    }

    public double getTotalAmount() {

        return totalAmount;

    }

    public void setTotalAmount(double totalAmount) {

        this.totalAmount = totalAmount;

    }

    public String getStatus() {

        return status;

    }

    public void setStatus(String status) {

        this.status = status;

    }

    public String getDeliveryAddress() {

        return deliveryAddress;

    }

    public void setDeliveryAddress(String deliveryAddress) {

        this.deliveryAddress = deliveryAddress;

    }

    public List<OrderItem> getItems() {

        return items;

    }

    public void setItems(List<OrderItem> items) {

        this.items = items;

    }

    // ==============================
    // SECTION 6: ADD ITEM
    // ==============================
    public void addItem(OrderItem item) {

        this.items.add(item);

        calculateTotal();

    }

    // ==============================
    // SECTION 7: CALCULATE TOTAL
    // ==============================
    public void calculateTotal() {

        this.totalAmount = items.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();

    }

    // ==============================
    // SECTION 8: SAVE FORMAT
    // Format:
    // orderId|customerId|orderDate|total|status|deliveryAddress|items
    // ==============================
    public String toString() {

        StringBuilder sb = new StringBuilder();

        sb.append(orderId).append("|");

        sb.append(customerId).append("|");

        sb.append(orderDate).append("|");

        sb.append(totalAmount).append("|");

        sb.append(status).append("|");

        sb.append(deliveryAddress == null ? "" : deliveryAddress).append("|");

        for (int i = 0; i < items.size(); i++) {

            if (i > 0) {

                sb.append(";");

            }

            sb.append(items.get(i).toString());

        }

        return sb.toString();

    }

}