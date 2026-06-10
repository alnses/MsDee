package com.project.controller;

import com.project.dao.CartDAO;
import com.project.model.CartItem;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CheckoutController")
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO = new CartDAO();

    // CASE 1: Handles "Proceed to Checkout" from the Cart Page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Fetch everything currently in their database cart
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        double subtotal = cartDAO.getCartTotal(userId);

        // Attach details to request scope for checkout.jsp to read
        request.setAttribute("checkoutItems", cartItems);
        request.setAttribute("checkoutSubtotal", subtotal);
        request.setAttribute("isSingleProductCheckout", false);

        // Forward safely to checkout view page
        request.getRequestDispatcher("/pages/users/checkout.jsp").forward(request, response);
    }

    // CASE 2: Handles the "Buy Now" form submission from Product Details
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp?error=auth");
            return;
        }

        String prodName = request.getParameter("prodName");
        String prodPriceStr = request.getParameter("prodPrice");
        String prodImage = request.getParameter("prodImage");

        if (prodName != null && prodPriceStr != null) {
            request.setAttribute("checkoutName", prodName);
            request.setAttribute("checkoutPrice", Double.parseDouble(prodPriceStr));
            request.setAttribute("checkoutImage", prodImage);
            request.setAttribute("isSingleProductCheckout", true);
        }

        request.getRequestDispatcher("/pages/users/checkout.jsp").forward(request, response);
    }
}