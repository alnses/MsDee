package com.project.controller;

import com.project.dao.DBConnection;
import com.project.dao.UserDAO;
import com.project.model.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/users/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        try {
            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO orders (user_id, total_amount, order_status) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setDouble(2, totalAmount);
            ps.setString(3, "Completed");
            ps.executeUpdate();

            conn.close();

            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);

            double newTotalSpent = user.getTotalSpent() + totalAmount;
            userDAO.updateMembership(userId, newTotalSpent);

            session.setAttribute("totalSpent", newTotalSpent);

            response.sendRedirect(request.getContextPath() + "/profile?checkout=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/users/checkout.jsp?error=1");
        }
    }
}