<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.UserService" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>

<%
    UserService userService = new UserService();

    List<User> users = userService.getAllUsers();
%>

<!DOCTYPE html>

<html>
<head>

    <title>Admin Users</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css?v=20">

    <style>

        body{
            margin:0 !important;
            overflow-x:hidden !important;
        }

        .admin-shell{
            display:block !important;
            min-height:100vh !important;
        }

        .sidebar{
            position:fixed !important;
            top:0 !important;
            left:0 !important;
            width:260px !important;
            height:100vh !important;
            overflow-y:auto !important;
            background:#15110d !important;
            color:white !important;
            padding:24px !important;
            z-index:99999 !important;
        }

        .admin-main{
            margin-left:260px !important;
            width:calc(100% - 260px) !important;
            min-height:100vh !important;
            padding:34px !important;
        }

        .user-filter-bar{
            display:flex;
            gap:12px;
            flex-wrap:wrap;
            margin:0 0 24px 0;
        }

        .user-filter-btn{
            border:none;
            background:#ffffff;
            color:#15110d;
            padding:12px 22px;
            border-radius:999px;
            font-weight:800;
            cursor:pointer;
            box-shadow:0 4px 14px rgba(0,0,0,0.06);
        }

        .user-filter-btn:hover,
        .active-user-filter{
            background:#ff7a00;
            color:#ffffff;
        }

    </style>

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
                <h1 class="page-title">User Management</h1>
                <p class="page-subtitle">
                    Manage customers, drivers, and admin accounts.
                </p>
            </div>

            <span class="notification-count">
                <%= users.size() %> Users
            </span>

        </div>

        <% if (request.getParameter("success") != null) { %>

        <div class="alert alert-success">
            User added successfully.
        </div>

        <% } %>

        <% if (request.getParameter("error") != null) { %>

        <div class="alert alert-error">
            Email already exists.
        </div>

        <% } %>

        <% if (request.getParameter("deleted") != null) { %>

        <div class="alert alert-success">
            User deleted successfully.
        </div>

        <% } %>

        <div class="admin-user-form-card">

            <h2>Add New User</h2>

            <form class="admin-user-form"
                  method="post"
                  action="<%=request.getContextPath()%>/admin-user">

                <input type="hidden"
                       name="action"
                       value="add">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text"
                           name="name"
                           placeholder="Enter full name"
                           required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email"
                           name="email"
                           placeholder="example@forkly.com"
                           required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password"
                           name="password"
                           placeholder="Create password"
                           required>
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text"
                           name="phone"
                           placeholder="Phone number"
                           required>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text"
                           name="address"
                           placeholder="Address"
                           required>
                </div>

                <div class="form-group">
                    <label>Role</label>
                    <select name="role" required>
                        <option value="CUSTOMER">Customer</option>
                        <option value="DRIVER">Driver</option>
                        <option value="ADMIN">Admin</option>
                    </select>
                </div>

                <button class="btn btn-primary"
                        type="submit">
                    Add User
                </button>

            </form>

        </div>

        <div class="user-filter-bar">

            <button class="user-filter-btn active-user-filter"
                    onclick="filterUsers('ALL', this)">
                All Users
            </button>

            <button class="user-filter-btn"
                    onclick="filterUsers('CUSTOMER', this)">
                Customers
            </button>

            <button class="user-filter-btn"
                    onclick="filterUsers('DRIVER', this)">
                Drivers
            </button>

            <button class="user-filter-btn"
                    onclick="filterUsers('ADMIN', this)">
                Admins
            </button>

        </div>

        <div class="table-wrap">

            <table>

                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>

                <% for (User u : users) { %>

                <tr class="user-row"
                    data-role="<%= u.getRole() == null ? "" : u.getRole().trim().toUpperCase() %>">

                    <td><%= u.getUserId() %></td>

                    <td><%= u.getName() %></td>

                    <td><%= u.getEmail() %></td>

                    <td><%= u.getPhone() %></td>

                    <td><%= u.getAddress() %></td>

                    <td>
                        <span class="user-role-badge role-<%= u.getRole().toLowerCase() %>">
                            <%= u.getRole() %>
                        </span>
                    </td>

                    <td>

                        <form method="post"
                              action="<%=request.getContextPath()%>/admin-user">

                            <input type="hidden"
                                   name="action"
                                   value="delete">

                            <input type="hidden"
                                   name="userId"
                                   value="<%= u.getUserId() %>">

                            <button class="delete-notification-btn"
                                    type="submit">
                                Delete
                            </button>

                        </form>

                    </td>

                </tr>

                <% } %>

            </table>

        </div>

    </main>

</div>

<script>

    function filterUsers(role, button) {

        const rows =
            document.querySelectorAll(".user-row");

        rows.forEach(function(row) {

            const rowRole =
                row.getAttribute("data-role");

            if (role === "ALL" || rowRole === role) {

                row.style.display = "";

            } else {

                row.style.display = "none";
            }
        });

        document.querySelectorAll(".user-filter-btn")
            .forEach(function(btn) {

                btn.classList.remove("active-user-filter");
            });

        button.classList.add("active-user-filter");
    }

</script>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

</body>

</html>