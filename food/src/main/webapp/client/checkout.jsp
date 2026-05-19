<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>

    <!-- ==============================
         SECTION 1: PAGE SETTINGS
         ============================== -->
    <title>Forkly Checkout</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>


<!-- ==============================
     SECTION 1: NAVIGATION BAR
     ============================== -->
<nav class="nav">

    <div class="container nav-inner">

        <a class="brand" href="<%=request.getContextPath()%>/index.jsp">

            <span class="logo">🍴</span>

            Forkly

        </a>

        <div class="nav-links">

            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>

            <a href="<%=request.getContextPath()%>/client/menu.jsp">Menu</a>

            <a href="<%=request.getContextPath()%>/client/cart.jsp">Cart 🛒</a>

            <a href="<%=request.getContextPath()%>/client/order-history.jsp">Orders</a>

            <a href="<%=request.getContextPath()%>/client/delivery-tracking.jsp">Tracking</a>

            <a href="<%=request.getContextPath()%>/client/notifications.jsp">Notifications</a>

        </div>

        <div class="nav-actions">

            <a class="btn btn-light" href="<%=request.getContextPath()%>/client/login.jsp">Login</a>

            <a class="btn btn-primary" href="<%=request.getContextPath()%>/client/register.jsp">Register</a>

        </div>

    </div>

</nav>


<main class="container">

    <form class="form-card" method="post" action="<%=request.getContextPath()%>/order">

        <h1 class="page-title">Checkout</h1>

        <p class="page-subtitle">Confirm delivery information before payment.</p>

        <div class="form-group">

            <label>Delivery Address</label>

            <textarea name="address" placeholder="Enter delivery address" required></textarea>

        </div>

        <div class="form-group">

            <label>Delivery Type</label>

            <select name="deliveryType">

                <option value="STANDARD">Standard Delivery</option>

                <option value="EXPRESS">Express Delivery</option>

            </select>

        </div>

        <button class="btn btn-primary" type="submit">Continue to Payment</button>

    </form>

</main>


<!-- ==============================
     SECTION 99: FOOTER
     ============================== -->
<footer class="footer">

    <div class="container">

        Forkly © 2026 | Online Food Delivery Management System

    </div>

</footer>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>

</html>
