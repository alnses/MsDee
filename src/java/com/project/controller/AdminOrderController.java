package com.project.controller;

import com.project.dao.OrderDAO;
import com.project.model.Order;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/admin/orders")
public class AdminOrderController extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        // Optional admin check
        Object roleObj = session.getAttribute("roleId");

        if (roleObj == null || Integer.parseInt(roleObj.toString()) != 3) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp?error=unauthorized");
            return;
        }

        List<Order> orders = orderDAO.getAllOrders();

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/pages/admin/manageOrders.jsp")
                .forward(request, response);
    }
}