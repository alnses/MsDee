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
    <title>Manage Orders | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=101">
</head>

<body>

<div class="admin-layout">

    <aside class="admin-sidebar">
        <h2>Ms.Dee Admin</h2>
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="manageProducts.jsp">Manage Products</a>
        <a href="manageInventory.jsp">Manage Inventory</a>
        <a href="manageOrders.jsp" class="active">Manage Orders</a>
        <a href="report.jsp">Reports</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </aside>

    <main class="admin-main">
        <h1>Manage Orders</h1>

        <table class="admin-table">
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Total</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <tr>
                <td>ORD001</td>
                <td>Alin</td>
                <td>RM 189.90</td>
                <td>Pending</td>
                <td>
                    <select>
                        <option>Pending</option>
                        <option>Processing</option>
                        <option>Shipped</option>
                        <option>Completed</option>
                    </select>
                    <button>Update</button>
                </td>
            </tr>

            <tr>
                <td>ORD002</td>
                <td>Ammar Hamdi</td>
                <td>RM 71.92</td>
                <td>Completed</td>
                <td>
                    <select>
                        <option>Pending</option>
                        <option>Processing</option>
                        <option>Shipped</option>
                        <option selected>Completed</option>
                    </select>
                    <button>Update</button>
                </td>
            </tr>
        </table>

    </main>

</div>

</body>
</html>