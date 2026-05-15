package model;

import java.io.Serializable;

public abstract class Delivery implements Serializable {
    private static final long serialVersionUID = 1L;

    protected String deliveryId;
    protected String orderId;
    protected String customerId;
    protected String driverName;
    protected String driverPhone;
    protected String address;
    protected String status;
    protected String assignedDate;
    protected String estimatedTime;

    public Delivery() {
        this.status = "PENDING";
    }

    public Delivery(String deliveryId, String orderId, String customerId,
                    String address, String assignedDate) {
        this.deliveryId = deliveryId;
        this.orderId = orderId;
        this.customerId = customerId;
        this.address = address;
        this.assignedDate = assignedDate;
        this.status = "PENDING";
    }

    public String getDeliveryId() { return deliveryId; }
    public void setDeliveryId(String deliveryId) { this.deliveryId = deliveryId; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverPhone() { return driverPhone; }
    public void setDriverPhone(String driverPhone) { this.driverPhone = driverPhone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAssignedDate() { return assignedDate; }
    public void setAssignedDate(String assignedDate) { this.assignedDate = assignedDate; }

    public String getEstimatedTime() { return estimatedTime; }
    public void setEstimatedTime(String estimatedTime) { this.estimatedTime = estimatedTime; }

    public abstract double calculateDeliveryFee();
    public abstract String getDeliveryType();

    public String toString() {
        return deliveryId + "|" + orderId + "|" + customerId + "|" + driverName + "|" +
                driverPhone + "|" + address + "|" + status + "|" + assignedDate + "|" + estimatedTime;
    }
}