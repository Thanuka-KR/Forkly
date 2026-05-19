<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.OrderService" %>
<%@ page import="service.NotificationService" %>
<%@ page import="service.DeliveryService" %>

<%@ page import="model.Order" %>
<%@ page import="model.Delivery" %>

<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <title>Forkly Order History</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<%
    String userName =
            (String) session.getAttribute("userName");
%>

<nav class="nav">

    <div class="container nav-inner">

        <a class="brand"
           href="<%=request.getContextPath()%>/index.jsp">

            <span class="logo">🍴</span>

            Forkly

        </a>

        <div class="nav-links">

            <a href="<%=request.getContextPath()%>/index.jsp">
                Home
            </a>

            <% if(userName != null){ %>

            <a href="<%=request.getContextPath()%>/client/menu.jsp">
                Menu
            </a>

            <a class="cart-nav-btn"
               href="<%=request.getContextPath()%>/client/cart.jsp">

                🛒 Cart

                <span id="cart-count-badge">

                    <%= session.getAttribute("cartCount") != null
                            ? session.getAttribute("cartCount")
                            : 0 %>

                </span>

            </a>

            <a href="<%=request.getContextPath()%>/client/order-history.jsp">
                Orders
            </a>

            <% } else { %>

            <a href="<%=request.getContextPath()%>/client/login.jsp">
                Menu 🔒
            </a>

            <a href="<%=request.getContextPath()%>/client/login.jsp">
                Cart 🔒
            </a>

            <a href="<%=request.getContextPath()%>/client/login.jsp">
                Orders 🔒
            </a>

            <% } %>

            <%
                String navUserId =
                        (String) session.getAttribute("userId");

                if (navUserId == null) {

                    navUserId = "GUEST";
                }

                NotificationService navNotificationService =
                        new NotificationService();

                int unreadCount =
                        navNotificationService.getUnreadCount(navUserId);
            %>

            <% if(userName != null){ %>

            <a class="notification-nav-btn"
               href="<%=request.getContextPath()%>/client/notifications.jsp">

                🔔 Notifications

                <% if (unreadCount > 0) { %>

                <span class="notification-badge">

                    <%= unreadCount %>

                </span>

                <% } %>

            </a>

            <% } else { %>

            <a class="notification-nav-btn"
               href="<%=request.getContextPath()%>/client/login.jsp">

                🔔 Notifications 🔒

            </a>

            <% } %>

        </div>

        <%
            String profileAvatar =
                    (String) session.getAttribute("profileAvatar");

            if (profileAvatar == null) {

                profileAvatar = "👤";
            }
        %>

        <div class="nav-actions">

            <% if (userName == null) { %>

            <a class="btn btn-light"
               href="<%=request.getContextPath()%>/client/login.jsp">

                Login

            </a>

            <a class="btn btn-primary"
               href="<%=request.getContextPath()%>/client/register.jsp">

                Register

            </a>

            <% } else { %>

            <div class="profile-dropdown">

                <button class="profile-btn"
                        type="button"
                        onclick="toggleProfileMenu()">

                    <span class="profile-avatar">

                        <%= profileAvatar %>

                    </span>

                </button>

                <div class="profile-menu"
                     id="profileMenu">

                    <div class="profile-menu-header">

                        <strong>
                            <%= userName %>
                        </strong>

                        <span>
                            Forkly Account
                        </span>

                    </div>

                    <a href="<%=request.getContextPath()%>/client/profile.jsp">
                        👤 Update Profile
                    </a>

                    <a href="<%=request.getContextPath()%>/client/notifications.jsp">
                        🔔 Notifications
                    </a>

                    <a href="<%=request.getContextPath()%>/logout">
                        🚪 Logout
                    </a>

                </div>

            </div>

            <% } %>

        </div>

    </div>

</nav>

<%
    String currentUserId =
            (String) session.getAttribute("userId");

    if (currentUserId == null) {

        session.setAttribute("redirectAfterLogin",
                request.getContextPath()
                        + "/client/order-history.jsp");

        response.sendRedirect(request.getContextPath()
                + "/client/login.jsp");

        return;
    }

    OrderService orderService =
            new OrderService();

    DeliveryService deliveryService =
            new DeliveryService();

    List<Order> orders =
            orderService.getOrdersByCustomer(currentUserId);
%>

