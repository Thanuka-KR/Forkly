<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="service.NotificationService" %>

<!DOCTYPE html>

<html>

<head>

    <title>Forkly Cart</title>

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
    List<OrderItem> cart =
            (List<OrderItem>) session.getAttribute("cart");

    double subtotal = 0;

    int itemCount = 0;

    if (cart != null) {

        for (OrderItem item : cart) {

            subtotal =
                    subtotal + item.getSubtotal();

            itemCount =
                    itemCount + item.getQuantity();
        }
    }

    double deliveryFee =
            subtotal > 0 ? 250 : 0;

    double total =
            subtotal + deliveryFee;
%>

<main class="container section">

    <h1 class="page-title">

        Your Cart

    </h1>

    <p class="page-subtitle">

        Review your selected food items and add your delivery address before checkout.

    </p>

    <% if (cart == null || cart.isEmpty()) { %>

    <div class="cart-empty-card">

        <h2>

            Your cart is empty 🛒

        </h2>

        <p>

            Add delicious meals from the menu.

        </p>

        <a class="btn btn-primary"
           href="<%=request.getContextPath()%>/client/menu.jsp">

            Browse Menu

        </a>

    </div>

    <% } else { %>

    <div class="cart-layout">

        <section class="cart-items">

            <% for (OrderItem item : cart) { %>

            <div class="cart-item-card">

                <div class="cart-item-left">

                    <h3>

                        <%= item.getItemName() %>

                    </h3>

                    <p class="muted">

                        Unit Price:
                        Rs.
                        <%= String.format("%.2f", item.getPrice()) %>

                    </p>

                    <div class="quantity-controls">

                        <form method="post"
                              action="<%=request.getContextPath()%>/cart">

                            <input type="hidden"
                                   name="action"
                                   value="decrease">

                            <input type="hidden"
                                   name="itemId"
                                   value="<%= item.getItemId() %>">

                            <button class="qty-btn"
                                    type="submit">

                                -

                            </button>

                        </form>

                        <span class="qty-number">

                                    <%= item.getQuantity() %>

                                </span>

                        <form method="post"
                              action="<%=request.getContextPath()%>/cart">

                            <input type="hidden"
                                   name="action"
                                   value="increase">

                            <input type="hidden"
                                   name="itemId"
                                   value="<%= item.getItemId() %>">

                            <button class="qty-btn"
                                    type="submit">

                                +

                            </button>

                        </form>

                    </div>

                </div>

                <div class="cart-item-right">

                    <strong class="cart-item-total">

                        Rs.
                        <%= String.format("%.2f", item.getSubtotal()) %>

                    </strong>

                    <form method="post"
                          action="<%=request.getContextPath()%>/cart">

                        <input type="hidden"
                               name="action"
                               value="remove">

                        <input type="hidden"
                               name="itemId"
                               value="<%= item.getItemId() %>">

                        <button class="btn btn-danger btn-small"
                                type="submit">

                            Remove

                        </button>

                    </form>

                </div>

            </div>

            <% } %>

        </section>

        <aside class="cart-summary-card">

            <h2>

                Bill Summary

            </h2>

            <div class="summary-row">

                    <span>

                        Total Items

                    </span>

                <strong>

                    <%= itemCount %>

                </strong>

            </div>

            <div class="summary-row">

                    <span>

                        Subtotal

                    </span>

                <strong>

                    Rs. <span id="subtotalAmount"><%= String.format("%.2f", subtotal) %></span>

                </strong>

            </div>

            <div class="delivery-option-box">

                <label class="delivery-label">

                    Choose Delivery Option

                </label>

                <label class="delivery-option">

                    <input type="radio"
                           name="deliveryOptionView"
                           value="STANDARD"
                           data-fee="250"
                           checked
                           onchange="updateDeliveryFee()">

                    Standard Delivery - Rs. 250.00

                </label>

                <label class="delivery-option">

                    <input type="radio"
                           name="deliveryOptionView"
                           value="EXPRESS"
                           data-fee="350"
                           onchange="updateDeliveryFee()">

                    Express Delivery - Rs. 350.00

                </label>

            </div>

            <div class="summary-row">

                    <span>

                        Delivery Fee

                    </span>

                <strong>

                    Rs. <span id="deliveryFeeAmount"><%= String.format("%.2f", deliveryFee) %></span>

                </strong>

            </div>

            <div class="summary-total">

                    <span>

                        Total Pay

                    </span>

                <strong>

                    Rs. <span id="totalPayAmount"><%= String.format("%.2f", total) %></span>

                </strong>

            </div>

            <form method="post"
                  action="<%=request.getContextPath()%>/cart">

                <input type="hidden"
                       name="action"
                       value="checkout">

                <input type="hidden"
                       name="deliveryType"
                       id="deliveryType"
                       value="STANDARD">

                <input type="hidden"
                       name="deliveryFee"
                       id="deliveryFee"
                       value="250">

                <div class="delivery-address-box">

                    <label class="delivery-label">

                        Delivery Address

                    </label>

                    <textarea name="deliveryAddress"
                              class="delivery-textarea"
                              placeholder="Enter full delivery address..."
                              required></textarea>

                    <p class="delivery-help-text">

                        This address will be saved with your order.

                    </p>

                </div>

                <button class="btn btn-primary cart-pay-btn"
                        type="submit">

                    Pay & Place Order

                </button>

            </form>

            <form method="post"
                  action="<%=request.getContextPath()%>/cart">

                <input type="hidden"
                       name="action"
                       value="clear">

                <button class="btn btn-light cart-clear-btn"
                        type="submit">

                    Clear Cart

                </button>

            </form>

        </aside>

    </div>

    <% } %>

</main>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

<script>

    function updateDeliveryFee() {

        const selectedOption =
            document.querySelector('input[name="deliveryOptionView"]:checked');

        const deliveryType =
            selectedOption.value;

        const deliveryFee =
            parseFloat(selectedOption.getAttribute("data-fee"));

        const subtotal =
            parseFloat(document.getElementById("subtotalAmount").innerText);

        const total =
            subtotal + deliveryFee;

        document.getElementById("deliveryFeeAmount").innerText =
            deliveryFee.toFixed(2);

        document.getElementById("totalPayAmount").innerText =
            total.toFixed(2);

        document.getElementById("deliveryType").value =
            deliveryType;

        document.getElementById("deliveryFee").value =
            deliveryFee;
    }

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

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>

</html>