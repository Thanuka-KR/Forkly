<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.OrderService" %>

<%@ page import="model.Order" %>

<%@ page import="java.util.List" %>

<%
    OrderService orderService = new OrderService();

    List<Order> orders = orderService.getAllOrders();
%>

<!DOCTYPE html>

<html>

<head>

    <title>Admin Orders</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<div class="admin-shell">

    <aside class="sidebar">

        <a class="brand" href="<%=request.getContextPath()%>/index.jsp">
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

    <main class="admin-main">

        <h1 class="page-title">Order Management</h1>

        <p class="page-subtitle">
            Approve payments and update customer order preparation status.
        </p>

        <div class="table-wrap">

            <table>

                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Admin Actions</th>
                </tr>

                <% for (Order o : orders) { %>

                <%
                    boolean frozen =
                            "PAYMENT_CANCELLED"
                                    .equalsIgnoreCase(o.getStatus());
                %>

                <tr class="<%= frozen ? "frozen-row" : "" %>">

                    <td><%= o.getOrderId() %></td>

                    <td><%= o.getCustomerId() %></td>

                    <td><%= o.getOrderDate() %></td>

                    <td>Rs. <%= String.format("%.2f", o.getTotalAmount()) %></td>

                    <td>
                            <span class="order-status-badge status-<%= o.getStatus().toLowerCase() %>">
                                <%= o.getStatus() %>
                            </span>
                    </td>

                    <td>

                        <% if (!frozen) { %>

                        <div class="admin-order-actions">

                            <form method="post"
                                  action="<%=request.getContextPath()%>/admin/order-status">

                                <input type="hidden"
                                       name="orderId"
                                       value="<%= o.getOrderId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="PAYMENT_APPROVED">

                                <button class="admin-action-btn approve-btn"
                                        type="submit">
                                    Approve Payment
                                </button>

                            </form>

                            <form method="post"
                                  action="<%=request.getContextPath()%>/admin/order-status">

                                <input type="hidden"
                                       name="orderId"
                                       value="<%= o.getOrderId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="PREPARING">

                                <button class="admin-action-btn prepare-btn"
                                        type="submit">
                                    Mark Preparing
                                </button>

                            </form>

                            <form method="post"
                                  action="<%=request.getContextPath()%>/admin/order-status">

                                <input type="hidden"
                                       name="orderId"
                                       value="<%= o.getOrderId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="READY_FOR_DELIVERY">

                                <button class="admin-action-btn ready-btn"
                                        type="submit">
                                    Ready Delivery
                                </button>

                            </form>

                            <form method="post"
                                  action="<%=request.getContextPath()%>/admin/order-status">

                                <input type="hidden"
                                       name="orderId"
                                       value="<%= o.getOrderId() %>">

                                <input type="hidden"
                                       name="status"
                                       value="DELIVERED">

                                <button class="admin-action-btn delivered-btn"
                                        type="submit">
                                    Delivered
                                </button>

                            </form>

                        </div>

                        <% } else { %>

                        <span class="frozen-label">
                                    Frozen Order
                                </span>

                        <% } %>

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