<main class="container section">

    <h1 class="page-title">
        Order History
    </h1>

    <p class="page-subtitle">
        Track your payment approval, preparation, and delivery progress.
    </p>

    <% if (orders == null || orders.isEmpty()) { %>

    <div class="cart-empty-card">

        <h2>
            No orders yet
        </h2>

        <p>
            Your order history will appear here after you place an order.
        </p>

        <a class="btn btn-primary"
           href="<%=request.getContextPath()%>/client/menu.jsp">

            Browse Menu

        </a>

    </div>

    <% } else { %>

    <div class="order-history-list">

        <% for (Order order : orders) { %>

        <%
            Delivery delivery =
                    deliveryService.getDeliveryByOrderId(
                            order.getOrderId()
                    );

            double deliveryFee = 0;

            if (delivery != null) {

                deliveryFee =
                        delivery.calculateDeliveryFee();
            }

            double finalTotal =
                    order.getTotalAmount() + deliveryFee;

            String status =
                    order.getStatus();

            boolean placedActive = true;

            boolean paymentActive =
                    "PAYMENT_APPROVED".equals(status)
                            || "PREPARING".equals(status)
                            || "READY_FOR_DELIVERY".equals(status)
                            || "PICKED_UP".equals(status)
                            || "DELIVERED".equals(status);

            boolean preparingActive =
                    "PREPARING".equals(status)
                            || "READY_FOR_DELIVERY".equals(status)
                            || "PICKED_UP".equals(status)
                            || "DELIVERED".equals(status);

            boolean readyActive =
                    "READY_FOR_DELIVERY".equals(status)
                            || "PICKED_UP".equals(status)
                            || "DELIVERED".equals(status);

            boolean deliveredActive =
                    "DELIVERED".equals(status);
        %>

        <div class="customer-order-card">

            <div class="order-card-top">

                <div>

                    <h2>
                        Order #<%= order.getOrderId() %>
                    </h2>

                    <p class="muted">
                        Your Order
                    </p>

                </div>

                <span class="order-status-badge status-<%= status.toLowerCase() %>">

                    <%= status %>

                </span>

            </div>

            <div class="order-info-grid">

                <div>

                    <span>
                        Date
                    </span>

                    <strong>
                        <%= order.getOrderDate() %>
                    </strong>

                </div>

                <div>

                    <span>
                        Payment Summary
                    </span>

                    <div class="payment-breakdown">

                        <p>
                            Food Total:
                            <strong>
                                Rs. <%= String.format("%.2f",
                                    order.getTotalAmount()) %>
                            </strong>
                        </p>

                        <p>
                            Delivery Fee:
                            <strong>
                                Rs. <%= String.format("%.2f",
                                    deliveryFee) %>
                            </strong>
                        </p>

                        <p class="final-total">
                            Total Payment:
                            <strong>
                                Rs. <%= String.format("%.2f",
                                    finalTotal) %>
                            </strong>
                        </p>

                    </div>

                </div>

            </div>

            <div class="order-progress">

                <div class="progress-step <%= placedActive ? "active" : "" %>">

                    <div class="progress-dot">
                        ✓
                    </div>

                    <p>
                        Order Placed
                    </p>

                </div>

                <div class="progress-line <%= paymentActive ? "active" : "" %>"></div>

                <div class="progress-step <%= paymentActive ? "active" : "" %>">

                    <div class="progress-dot">
                        ✓
                    </div>

                    <p>
                        Payment Approved
                    </p>

                </div>

                <div class="progress-line <%= preparingActive ? "active" : "" %>"></div>

                <div class="progress-step <%= preparingActive ? "active" : "" %>">

                    <div class="progress-dot">
                        ✓
                    </div>

                    <p>
                        Preparing
                    </p>

                </div>

                <div class="progress-line <%= readyActive ? "active" : "" %>"></div>

                <div class="progress-step <%= readyActive ? "active" : "" %>">

                    <div class="progress-dot">
                        ✓
                    </div>

                    <p>
                        Ready
                    </p>

                </div>

                <div class="progress-line <%= deliveredActive ? "active" : "" %>"></div>

                <div class="progress-step <%= deliveredActive ? "active" : "" %>">

                    <div class="progress-dot">
                        ✓
                    </div>

                    <p>
                        Delivered
                    </p>

                </div>

            </div>

        </div>

        <% } %>

    </div>

    <% } %>

</main>

<script>

    function toggleProfileMenu() {

        const menu =
            document.getElementById("profileMenu");

        if (menu) {

            menu.classList.toggle("show-profile-menu");
        }
    }

    window.addEventListener("click", function (e) {

        if (!e.target.closest(".profile-dropdown")) {

            const menu =
                document.getElementById("profileMenu");

            if (menu) {

                menu.classList.remove("show-profile-menu");
            }
        }
    });

</script>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

</body>

</html>