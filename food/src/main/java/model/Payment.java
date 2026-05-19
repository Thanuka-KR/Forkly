package model;

import java.io.Serializable;

public abstract class Payment implements Serializable {
    private static final long serialVersionUID = 1L;

    protected String paymentId;
    protected String orderId;
    protected String customerId;
    protected double amount;
    protected String paymentDate;
    protected String status;
    protected String method;

    public Payment() {
        this.status = "PENDING";
    }

    public Payment(String paymentId, String orderId, String customerId,
                   double amount, String paymentDate, String method) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.customerId = customerId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.method = method;
        this.status = "PENDING";
    }

    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentDate() { return paymentDate; }
    public void setPaymentDate(String paymentDate) { this.paymentDate = paymentDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public abstract boolean processPayment();
    public abstract String getPaymentDetails();

    public String toString() {
        return paymentId + "|" + orderId + "|" + customerId + "|" + amount + "|" +
                paymentDate + "|" + status + "|" + method;
    }
}