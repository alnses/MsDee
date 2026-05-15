<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/pages/admin/adminLogin.jsp?error=1");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Reports | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=101">
</head>

<body>

<div class="admin-layout">

    <aside class="admin-sidebar">
        <h2>Ms.Dee Admin</h2>
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="manageProducts.jsp">Manage Products</a>
        <a href="manageInventory.jsp">Manage Inventory</a>
        <a href="manageOrders.jsp">Manage Orders</a>
        <a href="report.jsp" class="active">Reports</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </aside>

    <main class="admin-main">
        <h1>Sales & Inventory Reports</h1>

        <div class="admin-cards">
            <div class="admin-card">
                <h3>Monthly Sales</h3>
                <p>RM 2,450.90</p>
            </div>

            <div class="admin-card">
                <h3>Total Orders</h3>
                <p>32</p>
            </div>

            <div class="admin-card">
                <h3>Best Seller</h3>
                <p>Air Cooler</p>
            </div>

            <div class="admin-card">
                <h3>Low Stock</h3>
                <p>5 Items</p>
            </div>
        </div>

        <h2>Report Summary</h2>

        <table class="admin-table">
            <tr>
                <th>Report Type</th>
                <th>Description</th>
                <th>Status</th>
            </tr>

            <tr>
                <td>Sales Report</td>
                <td>Shows total sales and completed orders.</td>
                <td>Available</td>
            </tr>

            <tr>
                <td>Inventory Report</td>
                <td>Shows stock level and low stock products.</td>
                <td>Available</td>
            </tr>
        </table>

    </main>

</div>

</body>
</html>