<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="service.DeliveryService" %>
<%@ page import="model.Delivery" %>
<%@ page import="java.util.List" %>

<%
    Boolean loggedIn =
            (Boolean) session.getAttribute("driverLoggedIn");

    if (loggedIn == null || !loggedIn) {

        response.sendRedirect(
                request.getContextPath()
                        + "/driver/login.jsp"
        );

        return;
    }

    DeliveryService deliveryService =
            new DeliveryService();

    List<Delivery> deliveries =
            deliveryService.getAllDeliveries();
%>

<!DOCTYPE html>

<html>
<head>

    <title>Forkly Driver Panel</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/style.css">

    <style>
        <style>

        .driver-filter-bar{
            display:flex !important;
            gap:14px !important;
            margin-bottom:30px !important;
            flex-wrap:wrap !important;
        }

        .driver-filter-btn{
            border:none !important;
            padding:12px 22px !important;
            border-radius:14px !important;
            background:#ffffff !important;
            color:#444 !important;
            font-weight:800 !important;
            cursor:pointer !important;
            transition:0.3s !important;
            box-shadow:0 4px 12px rgba(0,0,0,0.08) !important;
        }

        .driver-filter-btn:hover{
            background:#fff1e8 !important;
            color:#ff6b1a !important;
        }

        .driver-filter-btn.active-filter,
        .active-filter{
            background:#ff6b1a !important;
            color:#ffffff !important;
        }

    </style>
    </style>

</head>
<body>


<div class="driver-topbar">

    <div>

        <h1>Forkly Delivery Driver</h1>

        <p>Manage customer deliveries in real time.</p>

    </div>

    <div class="driver-profile">

        🚚
        <%= session.getAttribute("driverName") %>

    </div>

</div>

<main class="container section">

    <!-- ==============================
         DELIVERY FILTER BUTTONS
         ============================== -->

    <div class="driver-filter-bar">

        <button class="driver-filter-btn active-filter"
                onclick="filterDeliveries('ALL', this)">

            All Orders

        </button>

        <button class="driver-filter-btn"
                onclick="filterDeliveries('ACTIVE', this)">

            Non Delivered

        </button>

        <button class="driver-filter-btn"
                onclick="filterDeliveries('DELIVERED', this)">

            Delivered

        </button>

    </div>

    <div class="driver-delivery-grid">

        <% for (Delivery d : deliveries) { %>

        <div class="driver-delivery-card"
             data-status="<%= d.getStatus() %>">

            <span class="order-status-badge status-<%= d.getStatus().toLowerCase() %>">

                <%= d.getStatus() %>

            </span>

            <h2>

                Order #<%= d.getOrderId() %>

            </h2>

            <p>

                Customer:
                <strong><%= d.getCustomerId() %></strong>

            </p>

            <div class="driver-address-box">

                📍
                <%= d.getAddress() %>

            </div>

            <p class="muted">

                Delivery Type:
                <strong><%= d.getDeliveryType() %></strong>

            </p>

            <p class="muted">

                Delivery Fee:
                <strong>
                    Rs. <%= String.format("%.2f", d.calculateDeliveryFee()) %>
                </strong>

            </p>

            <%
                String paymentMethod = "UNKNOWN";

                try {

                    service.PaymentService paymentService =
                            new service.PaymentService();

                    model.Payment payment =
                            paymentService.getPaymentByOrderId(
                                    d.getOrderId()
                            );

                    if (payment != null) {

                        paymentMethod =
                                payment.getMethod();
                    }

                } catch (Exception ex) {

                    paymentMethod = "UNKNOWN";
                }
            %>

            <p class="muted">

                Payment Method:
                <strong><%= paymentMethod %></strong>

            </p>

            <p class="muted">

                ETA:
                <%= d.getEstimatedTime() == null
                        ? "Not set yet"
                        : d.getEstimatedTime() %>

            </p>

            <div class="driver-actions">

                <% if ("READY_FOR_DELIVERY".equals(d.getStatus())) { %>

                <form method="post"
                      action="<%=request.getContextPath()%>/driver-delivery">

                    <input type="hidden"
                           name="deliveryId"
                           value="<%= d.getDeliveryId() %>">

                    <input type="hidden"
                           name="action"
                           value="accept">

                    <button class="driver-btn accept-btn"
                            type="submit">

                        Accept Order

                    </button>

                </form>

                <% } %>

                <% if ("ACCEPTED".equals(d.getStatus())) { %>

                <form method="post"
                      action="<%=request.getContextPath()%>/driver-delivery">

                    <input type="hidden"
                           name="deliveryId"
                           value="<%= d.getDeliveryId() %>">

                    <input type="hidden"
                           name="action"
                           value="pickup">

                    <div class="driver-address-box">

                        <strong>⏱ Enter ETA Time</strong>

                        <input type="text"
                               name="etaTime"
                               placeholder="Example: 20-30 minutes"
                               required
                               style="margin-top:12px;">

                    </div>

                    <button class="driver-btn pickup-btn"
                            type="submit">

                        Mark Picked Up

                    </button>

                </form>

                <% } %>

                <% if ("PICKED_UP".equals(d.getStatus())) { %>

                <form method="post"
                      action="<%=request.getContextPath()%>/driver-delivery">

                    <input type="hidden"
                           name="deliveryId"
                           value="<%= d.getDeliveryId() %>">

                    <input type="hidden"
                           name="action"
                           value="delivered">

                    <button class="driver-btn delivered-btn"
                            type="submit">

                        Mark Delivered

                    </button>

                </form>

                <% } %>

            </div>

        </div>

        <% } %>

    </div>

</main>

<script>

    function filterDeliveries(type, button) {

        const cards =
            document.querySelectorAll(".driver-delivery-card");

        document.querySelectorAll(".driver-filter-btn")
            .forEach(btn => {

                btn.classList.remove("active-filter");
            });

        button.classList.add("active-filter");

        cards.forEach(card => {

            const status =
                card.getAttribute("data-status");

            if (type === "ALL") {

                card.style.display = "block";
            }

            else if (type === "DELIVERED") {

                if (status === "DELIVERED") {

                    card.style.display = "block";

                } else {

                    card.style.display = "none";
                }
            }

            else if (type === "ACTIVE") {

                if (status !== "DELIVERED") {

                    card.style.display = "block";

                } else {

                    card.style.display = "none";
                }
            }
        });
    }

</script>

<script src="<%=request.getContextPath()%>/assets/js/main.js"></script>

</body>

</html>