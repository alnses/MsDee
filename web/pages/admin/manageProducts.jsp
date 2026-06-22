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
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Products | Ms. Dee</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=102">
</head>
<body>
    <jsp:include page="/partials/admin-sidebar.jsp">
    <jsp:param name="activePage" value="products" /> </jsp:include>

<div class="admin-layout">
    <main class="admin-main">
        <h1>Manage Products</h1>
        
        <div class="admin-form-box">
            <h2>Add New Product</h2>
            <form action="${pageContext.request.contextPath}/products" method="post" enctype="multipart/form-data">
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
                    <label>Description</label>
                    <textarea name="description" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>Upload Product Image</label>
                    <input type="file" name="productImage" accept="image/*" required>
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
            </tr>
            <% 
                ProductDAO dao = new ProductDAO();
                List<Product> products = dao.getAllProducts();
                for (Product p : products) { 
            %>
                <tr>
                    <td><%= p.getProductId() %></td>
                    <td><%= p.getProductName() %></td>
                    <td><%= p.getCategory() %></td>
                    <td>RM <%= String.format("%.2f", p.getPrice()) %></td>
                    <td><%= p.getStockQuantity() %></td>
                </tr>
            <% } %>
        </table>
    </main>
</div>
</body>
</html>