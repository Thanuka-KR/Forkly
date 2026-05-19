<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>

<%
    User user =
            (User) session.getAttribute("loggedInUser");

    if(user == null){

        response.sendRedirect(request.getContextPath()
                + "/client/login.jsp?loginRequired=1");

        return;
    }

    String avatar =
            (String) session.getAttribute("profileAvatar");

    if(avatar == null){

        avatar = "👤";
    }
%>

<!DOCTYPE html>

<html>

<head>

    <title>My Profile</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<!-- ==============================
     NAVBAR
     ============================== -->
<nav class="nav">

    <div class="container nav-inner">

        <a class="brand"
           href="<%=request.getContextPath()%>/index.jsp">

            <span class="logo">🍴</span>

            Forkly

        </a>

        <div class="nav-links">

            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>

            <a href="<%=request.getContextPath()%>/client/menu.jsp">Menu</a>

            <a href="<%=request.getContextPath()%>/client/cart.jsp">Cart</a>

            <a href="<%=request.getContextPath()%>/client/order-history.jsp">Orders</a>

        </div>

        <div class="nav-actions">

            <div class="profile-dropdown">

                <button class="profile-btn"
                        onclick="toggleProfileMenu()">

                    <span class="profile-avatar">

                        <%= avatar %>

                    </span>

                </button>

                <div class="profile-menu"
                     id="profileMenu">

                    <div class="profile-menu-header">

                        <strong>

                            <%= user.getName() %>

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

        </div>

    </div>

</nav>

<!-- ==============================
     PROFILE PAGE
     ============================== -->
<main class="container section">

    <div class="profile-page-wrapper">

        <!-- LEFT SIDE -->
        <div class="profile-card-modern">

            <div class="big-profile-avatar">

                <%= avatar %>

            </div>

            <h2>

                <%= user.getName() %>

            </h2>

            <p>

                <%= user.getEmail() %>

            </p>

            <span class="profile-role-badge">

                <%= user.getRole() %>

            </span>

        </div>

        <!-- RIGHT SIDE -->
        <div class="profile-form-card">

            <h1 class="page-title">

                Update Profile

            </h1>

            <p class="page-subtitle">

                Manage your Forkly account information.

            </p>

            <% if(request.getParameter("success") != null){ %>

            <div class="alert alert-success">

                Profile updated successfully.

            </div>

            <% } %>

            <form method="post"
                  action="<%=request.getContextPath()%>/profile">

                <div class="form-group">

                    <label>Full Name</label>

                    <input type="text"
                           name="name"
                           value="<%= user.getName() %>"
                           required>

                </div>

                <div class="form-group">

                    <label>Email Address</label>

                    <input type="email"
                           value="<%= user.getEmail() %>"
                           disabled>

                </div>

                <div class="form-group">

                    <label>Phone Number</label>

                    <input type="text"
                           name="phone"
                           value="<%= user.getPhone() %>"
                           required>

                </div>

                <div class="form-group">

                    <label>Address</label>

                    <textarea name="address"
                              rows="4"
                              required><%= user.getAddress() %></textarea>

                </div>

                <div class="form-group">

                    <label>New Password</label>

                    <input type="password"
                           name="password"
                           placeholder="Leave empty if no change">

                </div>

                <button class="btn btn-primary"
                        type="submit">

                    Save Changes

                </button>

            </form>

        </div>

    </div>

</main>

<!-- ==============================
     FOOTER
     ============================== -->
<footer class="footer">

    <div class="container">

        Forkly © 2026 | Online Food Delivery System

    </div>

</footer>

<script>

    function toggleProfileMenu() {

        const menu =
            document.getElementById("profileMenu");

        menu.classList.toggle("show-profile-menu");
    }

    window.addEventListener("click", function (e) {

        if (!e.target.closest(".profile-dropdown")) {

            const menu =
                document.getElementById("profileMenu");

            if(menu){

                menu.classList.remove("show-profile-menu");
            }
        }
    });

</script>

</body>

</html>