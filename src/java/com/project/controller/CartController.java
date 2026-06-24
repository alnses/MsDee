package com.project.controller;

import com.project.dao.CartDAO;
import com.project.model.CartItem;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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

        response.sendRedirect(request.getContextPath()
                + "/CartController");
    }
}
