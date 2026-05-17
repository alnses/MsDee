package com.project.controller;

import com.project.dao.CartDAO;
import com.project.model.CartItem;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        double cartTotal = cartDAO.getCartTotal(userId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);

        request.getRequestDispatcher("/users/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("product_id"));
                int quantity = 1;

                String qtyParam = request.getParameter("quantity");
                if (qtyParam != null && !qtyParam.isEmpty()) {
                    quantity = Integer.parseInt(qtyParam);
                }

                cartDAO.addToCart(userId, productId, quantity);
                response.sendRedirect(request.getContextPath() + "/products?added=true");

            } else if ("update".equals(action)) {
                int cartId = Integer.parseInt(request.getParameter("cart_id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity <= 0) {
                    cartDAO.removeItem(cartId, userId);
                } else {
                    cartDAO.updateQuantity(cartId, quantity, userId);
                }

                response.sendRedirect(request.getContextPath() + "/cart");

            } else if ("remove".equals(action)) {
                int cartId = Integer.parseInt(request.getParameter("cart_id"));

                cartDAO.removeItem(cartId, userId);
                response.sendRedirect(request.getContextPath() + "/cart");

            } else if ("clear".equals(action)) {
                cartDAO.clearCart(userId);
                response.sendRedirect(request.getContextPath() + "/cart");

            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart?error=true");
        }
    }
}