<%@ page import="java.util.List" %>
<%@ page import="com.project.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>My Orders | Ms. Dee</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body>

        <jsp:include page="../../partials/header.jsp"/>

        <div class="orders-page">

            <div class="orders-header">
                <h1>My Orders</h1>
                <p>Track your purchases and order history</p>
            </div>


            <%
                List<Order> orders
                        = (List<Order>) request.getAttribute("orders");

                if (orders == null || orders.isEmpty()) {
            %>

            <div class="empty-orders">

                <div class="empty-icon">📦</div>

                <h2>No Orders Yet</h2>

                <p>
                    Looks like you haven’t purchased anything.
                </p>

                <a href="${pageContext.request.contextPath}/pages/users/shop.jsp"
                   class="shop-btn">
                    Start Shopping
                </a>

            </div>

            <%
            } else {

                for (Order o : orders) {
            %>


            <div class="order-card">

                <div class="order-top">

                    <div>
                        <h3>
                            Order #<%= o.getOrderId()%>
                        </h3>

                        <p>
                            <%= o.getOrderDate()%>
                        </p>
                    </div>


                    <span class="status-badge">
                        <%= o.getOrderStatus()%>
                    </span>

                </div>


                <div class="order-middle">

                    <div>
                        Total Paid
                        <h2>
                            RM
                            <%= String.format("%.2f",
                        o.getTotalAmount())%>
                        </h2>
                    </div>

                </div>

            </div>

            <%
                    }
                }
            %>

        </div>

        <jsp:include page="../../partials/footer.jsp"/>

    </body>
</html>