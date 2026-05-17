<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.project.model.Order"%>
<%@page import="com.project.dao.OrderDAO"%>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !role.equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/pages/admin/adminLogin.jsp?error=1");
        return;
    }

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getAllOrders();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders | Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        body {
            margin: 0;
            background: #f5f6fa;
            font-family: Arial, sans-serif;
        }

        .admin-container {
            margin-left: 270px;
            padding: 40px;
            min-height: 100vh;
        }

        .admin-title {
            font-size: 36px;
            margin-bottom: 25px;
            font-weight: 800;
            color: #050827;
        }

        .order-table {
            width: 100%;
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }

        .order-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-table th {
            background: #171628;
            color: white;
            padding: 18px;
            text-align: left;
        }

        .order-table td {
            padding: 18px;
            border-bottom: 1px solid #eee;
        }

        .status {
            padding: 8px 14px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 700;
        }

        .processing, .pending {
            background: #fff2cc;
            color: #7a5900;
        }

        .shipped {
            background: #d9ead3;
            color: #236b2e;
        }

        .completed {
            background: #cfe2ff;
            color: #084298;
        }

        select {
            padding: 8px;
            border-radius: 8px;
        }

        .update-btn {
            padding: 8px 16px;
            border: none;
            background: #6366f1;
            color: white;
            border-radius: 8px;
            cursor: pointer;
        }

        .no-order {
            padding: 30px;
            text-align: center;
        }
    </style>
</head>

<body>

<jsp:include page="/partials/admin-sidebar.jsp"/>

<div class="admin-container">

    <h1 class="admin-title">Manage Orders</h1>

    <div class="order-table">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Email</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Update</th>
                </tr>
            </thead>

            <tbody>
            <% if (orders != null && !orders.isEmpty()) { %>

                <% for (Order order : orders) { 
                    String status = order.getOrderStatus();
                    if (status == null) {
                        status = "Processing";
                    }
                %>

                <tr>
                    <td>#<%= order.getOrderId() %></td>
                    <td><%= order.getFullName() %></td>
                    <td><%= order.getEmail() %></td>
                    <td>RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
                    <td>
                        <span class="status <%= status.toLowerCase() %>">
                            <%= status %>
                        </span>
                    </td>
                    <td><%= order.getOrderDate() %></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/adminOrders" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                            <select name="status">
                                <option value="Processing">Processing</option>
                                <option value="Pending">Pending</option>
                                <option value="Shipped">Shipped</option>
                                <option value="Completed">Completed</option>
                            </select>

                            <button class="update-btn" type="submit">Update</button>
                        </form>
                    </td>
                </tr>

                <% } %>

            <% } else { %>

                <tr>
                    <td colspan="7" class="no-order">No orders found</td>
                </tr>

            <% } %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>