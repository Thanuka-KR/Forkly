<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>

    <!-- ==============================
         SECTION 1: PAGE SETTINGS
         ============================== -->
    <title>Forkly Register</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>


<!-- ==============================
     SECTION 1: NAVIGATION BAR
     ============================== -->
<nav class="nav">

    <div class="container nav-inner">

        <a class="brand" href="<%=request.getContextPath()%>/index.jsp">

            <span class="logo">🍴</span>

            Forkly

        </a>

        <div class="nav-links">

            <a href="<%=request.getContextPath()%>/index.jsp">Home</a>

            <a href="<%=request.getContextPath()%>/client/menu.jsp">Menu</a>

            <a href="<%=request.getContextPath()%>/client/cart.jsp">Cart 🛒</a>

            <a href="<%=request.getContextPath()%>/client/order-history.jsp">Orders</a>



            <a href="<%=request.getContextPath()%>/client/notifications.jsp">Notifications</a>

        </div>

        <div class="nav-actions">

            <a class="btn btn-light" href="<%=request.getContextPath()%>/client/login.jsp">Login</a>

            <a class="btn btn-primary" href="<%=request.getContextPath()%>/client/register.jsp">Register</a>

        </div>

    </div>

</nav>


<main class="container">

    <form class="form-card" method="post" action="<%=request.getContextPath()%>/register">

        <h1 class="page-title">Create Account</h1>

        <p class="page-subtitle">Register as a customer and start ordering food.</p>

        <% if(request.getParameter("error") != null){ %>

        <div class="alert alert-error">Registration failed. Email may already exist.</div>

        <% } %>

        <input type="hidden" name="role" value="CUSTOMER">

        <div class="form-group">

            <label>Full Name</label>

            <input type="text" name="name" placeholder="Enter full name" required>

        </div>

        <div class="form-group">

            <label>Email</label>

            <input type="email" name="email" placeholder="Enter email" required>

        </div>

        <div class="form-group">

            <label>Password</label>

            <input type="password" name="password" placeholder="Create password" required>

        </div>

        <div class="form-group">

            <label>Phone</label>

            <input type="text" name="phone" placeholder="Enter phone number" required>

        </div>

        <div class="form-group">

            <label>Address</label>

            <textarea name="address" placeholder="Enter delivery address" required></textarea>

        </div>

        <button class="btn btn-primary" type="submit">Register</button>

        <a class="btn btn-light" href="<%=request.getContextPath()%>/client/login.jsp">Already have account?</a>

    </form>

</main>



<!-- ==============================
     SECTION 99: FOOTER
     ============================== -->
<footer class="footer">

    <div class="container">

        Forkly © 2026 | Online Food Delivery Management System

    </div>

</footer>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>

</html>
