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

<<<<<<< HEAD
        if (session == null
                || session.getAttribute("user_id") == null) {

            request.setAttribute("guestMode", true);
            request.setAttribute("cartItems", new ArrayList<CartItem>());
            request.setAttribute("cartTotal", 0.0);

            request.getRequestDispatcher("/pages/users/cart.jsp")
                    .forward(request, response);

=======
        // Aligned with the exact key used by your LoginController ("userId")
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05
            return;
        }

        int userId = (int) session.getAttribute("userId");

<<<<<<< HEAD
        List<CartItem> cartItems =
                cartDAO.getCartItems(userId);

        double cartTotal =
                cartDAO.getCartTotal(userId);
=======
        // Load item data collections securely from your MySQL database layer
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        double cartTotal = cartDAO.getCartTotal(userId);
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);

<<<<<<< HEAD
        request.getRequestDispatcher("/pages/users/cart.jsp")
                .forward(request, response);
=======
        // Forward safely to your true page path template
        request.getRequestDispatcher("/pages/users/cart.jsp").forward(request, response);
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

<<<<<<< HEAD
        if (session == null
                || session.getAttribute("user_id") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/pages/users/login.jsp"
            );

            return;
        }

        int userId = (int) session.getAttribute("user_id");

=======
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05
        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {
<<<<<<< HEAD

                int productId =
                        Integer.parseInt(
                                request.getParameter("product_id"));

                int quantity = 1;

                String qtyParam =
                        request.getParameter("quantity");

                if (qtyParam != null
                        && !qtyParam.isEmpty()) {

=======
                // Since your cards are static, we match on a numeric placeholder mapping 
                // or fallback to a custom product identification integer logic
                int productId = 1; 
                String prodIdParam = request.getParameter("product_id");
                if (prodIdParam != null && !prodIdParam.isEmpty()) {
                    productId = Integer.parseInt(prodIdParam);
                }

                int quantity = 1;
                String qtyParam = request.getParameter("quantity");
                if (qtyParam != null && !qtyParam.isEmpty()) {
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05
                    quantity = Integer.parseInt(qtyParam);
                }

                // Persist the transaction securely inside your DB backend tables
                cartDAO.addToCart(userId, productId, quantity);
<<<<<<< HEAD

                response.sendRedirect(
                        request.getContextPath()
                        + "/products?added=true"
                );
=======
                
                // Redirect back to shop frontend displaying a toast message successfully
                response.sendRedirect(request.getContextPath() + "/pages/users/shop.jsp?added=true");
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05

            } else if ("update".equals(action)) {

                int cartId =
                        Integer.parseInt(
                                request.getParameter("cart_id"));

                int quantity =
                        Integer.parseInt(
                                request.getParameter("quantity"));

                if (quantity <= 0) {

                    cartDAO.removeItem(cartId, userId);

                } else {

                    cartDAO.updateQuantity(
                            cartId,
                            quantity,
                            userId
                    );
                }
<<<<<<< HEAD

                response.sendRedirect(
                        request.getContextPath()
                        + "/cart"
                );
=======
                response.sendRedirect(request.getContextPath() + "/CartController");
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05

            } else if ("remove".equals(action)) {

                int cartId =
                        Integer.parseInt(
                                request.getParameter("cart_id"));

                cartDAO.removeItem(cartId, userId);
<<<<<<< HEAD

                response.sendRedirect(
                        request.getContextPath()
                        + "/cart"
                );
=======
                response.sendRedirect(request.getContextPath() + "/CartController");
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05

            } else if ("clear".equals(action)) {

                cartDAO.clearCart(userId);
<<<<<<< HEAD

                response.sendRedirect(
                        request.getContextPath()
                        + "/cart"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/cart"
                );
=======
                response.sendRedirect(request.getContextPath() + "/CartController");

            } else {
                response.sendRedirect(request.getContextPath() + "/CartController");
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05
            }

        } catch (Exception e) {

            e.printStackTrace();
<<<<<<< HEAD

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart?error=true"
            );
=======
            response.sendRedirect(request.getContextPath() + "/pages/users/cart.jsp?error=true");
>>>>>>> fd7c233ba9a56af603dcdb59c430e0f8787afa05
        }
    }
}