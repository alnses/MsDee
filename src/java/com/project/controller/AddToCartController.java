package com.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCartController")
public class AddToCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Match against the exact session attributes initialized in LoginController
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp?error=auth");
            return;
        }
        
        // Grab product elements passed from the details layout
        String prodName = request.getParameter("prodName");
        String prodPriceStr = request.getParameter("prodPrice");
        String prodImage = request.getParameter("prodImage");
        
        if (prodName != null && prodPriceStr != null) {
            double prodPrice = Double.parseDouble(prodPriceStr);
            
            // Retrieve or initialize a clean backend session-driven cart instance
            List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("sessionCart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("sessionCart", cart);
            }
            
            // Track duplicate entries to update item quantity thresholds smoothly
            boolean itemExists = false;
            for (Map<String, Object> item : cart) {
                if (prodName.equalsIgnoreCase((String) item.get("name"))) {
                    int currentQty = (Integer) item.get("quantity");
                    item.put("quantity", currentQty + 1);
                    itemExists = true;
                    break;
                }
            }
            
            if (!itemExists) {
                Map<String, Object> newItem = new HashMap<>();
                newItem.put("name", prodName);
                newItem.put("price", prodPrice);
                newItem.put("image", prodImage);
                newItem.put("quantity", 1);
                cart.add(newItem);
            }
        }
        
        // Redirect right back to the store front layout with a success parameter flag
        response.sendRedirect(request.getContextPath() + "/pages/users/shop.jsp?added=true");
    }
}