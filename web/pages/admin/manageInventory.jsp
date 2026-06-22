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
        <title>Manage Inventory | Ms. Dee</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=102">
    </head>

    <body>
        <jsp:include page="/partials/admin-sidebar.jsp"/>

        <div style="width: 260px; float: left;"></div>

        <div class="admin-layout">
            <main class="admin-main">
                <% 
                    String msg = (String) session.getAttribute("message");
                    if (msg != null) { 
                %>
                    <div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                        <%= msg %>
                    </div>
                <% 
                        session.removeAttribute("message"); 
                    } 
                %>

                <h1>Manage Inventory</h1>
                <p>Update stock quantity and product availability status.</p>

                <table class="admin-table">
                    <tr>
                        <th>ID</th>
                        <th>Product</th>
                        <th>Category</th>
                        <th>Stock Quantity</th>
                        <th>Status</th>
                        <th>Update Stock</th>
                    </tr>

                    <% for (Product p : products) {%>
                    <tr>
                        <td><%= p.getProductId()%></td>
                        <td><%= p.getProductName()%></td>
                        <td><%= p.getCategory()%></td>
                        <td><%= p.getStockQuantity()%></td>
                        <td>
                            <% if (p.getStockQuantity() > 0) { %>
                                Active
                            <% } else { %>
                                Inactive
                            <% } %>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/products" method="post">
                                <input type="hidden" name="action" value="updateStock">
                                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                <input type="number" name="stockQuantity" value="<%= p.getStockQuantity() %>" min="0" required>
                                <button type="submit">Update</button>
                            </form>
                        </td>
                    </tr>
                    <% }%>
                </table>
            </main>
        </div>
    </body>
</html>