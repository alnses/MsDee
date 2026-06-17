<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.project.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>My Orders | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=63">
    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="orders-page">

            <div class="orders-hero">
                <div>
                    <h1>My Orders</h1>
                    <p>Track your purchases, payment status, and order progress.</p>
                </div>

                <a href="${pageContext.request.contextPath}/pages/users/shop.jsp" class="small-btn">Continue Shopping</a>
            </div>

            <%
                List<Order> orders = (List<Order>) request.getAttribute("orders");
                SimpleDateFormat orderDateFormat = new SimpleDateFormat("dd MMM yyyy, h:mm a");

                if (orders == null || orders.isEmpty()) {
            %>

            <div class="empty-orders">
                <div class="empty-icon">Order Box</div>
                <h2>No Orders Yet</h2>
                <p>Your completed purchases will appear here once you checkout.</p>
                <a href="${pageContext.request.contextPath}/pages/users/shop.jsp" class="shop-btn">Start Shopping</a>
            </div>

            <%
            } else {
            %>

            <div class="orders-list">
                <%
                    for (Order o : orders) {
                        String dateText = o.getCreatedAt() != null
                                ? orderDateFormat.format(o.getCreatedAt())
                                : "Date unavailable";
                        String orderStatus = o.getOrderStatus() != null ? o.getOrderStatus() : "Processing";
                        String paymentStatus = o.getPaymentStatus() != null ? o.getPaymentStatus() : "Pending";
                        String orderRef = o.getOrderRef() != null ? o.getOrderRef() : "MSDEE-" + o.getOrderId();
                %>

                <div class="order-card enhanced-order-card">
                    <div class="order-top">
                        <div>
                            <p class="order-label">Order Reference</p>
                            <h3><%= orderRef %></h3>
                            <p class="order-date"><%= dateText %></p>
                        </div>

                        <span class="status-badge"><%= orderStatus %></span>
                    </div>

                    <div class="order-middle enhanced-order-middle">
                        <div>
                            <span>Total Paid</span>
                            <h2>RM <%= String.format("%.2f", o.getTotalAmount()) %></h2>
                        </div>

                        <div>
                            <span>Payment</span>
                            <strong><%= paymentStatus %></strong>
                        </div>

                        <div>
                            <span>Order ID</span>
                            <strong>#<%= o.getOrderId() %></strong>
                        </div>
                    </div>
                </div>

                <%
                    }
                %>
            </div>

            <%
                }
            %>

        </div>

        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>
