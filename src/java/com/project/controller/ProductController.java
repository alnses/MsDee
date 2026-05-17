package com.project.controller;

import com.project.dao.ProductDAO;
import com.project.model.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/products")
public class ProductController extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        List<Product> products;

        if (category != null && !category.equalsIgnoreCase("all")) {
            products = productDAO.getProductsByCategory(category);
        } else {
            products = productDAO.getAllProducts();
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("/pages/users/shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                Product p = new Product();

                p.setProductName(request.getParameter("productName"));
                p.setCategory(request.getParameter("category"));
                p.setDescription(request.getParameter("description"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                p.setImageUrl(request.getParameter("imageUrl"));
                p.setActive(true);

                productDAO.addProduct(p);

                response.sendRedirect(request.getContextPath() + "/pages/admin/manageProducts.jsp");
                return;

            } else if ("delete".equals(action)) {

                int productId = Integer.parseInt(request.getParameter("productId"));

                productDAO.deleteProduct(productId);

                response.sendRedirect(request.getContextPath() + "/pages/admin/manageProducts.jsp");
                return;

            } else if ("updateStock".equals(action)) {

                int productId = Integer.parseInt(request.getParameter("productId"));
                int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

                productDAO.updateStock(productId, stockQuantity);

                response.sendRedirect(request.getContextPath() + "/pages/admin/manageInventory.jsp");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/pages/admin/manageProducts.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/admin/manageProducts.jsp?error=1");
        }
    }
}