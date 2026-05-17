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
    <title>Admin Dashboard | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=99">
</head>

<body>
    <jsp:include page="/partials/admin-sidebar.jsp"/>

<div class="admin-layout">

    <aside class="admin-sidebar">
        <h2>Ms.Dee Admin</h2>
        <a href="adminDashboard.jsp" class="active">Dashboard</a>
        <a href="manageProducts.jsp">Manage Products</a>
        <a href="manageInventory.jsp">Manage Inventory</a>
        <a href="manageOrders.jsp">Manage Orders</a>
        <a href="report.jsp">Reports</a>
    </aside>

    <main class="admin-main">
        <h1>Admin Dashboard</h1>
        <p>Welcome, <%= session.getAttribute("fullName") %></p>

        <div class="admin-cards">
            <div class="admin-card">
                <h3>Total Products</h3>
                <p>24</p>
            </div>

            <div class="admin-card">
                <h3>Pending Orders</h3>
                <p>8</p>
            </div>

            <div class="admin-card">
                <h3>Low Stock Items</h3>
                <p>5</p>
            </div>

            <div class="admin-card">
                <h3>Total Sales</h3>
                <p>RM 2,450.90</p>
            </div>
        </div>
    </main>

</div>

</body>
</html>