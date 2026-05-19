package model;

public class ExpressDelivery extends Delivery {

    private static final double BASE_FEE = 350.00;

    public ExpressDelivery() {
        super();
    }

    public ExpressDelivery(String deliveryId, String orderId, String customerId,
                           String address, String assignedDate) {
        super(deliveryId, orderId, customerId, address, assignedDate);
        this.estimatedTime = "15-20 minutes";
    }

    @Override
    public double calculateDeliveryFee() {
        return BASE_FEE;
    }

    @Override
    public String getDeliveryType() {
        return "EXPRESS";
    }

    @Override
    public String toString() {
        return super.toString() + "|EXPRESS|" + BASE_FEE;
    }
}