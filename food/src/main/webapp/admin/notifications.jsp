<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.NotificationService" %>
<%@ page import="model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>

<%
    NotificationService notificationService = new NotificationService();

    List<Notification> notifications =
            notificationService.getNotificationsByUser("ADMIN");

    Map<String, java.util.List<Notification>> groupedNotifications =
            new LinkedHashMap<>();

    for (Notification n : notifications) {

        String message = n.getMessage();
        String orderKey = "General Updates";

        int orderIndex = message.indexOf("#ORD");

        if (orderIndex >= 0) {
            orderKey = message.substring(orderIndex).split(" ")[0];
            orderKey = orderKey.replace(".", "");
        }

        if (!groupedNotifications.containsKey(orderKey)) {
            groupedNotifications.put(orderKey,
                    new java.util.ArrayList<Notification>());
        }

        groupedNotifications.get(orderKey).add(n);
    }
%>

<!DOCTYPE html>

<html>

<head>

    <title>Admin Notifications</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<div class="admin-shell">

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

    <main class="admin-main">

        <div class="notification-header">

            <div>

                <h1 class="page-title">
                    Admin Notifications
                </h1>

                <p class="page-subtitle">
                    Grouped updates about payments, deliveries, and customer activity.
                </p>

            </div>

            <span class="notification-count">
                <%= notifications.size() %> Updates
            </span>

        </div>

        <!-- ==============================
             OFFER SUCCESS MESSAGE
             ============================== -->

        <% if(request.getParameter("offerSent") != null){ %>

        <div class="alert alert-success">

            🎉 Offer notification sent to
            <strong><%= request.getParameter("offerSent") %></strong>
            users successfully.

        </div>

        <% } %>

        <!-- ==============================
             SEND OFFER CARD
             ============================== -->

        <div class="admin-offer-card">

            <div class="offer-card-top">

                <div>

                    <h2>
                        📢 Send Promotional Offer
                    </h2>

                    <p class="muted">
                        Send a notification offer to all customer accounts.
                    </p>

                </div>

                <span class="offer-badge">
                    Marketing Tool
                </span>

            </div>

            <form class="admin-offer-form"
                  method="post"
                  action="<%=request.getContextPath()%>/notification-action">

                <input type="hidden"
                       name="action"
                       value="sendOfferAll">

                <div class="form-group">

                    <label>
                        Offer Title
                    </label>

                    <input type="text"
                           name="offerTitle"
                           placeholder="50% OFF Weekend Deal"
                           required>

                </div>

                <div class="form-group">

                    <label>
                        Offer Message
                    </label>

                    <textarea name="offerMessage"
                              rows="4"
                              placeholder="Enjoy 50% OFF on all pizza orders this weekend!"
                              required></textarea>

                </div>

                <button class="btn btn-primary"
                        type="submit">

                    🚀 Send Offer To All Users

                </button>

            </form>

        </div>

        <% if (notifications != null && !notifications.isEmpty()) { %>

        <div class="notification-toolbar">

            <form method="post"
                  action="<%=request.getContextPath()%>/notification-action">

                <input type="hidden" name="action" value="markAllRead">
                <input type="hidden" name="userId" value="ADMIN">
                <input type="hidden" name="redirect" value="admin">

                <button class="btn btn-light" type="submit">
                    ✓ Mark All Read
                </button>

            </form>

            <form method="post"
                  action="<%=request.getContextPath()%>/notification-action">

                <input type="hidden" name="action" value="clearAll">
                <input type="hidden" name="userId" value="ADMIN">
                <input type="hidden" name="redirect" value="admin">

                <button class="btn btn-danger" type="submit">
                    🗑 Delete All
                </button>

            </form>

        </div>

        <% } %>

        <% if (notifications == null || notifications.isEmpty()) { %>

        <div class="empty-notification-card">

            <h2>No admin notifications 🔔</h2>

            <p>
                New payment and delivery alerts will appear here.
            </p>

        </div>

        <% } else { %>

        <div class="notification-thread-list">

            <% for (Map.Entry<String, java.util.List<Notification>> entry
                    : groupedNotifications.entrySet()) { %>

            <%
                String orderKey = entry.getKey();

                java.util.List<Notification> group =
                        entry.getValue();

                Notification latest =
                        group.get(group.size() - 1);
            %>

            <details class="notification-thread-card" open>

                <summary class="notification-thread-summary">

                    <div class="thread-left">

                        <div class="thread-icon">
                            🔔
                        </div>

                        <div>
                            <h2><%= orderKey %></h2>

                            <p>
                                Latest update:
                                <strong><%= latest.getTitle() %></strong>
                            </p>
                        </div>

                    </div>

                    <div class="thread-right">

                        <span class="thread-count">
                            <%= group.size() %> updates
                        </span>

                        <span class="thread-time">
                            <%= latest.getCreatedAt() %>
                        </span>

                    </div>

                </summary>

                <div class="notification-timeline">

                    <% for (Notification n : group) { %>

                    <div class="timeline-row">

                        <div class="timeline-dot">

                            <%
                                String type = n.getType();

                                if (type.contains("PAYMENT")) {
                            %>
                            💳
                            <% } else if (type.contains("DELIVERY")) { %>
                            🚚
                            <% } else if (type.contains("ORDER")) { %>
                            🍽️
                            <% } else { %>
                            🔔
                            <% } %>

                        </div>

                        <div class="timeline-content">

                            <div class="timeline-top">

                                <span class="notification-type">
                                    <%= n.getType() %>
                                </span>

                                <span class="notification-time">
                                    <%= n.getCreatedAt() %>
                                </span>

                            </div>

                            <h3><%= n.getTitle() %></h3>

                            <p><%= n.getMessage() %></p>

                            <form class="single-delete-form"
                                  method="post"
                                  action="<%=request.getContextPath()%>/notification-action">

                                <input type="hidden"
                                       name="action"
                                       value="deleteOne">

                                <input type="hidden"
                                       name="notificationId"
                                       value="<%= n.getNotificationId() %>">

                                <input type="hidden"
                                       name="redirect"
                                       value="admin">

                                <button class="delete-notification-btn"
                                        type="submit">
                                    Delete
                                </button>

                            </form>

                        </div>

                    </div>

                    <% } %>

                </div>

            </details>

            <% } %>

        </div>

        <% } %>

    </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/main.js?v=25"></script>

</body>

</html>