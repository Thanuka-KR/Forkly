package service;

import model.Payment;
import model.CashPayment;
import model.CardPayment;
import util.FileHandler;
import util.IdGenerator;

import java.util.ArrayList;
import java.util.List;

public class PaymentService {

    private static final String PAYMENT_FILE = "payments.txt";

    // ==============================
    // SECTION 1: CREATE CASH PAYMENT
    // ==============================
    public Payment createCashPayment(String orderId,
                                     String customerId,
                                     double amount,
                                     double cashTendered) {

        String paymentId = IdGenerator.generatePaymentId();

        String paymentDate =
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(new java.util.Date());

        CashPayment payment =
                new CashPayment(paymentId,
                        orderId,
                        customerId,
                        amount,
                        paymentDate,
                        cashTendered);

        payment.processPayment();

        FileHandler.writeLine(PAYMENT_FILE,
                payment.toString(),
                true);

        return payment;

    }

    // ==============================
    // SECTION 2: CREATE CARD PAYMENT
    // ==============================
    public Payment createCardPayment(String orderId,
                                     String customerId,
                                     double amount,
                                     String cardNumber,
                                     String cardHolderName,
                                     String expiryDate) {

        String paymentId = IdGenerator.generatePaymentId();

        String paymentDate =
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(new java.util.Date());

        CardPayment payment =
                new CardPayment(paymentId,
                        orderId,
                        customerId,
                        amount,
                        paymentDate,
                        cardNumber,
                        cardHolderName,
                        expiryDate);

        payment.processPayment();

        FileHandler.writeLine(PAYMENT_FILE,
                payment.toString(),
                true);

        return payment;

    }

    // ==============================
    // SECTION 3: GET PAYMENT BY ORDER ID
    // ==============================
    public Payment getPaymentByOrderId(String orderId) {

        List<String> lines =
                FileHandler.readFromFile(PAYMENT_FILE);

        for (String line : lines) {

            String[] parts =
                    line.split("\\|");

            if (parts.length > 1
                    && parts[1].equals(orderId)) {

                return parsePayment(line);

            }

        }

        return null;

    }

    // ==============================
    // SECTION 4: GET PAYMENTS BY CUSTOMER
    // ==============================
    public List<Payment> getPaymentsByCustomer(String customerId) {

        List<Payment> payments =
                new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(PAYMENT_FILE);

        for (String line : lines) {

            String[] parts =
                    line.split("\\|");

            if (parts.length > 2
                    && parts[2].equals(customerId)) {

                Payment payment =
                        parsePayment(line);

                if (payment != null) {

                    payments.add(payment);

                }

            }

        }

        return payments;

    }

    // ==============================
    // SECTION 5: GET ALL PAYMENTS
    // ==============================
    public List<Payment> getAllPayments() {

        List<Payment> payments =
                new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(PAYMENT_FILE);

        for (String line : lines) {

            Payment payment =
                    parsePayment(line);

            if (payment != null) {

                payments.add(payment);

            }

        }

        return payments;

    }

    // ==============================
    // SECTION 6: UPDATE PAYMENT STATUS
    // ==============================
    public boolean updatePaymentStatus(String paymentId,
                                       String status) {

        List<String> lines =
                FileHandler.readFromFile(PAYMENT_FILE);

        for (int i = 0; i < lines.size(); i++) {

            String[] parts =
                    lines.get(i).split("\\|");

            if (parts.length > 0
                    && parts[0].equals(paymentId)) {

                parts[5] = status;

                String newLine =
                        String.join("|", parts);

                lines.set(i, newLine);

                FileHandler.writeToFile(PAYMENT_FILE,
                        lines,
                        false);

                return true;

            }

        }

        return false;

    }

    // ==============================
    // SECTION 7: CANCEL PAYMENT
    // Important: Do not delete.
    // We freeze the record by status.
    // ==============================
    public boolean cancelPayment(String paymentId) {

        return updatePaymentStatus(paymentId,
                "CANCELLED");

    }

    // ==============================
    // SECTION 8: DELETE PAYMENT
    // Kept for old code compatibility.
    // Avoid using for modern workflow.
    // ==============================
    public boolean deletePayment(String paymentId) {

        return FileHandler.deleteLine(PAYMENT_FILE,
                paymentId,
                0);

    }

    // ==============================
    // SECTION 9: CONVERT TXT LINE TO PAYMENT OBJECT
    // ==============================
    private Payment parsePayment(String line) {

        String[] parts =
                line.split("\\|");

        if (parts.length < 7) {

            return null;

        }

        String method =
                parts[6];

        if (method.equals("CASH")
                && parts.length >= 8) {

            CashPayment payment =
                    new CashPayment(parts[0],
                            parts[1],
                            parts[2],
                            Double.parseDouble(parts[3]),
                            parts[4],
                            Double.parseDouble(parts[7]));

            payment.setStatus(parts[5]);

            return payment;

        } else if (method.equals("CARD")
                && parts.length >= 10) {

            CardPayment payment =
                    new CardPayment(parts[0],
                            parts[1],
                            parts[2],
                            Double.parseDouble(parts[3]),
                            parts[4],
                            parts[7],
                            parts[8],
                            parts[9]);

            payment.setStatus(parts[5]);

            return payment;

        }

        return null;

    }

}