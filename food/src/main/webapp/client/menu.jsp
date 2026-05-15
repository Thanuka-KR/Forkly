<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.MenuService" %>
<%@ page import="service.NotificationService" %>
<%@ page import="model.MenuItem" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>

<head>
    <title>Forkly Menu</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">
</head>

<body>

<%
    String userName =
            (String) session.getAttribute("userName");
%>

<nav class="nav">

    <div class="container nav-inner">

        <a class="brand"
           href="<%=request.getContextPath()%>/index.jsp">

            <span class="logo">🍴</span>

            Forkly

        </a>

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

<%
    MenuService menuService =
            new MenuService();

    List<MenuItem> items =
            menuService.getAvailableItems();
%>

<main class="container section">

    <div class="menu-page-header">

        <div>

            <h1 class="page-title">

                Explore Delicious Meals

            </h1>

            <p class="page-subtitle">

                Fresh food, premium taste,
                and fast delivery from Forkly.

            </p>

        </div>

        <div class="modern-menu-search-wrap">

            <div class="modern-menu-search">

                <span class="search-icon">

                    🔍

                </span>

                <input type="text"
                       id="menuSearchInput"
                       placeholder="Search pizza, burgers, drinks...">

            </div>

        </div>

        <span class="notification-count"
              id="menuItemCount">

            <%= items.size() %> Items

        </span>

    </div>

    <div class="menu-category-filter">

        <button type="button"
                class="category-btn active-category"
                onclick="filterMenuByCategory('All', event)">

            All

        </button>

        <button type="button"
                class="category-btn"
                onclick="filterMenuByCategory('Cake', event)">

            Cake

        </button>

        <button type="button"
                class="category-btn"
                onclick="filterMenuByCategory('Dessert', event)">

            Dessert

        </button>

        <button type="button"
                class="category-btn"
                onclick="filterMenuByCategory('Food', event)">

            Food

        </button>

        <button type="button"
                class="category-btn"
                onclick="filterMenuByCategory('Drink', event)">

            Drink

        </button>

        <button type="button"
                class="category-btn"
                onclick="filterMenuByCategory('Shorteat', event)">

            Shorteat

        </button>

    </div>

    <div class="modern-food-grid"
         id="menuItemsGrid">

        <% for(MenuItem item : items){ %>

        <div class="modern-food-card"
             id="item-<%= item.getItemId() %>"
             data-category="<%= item.getCategory() %>"
             data-search="<%= item.getName().toLowerCase() %> <%= item.getCategory().toLowerCase() %> <%= item.getDescription().toLowerCase() %> <%= item.getPrice() %>">

            <div class="modern-food-image-wrap">

                <img src="<%=request.getContextPath()%>/assets/images/menu/<%= item.getImage() %>"
                     alt="<%= item.getName() %>"
                     class="modern-food-image">

                <span class="modern-food-category">

                    <%= item.getCategory() %>

                </span>

            </div>

            <div class="modern-food-body">

                <h3 class="modern-food-title">

                    <%= item.getName() %>

                </h3>

                <p class="modern-food-description">

                    <%= item.getDescription() %>

                </p>

                <div class="modern-food-price-row">

                    <span class="modern-food-price">

                        Rs. <%= String.format("%.2f", item.getPrice()) %>

                    </span>

                    <span class="modern-food-rating">

                        ⭐ 4.8

                    </span>

                </div>

                <% if(userName != null){ %>

                <div class="modern-qty-row">

                    <label>

                        Quantity

                    </label>

                    <input type="number"
                           class="modern-qty-input menu-qty"
                           value="1"
                           min="1">

                </div>

                <form method="post"
                      action="<%=request.getContextPath()%>/cart">

                    <input type="hidden"
                           name="action"
                           value="add">

                    <input type="hidden"
                           name="itemId"
                           value="<%= item.getItemId() %>">

                    <input type="hidden"
                           name="itemName"
                           value="<%= item.getName() %>">

                    <input type="hidden"
                           name="price"
                           value="<%= item.getPrice() %>">

                    <input type="hidden"
                           class="hidden-menu-qty"
                           name="quantity"
                           value="1">

                    <button class="modern-add-cart-btn"
                            type="submit"
                            onclick="this.closest('.modern-food-body').querySelector('.hidden-menu-qty').value =
                                         this.closest('.modern-food-body').querySelector('.menu-qty').value;">

                        Add to Cart

                    </button>

                </form>

                <% } else { %>

                <a class="modern-add-cart-btn locked-cart-btn"
                   href="<%=request.getContextPath()%>/client/login.jsp">

                    Login to Order 🔒

                </a>

                <% } %>

            </div>

        </div>

        <% } %>

        <% if(items.isEmpty()){ %>

        <div class="card">

            <h3>

                No menu items found

            </h3>

            <p class="muted">

                Add menu items from admin panel.

            </p>

        </div>

        <% } %>

    </div>

    <div class="menu-empty-search"
         id="menuEmptySearch"
         style="display:none;">

        <h3>

            No matching food items found 🍽️

        </h3>

        <p>

            Try searching with another keyword.

        </p>

    </div>

</main>

<script>

    const APP_CONTEXT =
        "<%=request.getContextPath()%>";

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

<script src="<%=request.getContextPath()%>/assets/js/main.js?v=30"></script>

<script>

    let selectedMenuCategory = "All";

    function applyMenuFilters() {

        const searchInput =
            document.getElementById("menuSearchInput");

        const cards =
            document.querySelectorAll(".modern-food-card");

        const emptyBox =
            document.getElementById("menuEmptySearch");

        const countBox =
            document.getElementById("menuItemCount");

        const keyword =
            searchInput
                ? searchInput.value.toLowerCase().trim()
                : "";

        let visibleCount = 0;

        cards.forEach(card => {

            const itemCategory =
                card.getAttribute("data-category");

            const searchText =
                card.getAttribute("data-search");

            const categoryMatch =
                selectedMenuCategory === "All"
                || itemCategory === selectedMenuCategory;

            const searchMatch =
                keyword === ""
                || searchText.includes(keyword);

            if (categoryMatch && searchMatch) {

                card.style.display = "block";

                visibleCount++;

            } else {

                card.style.display = "none";
            }
        });

        if (countBox) {

            countBox.innerText = visibleCount + " Items";
        }

        if (emptyBox) {

            emptyBox.style.display =
                visibleCount === 0 ? "block" : "none";
        }
    }

    function filterMenuByCategory(category, event) {

        selectedMenuCategory = category;

        const buttons =
            document.querySelectorAll(".category-btn");

        buttons.forEach(button => {

            button.classList.remove("active-category");
        });

        if (event && event.target) {

            event.target.classList.add("active-category");
        }

        applyMenuFilters();
    }

    const menuSearchInput =
        document.getElementById("menuSearchInput");

    if (menuSearchInput) {

        menuSearchInput.addEventListener("input", applyMenuFilters);
    }

</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>

</body>
</html>