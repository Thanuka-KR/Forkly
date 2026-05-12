package model;

public class StandardDelivery extends Delivery {

    private static final double BASE_FEE = 250.00;

    public StandardDelivery() {
        super();
    }

    public StandardDelivery(String deliveryId, String orderId, String customerId,
                            String address, String assignedDate) {
        super(deliveryId, orderId, customerId, address, assignedDate);
        this.estimatedTime = "30-45 minutes";
    }

    @Override
    public double calculateDeliveryFee() {
        return BASE_FEE;
    }

    @Override
    public String getDeliveryType() {
        return "STANDARD";
    }

    @Override
    public String toString() {
        return super.toString() + "|STANDARD|" + BASE_FEE;
    }
}