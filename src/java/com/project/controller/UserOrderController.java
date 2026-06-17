package com.project.controller;

import com.project.dao.OrderDAO;
import com.project.model.Order;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/orders")
public class UserOrderController extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = getUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        List<Order> orders = orderDAO.getOrdersByUserId(userId);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/pages/users/orders.jsp").forward(request, response);
    }

    private Integer getUserId(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object userObj = session.getAttribute("userId");

        if (userObj == null) {
            userObj = session.getAttribute("user_id");
        }

        if (userObj == null) {
            return null;
        }

        return Integer.parseInt(userObj.toString());
    }
}
