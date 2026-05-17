<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.NotificationService" %>

<!DOCTYPE html>

<html>

<head>

    <title>Forkly Payment</title>

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

            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>

            <% if(userName != null){ %>

            <a href="<%=request.getContextPath()%>/client/menu.jsp">Menu</a>

            <a class="cart-nav-btn"
               href="<%=request.getContextPath()%>/client/cart.jsp">

                🛒 Cart

                <span id="cart-count-badge">
                    <%= session.getAttribute("cartCount") != null
                            ? session.getAttribute("cartCount")
                            : 0 %>
                </span>

            </a>

            <a href="<%=request.getContextPath()%>/client/order-history.jsp">Orders</a>

            <% } else { %>

            <a href="<%=request.getContextPath()%>/client/login.jsp">Menu 🔒</a>
            <a href="<%=request.getContextPath()%>/client/login.jsp">Cart 🔒</a>
            <a href="<%=request.getContextPath()%>/client/login.jsp">Orders 🔒</a>

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
                        <strong><%= userName %></strong>
                        <span>Forkly Account</span>
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
    String pendingOrderId =
            (String) session.getAttribute("pendingOrderId");

    Double pendingAmount =
            (Double) session.getAttribute("pendingAmount");

    Double pendingSubtotal =
            (Double) session.getAttribute("pendingSubtotal");

    Double pendingDeliveryFee =
            (Double) session.getAttribute("pendingDeliveryFee");

    if (pendingOrderId == null) {
        pendingOrderId = "";
    }

    if (pendingAmount == null) {
        pendingAmount = 0.0;
    }

    if (pendingSubtotal == null) {
        pendingSubtotal = 0.0;
    }

    if (pendingDeliveryFee == null) {
        pendingDeliveryFee = 0.0;
    }
%>

<main class="container">

    <form class="form-card"
          method="post"
          action="<%=request.getContextPath()%>/payment">

        <h1 class="page-title">Payment</h1>

        <p class="page-subtitle">
            Choose payment method and confirm payment.
        </p>

        <div class="form-group">

            <label>Order ID</label>

            <input type="text"
                   name="orderId"
                   value="<%= pendingOrderId %>"
                   readonly>

        </div>

        <div class="modern-payment-summary">

            <h3>Payment Summary</h3>

            <div class="payment-summary-row">

                <span>Subtotal</span>

                <strong>
                    Rs. <%= String.format("%.2f", pendingSubtotal) %>
                </strong>

            </div>

            <div class="payment-summary-row">

                <span>Delivery Fee</span>

                <strong>
                    Rs. <%= String.format("%.2f", pendingDeliveryFee) %>
                </strong>

            </div>

            <div class="payment-summary-divider"></div>

            <div class="payment-summary-row total-pay-row">

                <span>Total Pay</span>

                <strong>
                    Rs. <%= String.format("%.2f", pendingAmount) %>
                </strong>

            </div>

        </div>

        <input type="hidden"
               name="amount"
               value="<%= pendingAmount %>">

        <div class="form-group">

            <label>Payment Method</label>

            <select name="method"
                    id="paymentMethodSelect">

                <option value="CARD">💳 Card Payment</option>

                <option value="CASH">💵 Cash Payment</option>

            </select>

        </div>

        <div class="modern-card-payment"
             id="modernCardPayment">

            <div class="card-payment-header">

                <div>

                    <h3>Secure Card Payment</h3>

                    <p>Enter your debit or credit card details.</p>

                </div>

                <div class="payment-card-icon">💳</div>

            </div>

            <div class="form-group">

                <label>Card Holder Name</label>

                <input type="text"
                       name="cardHolder"
                       id="cardHolder"
                       placeholder="John Smith">

            </div>

            <div class="form-group">

                <label>Card Number</label>

                <input type="text"
                       name="cardNumber"
                       id="cardNumber"
                       maxlength="19"
                       placeholder="1234 5678 9012 3456">

            </div>

            <div class="payment-row">

                <div class="form-group">

                    <label>Expiry Date</label>

                    <input type="text"
                           name="expiryDate"
                           id="expiryDate"
                           maxlength="5"
                           placeholder="MM/YY">

                </div>

                <div class="form-group">

                    <label>CVV</label>

                    <input type="password"
                           name="cvv"
                           id="cvv"
                           maxlength="3"
                           placeholder="123">

                </div>

            </div>

        </div>

        <button class="btn btn-primary"
                type="submit">

            Pay Now

        </button>

    </form>

</main>

<footer class="footer">

    <div class="container">
        Forkly © 2026 | Online Food Delivery Management System
    </div>

</footer>

<script src="<%=request.getContextPath()%>/assets/js/main.js?v=70"></script>

<script>

    function toggleProfileMenu() {

        const menu =
            document.getElementById("profileMenu");

        if(menu){

            menu.classList.toggle("show-profile-menu");
        }
    }

    window.addEventListener("click", function (e) {

        if (!e.target.closest(".profile-dropdown")) {

            const menu =
                document.getElementById("profileMenu");

            if(menu){

                menu.classList.remove("show-profile-menu");
            }
        }
    });

    const paymentSelect =
        document.getElementById("paymentMethodSelect");

    const cardSection =
        document.getElementById("modernCardPayment");

    function updatePaymentUI(){

        if(paymentSelect.value === "CARD"){

            cardSection.style.display =
                "block";

        } else {

            cardSection.style.display =
                "none";
        }
    }

    paymentSelect.addEventListener(
        "change",
        updatePaymentUI
    );

    updatePaymentUI();

</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>

</html>