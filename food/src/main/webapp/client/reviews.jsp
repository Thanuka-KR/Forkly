<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.ReviewService" %>
<%@ page import="service.NotificationService" %>
<%@ page import="service.OrderService" %>
<%@ page import="model.Review" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedHashSet" %>

<%
    ReviewService reviewService = new ReviewService();
    List<Review> reviews = reviewService.getAllReviews();

    String userName =
            (String) session.getAttribute("userName");

    String userId =
            (String) session.getAttribute("userId");

    String profileAvatar =
            (String) session.getAttribute("profileAvatar");

    if(profileAvatar == null){
        profileAvatar = "👤";
    }

    OrderService orderService =
            new OrderService();

    List<Order> userOrders =
            new java.util.ArrayList<>();

    LinkedHashSet<String> orderedItems =
            new LinkedHashSet<>();

    if(userId != null){

        userOrders =
                orderService.getOrdersByCustomer(userId);

        for(Order order : userOrders){

            for(OrderItem item : order.getItems()){

                orderedItems.add(
                        item.getItemName()
                );
            }
        }
    }
%>

<!DOCTYPE html>

<html>

<head>
    <title>Forkly Reviews</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">
</head>

<body>

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

                if(navUserId == null){
                    navUserId = "GUEST";
                }

                NotificationService notificationService =
                        new NotificationService();

                int unreadCount =
                        notificationService.getUnreadCount(navUserId);
            %>

            <% if(userName != null){ %>

            <a class="notification-nav-btn"
               href="<%=request.getContextPath()%>/client/notifications.jsp">

                🔔 Notifications

                <% if(unreadCount > 0){ %>

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

            <a href="<%=request.getContextPath()%>/client/reviews.jsp">

                Reviews

            </a>

        </div>

        <div class="nav-actions">

            <% if(userName == null){ %>

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

<main class="container section">

    <div class="review-page-header">

        <div>

            <span class="eyebrow">
                ⭐ Customer Feedback
            </span>

            <h1 class="page-title">
                Forkly Reviews
            </h1>

            <p class="page-subtitle">
                Read real customer experiences and share your own feedback.
            </p>

        </div>

        <span class="notification-count">
            <%= reviews.size() %> Reviews
        </span>

    </div>

    <% if(request.getParameter("success") != null){ %>

    <div class="alert alert-success">
        Thank you! Your review has been submitted successfully.
    </div>

    <% } %>

    <div class="review-layout">

        <section class="review-feed">

            <% if(reviews == null || reviews.isEmpty()){ %>

            <div class="empty-notification-card">

                <h2>No reviews yet ⭐</h2>

                <p>
                    Be the first customer to share your experience.
                </p>

            </div>

            <% } else { %>

            <% for(Review r : reviews){ %>

            <div class="public-review-card">

                <div class="public-review-top">

                    <div class="review-user-avatar">
                        <%= r.getCustomerName() != null && r.getCustomerName().length() > 0
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

                <p class="public-review-comment">
                    “<%= r.getComment() %>”
                </p>

                <div class="public-review-meta">

                    <span>
                        <%= r.getReviewType() %>
                    </span>

                    <span>
                        Ref: <%= r.getItemId() %>
                    </span>

                </div>

            </div>

            <% } %>

            <% } %>

        </section>

        <aside class="review-submit-card">

            <% if(userName != null){ %>

            <h2>
                Write a Review
            </h2>

            <p class="muted">
                Help other customers by sharing your Forkly experience.
            </p>

            <form method="post"
                  action="<%=request.getContextPath()%>/review">

                <input type="hidden"
                       name="action"
                       value="add">

                <div class="form-group">

                    <label>Select Ordered Item</label>

                    <% if(!orderedItems.isEmpty()){ %>

                    <select name="itemId"
                            class="modern-review-select"
                            required>

                        <option value="">
                            Choose your recently ordered item
                        </option>

                        <% for(String orderedItem : orderedItems){ %>

                        <option value="<%= orderedItem %>">
                            🍽️ <%= orderedItem %>
                        </option>

                        <% } %>

                    </select>

                    <% } else { %>

                    <input type="text"
                           name="itemId"
                           placeholder="No previous order found. Enter item or order ID"
                           required>

                    <% } %>

                </div>

                <div class="form-group">

                    <label>Review Type</label>

                    <select name="reviewType"
                            required>

                        <option value="FOOD">Food</option>
                        <option value="DELIVERY">Delivery</option>
                        <option value="SERVICE">Service</option>
                        <option value="GENERAL">General</option>

                    </select>

                </div>

                <div class="form-group">

                    <label>Rating</label>

                    <select name="rating"
                            required>

                        <option value="5">★★★★★ Excellent</option>
                        <option value="4">★★★★☆ Very Good</option>
                        <option value="3">★★★☆☆ Good</option>
                        <option value="2">★★☆☆☆ Fair</option>
                        <option value="1">★☆☆☆☆ Poor</option>

                    </select>

                </div>

                <div class="form-group">

                    <label>Comment</label>

                    <textarea name="comment"
                              placeholder="Write your review..."
                              required></textarea>

                </div>

                <button class="btn btn-primary review-submit-btn"
                        type="submit">

                    Submit Review

                </button>

            </form>

            <% } else { %>

            <h2>
                Want to write a review?
            </h2>

            <p class="muted">
                Login first to share your experience with Forkly.
            </p>

            <a class="btn btn-primary"
               href="<%=request.getContextPath()%>/client/login.jsp">

                Login to Review

            </a>

            <% } %>

        </aside>

    </div>

</main>

<script src="<%=request.getContextPath()%>/assets/js/main.js?v=60"></script>

<script>

    function toggleProfileMenu() {

        const menu =
            document.getElementById("profileMenu");

        if(menu){

            menu.classList.toggle("show-profile-menu");
        }
    }

    window.addEventListener("click", function(e){

        if(!e.target.closest(".profile-dropdown")){

            const menu =
                document.getElementById("profileMenu");

            if(menu){

                menu.classList.remove("show-profile-menu");
            }
        }
    });

</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>

</html>