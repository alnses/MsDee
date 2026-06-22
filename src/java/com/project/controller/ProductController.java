package com.project.controller;

import com.project.dao.ProductDAO;
import com.project.model.Product;
import java.io.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/products")
@MultipartConfig(fileSizeThreshold=1024*1024*2, maxFileSize=1024*1024*10, maxRequestSize=1024*1024*50)
public class ProductController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Product> products;
        if (category != null && !category.isEmpty()) {
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

    // 1. Check for file upload (Multipart)
    String contentType = request.getContentType();
    
    if (contentType != null && contentType.startsWith("multipart/form-data")) {
        // This block handles adding new products (with images)
        try {
            String productName = getPartValue(request.getPart("productName"));
            String category = getPartValue(request.getPart("category"));
            double price = Double.parseDouble(getPartValue(request.getPart("price")));
            int stock = Integer.parseInt(getPartValue(request.getPart("stockQuantity")));
            String description = getPartValue(request.getPart("description"));

            Part filePart = request.getPart("productImage");
            String fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images";
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            filePart.write(uploadPath + File.separator + fileName);

            Product p = new Product(productName, category, description, price, stock, "assets/images/" + fileName);
            productDAO.addProduct(p);

            response.sendRedirect(request.getContextPath() + "/pages/admin/manageProducts.jsp");
            
        } catch (Exception e) {
            // This catches errors for the file upload part
            throw new ServletException("File upload error", e);
        }
    } else {
        // 2. This block handles standard updates (like your Inventory Update button)
        // We use getParameter() here because there are no "parts" to get
        String action = request.getParameter("action");
        // --- Inside your updateStock block ---
        if ("updateStock".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int newStock = Integer.parseInt(request.getParameter("stockQuantity"));

            productDAO.updateStock(productId, newStock);

            // Add this line to trigger the success message
            request.getSession().setAttribute("message", "Stock updated successfully!");

            response.sendRedirect(request.getContextPath() + "/pages/admin/manageInventory.jsp");
        }
    }
}

    private String getPartValue(Part part) throws IOException {
        if (part == null) return null;
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"))) {
            StringBuilder value = new StringBuilder();
            char[] buffer = new char[1024];
            int read;
            while ((read = reader.read(buffer)) != -1) {
                value.append(buffer, 0, read);
            }
            return value.toString().trim();
        }
    }
}