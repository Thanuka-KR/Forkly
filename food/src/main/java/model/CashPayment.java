package model;

public class CashPayment extends Payment {

    private double cashTendered;
    private double changeAmount;

    public CashPayment() {
        super();
        this.method = "CASH";
    }

    public CashPayment(String paymentId, String orderId, String customerId,
                       double amount, String paymentDate, double cashTendered) {
        super(paymentId, orderId, customerId, amount, paymentDate, "CASH");
        this.cashTendered = cashTendered;
        this.changeAmount = cashTendered - amount;
    }

    public double getCashTendered() { return cashTendered; }
    public void setCashTendered(double cashTendered) {
        this.cashTendered = cashTendered;
        this.changeAmount = cashTendered - amount;
    }

    public double getChangeAmount() { return changeAmount; }

    @Override
    public boolean processPayment() {
        if (cashTendered >= amount) {
            this.status = "PAID";
            return true;
        }
        this.status = "FAILED";
        return false;
    }

    @Override
    public String getPaymentDetails() {
        return "Cash Payment - Amount: $" + amount + ", Change: $" + changeAmount;
    }

    @Override
    public String toString() {
        return super.toString() + "|" + cashTendered + "|" + changeAmount;
    }
}