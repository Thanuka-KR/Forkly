package controller;

import service.PaymentService;
import service.OrderService;
import model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/payment-management")
public class PaymentManagementServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        String paymentId =
                request.getParameter("paymentId");

        String orderId =
                request.getParameter("orderId");

        PaymentService paymentService =
                new PaymentService();

        OrderService orderService =
                new OrderService();

        if ("cancel".equals(action)) {

            paymentService.cancelPayment(paymentId);

            orderService.updateOrderStatus(orderId,
                    "PAYMENT_CANCELLED");

        }

        response.sendRedirect(request.getContextPath()
                + "/admin/payments.jsp");

    }

}