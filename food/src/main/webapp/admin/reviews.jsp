<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.ReviewService" %>
<%@ page import="model.Review" %>
<%@ page import="java.util.List" %>

<%
    ReviewService reviewService = new ReviewService();
    List<Review> reviews = reviewService.getAllReviews();
%>

<!DOCTYPE html>

<html>

<head>
    <title>Admin Reviews</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">
</head>

<body>

<div class="admin-shell">

    <aside class="sidebar">

        <a class="brand" href="<%=request.getContextPath()%>/index.jsp">
            <span class="logo">🍴</span> Forkly
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

        <div class="admin-page-head">

            <div>
                <h1 class="page-title">Review Management</h1>

                <p class="page-subtitle">
                    Manage customer feedback and food delivery reviews.
                </p>
            </div>

            <span class="notification-count">
                <%= reviews.size() %> Reviews
            </span>

        </div>

        <% if(request.getParameter("deleted") != null){ %>

        <div class="alert alert-success">
            Review deleted successfully.
        </div>

        <% } %>

        <% if(reviews == null || reviews.isEmpty()){ %>

        <div class="empty-notification-card">

            <h2>No reviews yet ⭐</h2>

            <p>
                Customer reviews will appear here after users submit feedback.
            </p>

        </div>

        <% } else { %>

        <div class="admin-review-grid">

            <% for(Review r : reviews){ %>

            <div class="admin-review-card">

                <div class="admin-review-top">

                    <div>

                        <h3>
                            <%= r.getCustomerName() %>
                        </h3>

                        <p class="muted">
                            Review ID: <%= r.getReviewId() %>
                        </p>

                    </div>

                    <span class="review-rating-badge">
                        <%= r.getRatingStars() %>
                    </span>

                </div>

                <div class="admin-review-meta">

                    <span>
                        Type: <strong><%= r.getReviewType() %></strong>
                    </span>

                    <span>
                        Item/Order: <strong><%= r.getItemId() %></strong>
                    </span>

                    <span>
                        Date: <strong><%= r.getReviewDate() %></strong>
                    </span>

                </div>

                <p class="admin-review-comment">
                    “<%= r.getComment() %>”
                </p>

                <form method="post"
                      action="<%=request.getContextPath()%>/review">

                    <input type="hidden"
                           name="action"
                           value="delete">

                    <input type="hidden"
                           name="reviewId"
                           value="<%= r.getReviewId() %>">

                    <button class="delete-menu-btn"
                            type="submit">

                        Delete Review

                    </button>

                </form>

            </div>

            <% } %>

        </div>

        <% } %>

    </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

</body>

</html>