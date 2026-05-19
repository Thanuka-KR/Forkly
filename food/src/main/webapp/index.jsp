<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.NotificationService" %>
<%@ page import="service.ReviewService" %>
<%@ page import="service.UserService" %>
<%@ page import="service.MenuService" %>
<%@ page import="service.OrderService" %>
<%@ page import="service.DeliveryService" %>
<%@ page import="service.DashboardService" %>
<%@ page import="model.Review" %>
<%@ page import="model.Delivery" %>
<%@ page import="model.MenuItem" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>
    <title>Forkly - Online Food Delivery</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>

<body>

<nav class="nav">

    <div class="container nav-inner">

        <a class="brand" href="<%=request.getContextPath()%>/index.jsp">
            <span class="logo">🍴</span>
            Forkly
        </a>

        <%
            String userName =
                    (String) session.getAttribute("userName");
        %>

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
            <!-- ==============================
     DARK MODE TOGGLE
     ============================== -->

            <button class="theme-toggle-btn"
                    id="themeToggleBtn"
                    type="button">

                🌙

            </button>

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

<main class="container hero">

    <section>

        <span class="eyebrow">
            <span class="dot"></span>
            30-minute delivery in your area
        </span>

        <h1>
            Crave it.
            <span class="accent">Tap it.</span>
            Eat it.
        </h1>

        <p class="lead">
            Forkly helps customers register, browse menu items, place orders,
            complete payments, track deliveries, receive notifications,
            and submit reviews using one clean Java web system.
        </p>

        <div class="hero-actions">

            <% if(userName != null){ %>

            <a class="btn btn-primary"
               href="<%=request.getContextPath()%>/client/menu.jsp">

                Browse Menu →

            </a>

            <% } else { %>

            <a class="btn btn-primary"
               href="<%=request.getContextPath()%>/client/login.jsp">

                Login to Explore →

            </a>

            <% } %>


        </div>



    </section>

    <section class="food-showcase">

        <img src="<%=request.getContextPath()%>/assets/imageshero/hero-food.jpg"
             alt="Forkly food showcase"
             class="hero-food-image">

    </section>
</main>

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

    MenuService homeMenuService =
            new MenuService();

    List<MenuItem> featuredMenuItems =
            homeMenuService.getAllMenuItems();

    int featuredLimit =
            Math.min(4, featuredMenuItems.size());
%>

<section class="container section modern-home-dashboard">

    <div class="dashboard-stats-grid">

        <div class="dashboard-stat-card">

            <div class="dashboard-stat-icon users-icon">

                👥

            </div>

            <div class="dashboard-stat-plus">

                +

            </div>
            <h2 class="counter-number"
                data-target="<%= totalUsers %>">

                +0

            </h2>
            <p>

                Total Users

            </p>

        </div>

        <div class="dashboard-stat-card">

            <div class="dashboard-stat-icon menu-icon">

                🍔

            </div>

            <div class="dashboard-stat-plus">

                +

            </div>

            <h2 class="counter-number"
                data-target="<%= totalMenuItems %>">

                +0

            </h2>
            <p>

                Menu Items

            </p>

        </div>

        <div class="dashboard-stat-card">

            <div class="dashboard-stat-icon order-icon">

                🛒

            </div>

            <div class="dashboard-stat-plus">

                +

            </div>

            <h2 class="counter-number"
                data-target="<%= totalOrders %>">

                +0

            </h2>

            <p>

                Total Orders

            </p>

        </div>

        <div class="dashboard-stat-card">

            <div class="dashboard-stat-icon delivery-icon">

                🚚

            </div>

            <div class="dashboard-stat-plus">

                +

            </div>

            <h2 class="counter-number"
                data-target="<%= activeDeliveries %>">

                +0

            </h2>
            <p>

                Active Deliveries

            </p>

        </div>

    </div>

</section>

<section class="container section home-featured-menu-section">

    <div class="featured-menu-header">

        <div class="featured-menu-header-left">

            <span class="eyebrow">
                🍽️ Popular Menu
            </span>

            <h2>
                Explore Popular Meals
            </h2>

            <p>
                Discover customer favorite meals prepared fresh by Forkly.
                Fast delivery, premium ingredients, and unforgettable taste.
            </p>

        </div>

        <a class="featured-menu-btn"
           href="<%=request.getContextPath()%>/client/menu.jsp">

            See Full Menu →

        </a>

    </div>

    <% if(featuredMenuItems == null || featuredMenuItems.isEmpty()){ %>

    <div class="card">

        <h3>
            No menu items yet
        </h3>

        <p class="muted">
            Menu items will appear here after admin adds them.
        </p>

    </div>

    <% } else { %>

    <div class="featured-menu-grid">

        <%
            for(int i = 0; i < featuredLimit; i++){

                MenuItem item =
                        featuredMenuItems.get(i);
        %>

        <div class="featured-food-card">

            <div class="featured-food-image-wrap">

                <img src="<%=request.getContextPath()%>/assets/images/menu/<%= item.getImage() %>"
                     alt="<%= item.getName() %>"
                     class="featured-food-image">

                <span class="featured-food-category">

                    <%= item.getCategory() %>

                </span>

            </div>

            <div class="featured-food-body">

                <h3 class="featured-food-title">

                    <%= item.getName() %>

                </h3>

                <p class="featured-food-description">

                    <%= item.getDescription() %>

                </p>

                <div class="featured-food-bottom">

                    <span class="featured-food-price">

                        Rs. <%= String.format("%.2f", item.getPrice()) %>

                    </span>

                    <span class="featured-food-rating">

                        ⭐ 4.8

                    </span>

                </div>

            </div>

        </div>

        <% } %>

    </div>

    <% } %>

</section>

<%
    ReviewService homeReviewService =
            new ReviewService();

    List<Review> homeReviews =
            homeReviewService.getAllReviews();
%>

<section class="container section home-review-section">

    <div class="review-home-header">

        <div>

            <span class="eyebrow">
                ⭐ Customer Reviews
            </span>

            <h2 class="section-title">

                What Customers Say About Forkly

            </h2>

            <p class="muted">

                Real reviews from our food delivery customers.

            </p>

        </div>

        <a class="btn btn-light"
           href="<%=request.getContextPath()%>/client/reviews.jsp">

            View All Reviews →

        </a>

    </div>

    <% if(homeReviews == null || homeReviews.isEmpty()){ %>

    <div class="card">

        <h3>

            No reviews yet

        </h3>

        <p class="muted">

            Customer reviews will appear here.

        </p>

    </div>

    <% } else { %>

    <div class="home-review-grid">

        <%
            int limit =
                    Math.min(homeReviews.size(), 3);

            for(int i = 0; i < limit; i++){

                Review r =
                        homeReviews.get(i);
        %>

        <div class="home-review-card">

            <div class="home-review-top">

                <div class="review-user-avatar">

                    <%= r.getCustomerName() != null
                            && r.getCustomerName().length() > 0
                            ? r.getCustomerName().substring(0,1).toUpperCase()
                            : "U" %>

                </div>

                <div>

                    <h3>

                        <%= r.getCustomerName() %>

                    </h3>

                    <p class="muted">

                        <%= r.getReviewDate() %>

                    </p>

                </div>

            </div>

            <div class="public-review-stars">

                <%= r.getRatingStars() %>

            </div>

            <p class="home-review-comment">

                “<%= r.getComment() %>”

            </p>

        </div>

        <% } %>

    </div>

    <% } %>

</section>


<script src="<%=request.getContextPath()%>/assets/js/main.js?v=100"></script>

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