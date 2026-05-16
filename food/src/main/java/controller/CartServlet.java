package controller;

import model.Order;
import model.OrderItem;

import service.OrderService;
import service.DeliveryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        response.sendRedirect(request.getContextPath()
                + "/client/cart.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        HttpSession session = request.getSession();

        List<OrderItem> cart = getCartFromSession(session);

        if ("add".equals(action)) {

            addItemToCart(request, cart);

            session.setAttribute("cart", cart);

            updateCartCount(session, cart);

            String ajax =
                    request.getHeader("X-Requested-With");

            if ("XMLHttpRequest".equals(ajax)) {

                response.setContentType("text/plain");

                response.getWriter().write("success");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/client/menu.jsp#item-"
                        + request.getParameter("itemId"));
            }

            return;
        }

        if ("remove".equals(action)) {

            removeItemFromCart(request, cart);

            session.setAttribute("cart", cart);

            updateCartCount(session, cart);

            response.sendRedirect(request.getContextPath()
                    + "/client/cart.jsp");

            return;
        }

        if ("increase".equals(action)) {

            updateQuantity(cart,
                    request.getParameter("itemId"),
                    1);

            session.setAttribute("cart", cart);

            updateCartCount(session, cart);

            response.sendRedirect(request.getContextPath()
                    + "/client/cart.jsp");

            return;
        }

        if ("decrease".equals(action)) {

            updateQuantity(cart,
                    request.getParameter("itemId"),
                    -1);

            session.setAttribute("cart", cart);

            updateCartCount(session, cart);

            response.sendRedirect(request.getContextPath()
                    + "/client/cart.jsp");

            return;
        }

        if ("clear".equals(action)) {

            session.removeAttribute("cart");

            session.setAttribute("cartCount", 0);

            response.sendRedirect(request.getContextPath()
                    + "/client/cart.jsp");

            return;
        }

        if ("checkout".equals(action)) {

            checkoutCart(request, response, session, cart);

            return;
        }

        response.sendRedirect(request.getContextPath()
                + "/client/cart.jsp");
    }

    private List<OrderItem> getCartFromSession(HttpSession session) {

        List<OrderItem> cart =
                (List<OrderItem>) session.getAttribute("cart");

        if (cart == null) {

            cart = new ArrayList<>();
        }

        return cart;
    }

    private void addItemToCart(HttpServletRequest request,
                               List<OrderItem> cart) {

        String itemId = request.getParameter("itemId");

        String itemName = request.getParameter("itemName");

        double price =
                Double.parseDouble(request.getParameter("price"));

        int quantity =
                Integer.parseInt(request.getParameter("quantity"));

        for (OrderItem item : cart) {

            if (item.getItemId().equals(itemId)) {

                item.setQuantity(item.getQuantity() + quantity);

                return;
            }
        }

        OrderItem newItem =
                new OrderItem(itemId, itemName, quantity, price);

        cart.add(newItem);
    }

    private void removeItemFromCart(HttpServletRequest request,
                                    List<OrderItem> cart) {

        String itemId =
                request.getParameter("itemId");

        cart.removeIf(item ->
                item.getItemId().equals(itemId));
    }

    private void updateQuantity(List<OrderItem> cart,
                                String itemId,
                                int change) {

        for (int i = 0; i < cart.size(); i++) {

            OrderItem item = cart.get(i);

            if (item.getItemId().equals(itemId)) {

                int newQuantity =
                        item.getQuantity() + change;

                if (newQuantity <= 0) {

                    cart.remove(i);

                } else {

                    item.setQuantity(newQuantity);
                }

                return;
            }
        }
    }

    private void updateCartCount(HttpSession session,
                                 List<OrderItem> cart) {

        int totalCount = 0;

        for (OrderItem item : cart) {

            totalCount =
                    totalCount + item.getQuantity();
        }

        session.setAttribute("cartCount", totalCount);
    }

    private void checkoutCart(HttpServletRequest request,
                              HttpServletResponse response,
                              HttpSession session,
                              List<OrderItem> cart)
            throws IOException {

        if (cart == null || cart.isEmpty()) {

            response.sendRedirect(request.getContextPath()
                    + "/client/cart.jsp?empty=1");

            return;
        }

        String customerId =
                (String) session.getAttribute("userId");

        if (customerId == null) {

            customerId = "GUEST";
        }

        String deliveryAddress =
                request.getParameter("deliveryAddress");

        if (deliveryAddress == null
                || deliveryAddress.trim().isEmpty()) {

            deliveryAddress = "Address not provided";
        }

        String deliveryType =
                request.getParameter("deliveryType");

        if (deliveryType == null
                || deliveryType.trim().isEmpty()) {

            deliveryType = "STANDARD";
        }

        double deliveryFee;

        if ("EXPRESS".equals(deliveryType)) {

            deliveryFee = 350.00;

        } else {

            deliveryFee = 250.00;
        }

        OrderService orderService =
                new OrderService();

        Order order =
                orderService.createOrder(
                        customerId,
                        cart,
                        deliveryAddress
                );

        DeliveryService deliveryService =
                new DeliveryService();

        deliveryService.createDelivery(
                order.getOrderId(),
                customerId,
                deliveryAddress,
                deliveryType
        );

        double subtotal =
                order.getTotalAmount();

        double finalAmount =
                subtotal + deliveryFee;

        session.setAttribute("pendingOrderId",
                order.getOrderId());

        session.setAttribute("pendingSubtotal",
                subtotal);

        session.setAttribute("pendingDeliveryFee",
                deliveryFee);

        session.setAttribute("pendingDeliveryType",
                deliveryType);

        session.setAttribute("pendingAmount",
                finalAmount);

        session.removeAttribute("cart");

        session.setAttribute("cartCount", 0);

        response.sendRedirect(request.getContextPath()
                + "/client/payment.jsp");
    }
}