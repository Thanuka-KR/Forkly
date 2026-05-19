login.jsp




<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>

    <title>Forkly Driver Login</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<!-- ==============================
     DRIVER LOGIN PAGE
     ============================== -->
<div class="driver-login-wrapper">

    <div class="driver-login-card">

        <!-- LOGO -->
        <div class="driver-login-logo">

            🚚

        </div>

        <!-- TITLE -->
        <h1>

            Driver Login

        </h1>

        <p class="muted">

            Login to manage customer deliveries.

        </p>

        <!-- ERROR MESSAGE -->
        <%
            String error =
                    request.getParameter("error");

            if (error != null) {
        %>

        <div class="driver-error-box">

            Invalid email or password.

        </div>

        <% } %>

        <!-- ==============================
             LOGIN FORM
             ============================== -->
        <form method="post"
              action="<%=request.getContextPath()%>/driver-login">

            <!-- EMAIL -->
            <div class="form-group">

                <label>

                    Driver Email

                </label>

                <input type="email"
                       name="email"
                       placeholder="Enter driver email"
                       required>

            </div>

            <!-- PASSWORD -->
            <div class="form-group">

                <label>

                    Password

                </label>

                <input type="password"
                       name="password"
                       placeholder="Enter password"
                       required>

            </div>

            <!-- LOGIN BUTTON -->
            <button class="btn btn-primary driver-login-btn"
                    type="submit">

                Login as Driver

            </button>

        </form>

        <!-- DEMO LOGIN -->
        <div class="driver-demo-box">

            <h3>

                Demo Driver Login

            </h3>

            <p>

                Email:
                <strong>driver@forkly.com</strong>

            </p>

            <p>

                Password:
                <strong>driver123</strong>

            </p>

        </div>

    </div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

</body>

</html>
