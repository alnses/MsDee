<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project.dao.ProductDAO" %>
<%@ page import="com.project.model.Product" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !role.equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/pages/admin/adminLogin.jsp?error=1");
        return;
    }

    ProductDAO dao = new ProductDAO();
    List<Product> products = dao.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Products | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=102">
</head>

<body>

<div class="admin-layout">

    <aside class="admin-sidebar">
        <h2>Ms.Dee Admin</h2>
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="manageProducts.jsp" class="active">Manage Products</a>
        <a href="manageInventory.jsp">Manage Inventory</a>
        <a href="manageOrders.jsp">Manage Orders</a>
        <a href="report.jsp">Reports</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </aside>

    <main class="admin-main">

        <h1>Manage Products</h1>
        <p>Add, view and delete product records.</p>

        <div class="admin-form-box">
            <h2>Add New Product</h2>

            <form action="${pageContext.request.contextPath}/ProductController" method="post">

                <input type="hidden" name="action" value="add">

                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" name="productName" required>
                </div>

                <div class="form-group">
                    <label>Category</label>
                    <select name="category" required>
                        <option value="Kitchen">Kitchen</option>
                        <option value="Cleaning">Cleaning</option>
                        <option value="Cooling">Cooling</option>
                        <option value="Heating">Heating</option>
                        <option value="Laundry">Laundry</option>
                        <option value="Electrical">Electrical</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Price</label>
                    <input type="number" name="price" step="0.01" required>
                </div>

                <div class="form-group">
                    <label>Stock Quantity</label>
                    <input type="number" name="stockQuantity" required>
                </div>

                <div class="form-group">
                    <label>Image Path</label>
                    <input type="text" name="imagePath" placeholder="assets/images/product.png">
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="3"></textarea>
                </div>

                <button class="main-btn" type="submit">Add Product</button>

            </form>
        </div>

        <h2>Product List</h2>

        <table class="admin-table">
            <tr>
                <th>ID</th>
                <th>Product</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <% for (Product p : products) { %>
                <tr>
                    <td><%= p.getProductId() %></td>
                    <td><%= p.getProductName() %></td>
                    <td><%= p.getCategory() %></td>
                    <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                    <td><%= p.getStockQuantity() %></td>
                    <td><%= p.getStatus() %></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/ProductController" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                            <button type="submit" onclick="return confirm('Delete this product?')">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>

    </main>

</div>

</body>
</html>