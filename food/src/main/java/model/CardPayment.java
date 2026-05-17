package model;

public class CardPayment extends Payment {

    private String cardNumber;
    private String cardHolderName;
    private String expiryDate;
    private String cvv;

    public CardPayment() {
        super();
        this.method = "CARD";
    }

    public CardPayment(String paymentId, String orderId, String customerId,
                       double amount, String paymentDate, String cardNumber,
                       String cardHolderName, String expiryDate) {
        super(paymentId, orderId, customerId, amount, paymentDate, "CARD");
        this.cardNumber = maskCardNumber(cardNumber);
        this.cardHolderName = cardHolderName;
        this.expiryDate = expiryDate;
    }

    private String maskCardNumber(String number) {
        if (number != null && number.length() > 4) {
            return "****" + number.substring(number.length() - 4);
        }
        return "****";
    }

    public String getCardNumber() { return cardNumber; }
    public String getCardHolderName() { return cardHolderName; }
    public String getExpiryDate() { return expiryDate; }

    @Override
    public boolean processPayment() {
        if (cardNumber != null && cardHolderName != null && expiryDate != null) {
            this.status = "PAID";
            return true;
        }
        this.status = "FAILED";
        return false;
    }

    @Override
    public String getPaymentDetails() {
        return "Card Payment - Card: " + cardNumber + ", Holder: " + cardHolderName;
    }

    @Override
    public String toString() {
        return super.toString() + "|" + cardNumber + "|" + cardHolderName + "|" + expiryDate;
    }
}