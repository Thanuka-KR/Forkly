<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.NotificationService" %>
<%@ page import="model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>

<!DOCTYPE html>

<html>

<head>

    <title>Forkly Notifications</title>

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
    String userId =
            (String) session.getAttribute("userId");

    if (userId == null) {

        userId = "GUEST";
    }

    NotificationService notificationService =
            new NotificationService();

    List<Notification> notifications =
            notificationService.getNotificationsByUser(userId);

    Map<String, java.util.List<Notification>> groupedNotifications =
            new LinkedHashMap<>();

    for (Notification n : notifications) {

        String message =
                n.getMessage();

        String orderKey =
                "General Updates";

        int orderIndex =
                message.indexOf("#ORD");

        if (orderIndex >= 0) {

            orderKey =
                    message.substring(orderIndex).split(" ")[0];

            orderKey =
                    orderKey.replace(".", "");
        }

        if (!groupedNotifications.containsKey(orderKey)) {

            groupedNotifications.put(
                    orderKey,
                    new java.util.ArrayList<Notification>()
            );
        }

        groupedNotifications.get(orderKey).add(n);
    }
%>

<main class="container section">

    <div class="notification-header">

        <div>

            <h1 class="page-title">

                Notifications

            </h1>

            <p class="page-subtitle">

                View your order updates
                in grouped notification threads.

            </p>

        </div>

        <span class="notification-count">

            <%= notifications.size() %> Updates

        </span>

    </div>

    <% if (notifications != null && !notifications.isEmpty()) { %>

    <div class="notification-toolbar">

        <form method="post"
              action="<%=request.getContextPath()%>/notification-action">

            <input type="hidden"
                   name="action"
                   value="markAllRead">

            <input type="hidden"
                   name="userId"
                   value="<%= userId %>">

            <input type="hidden"
                   name="redirect"
                   value="client">

            <button class="btn btn-light"
                    type="submit">

                ✓ Mark All Read

            </button>

        </form>

        <form method="post"
              action="<%=request.getContextPath()%>/notification-action">

            <input type="hidden"
                   name="action"
                   value="clearAll">

            <input type="hidden"
                   name="userId"
                   value="<%= userId %>">

            <input type="hidden"
                   name="redirect"
                   value="client">

            <button class="btn btn-danger"
                    type="submit">

                🗑 Delete All

            </button>

        </form>

    </div>

    <% } %>

    <% if (notifications == null || notifications.isEmpty()) { %>

    <div class="empty-notification-card">

        <h2>

            No notifications yet 🔔

        </h2>

        <p>

            Payment, order,
            and delivery updates will appear here.

        </p>

    </div>

    <% } else { %>

    <div class="notification-thread-list">

        <% for (Map.Entry<String,
                java.util.List<Notification>> entry
                : groupedNotifications.entrySet()) { %>

        <%
            String orderKey =
                    entry.getKey();

            java.util.List<Notification> group =
                    entry.getValue();

            Notification latest =
                    group.get(group.size() - 1);
        %>

        <details class="notification-thread-card"
                 open>

            <summary class="notification-thread-summary">

                <div class="thread-left">

                    <div class="thread-icon">

                        🔔

                    </div>

                    <div>

                        <h2>

                            <%= orderKey %>

                        </h2>

                        <p>

                            Latest update:
                            <strong>

                                <%= latest.getTitle() %>

                            </strong>

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
                            String type =
                                    n.getType();

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

                        <h3>

                            <%= n.getTitle() %>

                        </h3>

                        <p>

                            <%= n.getMessage() %>

                        </p>

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
                                   value="client">

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

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

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

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>

</html>