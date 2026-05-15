<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.DeliveryService" %>
<%@ page import="model.Delivery" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <!-- ==============================
         SECTION 1: PAGE SETTINGS
         ============================== -->
    <title>Forkly Delivery Tracking</title>

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


<%
    DeliveryService deliveryService = new DeliveryService();
    List<Delivery> deliveries = deliveryService.getAllDeliveries();
%>
<main class="container section">

    <h1 class="page-title">Delivery Tracking</h1>

    <p class="page-subtitle">Track all delivery records saved in deliveries.txt.</p>

    <div class="table-wrap">

        <table>

            <tr><th>Delivery ID</th><th>Order ID</th><th>Driver</th><th>Status</th><th>Address</th></tr>

            <% for(Delivery d : deliveries){ %>

            <tr>

                <td><%= d.getDeliveryId() %></td>

                <td><%= d.getOrderId() %></td>

                <td><%= d.getDriverName() %></td>

                <td><span class="badge"><%= d.getStatus() %></span></td>

                <td><%= d.getAddress() %></td>

            </tr>

            <% } %>

        </table>

    </div>

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
