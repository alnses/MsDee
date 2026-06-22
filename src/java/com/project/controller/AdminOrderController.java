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

        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/pages/admin/manageOrders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        // Retrieve parameters
        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        
        // Ensure inputs are not null before updating
        if (orderId != null && status != null) {
            orderDAO.updateStatus(Integer.parseInt(orderId), status);
        }
        
        // Redirect back to GET method to refresh the list
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private boolean isAdmin(HttpSession session) {
        if (session == null || session.getAttribute("userId") == null) {
            return false;
        }
        // Check if the role is "admin"
        String role = (String) session.getAttribute("role");
        return "admin".equalsIgnoreCase(role);
    }
}