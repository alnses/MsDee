package com.project.controller;

import com.project.dao.ProductDAO;
import com.project.model.Product;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if ("add".equals(action)) {

            Product product = new Product();

            product.setProductName(request.getParameter("productName"));
            product.setCategory(request.getParameter("category"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
            product.setImagePath(request.getParameter("imagePath"));
            product.setDescription(request.getParameter("description"));

            int stock = product.getStockQuantity();

            if (stock <= 0) {
                product.setStatus("Out of Stock");
            } else if (stock <= 5) {
                product.setStatus("Low Stock");
            } else {
                product.setStatus("Available");
            }

            dao.addProduct(product);
            response.sendRedirect(request.getContextPath() + "/pages/admin/manageProducts.jsp");

        } else if ("delete".equals(action)) {

            int productId = Integer.parseInt(request.getParameter("productId"));
            dao.deleteProduct(productId);
            response.sendRedirect(request.getContextPath() + "/pages/admin/manageProducts.jsp");

        } else if ("updateStock".equals(action)) {

            int productId = Integer.parseInt(request.getParameter("productId"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

            dao.updateStock(productId, stockQuantity);
            response.sendRedirect(request.getContextPath() + "/pages/admin/manageInventory.jsp");
        }
    }
}