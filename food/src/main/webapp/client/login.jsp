<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>
    <title>Forkly Login</title>

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

        <div class="nav-links">

            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>

            <a href="<%=request.getContextPath()%>/client/login.jsp">Menu 🔒</a>

            <a href="<%=request.getContextPath()%>/client/login.jsp">Cart 🔒</a>

            <a href="<%=request.getContextPath()%>/client/login.jsp">Orders 🔒</a>

            <a href="<%=request.getContextPath()%>/client/login.jsp">Notifications 🔒</a>

        </div>

        <div class="nav-actions">

            <a class="btn btn-light"
               href="<%=request.getContextPath()%>/client/login.jsp">
                Login
            </a>

            <a class="btn btn-primary"
               href="<%=request.getContextPath()%>/client/register.jsp">
                Register
            </a>

        </div>

    </div>

</nav>

<main class="container">

    <form class="form-card"
          method="post"
          action="<%=request.getContextPath()%>/login">

        <h1 class="page-title">Login</h1>

        <p class="page-subtitle">
            Access your Forkly customer or admin account.
        </p>

        <% if(request.getParameter("loginRequired") != null){ %>
        <div class="alert alert-error">
            Please login first to continue.
        </div>
        <% } %>

        <% if(request.getParameter("adminRequired") != null){ %>
        <div class="alert alert-error">
            Admin access required. Please login as an admin.
        </div>
        <% } %>

        <% if(request.getParameter("sessionExpired") != null){ %>
        <div class="alert alert-error">
            Your session expired. Please login again.
        </div>
        <% } %>

        <% if(request.getParameter("success") != null){ %>
        <div class="alert alert-success">
            Registration successful. Please login.
        </div>
        <% } %>

        <% if(request.getParameter("error") != null){ %>
        <div class="alert alert-error">
            Invalid email or password.
        </div>
        <% } %>

        <% if(request.getParameter("logout") != null){ %>
        <div class="alert alert-success">
            You have logged out successfully.
        </div>
        <% } %>

        <div class="form-group">

            <label>Email Address</label>

            <input type="email"
                   name="email"
                   placeholder="admin@forkly.com"
                   required>

        </div>

        <div class="form-group">

            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Enter password"
                   required>

        </div>

        <button class="btn btn-primary"
                type="submit">
            Login
        </button>

        <a class="btn btn-light"
           href="<%=request.getContextPath()%>/client/register.jsp">
            Create Account
        </a>

    </form>

</main>

<footer class="footer">

    <div class="container">
        Forkly © 2026 | Online Food Delivery Management System
    </div>

</footer>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>

</html>