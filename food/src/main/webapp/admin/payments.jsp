<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.PaymentService" %>

<%@ page import="model.Payment" %>

<%@ page import="java.util.List" %>

<%
    // ==============================
    // SECTION 1: LOAD PAYMENTS FROM BACKEND
    // ==============================
    PaymentService paymentService =
            new PaymentService();

    List<Payment> payments =
            paymentService.getAllPayments();
%>

<!DOCTYPE html>

<html>

<head>

    <!-- ==============================
         SECTION 2: PAGE SETTINGS
         ============================== -->
    <title>Admin Payments</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<!-- ==============================
     SECTION 3: ADMIN LAYOUT
     ============================== -->
<div class="admin-shell">

    <!-- ==============================
         SECTION 4: SIDEBAR
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
         SECTION 5: MAIN CONTENT
         ============================== -->
    <main class="admin-main">

        <h1 class="page-title">Payment Management</h1>

        <p class="page-subtitle">
            View payment records and cancel invalid payments without deleting data.
        </p>

        <!-- ==============================
             SECTION 6: PAYMENT TABLE
             ============================== -->
        <div class="table-wrap">

            <table>

                <tr>

                    <th>Payment ID</th>

                    <th>Order ID</th>

                    <th>Customer ID</th>

                    <th>Amount</th>

                    <th>Date</th>

                    <th>Method</th>

                    <th>Status</th>

                    <th>Action</th>

                </tr>

                <% if (payments == null || payments.isEmpty()) { %>

                <tr>

                    <td colspan="8">

                        No payment records found.

                    </td>

                </tr>

                <% } else { %>

                <% for (Payment p : payments) { %>

                <%
                    boolean cancelled =
                            "CANCELLED".equalsIgnoreCase(p.getStatus());
                %>

                <tr class="<%= cancelled ? "frozen-row" : "" %>">

                    <td>
                        <%= p.getPaymentId() %>
                    </td>

                    <td>
                        <%= p.getOrderId() %>
                    </td>

                    <td>
                        <%= p.getCustomerId() %>
                    </td>

                    <td>
                        Rs. <%= String.format("%.2f", p.getAmount()) %>
                    </td>

                    <td>
                        <%= p.getPaymentDate() %>
                    </td>

                    <td>
                        <%= p.getMethod() %>
                    </td>

                    <td>

                                <span class="order-status-badge status-<%= p.getStatus().toLowerCase() %>">

                                    <%= p.getStatus() %>

                                </span>

                    </td>

                    <td>

                        <% if (!cancelled) { %>

                        <!-- ==============================
                             CANCEL PAYMENT BUTTON
                             ============================== -->
                        <form method="post"
                              action="<%=request.getContextPath()%>/admin/payment-management">

                            <input type="hidden"
                                   name="action"
                                   value="cancel">

                            <input type="hidden"
                                   name="paymentId"
                                   value="<%= p.getPaymentId() %>">

                            <input type="hidden"
                                   name="orderId"
                                   value="<%= p.getOrderId() %>">

                            <button class="admin-action-btn cancel-payment-btn"
                                    type="submit">

                                Cancel Payment

                            </button>

                        </form>

                        <% } else { %>

                        <!-- ==============================
                             FROZEN RECORD LABEL
                             ============================== -->
                        <span class="frozen-label">

                                        Frozen Record

                                    </span>

                        <% } %>

                    </td>

                </tr>

                <% } %>

                <% } %>

            </table>

        </div>

    </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

</body>

</html>