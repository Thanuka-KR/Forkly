package controller;

import model.Delivery;
import model.Order;
import service.DeliveryService;
import service.OrderService;
import service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/driver-delivery")
public class DriverDeliveryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        Boolean loggedIn =
                (Boolean) session.getAttribute("driverLoggedIn");

        if (loggedIn == null || !loggedIn) {

            response.sendRedirect(request.getContextPath()
                    + "/driver/login.jsp");

            return;
        }

        String deliveryId =
                request.getParameter("deliveryId");

        String action =
                request.getParameter("action");

        DeliveryService deliveryService =
                new DeliveryService();

        OrderService orderService =
                new OrderService();

        NotificationService notificationService =
                new NotificationService();

        Delivery delivery =
                deliveryService.getDeliveryById(deliveryId);

        if (delivery == null) {

            response.sendRedirect(request.getContextPath()
                    + "/driver/tracking.jsp");

            return;
        }

        Order order =
                orderService.getOrderById(delivery.getOrderId());

        String customerId =
                order != null ? order.getCustomerId() : delivery.getCustomerId();

        if ("accept".equals(action)) {

            deliveryService.acceptDelivery(
                    deliveryId,
                    "Forkly Driver",
                    "0700000000"
            );

            notificationService.createNotification(
                    customerId,
                    "DELIVERY_ACCEPTED",
                    "Driver Accepted Your Order",
                    "A Forkly driver has accepted your order #"
                            + delivery.getOrderId()
                            + ". Your food will be picked up soon."
            );

            notificationService.createNotification(
                    "ADMIN",
                    "DRIVER_ACCEPTED",
                    "Driver Accepted Delivery",
                    "Driver accepted delivery for order #"
                            + delivery.getOrderId()
            );
        }

        if ("pickup".equals(action)) {

            String etaTime =
                    request.getParameter("etaTime");

            if (etaTime == null || etaTime.trim().isEmpty()) {

                etaTime = "Not provided";
            }

            deliveryService.updateEstimatedTime(
                    deliveryId,
                    etaTime
            );

            deliveryService.updateDeliveryStatus(
                    deliveryId,
                    "PICKED_UP"
            );

            orderService.updateOrderStatus(
                    delivery.getOrderId(),
                    "PICKED_UP"
            );

            notificationService.createNotification(
                    customerId,
                    "ORDER_PICKED_UP",
                    "Order Picked Up",
                    "Your order #"
                            + delivery.getOrderId()
                            + " has been picked up and is on the way. Estimated arrival time: "
                            + etaTime
                            + "."
            );

            notificationService.createNotification(
                    "ADMIN",
                    "ORDER_PICKED_UP",
                    "Order Picked Up",
                    "Driver picked up order #"
                            + delivery.getOrderId()
                            + ". ETA: "
                            + etaTime
            );
        }

        if ("delivered".equals(action)) {

            deliveryService.updateDeliveryStatus(
                    deliveryId,
                    "DELIVERED"
            );

            orderService.updateOrderStatus(
                    delivery.getOrderId(),
                    "DELIVERED"
            );

            notificationService.createNotification(
                    customerId,
                    "ORDER_DELIVERED",
                    "Order Delivered",
                    "Your order #"
                            + delivery.getOrderId()
                            + " has been delivered successfully. Thank you for choosing Forkly!"
            );

            notificationService.createNotification(
                    "ADMIN",
                    "DELIVERY_COMPLETED",
                    "Delivery Completed",
                    "Order #"
                            + delivery.getOrderId()
                            + " was delivered successfully by the driver."
            );
        }

        response.sendRedirect(request.getContextPath()
                + "/driver/tracking.jsp");
    }
}