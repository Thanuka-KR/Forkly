package controller;

import model.Order;
import service.OrderService;
import service.DeliveryService;
import service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/order-status")
public class OrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String orderId =
                request.getParameter("orderId");

        String status =
                request.getParameter("status");

        OrderService orderService =
                new OrderService();

        orderService.updateOrderStatus(orderId, status);

        Order order =
                orderService.getOrderById(orderId);

        NotificationService notificationService =
                new NotificationService();

        if (order != null) {

            if ("PAYMENT_APPROVED".equals(status)) {

                notificationService.createNotification(
                        order.getCustomerId(),
                        "PAYMENT_APPROVED",
                        "Payment Approved",
                        "Your payment for order #" + orderId
                                + " has been approved. We will start preparing your food soon."
                );

            }

            if ("PREPARING".equals(status)) {

                notificationService.createNotification(
                        order.getCustomerId(),
                        "ORDER_PREPARING",
                        "Order Preparing",
                        "Your order #" + orderId
                                + " is now being prepared by our kitchen team."
                );

            }

            if ("READY_FOR_DELIVERY".equals(status)) {

                DeliveryService deliveryService =
                        new DeliveryService();

                if (deliveryService.getDeliveryByOrderId(orderId) == null) {

                    deliveryService.createDelivery(
                            order.getOrderId(),
                            order.getCustomerId(),
                            order.getDeliveryAddress(),
                            "STANDARD"
                    );

                }

                notificationService.createNotification(
                        order.getCustomerId(),
                        "READY_FOR_DELIVERY",
                        "Order Ready for Delivery",
                        "Your order #" + orderId
                                + " is ready for delivery. A driver will accept it soon."
                );

                notificationService.createNotification(
                        "ADMIN",
                        "DELIVERY_CREATED",
                        "Delivery Record Created",
                        "Delivery record was created for order #" + orderId
                                + " and is now waiting for a driver."
                );

            }

            if ("DELIVERED".equals(status)) {

                notificationService.createNotification(
                        order.getCustomerId(),
                        "ORDER_DELIVERED",
                        "Order Delivered",
                        "Your order #" + orderId
                                + " has been delivered successfully. Thank you for choosing Forkly!"
                );

            }

        }

        response.sendRedirect(request.getContextPath()
                + "/admin/orders.jsp");

    }

}