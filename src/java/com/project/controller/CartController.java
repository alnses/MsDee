package com.project.controller;

import com.project.dao.CartDAO;
import com.project.model.CartItem;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

// Maps to the exact action endpoint used by your dynamic forms
@WebServlet("/CartController")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        double cartTotal = cartDAO.getCartTotal(userId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);

        request.getRequestDispatcher("/pages/users/cart.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                int productId = Integer.parseInt(
                        request.getParameter("product_id"));

                int quantity = 1;

                String qtyParam = request.getParameter("quantity");

                if (qtyParam != null && !qtyParam.isEmpty()) {
                    quantity = Integer.parseInt(qtyParam);
                }

                cartDAO.addToCart(userId, productId, quantity);

                response.sendRedirect(
                        request.getContextPath()
                        + "/products?added=true");

            } else if ("update".equals(action)) {

                int cartId = Integer.parseInt(
                        request.getParameter("cart_id"));

                int quantity = Integer.parseInt(
                        request.getParameter("quantity"));

                if (quantity <= 0) {
                    cartDAO.removeItem(cartId, userId);
                } else {
                    cartDAO.updateQuantity(
                            cartId,
                            quantity,
                            userId);
                }

                response.sendRedirect(
                        request.getContextPath()
                        + "/CartController");

            } else if ("remove".equals(action)) {

                int cartId = Integer.parseInt(
                        request.getParameter("cart_id"));

                cartDAO.removeItem(cartId, userId);

                response.sendRedirect(
                        request.getContextPath()
                        + "/CartController");

            } else if ("clear".equals(action)) {

                cartDAO.clearCart(userId);

                response.sendRedirect(
                        request.getContextPath()
                        + "/CartController");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/CartController");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/CartController?error=true");
        }
    }

}
