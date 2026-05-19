
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.DashboardService" %>

<!DOCTYPE html>

<html>

<head>

    <!-- ==============================
         SECTION 1: PAGE SETTINGS
         ============================== -->
    <title>Forkly Admin Dashboard</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- ==============================
         SECTION 2: CSS FILE LINK
         ============================== -->
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/admin-dashboard.css">

</head>

<body>

<!-- ==============================
     SECTION 3: MAIN LAYOUT
     ============================== -->
<div class="admin-layout">

    <!-- ==============================
         SECTION 4: SIDEBAR
         ============================== -->
    <aside class="sidebar">

        <div class="brand">

            <div class="brand-icon">
                🍴
            </div>

            <div class="brand-text">

                <h2>Forkly</h2>

                <p>Admin Panel</p>

            </div>

        </div>

        <nav class="side-menu">

            <a class="active"
               href="<%=request.getContextPath()%>/admin/dashboard.jsp">

                Dashboard

            </a>

            <a href="<%=request.getContextPath()%>/admin/users.jsp">
                User Management
            </a>

            <a href="<%=request.getContextPath()%>/admin/menu-management.jsp">
                Menu Management
            </a>

            <a href="<%=request.getContextPath()%>/admin/orders.jsp">
                Order Management
            </a>

            <a href="<%=request.getContextPath()%>/admin/payments.jsp">
                Payment Management
            </a>

            <a href="<%=request.getContextPath()%>/admin/deliveries.jsp">
                Delivery Management
            </a>

            <a href="<%=request.getContextPath()%>/admin/reviews.jsp">
                Review Management
            </a>

            <a href="<%=request.getContextPath()%>/admin/notifications.jsp">
                Notifications
            </a>

            <a href="<%=request.getContextPath()%>/index.jsp">
                Back to Website
            </a>

        </nav>

    </aside>

    <!-- ==============================
         SECTION 5: DASHBOARD COUNTS
         ============================== -->
    <%
        DashboardService dashboardService =
                new DashboardService();

        int totalUsers =
                dashboardService.getTotalUsers();

        int totalMenuItems =
                dashboardService.getTotalMenuItems();

        int totalOrders =
                dashboardService.getTotalOrders();

        int activeDeliveries =
                dashboardService.getActiveDeliveries();
    %>

    <!-- ==============================
         SECTION 6: MAIN CONTENT
         ============================== -->
    <main class="main-content">

        <!-- ==============================
             SECTION 7: TOPBAR
             ============================== -->
        <section class="topbar">

            <div>

                <h1>Admin Dashboard</h1>

                <p>
                    Manage Forkly online food delivery system.
                </p>

            </div>

            <div class="admin-profile">

                <div class="admin-avatar">
                    A
                </div>

                <div>

                    <strong>Admin</strong>

                    <p>System Manager</p>

                </div>

            </div>

        </section>

        <!-- ==============================
             SECTION 8: SUMMARY CARDS
             ============================== -->
        <section class="summary-grid">

            <div class="summary-card">

                <span>👥</span>

                <h3><%= totalUsers %></h3>

                <p>Total Users</p>

            </div>

            <div class="summary-card">

                <span>🍔</span>

                <h3><%= totalMenuItems %></h3>

                <p>Menu Items</p>

            </div>

            <div class="summary-card">

                <span>🛒</span>

                <h3><%= totalOrders %></h3>

                <p>Total Orders</p>

            </div>

            <div class="summary-card">

                <span>🚚</span>

                <h3><%= activeDeliveries %></h3>

                <p>Active Deliveries</p>

            </div>

        </section>

        <!-- ==============================
             SECTION 9: MODULE CARDS
             ============================== -->
        <section class="module-grid">

            <!-- USER MANAGEMENT -->
            <div class="module-card">

                <div class="module-icon">
                    👤
                </div>

                <h2>User Management</h2>

                <p>
                    Manage customers, drivers, and admin accounts.
                </p>

                <a class="module-btn"
                   href="<%=request.getContextPath()%>/admin/users.jsp">

                    Open Module

                </a>

            </div>

            <!-- MENU MANAGEMENT -->
            <div class="module-card">

                <div class="module-icon">
                    🍕
                </div>

                <h2>Menu Management</h2>

                <p>
                    Manage food items and categories.
                </p>

                <a class="module-btn"
                   href="<%=request.getContextPath()%>/admin/menu-management.jsp">

                    Open Module

                </a>

            </div>

            <!-- ORDER MANAGEMENT -->
            <div class="module-card">

                <div class="module-icon">
                    📦
                </div>

                <h2>Order Management</h2>

                <p>
                    Manage customer orders and status.
                </p>

                <a class="module-btn"
                   href="<%=request.getContextPath()%>/admin/orders.jsp">

                    Open Module

                </a>

            </div>

            <!-- PAYMENT MANAGEMENT -->
            <div class="module-card">

                <div class="module-icon">
                    💳
                </div>

                <h2>Payment Management</h2>

                <p>
                    Manage payments and transaction history.
                </p>

                <a class="module-btn"
                   href="<%=request.getContextPath()%>/admin/payments.jsp">

                    Open Module

                </a>

            </div>

            <!-- DELIVERY MANAGEMENT -->
            <div class="module-card">

                <div class="module-icon">
                    🚴
                </div>

                <h2>Delivery Management</h2>

                <p>
                    Track deliveries and delivery persons.
                </p>

                <a class="module-btn"
                   href="<%=request.getContextPath()%>/admin/deliveries.jsp">

                    Open Module

                </a>

            </div>

            <!-- REVIEW MANAGEMENT -->
            <div class="module-card">

                <div class="module-icon">
                    ⭐
                </div>

                <h2>Review Management</h2>

                <p>
                    Manage customer reviews and ratings.
                </p>

                <a class="module-btn"
                   href="<%=request.getContextPath()%>/admin/reviews.jsp">

                    Open Module

                </a>

            </div>

            <!-- NOTIFICATION MANAGEMENT -->
            <div class="module-card">

                <div class="module-icon">
                    🔔
                </div>

                <h2>Notification Management</h2>

                <p>
                    Manage customer and system notifications.
                </p>

                <a class="module-btn"
                   href="<%=request.getContextPath()%>/admin/notifications.jsp">

                    Open Module

                </a>

            </div>

        </section>

    </main>

</div>

</body>

</html>

