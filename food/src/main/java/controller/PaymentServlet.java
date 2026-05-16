package controller;

import service.PaymentService;
import service.NotificationService;

import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException {

        String orderId = req.getParameter("orderId");

        String method = req.getParameter("method");

        double amount = Double.parseDouble(req.getParameter("amount"));

        HttpSession session = req.getSession();

        String customerId = (String) session.getAttribute("userId");

        if (customerId == null) {
            customerId = "GUEST";
        }

        PaymentService paymentService = new PaymentService();

        if ("CASH".equals(method)) {

            paymentService.createCashPayment(
                    orderId,
                    customerId,
                    amount,
                    amount
            );

        } else {

            paymentService.createCardPayment(
                    orderId,
                    customerId,
                    amount,
                    "4111111111111111",
                    "Forkly Customer",
                    "12/30"
            );

        }

        // ==============================
        // SECTION: CREATE NOTIFICATIONS
        // ==============================
        NotificationService notificationService =
                new NotificationService();

        notificationService.createNotification(
                customerId,
                "PAYMENT_RECORDED",
                "Payment Recorded",
                "Your payment for order #" + orderId
                        + " has been recorded. Please wait for admin approval."
        );

        notificationService.createNotification(
                "ADMIN",
                "NEW_PAYMENT",
                "New Payment Received",
                "A new payment of Rs. "
                        + String.format("%.2f", amount)
                        + " was received for order #" + orderId
                        + ". Please review and approve it."
        );

        session.removeAttribute("pendingOrderId");

        session.removeAttribute("pendingAmount");

        resp.sendRedirect(req.getContextPath()
                + "/client/order-history.jsp");

    }

}