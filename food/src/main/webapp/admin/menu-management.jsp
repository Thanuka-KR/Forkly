<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.MenuService" %>
<%@ page import="model.MenuItem" %>
<%@ page import="java.util.List" %>

<%
    MenuService menuService = new MenuService();
    List<MenuItem> menuItems = menuService.getAllMenuItems();
%>

<!DOCTYPE html>

<html>

<head>

    <title>Admin Menu</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

</head>

<body>

<div class="admin-shell">

    <aside class="sidebar">

        <a class="brand"
           href="<%=request.getContextPath()%>/index.jsp">

            <span class="logo">🍴</span>

            Forkly

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

                <h1 class="page-title">Menu Management</h1>

                <p class="page-subtitle">
                    Add food items with images and manage customer menu cards.
                </p>

            </div>

            <span class="notification-count"
                  id="adminMenuItemCount">

                <%= menuItems.size() %> Items

            </span>

        </div>

        <% if (request.getParameter("success") != null) { %>

        <div class="alert alert-success">
            Menu item added successfully.
        </div>

        <% } %>

        <% if (request.getParameter("deleted") != null) { %>

        <div class="alert alert-success">
            Menu item deleted successfully.
        </div>

        <% } %>

        <% if (request.getParameter("priceUpdated") != null) { %>

        <div class="alert alert-success">
            Menu item price updated successfully.
        </div>

        <% } %>

        <!-- ADD MENU ITEM -->
        <div class="admin-menu-form-card">

            <div class="menu-form-title">

                <div>

                    <h2>Add Menu Item</h2>

                    <p>
                        Use image file name from
                        <strong>assets/images/menu</strong>
                    </p>

                </div>

                <div class="menu-form-icon">
                    🍽️
                </div>

            </div>

            <form class="admin-menu-form"
                  method="post"
                  action="<%=request.getContextPath()%>/menu">

                <input type="hidden"
                       name="action"
                       value="add">

                <div class="form-group">

                    <label>Item Name</label>

                    <input name="name"
                           placeholder="Chicken Burger"
                           required>

                </div>

                <div class="form-group">

                    <label>Price</label>

                    <input name="price"
                           type="number"
                           step="0.01"
                           placeholder="1200.00"
                           required>

                </div>

                <div class="form-group">

                    <label>Category</label>

                    <select name="category"
                            id="categorySelect"
                            onchange="updateItemTypeByCategory()"
                            required>

                        <option value="Food">Food</option>

                        <option value="Drink">Drink</option>

                        <option value="Cake">Cake</option>

                        <option value="Dessert">Dessert</option>

                        <option value="Shorteat">Shorteat</option>

                    </select>

                </div>

                <!-- Hidden itemType for Java OOP class selection -->
                <input type="hidden"
                       name="itemType"
                       id="itemTypeInput"
                       value="FOOD">

                <div class="form-group">

                    <label>Image File Name</label>

                    <input name="image"
                           placeholder="burger.jpg"
                           required>

                </div>

                <div class="form-group form-wide">

                    <label>Description</label>

                    <textarea name="description"
                              placeholder="Short menu description for customer..."
                              required></textarea>

                </div>

                <button class="btn btn-primary menu-save-btn"
                        type="submit">

                    Save Item

                </button>

            </form>

        </div>

        <!-- ADMIN SEARCH BAR -->
        <div class="modern-menu-search-wrap admin-search-space">

            <div class="modern-menu-search">

                <span class="search-icon">🔍</span>

                <input type="text"
                       id="adminMenuSearchInput"
                       placeholder="Search menu items to delete...">

            </div>

        </div>

        <!-- MENU ITEMS -->
        <div class="admin-menu-grid"
             id="adminMenuGrid">

            <% for (MenuItem m : menuItems) { %>

            <div class="admin-menu-card"
                 data-search="<%= m.getName().toLowerCase() %>
                 <%= m.getCategory().toLowerCase() %>
                 <%= m.getDescription().toLowerCase() %>
                 <%= m.getPrice() %>">

                <div class="admin-menu-image-wrap">

                    <img src="<%=request.getContextPath()%>/assets/images/menu/<%= m.getImage() %>"
                         alt="<%= m.getName() %>"
                         class="admin-menu-image">

                </div>

                <div class="admin-menu-card-body">

                    <div class="admin-menu-card-top">

                        <span class="badge">
                            <%= m.getCategory() %>
                        </span>

                        <span class="menu-available-badge">

                            <%= m.isAvailable()
                                    ? "Available"
                                    : "Unavailable" %>

                        </span>

                    </div>

                    <h3>
                        <%= m.getName() %>
                    </h3>

                    <p class="muted">
                        <%= m.getDescription() %>
                    </p>

                    <p class="price">
                        Rs. <%= String.format("%.2f", m.getPrice()) %>
                    </p>

                    <!-- UPDATE PRICE -->
                    <form method="post"
                          action="<%=request.getContextPath()%>/menu"
                          class="update-price-form">

                        <input type="hidden"
                               name="action"
                               value="updatePrice">

                        <input type="hidden"
                               name="itemId"
                               value="<%= m.getItemId() %>">

                        <input type="number"
                               step="0.01"
                               name="price"
                               placeholder="New price"
                               required
                               class="update-price-input">

                        <button type="submit"
                                class="update-price-btn">

                            Update Price

                        </button>

                    </form>

                    <!-- DELETE ITEM -->
                    <form method="post"
                          action="<%=request.getContextPath()%>/menu">

                        <input type="hidden"
                               name="action"
                               value="delete">

                        <input type="hidden"
                               name="itemId"
                               value="<%= m.getItemId() %>">

                        <button class="delete-menu-btn"
                                type="submit">

                            Delete Item

                        </button>

                    </form>

                </div>

            </div>

            <% } %>

            <% if (menuItems.isEmpty()) { %>

            <div class="card">

                <h3>No menu items found</h3>

                <p class="muted">
                    Add your first menu item using the form above.
                </p>

            </div>

            <% } %>

        </div>

        <div class="menu-empty-search"
             id="adminMenuEmptySearch"
             style="display:none;">

            <h3>No matching menu items 🍔</h3>

            <p>
                Try another keyword or category.
            </p>

        </div>

    </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/main.js?v=50"></script>

<script>

    function updateItemTypeByCategory() {

        const category =
            document.getElementById("categorySelect").value;

        const itemTypeInput =
            document.getElementById("itemTypeInput");

        if (category === "Drink") {

            itemTypeInput.value = "DRINK";

        } else {

            itemTypeInput.value = "FOOD";
        }
    }

</script>

</body>

</html>