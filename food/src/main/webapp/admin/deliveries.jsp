<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.DeliveryService" %>
<%@ page import="model.Delivery" %>
<%@ page import="java.util.List" %>

<%
    DeliveryService deliveryService =
            new DeliveryService();

    List<Delivery> deliveries =
            deliveryService.getAllDeliveries();
%>

<!DOCTYPE html>

<html>

<head>

    <title>Admin Deliveries</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<div class="admin-shell">

    <!-- ==============================
         SIDEBAR
         ============================== -->
    <aside class="sidebar">

        <a class="brand"
           href="<%=request.getContextPath()%>/index.jsp">

            <span class="logo">🍴</span>

            Forkly

        </a>

        <a href="<%=request.getContextPath()%>/admin/dashboard.jsp">Dashboard</a>

        <a href="<%=request.getContextPath()%>/admin/users.jsp">Users</a>

        <a href="<%=request.getContextPath()%>/admin/menu-management.jsp">Menu</a>

        <a href="<%=request.getContextPath()%>/admin/orders.jsp">Orders</a>

        <a href="<%=request.getContextPath()%>/admin/payments.jsp">Payments</a>

        <a href="<%=request.getContextPath()%>/admin/deliveries.jsp">Deliveries</a>

        <a href="<%=request.getContextPath()%>/admin/reviews.jsp">Reviews</a>

        <a href="<%=request.getContextPath()%>/admin/notifications.jsp">Notifications</a>

        <a href="<%=request.getContextPath()%>/logout">Logout</a>

    </aside>

    <!-- ==============================
         MAIN CONTENT
         ============================== -->
    <main class="admin-main">

        <h1 class="page-title">

            Delivery Management

        </h1>

        <p class="page-subtitle">

            Track driver activity and real-time delivery progress.

        </p>

        <!-- ==============================
             DELIVERY TABLE
             ============================== -->
        <div class="table-wrap">

            <table>

                <tr>

                    <th>Delivery ID</th>

                    <th>Order ID</th>

                    <th>Customer</th>

                    <th>Driver</th>

                    <th>Phone</th>

                    <th>Status</th>

                    <th>Address</th>

                    <th>ETA</th>

                </tr>

                <% for (Delivery d : deliveries) { %>

                <tr>

                    <td>

                        <%= d.getDeliveryId() %>

                    </td>

                    <td>

                        #<%= d.getOrderId() %>

                    </td>

                    <td>

                        <%= d.getCustomerId() %>

                    </td>

                    <td>

                        <%= d.getDriverName() %>

                    </td>

                    <td>

                        <%= d.getDriverPhone() %>

                    </td>

                    <td>

                            <span class="order-status-badge status-<%= d.getStatus().toLowerCase() %>">

                                <%= d.getStatus() %>

                            </span>

                    </td>

                    <td class="delivery-address-cell">

                        <%= d.getAddress() %>

                    </td>

                    <td>

                        <%= d.getEstimatedTime() %>

                    </td>

                </tr>

                <% } %>

            </table>

        </div>

    </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

</body>

</html>